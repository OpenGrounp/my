#ifndef TEST_H
#define TEST_H

#include <QString>
#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

class JsonData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray jsonData READ getJsonData WRITE setJsonData NOTIFY dataChanged)
    //Q_PROPERTY(bool isLike WRITE setIsLike)

public:
    JsonData(QObject *parent = nullptr);

    QJsonArray getJsonData();
    void setJsonData(QJsonArray &json);

    bool loadJson();
    bool saveJson();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

signals:
    void dataChanged();

private:
    QJsonArray jsonData;
};

#endif // TEST_H
