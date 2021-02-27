#pragma once

#include <QList>
#include <QString>

struct dayTableStructure {
    QList<QString> tableNames = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
    QString primaryKeyName = "ID";
    QString timeColumnName = "ActivityTime";
    QString activityColumnName = "ActivityName";
};

struct noteTableStructure {
    QString tableName = "Notes";
    QString primaryKeyName = "ID";
    QString noteColumnName = "NoteName";
};

struct eventTableStructure {
    QString tableName = "Events";
    QString primaryKeyName = "ID";
    QString timeColumnName = "EventTime";
    QString dateColumnName = "EventDate";
    QString eventColumnName = "EventName";
    QString secsSinceEpochColumnName = "SecsSinceEpoch";
};

extern struct noteTableStructure databaseNoteTableStructure;
extern struct dayTableStructure databaseDayTableStructure;
extern struct eventTableStructure databaseEventTableStructure;
