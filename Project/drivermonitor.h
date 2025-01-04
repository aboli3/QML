#ifndef DRIVERMONITOR_H
#define DRIVERMONITOR_H

#include <QObject>
#include <QQuickItem>

//#include <QObject>
#include <QTimer>
#include <QImage>    // Add this
#include <opencv2/opencv.hpp>
//#include <dlib/image_processing.hpp>
#include "C:/Users/Aboli/dlib-19.24/dlib-19.24/source/dlib/image_processing.h"
#include "C:/Users/Aboli/dlib-19.24/dlib-19.24/source/dlib/image_processing/frontal_face_detector.h"
//#include <dlib/image_processing/frontal_face_detector.h>
#include "C:/Users/Aboli/dlib-19.24/dlib-19.24/source/dlib/opencv.h"
//#include <dlib/opencv.h>

//class DriverMonitor
//{
//    Q_OBJECT
//public:
//    DriverMonitor();
//};

class DriverMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isDriverAlert READ isDriverAlert NOTIFY alertnessChanged)
    Q_PROPERTY(double eyeAspectRatio READ eyeAspectRatio NOTIFY eyeAspectRatioChanged)
    Q_PROPERTY(QString alertnessStatus READ alertnessStatus NOTIFY alertnessStatusChanged)

public:
    explicit DriverMonitor(QObject *parent = nullptr);
    bool isDriverAlert() const { return m_isDriverAlert; }
    double eyeAspectRatio() const { return m_eyeAspectRatio; }
    QString alertnessStatus() const { return m_alertnessStatus; }

public slots:
    void processFrame(const QImage& frame);

signals:
    void alertnessChanged();
    void eyeAspectRatioChanged();
    void alertnessStatusChanged();

private:
    bool m_isDriverAlert;
    double m_eyeAspectRatio;
    QString m_alertnessStatus;

    dlib::frontal_face_detector m_faceDetector;
    dlib::shape_predictor m_shapePredictor;

    double calculateEAR(const std::vector<dlib::point>& eyePoints);
    void updateAlertnessStatus();
};


#endif // DRIVERMONITOR_H
