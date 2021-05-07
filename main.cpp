#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQuickView>
#include <QUrl>
#include <QQmlEngine>

#include "filewatcher.h"

#define LIVE

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

#ifdef LIVE
    QGuiApplication app(argc, argv);

    QQuickView view;

    const QDir DIRECTORY("C:/Users/Szafer/QtProjects/SoloNobleQuick");
    const QUrl SOURCE_URL = QUrl::fromLocalFile(DIRECTORY.filePath("Game.qml"));

    view.setSource(SOURCE_URL);
    view.setWidth(800);
    view.setHeight(600);
    view.show();

    FileWatcher watcher([&view, SOURCE_URL](){
        view.engine()->clearComponentCache();
        view.setSource(SOURCE_URL);
        view.setWidth(800);
        view.setHeight(600);
    });

    watcher.setDirectory(DIRECTORY.absolutePath());

    return app.exec();
#else
    QGuiApplication app(argc, argv);

    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
#endif
}
