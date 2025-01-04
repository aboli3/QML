#ifndef DASHBOARDCONTROLLER_H
#define DASHBOARDCONTROLLER_H

//#include <QObject>

//class dashboardcontroller
//{
//    Q_OBJECT
//public:
//    dashboardcontroller();
//};


#include <QObject>
#include <QTimer>
#include <QVector>
#include "drivermonitor.h"

class DashboardController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(QString drivingAdvice READ drivingAdvice NOTIFY drivingAdviceChanged)
    Q_PROPERTY(int riskLevel READ riskLevel NOTIFY riskLevelChanged)
    Q_PROPERTY(DriverMonitor* driverMonitor READ driverMonitor CONSTANT)

public:
    explicit DashboardController(QObject *parent = nullptr);
    double speed() const { return m_speed; }
    QString drivingAdvice() const { return m_drivingAdvice; }
    int riskLevel() const { return m_riskLevel; }
      DriverMonitor* driverMonitor() const { return m_driverMonitor; }

signals:
    void speedChanged();
    void drivingAdviceChanged();
    void riskLevelChanged();

private slots:
    void updateSpeed();
    void analyzeDriving();

private:
    DriverMonitor* m_driverMonitor;

    double m_speed;
    QString m_drivingAdvice;
    int m_riskLevel;
    QTimer m_timer;
    QVector<double> m_speedHistory;

    // Simple AI methods
    void updateRiskLevel();
    QString generateAdvice();
    double calculateSpeedVariation();
    bool detectRapidAcceleration();
    bool detectSuddenBraking();
};


#endif // DASHBOARDCONTROLLER_H
