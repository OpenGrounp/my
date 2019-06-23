#include "jsondata.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

JsonData::JsonData(QObject *parent) : QObject (parent){
}

bool JsonData::loadJson()
{

    QFile loadFile(QStringLiteral("../videoDY-2-0/assets/dydata.json"));//(QStringLiteral("./dydata.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

//    if(loadDoc.isNull()){
//        qDebug() << "This is a null";
//    }

//    if(loadDoc.isEmpty()){
//        qDebug() << "This is a empty";
//    }

    read(loadDoc.object());

    QTextStream(stdout) << "Loaded save for "
                        << loadDoc["video"][2]["heart_num"].toInt()
                        << " using "
                        << "JSON...\n";
    return true;

}

bool JsonData::saveJson(){
    QFile saveFile(QStringLiteral("../videoDY-2-0/assets/dydata.json"));;//Output.json"));

    if(!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject testObject;
    write(testObject);
    QJsonDocument saveDoc(testObject);
    saveFile.write(saveDoc.toJson());

    QTextStream(stdout) << "Loaded save for "
                        << saveDoc["video"][0]["isLike"].toBool()
            <<" using JSON ... END1\n";

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
    QJsonArray my;
    return my;
}

void JsonData::setJsonData(QJsonArray &json)
{
    jsonData = json;
    if(!saveJson()){
        qDebug() << "save error";
    }
}

void JsonData::write(QJsonObject &json) const
{
    QJsonArray jsonarray;
    for (int index = 0; index < jsonData.size(); index++) {
        QJsonObject onevideo;
        onevideo = jsonData[index].toObject();
        jsonarray.append(onevideo);
    }
    json["video"] = jsonarray;
    //qDebug() << jsonData[0]["isLike"];
    //qDebug() << jsonData[1]["isLike"];
    //qDebug() << json["video"][0]["isLike"];
}

void JsonData::dataUpdate()
{
    if(!saveJson()){
        qDebug() << "save error";
    }
}

