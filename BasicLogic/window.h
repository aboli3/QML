#ifndef WINDOW_H
#define WINDOW_H
#include <QObject>
#include <QDebug>

class window:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString entity READ entity WRITE setEntity NOTIFY entityChanged)
public:
    window();
    Q_INVOKABLE void display(QString);

    QString entity()const{
        return m_entity;
    }

    void setEntity(const QString& str){
        m_entity = str;
        emit entityChanged();
    }
signals:
    void entityChanged();
private:
    QString m_entity;
};

#endif // WINDOW_H
