from PyQt6.QtWidgets import QWidget, QLabel, QHBoxLayout, QVBoxLayout
from ui.components.sidebar import Sidebar

class EmployeeDashboard(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Employee Dashboard")
        self.setGeometry(200, 200, 1000, 700)

        layout = QHBoxLayout()

        self.sidebar = Sidebar(role='Employee')
        layout.addWidget(self.sidebar)

        main_content = QVBoxLayout()
        main_content.addWidget(QLabel("Welcome, Employee!"))
        layout.addLayout(main_content)

        self.setLayout(layout)
