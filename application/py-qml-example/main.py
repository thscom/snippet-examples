import os
from pathlib import Path
import sys
from PySide6.QtCore import QCoreApplication
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


def main():
    os.environ["QML_XHR_ALLOW_FILE_READ"] = "1"

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(
        os.fspath(Path(__file__).resolve().parent / "qml/mainwindow.qml")
    )
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
