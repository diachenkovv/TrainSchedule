import json
import os
from typing import Dict, Any, Optional
from pathlib import Path


class ConfigService:
    """Сервіс для роботи з конфігураційним файлом"""
    
    def __init__(self):
        # Шлях до конфігураційного файлу
        self.config_dir = Path.home() / ".train_schedule"
        self.config_file = self.config_dir / "config.json"
        
        # Налаштування за замовчуванням
        self.default_config = {
            "theme_mode": "light",
            "font_size": 14,
            "enable_animations": True,
            "enable_sounds": False,
            "use_real_api": False,
            "api_config": {
                "base_url": "https://booking.uz.gov.ua/",
                "timeout": 30,
                "user_agent": "TrainSchedule/1.0"
            },
            "ui_config": {
                "colors": {
                    "light_theme": "#213685",
                    "dark_theme": "#3591E4"
                }
            }
        }
        
        # Створюємо директорію якщо не існує
        self._ensure_config_dir()
        
        # Завантажуємо конфігурацію
        self.config = self._load_config()
    
    def _ensure_config_dir(self):
        """Створює директорію для конфігурації якщо не існує"""
        try:
            self.config_dir.mkdir(parents=True, exist_ok=True)
        except Exception as e:
            print(f"Помилка створення директорії конфігурації: {e}")
    
    def _load_config(self) -> Dict[str, Any]:
        """Завантажує конфігурацію з файлу"""
        try:
            if self.config_file.exists():
                with open(self.config_file, 'r', encoding='utf-8') as f:
                    loaded_config = json.load(f)
                
                # Об'єднуємо з дефолтними налаштуваннями
                config = self.default_config.copy()
                config.update(loaded_config)
                return config
            else:
                # Створюємо новий файл з дефолтними налаштуваннями
                self._save_config(self.default_config)
                return self.default_config.copy()
        except Exception as e:
            print(f"Помилка завантаження конфігурації: {e}")
            return self.default_config.copy()
    
    def _save_config(self, config: Dict[str, Any]) -> bool:
        """Зберігає конфігурацію у файл"""
        try:
            with open(self.config_file, 'w', encoding='utf-8') as f:
                json.dump(config, f, indent=2, ensure_ascii=False)
            return True
        except Exception as e:
            print(f"Помилка збереження конфігурації: {e}")
            return False
    
    def get(self, key: str, default: Any = None) -> Any:
        """Отримує значення з конфігурації"""
        keys = key.split('.')
        value = self.config
        
        try:
            for k in keys:
                value = value[k]
            return value
        except (KeyError, TypeError):
            return default
    
    def set(self, key: str, value: Any):
        """Встановлює значення в конфігурації"""
        keys = key.split('.')
        config = self.config
        
        # Навігуємо до потрібного рівня
        for k in keys[:-1]:
            if k not in config:
                config[k] = {}
            config = config[k]
        
        # Встановлюємо значення
        config[keys[-1]] = value
    
    def save(self) -> bool:
        """Зберігає поточну конфігурацію"""
        return self._save_config(self.config)
    
    def reset(self) -> bool:
        """Скидає конфігурацію до дефолтних значень"""
        self.config = self.default_config.copy()
        return self.save()
    
    def get_all(self) -> Dict[str, Any]:
        """Повертає всю конфігурацію"""
        return self.config.copy()
    
    def update_multiple(self, updates: Dict[str, Any]) -> bool:
        """Оновлює кілька значень одразу"""
        try:
            for key, value in updates.items():
                self.set(key, value)
            return self.save()
        except Exception as e:
            print(f"Помилка оновлення конфігурації: {e}")
            return False
    
    def get_config_path(self) -> str:
        """Повертає шлях до конфігураційного файлу"""
        return str(self.config_file)
    
    def is_config_exists(self) -> bool:
        """Перевіряє чи існує конфігураційний файл"""
        return self.config_file.exists()
