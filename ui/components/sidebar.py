from PyQt6.QtWidgets import QWidget, QVBoxLayout, QPushButton, QSizePolicy
from PyQt6.QtCore import QPropertyAnimation, QEasingCurve

class Sidebar(QWidget):
    def __init__(self, role):
        super().__init__()
        self.setFixedWidth(200)
        self.setSizePolicy(QSizePolicy.Policy.Fixed, QSizePolicy.Policy.Expanding)

        self.layout = QVBoxLayout()
        self.setLayout(self.layout)

        if role == 'CEO':
            buttons = ['Dashboard', 'Groups', 'Bookings', 'Reports', 'Users']
        else:
            buttons = ['Dashboard', 'Customers', 'Bookings']

        for name in buttons:
            btn = QPushButton(name)
            btn.setMinimumHeight(40)
            self.layout.addWidget(btn)

        self.animation = QPropertyAnimation(self, b"maximumWidth")
        self.animation.setDuration(300)
        self.animation.setEasingCurve(QEasingCurve.Type.InOutCubic)

    def toggle(self, show):
        self.animation.stop()
        if show:
            self.animation.setStartValue(0)
            self.animation.setEndValue(200)
        else:
            self.animation.setStartValue(200)
            self.animation.setEndValue(0)
        self.animation.start()
