//#include "dashboardcontroller.h"

//dashboardcontroller::dashboardcontroller()
//{

//}

// dashboardcontroller.cpp
#include "dashboardcontroller.h"
#include <QtMath>
#include <QDateTime>
#include <numeric>

DashboardController::DashboardController(QObject *parent)
    : QObject(parent)
    , m_speed(0)
    , m_riskLevel(0)
{
     m_driverMonitor = new DriverMonitor(this);
    connect(&m_timer, &QTimer::timeout, this, &DashboardController::updateSpeed);
    m_timer.start(100);

    // Analyze driving behavior every second
    QTimer* analysisTimer = new QTimer(this);
    connect(analysisTimer, &QTimer::timeout, this, &DashboardController::analyzeDriving);
    analysisTimer->start(1000);
}

void DashboardController::updateSpeed()
{
    // Simulated speed with some random variation
    m_speed = 50 + 50 * qSin(QDateTime::currentMSecsSinceEpoch() / 1000.0);
    m_speedHistory.append(m_speed);

    // Keep last 10 seconds of speed data
    if (m_speedHistory.size() > 100) {
        m_speedHistory.removeFirst();
    }

    emit speedChanged();
}

void DashboardController::analyzeDriving()
{
    updateRiskLevel();
    m_drivingAdvice = generateAdvice();
    emit drivingAdviceChanged();
    emit riskLevelChanged();
}

void DashboardController::updateRiskLevel()
{
    int risk = 0;

    // Check for rapid acceleration
    if (detectRapidAcceleration()) {
        risk += 2;
    }

    // Check for sudden braking
    if (detectSuddenBraking()) {
        risk += 2;
    }

    // Check speed variation
    double variation = calculateSpeedVariation();
    if (variation > 10) {
        risk += 1;
    }

    m_riskLevel = qBound(0, risk, 5);
}

QString DashboardController::generateAdvice()
{
    if (detectRapidAcceleration()) {
        return "Smooth acceleration recommended";
    }
    if (detectSuddenBraking()) {
        return "Maintain safe following distance";
    }
    if (calculateSpeedVariation() > 10) {
        return "Try to maintain steady speed";
    }
    return "Good driving pattern";
}

double DashboardController::calculateSpeedVariation()
{
    if (m_speedHistory.size() < 2) return 0;

    QVector<double> variations;
    for (int i = 1; i < m_speedHistory.size(); ++i) {
        variations.append(qAbs(m_speedHistory[i] - m_speedHistory[i-1]));
    }

    return std::accumulate(variations.begin(), variations.end(), 0.0) / variations.size();
}

bool DashboardController::detectRapidAcceleration()
{
    if (m_speedHistory.size() < 10) return false;

    double acceleration = (m_speedHistory.last() - m_speedHistory[m_speedHistory.size()-10]) / 1.0; // 1 second
    return acceleration > 15; // More than 15 km/h per second
}

bool DashboardController::detectSuddenBraking()
{
    if (m_speedHistory.size() < 10) return false;

    double deceleration = (m_speedHistory[m_speedHistory.size()-10] - m_speedHistory.last()) / 1.0;
    return deceleration > 20; // More than 20 km/h per second
}
