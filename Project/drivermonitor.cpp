//#include "drivermonitor.h"

//DriverMonitor::DriverMonitor()
//{

//}


// drivermonitor.cpp
#include "drivermonitor.h"
#include <QDebug>

DriverMonitor::DriverMonitor(QObject *parent)
    : QObject(parent)
    , m_isDriverAlert(true)
    , m_eyeAspectRatio(0.0)
{
    m_faceDetector = dlib::get_frontal_face_detector();
    dlib::deserialize("shape_predictor_68_face_landmarks.dat") >> m_shapePredictor;
}

void DriverMonitor::processFrame(const QImage& frame)
{
    // Convert QImage to OpenCV Mat
    cv::Mat cvFrame = cv::Mat(
        frame.height(),
        frame.width(),
        CV_8UC4,
        (void*)frame.constBits(),
        frame.bytesPerLine()
    ).clone();

    // Convert to grayscale
    cv::Mat gray;
    cv::cvtColor(cvFrame, gray, cv::COLOR_BGR2GRAY);

    // Convert OpenCV Mat to dlib format
    dlib::cv_image<unsigned char> dlibImg(gray);

    // Detect faces
    auto faces = m_faceDetector(dlibImg);

    if (faces.size() > 0) {
        // Get facial landmarks
        auto shape = m_shapePredictor(dlibImg, faces[0]);

        // Calculate Eye Aspect Ratio
        std::vector<dlib::point> leftEye;
        std::vector<dlib::point> rightEye;

        // Extract eye landmarks
        for(int i = 36; i <= 41; ++i)
            leftEye.push_back(shape.part(i));
        for(int i = 42; i <= 47; ++i)
            rightEye.push_back(shape.part(i));

        double leftEAR = calculateEAR(leftEye);
        double rightEAR = calculateEAR(rightEye);

        m_eyeAspectRatio = (leftEAR + rightEAR) / 2.0;
        emit eyeAspectRatioChanged();

        // Update alertness status
        updateAlertnessStatus();
    }
}

double DriverMonitor::calculateEAR(const std::vector<dlib::point>& eyePoints)
{
    // Calculate the eye aspect ratio using the formula
    double a = std::hypot(eyePoints[1].x() - eyePoints[5].x(),
                         eyePoints[1].y() - eyePoints[5].y());
    double b = std::hypot(eyePoints[2].x() - eyePoints[4].x(),
                         eyePoints[2].y() - eyePoints[4].y());
    double c = std::hypot(eyePoints[0].x() - eyePoints[3].x(),
                         eyePoints[0].y() - eyePoints[3].y());

    return (a + b) / (2.0 * c);
}

void DriverMonitor::updateAlertnessStatus()
{
    const double EAR_THRESHOLD = 0.25;

    m_isDriverAlert = (m_eyeAspectRatio > EAR_THRESHOLD);

    if (m_isDriverAlert) {
        m_alertnessStatus = "Driver Alert";
    } else {
        m_alertnessStatus = "Driver Fatigue Detected!";
    }

    emit alertnessChanged();
    emit alertnessStatusChanged();
}
