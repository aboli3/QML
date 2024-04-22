#include "window.h"
#include <QDebug>

window::window()
{
    qDebug()<<"window construct\n";
}

void window::display(QString str)
{
    qDebug()<<"str : "<<str<<"\n";
    setEntity(str);
}
