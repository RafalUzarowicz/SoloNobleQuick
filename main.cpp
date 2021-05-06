#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQuickView>
#include <QUrl>
#include <QQmlEngine>

#include "filewatcher.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQuickView view;

    const QDir DIRECTORY("C:/Users/Szafer/QtProjects/SoloNobleQuick");
    const QUrl SOURCE_URL = QUrl::fromLocalFile(DIRECTORY.filePath("main.qml"));

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

//    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    const QUrl url(QStringLiteral("qrc:/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

//    return app.exec();
}
