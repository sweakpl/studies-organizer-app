#include "DatabaseException.h"

DatabaseException::DatabaseException(const QString message) : _message(message) {}

QString DatabaseException::getMessage() const noexcept
{
    return _message;
}
