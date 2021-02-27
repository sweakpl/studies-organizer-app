#pragma warning(disable:4290)

#include "AbstractSqlModel.h"
#include "ModelUtilityFunctions.h"
#include <QCoreApplication>
#include <QtDebug>
#include <QSqlError>
#include <QSqlRecord>

AbstractSqlModel::AbstractSqlModel(QObject* parent) : QSqlQueryModel(parent)
{
    try {
        ModelUtilityFunctions::openDatabase(database);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
        // We can't continue if the database hasn't been opened
        QCoreApplication::quit();
    }

    databaseQuery = QSqlQuery(database);
}

void AbstractSqlModel::refresh()
{
    try {
        ModelUtilityFunctions::executeQuery(queryString(), databaseQuery);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }

    try {
        ModelUtilityFunctions::updateModel(*this, databaseQuery);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

QHash<int, QByteArray> AbstractSqlModel::roleNames() const
{
    QHash<int, QByteArray> roleNames;

    for (int i = 0; i < record().count(); i++) {
        roleNames.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }

    return roleNames;
}

QVariant AbstractSqlModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);

    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }

    return value;
}

QString AbstractSqlModel::queryString() const noexcept
{
    return m_queryString;
}

void AbstractSqlModel::setQueryStringAndRefresh(const QString &query)
{
    if (m_queryString == query)
        return;

    m_queryString = query;

    refresh();

    emit queryStringChanged();
}
