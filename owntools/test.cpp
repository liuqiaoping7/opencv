#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;

int main() {
    VideoCapture cap(0);
    if (!cap.isOpened()) {
        cout << "Cannot open camera\n";
        return 1;
    }
    Mat frame;
    while (true) {
        bool ret = cap.read(frame); // or cap >> frame;
        if (!ret) {
            cout << "Can't receive frame (stream end?). Exiting ...\n";
            break;
        }
        imshow("live", frame);
        if (waitKey(1) == 'q') {
            break;
        }
    }
    return 0;
}