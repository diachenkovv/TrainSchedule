"""
Конфігурація додатку розкладу поїздів
"""

# Налаштування додатку
APP_CONFIG = {
    "title": "Розклад поїздів України",
    "theme_color": "#3591E4",  # Новий акцентний колір
    "theme_color_light": "#213685",  # Колір для світлої теми
    "window_width": 800,
    "window_height": 600,
    "resizable": True
}

# Налаштування сервера розробки
DEV_CONFIG = {
    "host": "localhost",
    "port": 8000,
    "debug": True
}

# Налаштування API (для майбутнього використання)
API_CONFIG = {
    "base_url": "https://api.uz.gov.ua",
    "timeout": 30,
    "retries": 3
}

# Налаштування кешування
CACHE_CONFIG = {
    "enable": True,
    "ttl": 300,  # 5 хвилин
    "max_size": 100
}
