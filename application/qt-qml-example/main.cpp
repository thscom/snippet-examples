#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "backend.h"

static QObject *GetBackend(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    return Backend::instance();
}


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6,0,0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/qml/Calendar.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    qmlRegisterSingletonType<Backend>("App.Backend", 1, 0, "Backend", GetBackend);
    engine.rootContext()->setContextProperty("Backend2", new Backend2);
    // engine.loadFromModule("qtqml/qml", "Canvas3");
    engine.load(url);

    return app.exec();
}
