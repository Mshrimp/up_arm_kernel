#include "widget.h"
#include "ui_widget.h"
#include <QDebug>

Widget::Widget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Widget)
{
    ui->setupUi(this);
    this->showFullScreen();
   // qDebug() << this->geometry().width();
   // qDebug() << this->geometry().height();
   // ui->pushButton->move((this->geometry().width()-ui->pushButton->size().width())/2,
   //                      (this->geometry().height()-ui->pushButton->size().height())/2);

}

Widget::~Widget()
{
    delete ui;
}
