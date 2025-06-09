from PyQt6.QtWidgets import QWidget, QLabel, QLineEdit, QPushButton, QVBoxLayout, QMessageBox
from auth import authenticate_user
from ui.ceo_dashboard import CEODashboard
from ui.employee_dashboard import EmployeeDashboard


class LoginWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Travel Management - Login")
        self.setGeometry(100, 100, 300, 200)

        layout = QVBoxLayout()

        self.username_input = QLineEdit()
        self.username_input.setPlaceholderText("Username")

        self.password_input = QLineEdit()
        self.password_input.setPlaceholderText("Password")
        self.password_input.setEchoMode(QLineEdit.EchoMode.Password)

        self.login_button = QPushButton("Login")
        self.login_button.clicked.connect(self.handle_login)

        layout.addWidget(QLabel("Login"))
        layout.addWidget(self.username_input)
        layout.addWidget(self.password_input)
        layout.addWidget(self.login_button)

        self.setLayout(layout)

    def handle_login(self):
        username = self.username_input.text()
        password = self.password_input.text()

        role = authenticate_user(username, password)
        if role == 'CEO':
            self.dashboard = CEODashboard()
            self.dashboard.show()
            self.close()
        elif role == 'Employee':
            self.dashboard = EmployeeDashboard()
            self.dashboard.show()
            self.close()
        else:
            QMessageBox.warning(self, "Login Failed", "Invalid username or password.")
