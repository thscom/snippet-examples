from typing import Optional, List, Tuple
from PySide6.QtCore import Qt
from PySide6.QtWidgets import QMainWindow, QPlainTextEdit, QListWidgetItem
from .mainwindow_ui import Ui_MainWindow
from langchain_ollama import ChatOllama
from enum import Enum


class MessageType(Enum):
    SYSTEM = "system"
    USER = "human"


class MainWindow(QMainWindow, Ui_MainWindow):
    _provider: str = "Ollama"
    _model: Optional[str] = None
    _llm: Optional[ChatOllama] = None
    _messages: List[Tuple[str, str]] = [
        (MessageType.SYSTEM.value, "You are a helpful assistant.")
    ]

    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setupUi(self)
        self._connect()
        print(MessageType.SYSTEM.value)

    def _connect(self):
        self.providerComboBox.currentIndexChanged.connect(
            self._on_provider_changed)
        self.modelComboBox.currentIndexChanged.connect(self._on_model_changed)
        self.connectBtn.clicked.connect(self._on_connect_llm)
        self.queryBtn.clicked.connect(self._on_message_commit)

    def _on_provider_changed(self, _: int):
        self._provider = self.providerComboBox.currentText()
        self._show_status(f"LLM provider changed: {self._provider}")

    def _on_model_changed(self, _: int):
        self._model = self.modelComboBox.currentText()
        self._show_status(f"LLM model changed: {self._model}")

    def _on_connect_llm(self):
        if self._model is None:
            self._show_status("No LLM model found!")
            return
        self._llm = ChatOllama(model=self._model, temperature=0)
        self._show_status(
            f"Provider: {self._provider}, Model: {self._model} connected!")

    def _show_status(self, msg: str):
        self.statusbar.showMessage(msg)

    def _on_message_commit(self):
        msg: str = str(self.messageInput.toPlainText()).strip()
        if len(msg) == 0:
            self._show_status("No input message!")
            return
        self._show_status(f"Input: {msg}")
        self._messages.append((MessageType.USER.value, msg))

        box = QPlainTextEdit()
        box.setSizeAdjustPolicy(
            QPlainTextEdit.SizeAdjustPolicy.AdjustToContentsOnFirstShow)
        box.setPlainText(msg)

        item = QListWidgetItem()
        self.messageList.addItem(item)
        self.messageList.setItemWidget(item, box)
        item.setSizeHint(box.sizeHint())

        resp = QPlainTextEdit()
        resp.setSizeAdjustPolicy(
            QPlainTextEdit.SizeAdjustPolicy.AdjustToContentsOnFirstShow)

        item2 = QListWidgetItem()
        self.messageList.addItem(item2)
        self.messageList.setItemWidget(item2, resp)
        item2.setSizeHint(resp.sizeHint())

        full: str = ""

        self._show_status("Thinking...")
        for chunk in self._llm.stream(self._messages):
            full += chunk.text()
            resp.setPlainText(full)
        self._messages.append((MessageType.SYSTEM.value, full))
        self._show_status("Complete")
