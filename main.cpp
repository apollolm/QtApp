#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QUrlQuery>
#include <QVariant>
#include <QJsonValue>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVariantMap>
#include <QJsonArray>

void sendRequest();

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    sendRequest();
    return app.exec();
}

void sendRequest(){

    // create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    QNetworkRequest req( QUrl( QString("http://spatialserver.spatialdev.com/services/tables/library_2014/query?format=geojson&returnGeometry=yes&returnGeometryEnvelopes=no&limit=10") ) );
    QNetworkReply *reply = mgr.get(req);
    eventLoop.exec(); // blocks stack until "finished()" has been called

//    if (reply->error() == QNetworkReply::NoError) {
//        //success
//        qDebug() << "Success" <<reply->readAll();
//        delete reply;
//    }
//    else {
//        //failure
//        qDebug() << "Failure" <<reply->errorString();
//        delete reply;
//    }

    if (reply->error() == QNetworkReply::NoError) {

            QString strReply = (QString)reply->readAll();

            //parse json
            qDebug() << "Response:" << strReply;
            QJsonDocument jsonResponse = QJsonDocument::fromJson(strReply.toUtf8());

            QJsonObject jsonObject = jsonResponse.object();

            //qDebug() << "Time:" << jsonObj["time"].toString();
            //qDebug() << "Date:" << jsonObj["date"].toString();

            QJsonArray features = jsonObject["features"].toArray();

             foreach (const QJsonValue & feature, features)
             {
                 QJsonObject featureObj = feature.toObject();

                 QJsonObject propertiesObj = featureObj["properties"].toObject();

                 qDebug() << "Name:" << propertiesObj["name"].toString();
                 qDebug() << "Address:" << propertiesObj["address"].toString();
             }

            delete reply;
        }
        else {
            //failure
            qDebug() << "Failure" <<reply->errorString();
            delete reply;
        }
}
