#include "DatabaseHandler.h"
#include "AbstractSqlModel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    app.setOrganizationName("sweak");
    app.setOrganizationDomain("sweak.com");
    app.setApplicationName("studiesorganizer");

    qmlRegisterType<DatabaseHandler>("com.sweak.databasehandler", 1, 0, "DatabaseHandler");
    qmlRegisterType<AbstractSqlModel>("com.sweak.abstractsqlmodel", 1, 0, "AbstractSqlModel");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
