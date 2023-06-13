#include "opencv2/core.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/highgui.hpp"
#include "opencv2/videoio.hpp"
#include <iostream>
#include <io.h>

using namespace cv;
using namespace std;

void drawText(Mat & image);

int main(int argc, char *argv[])
{
    if (argc <= 1) {
        cout << "input videofile path or camid " << endl;
        return -1;
    }
    cout << "Built with OpenCV " << CV_VERSION << endl;
    Mat image;
    VideoCapture capture;
    if (!access(argv[1], 0)) {
        capture.open(argv[1]);
        cout << "open video :" << argv[1] << endl;
    } else {
        capture.open(atoi(argv[1]));
        cout << "open camera :" << argv[1] << endl;
    }
    if(capture.isOpened())
    {
        cout << "Capture is opened" << endl;
        for(;;)
        {
            capture >> image;
            if(image.empty())
                break;
            drawText(image);
            imshow("Sample", image);
            if(waitKey(10) >= 0)
                break;
        }
    }
    else
    {
        cout << "No capture" << endl;
        image = Mat::zeros(480, 640, CV_8UC1);
        drawText(image);
        imshow("Sample", image);
        waitKey(0);
    }
    return 0;
}

void drawText(Mat & image)
{
    putText(image, "Hello OpenCV",
            Point(20, 50),
            FONT_HERSHEY_COMPLEX, 1, // font face and scale
            Scalar(255, 255, 255), // white
            1, LINE_AA); // line thickness and type
}
