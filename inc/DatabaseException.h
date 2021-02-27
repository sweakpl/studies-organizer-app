#pragma once

#include <QString>

class DatabaseException
{
public:
    DatabaseException(const QString message);
    QString getMessage() const noexcept;

private:
    QString _message;
};
