/********************************************
 * 本模块实现了like-data-json文件的读取，在qml访问过程中会创建这个json文件，会保存人员关于是否点赞的信息
 * 时间：2019-06-24
 * 开发人员：
 *********************************************
 *********************************************/

#include "jsondatalike.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

JsonDataLike::JsonDataLike(QObject *parent) : QObject (parent){
}

bool JsonDataLike::loadJson()
{
    QFile loadFile(QStringLiteral("dydata_like.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());

    QTextStream(stdout) << "Loaded save for "
                        << loadDoc["video"][2]["heart_num"].toInt()
                        << " using "
                        << "JSON...\n";
    return true;

}

bool JsonDataLike::saveJson(){
    QFile saveFile(QStringLiteral("dydata_like.json"));

    if(!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject testObject;
    write(testObject);
    QJsonDocument saveDoc(testObject);
    saveFile.write(saveDoc.toJson());

    QTextStream(stdout) << "Loaded save for "
                        //<< saveDoc["video"][0]["isLike"].toBool()
                        <<" using JSON ... END2\n";

    return true;
}

void JsonDataLike::read(const QJsonObject &json)
{
    if(json.contains("video") && json["video"].isArray()){
        jsonDataLike = json["video"].toArray();
        qDebug() << "This Video is array";
    }
    if(jsonDataLike[2].isObject())
        qDebug() << "Every item is a object";
}


QJsonArray JsonDataLike::getJsonData()
{
    if(loadJson()){
        qDebug() << "getMyTest()";
        return jsonDataLike;
    }
    QTextStream(stdout) << "Here is error\n";
    QJsonArray my;
    return my;
}

void JsonDataLike::setJsonData(QJsonArray &json)
{
    jsonDataLike = json;
    if(!saveJson()){
        qDebug() << "save error....";
    }
}

void JsonDataLike::write(QJsonObject &json) const
{
    QJsonArray jsonarray;
    for (int index = 0; index < jsonDataLike.size(); index++) {
        QJsonObject onevideo;
        onevideo = jsonDataLike[index].toObject();
        jsonarray.append(onevideo);
    }
    json["video"] = jsonarray;
}

void JsonDataLike::dataUpdate()
{
    if(!saveJson()){
        qDebug() << "save error";
    }
}

