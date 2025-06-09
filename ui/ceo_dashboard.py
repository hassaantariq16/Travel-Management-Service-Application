from PyQt6.QtWidgets import QWidget, QLabel, QHBoxLayout, QVBoxLayout
from ui.components.sidebar import Sidebar

class CEODashboard(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("CEO Dashboard")
        self.setGeometry(200, 200, 1000, 700)

        layout = QHBoxLayout()

        self.sidebar = Sidebar(role='CEO')
        layout.addWidget(self.sidebar)

        main_content = QVBoxLayout()
        main_content.addWidget(QLabel("Welcome, CEO!"))
        layout.addLayout(main_content)

        self.setLayout(layout)
