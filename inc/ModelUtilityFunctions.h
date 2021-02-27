#pragma once

#include "DatabaseException.h"
#include <QtDebug>
#include <QString>
#include <QSqlDatabase>
#include <QSqlQueryModel>
#include <QSqlQuery>
#include <QSqlError>

namespace ModelUtilityFunctions {

    extern void openDatabase(QSqlDatabase& database) throw(DatabaseException)
    {
        if (database.open() == false)
            throw(DatabaseException("Could not open the database!"));
        else
            qDebug("Database successfully opened!");
    }

    extern void executeQuery(QString queryString, QSqlQuery& query) throw(DatabaseException)
    {
        if (query.exec(queryString) == false)
            throw(DatabaseException("Exception: Could not complete the query: " + query.lastQuery() + "!"));
        else
            qDebug() << query.lastQuery() + " query completed!";
    }

    extern void updateModel(QSqlQueryModel& model, QSqlQuery& databaseQuery) throw(DatabaseException)
    {
        if (databaseQuery.isActive() && databaseQuery.isForwardOnly() == false)
        {
            model.setQuery(databaseQuery);

            if (model.lastError().type() != QSqlError::NoError)
                throw(DatabaseException("Exception: Could not update the model with query: "
                                        + databaseQuery.lastQuery() + "!"));
            else
                qDebug() << "Model set with query: " + databaseQuery.lastQuery() + "!";
        }
        else
            throw(DatabaseException(QString("Exception: Could not update the model, ")
                                    + QString("the query is not Active or is forwardOnly!")));
    }
}
