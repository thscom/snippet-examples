from PySide6.QtWidgets import QApplication
from ui.mainwindow import MainWindow
import sys


def main():
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
