#pragma once
#pragma warning(disable:4290)

#include "DatabaseException.h"
#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>

class DatabaseHandler : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseHandler(QObject *parent = nullptr);

    Q_INVOKABLE void resetDatabase();

    Q_INVOKABLE void addEvent(QString eventName, QString eventTime, QString eventDate);
    Q_INVOKABLE void addActivity(QString dayName, QString eventName, QString eventTime);
    Q_INVOKABLE void addNote(QString noteName);

    Q_INVOKABLE void deleteEvent(int primaryKey);
    Q_INVOKABLE void deleteActivity(QString dayName, int primaryKey);
    Q_INVOKABLE void deleteNote(int primaryKey);

    Q_INVOKABLE void editEvent(int primaryKey, QString eventName, QString eventTime, QString eventDate);
    Q_INVOKABLE void editActivity(QString dayName, int primaryKey, QString activityName, QString activityTime);
    Q_INVOKABLE void editNote(int primaryKey, QString noteName);

private:
    QSqlDatabase database = QSqlDatabase::addDatabase("QSQLITE", "studiesorganizer");
    QSqlQuery databaseQuery;

    QString databaseName = "studiesorganizer.sqlite";

    void openDatabase() throw(DatabaseException);
    void executeQuery(QString queryString) throw(DatabaseException);
    void createNoteTable();
    void createDaysTables();
    void createEventTable();
};
