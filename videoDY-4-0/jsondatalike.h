#ifndef JSONDATALIKE_H
#define JSONDATALIKE_H

#include <QString>
#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

class JsonDataLike : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray jsonDataLike READ getJsonData WRITE setJsonData NOTIFY dataChanged)
    //Q_PROPERTY(bool isLike WRITE setIsLike)

public:
    JsonDataLike(QObject *parent = nullptr);

    QJsonArray getJsonData();
    void setJsonData(QJsonArray &json);

    bool loadJson();
    bool saveJson();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

signals:
    void dataChanged();

public slots:
    void dataUpdate();

private:
    QJsonArray jsonDataLike;
};

#endif // JSONDATALIKE_H
