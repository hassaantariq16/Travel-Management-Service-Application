# dashboard.py
from PyQt5.QtWidgets import QWidget, QLabel, QVBoxLayout

class CEODashboard(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("CEO Dashboard")
        layout = QVBoxLayout()
        layout.addWidget(QLabel("CEO Dashboard View"))
        self.setLayout(layout)

class EmployeeDashboard(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Employee Dashboard")
        layout = QVBoxLayout()
        layout.addWidget(QLabel("Employee Dashboard View"))
        self.setLayout(layout)

def open_dashboard(role_id, user_id):
    if role_id == 1:
        dash = CEODashboard()
    else:
        dash = EmployeeDashboard()
    dash.show()
    dash.exec_() if hasattr(dash, 'exec_') else dash.raise_()
