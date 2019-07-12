/********************************************
 * 本模块实现了json文件的读取，如果是第一次打开文件则会新建一个json文件，在后续使用过程中则会打开已经创建的json文件
 * 本模块读取的是视频资源的文件，以及保存视频的状态，包括视频路径，点赞人数，是否喜欢等
 * 时间：2019-06-24
 * 开发人员：
 *********************************************
 *********************************************/

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

    video1.insert("image_source" , "../../assets/images/picture/01.png");
    video1.insert("video_source" , "../../assets/video/01.mp4");
    video1.insert("isLike", false);
    video1.insert("heart_num", "20");
    video2.insert("id",2);
    video2.insert("video_source" , "../../assets/video/02.mp4");
    video2.insert("image_source" , "../../assets/images/picture/02.png");
    video2.insert("isLike", false);
    video2.insert("heart_num", "35");
    video3.insert("id",3);
    video3.insert("video_source" , "../../assets/video/03.mp4");
    video3.insert("image_source" , "../../assets/images/picture/03.png");
    video3.insert("isLike", false);
    video3.insert("heart_num", "10");
    video4.insert("id",4);
    video4.insert("video_source" , "../../assets/video/04.mp4");
    video4.insert("image_source" , "../../assets/images/picture/04.png");
    video4.insert("isLike", false);
    video4.insert("heart_num", "17");
    video5.insert("id",5);
    video5.insert("video_source" , "../../assets/video/05.mp4");
    video5.insert("image_source" , "../../assets/images/picture/05.png");
    video5.insert("isLike", false);
    video5.insert("heart_num", "19");
    video6.insert("id",6);
    video6.insert("video_source" , "../../assets/video/06.mp4");
    video6.insert("image_source" , "../../assets/images/picture/06.png");
    video6.insert("isLike", false);
    video6.insert("heart_num", "50");
    video7.insert("id",7);
    video7.insert("video_source" , "../../assets/video/07.mp4");
    video7.insert("image_source" , "../../assets/images/picture/07.png");
    video7.insert("isLike", false);
    video7.insert("heart_num", "37");
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

    QFile loadFile(QStringLiteral("dydata.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());

    QTextStream(stdout) << "Loaded save for "
                        << loadDoc["video"][1]["heart_num"].toInt()
                        << " using "
                        << "JSON...\n";
    return true;

}

bool JsonData::saveJson(){
    QFile saveFile(QStringLiteral("dydata.json"));

    if(!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.....");
        return false;
    }

    QJsonObject testObject;
    write(testObject);
    QJsonDocument saveDoc(testObject);
    saveFile.write(saveDoc.toJson());

    QTextStream(stdout) << "Loaded save for "
                        //<< saveDoc["video"][0]["isLike"].toBool()
                        <<" using JSON ... END1\n";

    return true;
}

void JsonData::read(const QJsonObject &json)
{
    if(json.contains("video") && json["video"].isArray()){
        jsonData = json["video"].toArray();
        qDebug() << "This Video is array";
    }
}


QJsonArray JsonData::getJsonData()
{
    if(!loadJson()){
        newJson();
        if(loadJson()){
            qDebug() << "getMyNewData()";
            return jsonData;
        }
    }else {
        qDebug() << "getMyOldData()";
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
    //emit dataChanged();
}

void JsonData::write(QJsonObject &json) const
{
    QJsonArray jsonarray;
    for (int index = 0; index < jsonData.size(); index++) {
        QJsonObject onevideo;
        onevideo = jsonData[index].toObject();
         //qDebug() << jsonData[index]["isLike"];
        jsonarray.append(onevideo);
    }
    json["video"] = jsonarray;
}

void JsonData::dataUpdate()
{
    if(!saveJson()){
        qDebug() << "save error";
    }
}

