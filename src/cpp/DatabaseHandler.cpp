#pragma warning(disable:4290)

#include "DatabaseHandler.h"
#include "TableStructures.h"
#include <QCoreApplication>
#include <QDebug>
#include <QDateTime>

struct noteTableStructure databaseNoteTableStructure;
struct dayTableStructure databaseDayTableStructure;
struct eventTableStructure databaseEventTableStructure;

DatabaseHandler::DatabaseHandler(QObject *parent) : QObject(parent)
{
    database.setDatabaseName(databaseName);

    try {
        openDatabase();
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
        // We can't continue if the database hasn't been opened
        QCoreApplication::quit();
    }

    databaseQuery = QSqlQuery(database);

    createNoteTable();
    createDaysTables();
    createEventTable();
}

void DatabaseHandler::openDatabase() throw(DatabaseException)
{
    if (database.open() == false)
        throw(DatabaseException("Could not open the database!"));
    else
        qDebug("Database successfully opened!");
}

void DatabaseHandler::createNoteTable()
{
    QString queryString = "CREATE TABLE IF NOT EXISTS " + databaseNoteTableStructure.tableName + "("
            + databaseNoteTableStructure.primaryKeyName + " INTEGER NOT NULL PRIMARY KEY, "
            + databaseNoteTableStructure.noteColumnName + " VARCHAR(200));";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        e.getMessage();
    }
}

void DatabaseHandler::createDaysTables()
{
    QString tableValuesQueryPart = "(" + databaseDayTableStructure.primaryKeyName + " INTEGER NOT NULL PRIMARY KEY, "
            + databaseDayTableStructure.timeColumnName + " VARCHAR(5), "
            + databaseDayTableStructure.activityColumnName + " VARCHAR(50));";

    QString queryString;
    QString dayTableName;

    for (int dayOfTheWeekIndex = 0; dayOfTheWeekIndex < 5; dayOfTheWeekIndex++)
    {
        dayTableName = databaseDayTableStructure.tableNames[dayOfTheWeekIndex];

        queryString = "CREATE TABLE IF NOT EXISTS " + dayTableName + tableValuesQueryPart;

        try {
            executeQuery(queryString);
        }  catch (DatabaseException& e) {
            e.getMessage();
        }
    }
}

void DatabaseHandler::createEventTable()
{
    QString queryString = "CREATE TABLE IF NOT EXISTS " + databaseEventTableStructure.tableName + "("
            + databaseEventTableStructure.primaryKeyName + " INTEGER NOT NULL PRIMARY KEY, "
            + databaseEventTableStructure.timeColumnName + " VARCHAR(5), "
            + databaseEventTableStructure.dateColumnName + " VARCHAR(11), "
            + databaseEventTableStructure.eventColumnName + " VARCHAR(200), "
            + databaseEventTableStructure.secsSinceEpochColumnName + " VARCHAR(10));";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        e.getMessage();
    }
}

void DatabaseHandler::resetDatabase()
{
    QString queryStringBeginning = "DELETE FROM ";
    QString dayTableName;

    try {
        executeQuery(queryStringBeginning + databaseEventTableStructure.tableName);
    }  catch (DatabaseException& e) {
        e.getMessage();
    }

    try {
        executeQuery(queryStringBeginning + databaseNoteTableStructure.tableName);
    }  catch (DatabaseException& e) {
        e.getMessage();
    }

    for (int dayOfTheWeekIndex = 0; dayOfTheWeekIndex < 5; dayOfTheWeekIndex++)
    {
        dayTableName = databaseDayTableStructure.tableNames[dayOfTheWeekIndex];

        try {
            executeQuery(queryStringBeginning + dayTableName);
        }  catch (DatabaseException& e) {
            e.getMessage();
        }
    }
}

void DatabaseHandler::executeQuery(QString queryString) throw(DatabaseException)
{
    if (databaseQuery.exec(queryString) == false)
        throw(DatabaseException("Exception: Could not complete the query: " + databaseQuery.lastQuery() + "!"));
    else
        qDebug() << databaseQuery.lastQuery() + " query completed!";
}

// definitions at the end of the page
QString formatTextWithQuotes(QString text);
QString parseDateStringToSecsSinceEpochString(QString date, QString time);

void DatabaseHandler::addEvent(QString eventName, QString eventTime, QString eventDate)
{
    QString queryString = "INSERT INTO " + databaseEventTableStructure.tableName
            + " (" + databaseEventTableStructure.timeColumnName + ", "
            + databaseEventTableStructure.dateColumnName + ", "
            + databaseEventTableStructure.eventColumnName + ", "
            + databaseEventTableStructure.secsSinceEpochColumnName + ") VALUES(\""
            + eventTime + "\", \"" + eventDate + "\", \"" + formatTextWithQuotes(eventName) + "\", \""
            + parseDateStringToSecsSinceEpochString(eventDate, eventTime) + "\");";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::addActivity(QString dayName, QString activityName, QString activityTime)
{
    QString queryString = "INSERT INTO " + dayName
            + " (" + databaseDayTableStructure.timeColumnName + ", "
            + databaseDayTableStructure.activityColumnName + ") VALUES(\""
            + activityTime + "\", \"" + formatTextWithQuotes(activityName) + "\");";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::addNote(QString noteName)
{
    QString queryString = "INSERT INTO " + databaseNoteTableStructure.tableName
            + " (" + databaseNoteTableStructure.noteColumnName + ") VALUES(\""
            + formatTextWithQuotes(noteName) + "\");";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::deleteEvent(int primaryKey)
{
    QString queryString = "DELETE FROM " + databaseEventTableStructure.tableName
            + " WHERE " + databaseEventTableStructure.primaryKeyName + " = " + QString::number(primaryKey) + ";";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::deleteActivity(QString dayName, int primaryKey)
{
    QString queryString = "DELETE FROM " + dayName
            + " WHERE " + databaseDayTableStructure.primaryKeyName + " = " + QString::number(primaryKey) + ";";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::deleteNote(int primaryKey)
{
    QString queryString = "DELETE FROM " + databaseNoteTableStructure.tableName
            + " WHERE " + databaseNoteTableStructure.primaryKeyName + " = " + QString::number(primaryKey) + ";";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::editEvent(int primaryKey, QString eventName, QString eventTime, QString eventDate)
{
    QString queryString = "UPDATE " + databaseEventTableStructure.tableName
            + " SET " + databaseEventTableStructure.timeColumnName + " = \"" + eventTime + "\", "
            + databaseEventTableStructure.dateColumnName + " = \"" + eventDate + "\", "
            + databaseEventTableStructure.eventColumnName + " = \"" + formatTextWithQuotes(eventName) + "\", "
            + databaseEventTableStructure.secsSinceEpochColumnName + " = \"" + parseDateStringToSecsSinceEpochString(eventDate, eventTime)
            + "\" WHERE " + databaseEventTableStructure.primaryKeyName + " = " + QString::number(primaryKey) + ";";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::editActivity(QString dayName, int primaryKey, QString activityName, QString activityTime)
{
    QString queryString = "UPDATE " + dayName
            + " SET " + databaseDayTableStructure.timeColumnName + " = \"" + activityTime + "\", "
            + databaseDayTableStructure.activityColumnName + " = \"" + formatTextWithQuotes(activityName)
            + "\" WHERE " + databaseDayTableStructure.primaryKeyName + " = " + QString::number(primaryKey) + ";";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

void DatabaseHandler::editNote(int primaryKey, QString noteName)
{
    QString queryString = "UPDATE " + databaseNoteTableStructure.tableName
            + " SET " + databaseNoteTableStructure.noteColumnName + " = \"" + formatTextWithQuotes(noteName)
            + "\" WHERE " + databaseNoteTableStructure.primaryKeyName + " = " + QString::number(primaryKey) + ";";

    try {
        executeQuery(queryString);
    }  catch (DatabaseException& e) {
        qDebug() << e.getMessage();
    }
}

// Replace every occurence of " with ' to ensure the validity of the queries
QString formatTextWithQuotes(QString text)
{
    if (text.contains(QChar('"')))
        return text.replace(QChar('"'), "'");
    else
        return text;
}

QString parseDateStringToSecsSinceEpochString(QString date, QString time)
{
    QString dateTimeString = time + " " + date;

    QLocale locale = QLocale(QLocale::English, QLocale::UnitedKingdom);
    QDateTime dateTime = locale.toDateTime(dateTimeString, "hh:mm d MMM yyyy");

    return QString::number(dateTime.toSecsSinceEpoch());
}
