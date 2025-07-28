import os
import cv2
from PySide6.QtCore import QSize, Qt
from PySide6.QtWidgets import QApplication, QMainWindow, QLabel
from PySide6.QtGui import QImage, QPixmap, QGuiApplication

origin_image_path = os.path.join(
    os.path.dirname(__file__), 'res', 'car01.jpeg')


def img_to_pixmap(img: cv2.Mat) -> QPixmap:
    h, w, c = img.shape
    q_image = QImage(img.data, w, h, w * c, QImage.Format_RGB888)
    pixmap = QPixmap.fromImage(q_image)
    return pixmap


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('MainWindow')
        self.resize(800, 600)

        screen = QGuiApplication.primaryScreen()
        screen_size = screen.size()
        self.move(int((screen_size.width() - self.width()) / 2),
                  int((screen_size.height() - self.height()) / 2))

    def loadImage(self):
        image = cv2.imread(origin_image_path)
        image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        pixmap = img_to_pixmap(image_rgb)

        self.label = QLabel()
        # self.label.setFixedSize(400, 300)
        # 自动保持比例缩放
        # self.label.setScaledContents(True)
        self.label.setAlignment(Qt.AlignmentFlag.AlignCenter)

        # 手动保持比例缩放
        pixmap = pixmap.scaled(
            QSize(400, 300),
            Qt.AspectRatioMode.KeepAspectRatio,
            Qt.TransformationMode.SmoothTransformation
        )
        self.label.setPixmap(pixmap)

        self.setCentralWidget(self.label)


if __name__ == '__main__':
    app = QApplication([])
    window = MainWindow()
    window.initUI()
    window.loadImage()
    window.show()
    app.exec()
