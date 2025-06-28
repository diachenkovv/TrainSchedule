"""
Пакет конфігурації додатку
"""

from .api_config import APIConfig

# Налаштування додатку
APP_CONFIG = {
    "title": "Розклад поїздів України",
    "theme_color": "#3591E4",  # Новий акцентний колір
    "theme_color_light": "#213685",  # Колір для світлої теми
    "window_width": 800,
    "window_height": 600,
    "resizable": True
}

__all__ = ['APIConfig', 'APP_CONFIG']
