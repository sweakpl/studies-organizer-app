#pragma once

#include "DatabaseException.h"
#include <QObject>
#include <QSqlQueryModel>
#include <QSqlQuery>

class AbstractSqlModel : public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QString query READ queryString WRITE setQueryStringAndRefresh NOTIFY queryStringChanged)

public:
    explicit AbstractSqlModel(QObject* parent = Q_NULLPTR);

    Q_INVOKABLE void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role) const override;

    QString queryString() const noexcept;
    void setQueryStringAndRefresh(const QString &query);

private:
    QSqlDatabase database = QSqlDatabase::database("studiesorganizer");
    QSqlQuery databaseQuery;
    void openDatabase() throw(DatabaseException);

    QString m_queryString;

signals:
    void queryStringChanged();
};
