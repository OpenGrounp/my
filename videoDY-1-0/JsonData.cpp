#include "JsonData.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

JsonData::JsonData(QObject *parent) : QObject (parent){
}

bool JsonData::loadJson()
{

    QFile loadFile(QStringLiteral("../videoDY-1-0/dydata.json")); //"/run/media/root/data/projects/videoDY/dydata.json"));//(QStringLiteral("./dydata.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    if(loadDoc.isNull()){
        qDebug() << "This is a null";
    }

    if(loadDoc.isEmpty()){
        qDebug() << "This is a empty";
    }

    read(loadDoc.object());

    QTextStream(stdout) << "Loaded save for "
                        << loadDoc["video"][2]["heart_num"].toString()
                        << " using "
                        << "JSON...\n";
    return true;

}

bool JsonData::saveJson(){
    QFile saveFile(QStringLiteral("../dydata.json"));

    if(!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject testObject;
    write(testObject);
    QJsonDocument saveDoc(testObject);
    saveFile.write(saveDoc.toJson());

    QTextStream(stdout) << "Loaded save for"
                        << saveDoc["video"][2]["isLike"].toString()
            <<"using JSON ... END\n";

    return true;
}

void JsonData::read(const QJsonObject &json)
{
    if(json.contains("video") && json["video"].isArray()){
        jsonData = json["video"].toArray();
        qDebug() << "This Video is array";
    }
    if(jsonData[2].isObject())
        qDebug() << "Every item is a object";
}


QJsonArray JsonData::getJsonData()
{
    if(loadJson()){
        qDebug() << "getMyTest()";
        return jsonData;
    }
    QTextStream(stdout) << "Here is error\n";
}

void JsonData::setJsonData(QJsonArray &json)
{
    jsonData = json;
    if(!saveJson()){
        qDebug() << "save error";
    }
    //emit dataChanged();
}

void JsonData::write(QJsonObject &json) const
{
    json["video"] = jsonData;
}
