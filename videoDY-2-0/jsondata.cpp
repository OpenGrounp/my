#include "jsondata.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

JsonData::JsonData(QObject *parent) : QObject (parent){
}

void JsonData::newJson()
{
    QJsonObject video1;
    QJsonObject video2;
    QJsonObject video3;
    QJsonObject video4;
    QJsonObject video5;
    QJsonObject video6;
    QJsonObject video7;
    video1.insert("id",1);
    video1.insert("video_source" , "../../assets/video/01.mp4");
    video1.insert("isLike", false);
    video1.insert("heartNum", 10);
    video2.insert("id",2);
    video2.insert("video_source" , "../../assets/video/02.mp4");
    video2.insert("isLike", false);
    video2.insert("heartNum", 10);
    video3.insert("id",3);
    video3.insert("video_source" , "../../assets/video/03.mp4");
    video3.insert("isLike", false);
    video3.insert("heartNum", 10);
    video4.insert("id",4);
    video4.insert("video_source" , "../../assets/video/04.mp4");
    video4.insert("isLike", false);
    video4.insert("heartNum", 10);
    video5.insert("id",5);
    video5.insert("video_source" , "../../assets/video/05.mp4");
    video5.insert("isLike", false);
    video5.insert("heartNum", 10);
    video6.insert("id",6);
    video6.insert("video_source" , "../../assets/video/06.mp4");
    video6.insert("isLike", false);
    video6.insert("heartNum", 10);
    video7.insert("id",7);
    video7.insert("video_source" , "../../assets/video/07.mp4");
    video7.insert("isLike", false);
    video7.insert("heartNum", 10);
//    QJsonArray videos;
    jsonData.append(video1);
    jsonData.append(video2);
    jsonData.append(video3);
    jsonData.append(video4);
    jsonData.append(video5);
    jsonData.append(video6);
    jsonData.append(video7);
    if(!saveJson()){
        qDebug() << "save error";
    }
}

bool JsonData::loadJson()
{

    QFile loadFile(QStringLiteral("dydata.json"));//(QStringLiteral("./dydata.json"));

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
    QFile saveFile(QStringLiteral("dydata.json"));;//Output.json"));

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
    newJson();
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

