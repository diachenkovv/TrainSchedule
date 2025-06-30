"""
Сервіс для роботи з налаштуваннями користувача
"""
import json
import os
from typing import Dict, Any
from .config_service import ConfigService


class SettingsService:
    """Сервіс для збереження та завантаження налаштувань користувача"""
    
    def __init__(self):
        # Використовуємо ConfigService для надійної роботи
        self.config_service = ConfigService()
        
        # Для відстеження змін
        self.current_settings = None
        self.pending_changes = {}
        self.has_unsaved_changes = False

    def load_settings(self) -> Dict[str, Any]:
        """Завантаження налаштувань"""
        try:
            settings = {
                'theme_mode': self.config_service.get('theme_mode', 'light'),
                'font_size': self.config_service.get('font_size', 14),
                'enable_animations': self.config_service.get('enable_animations', True),
                'enable_sounds': self.config_service.get('enable_sounds', False),
                'use_real_api': self.config_service.get('use_real_api', False),
                'language': self.config_service.get('language', 'uk')
            }
            self.current_settings = settings.copy()
            return settings
        except Exception as e:
            print(f"Помилка завантаження налаштувань: {e}")
            # Повертаємо дефолтні налаштування
            settings = {
                'theme_mode': 'light',
                'font_size': 14,
                'enable_animations': True,
                'enable_sounds': False,
                'use_real_api': False,
                'language': 'uk'
            }
            self.current_settings = settings.copy()
            return settings

    def save_settings(self, settings: Dict[str, Any]) -> bool:
        """Збереження налаштувань"""
        try:
            return self.config_service.update_multiple(settings)
        except Exception as e:
            print(f"Помилка збереження налаштувань: {e}")
            return False
    
    def get_setting(self, key: str, default=None):
        """Отримання конкретного налаштування"""
        return self.config_service.get(key, default)
    
    def set_setting(self, key: str, value: Any) -> bool:
        """Встановлення конкретного налаштування"""
        self.config_service.set(key, value)
        return self.config_service.save()
    
    def reset_settings(self) -> bool:
        """Скидання налаштувань до значень за замовчуванням"""
        try:
            return self.config_service.reset()
        except Exception as e:
            print(f"Помилка скидання налаштувань: {e}")
            return False

    def set_pending_change(self, key: str, value: Any):
        """Встановлення змін які ще не збережені"""
        self.pending_changes[key] = value
        self.has_unsaved_changes = True

    def has_changes(self) -> bool:
        """Перевірка наявності незбережених змін"""
        return self.has_unsaved_changes and len(self.pending_changes) > 0

    def save_pending_changes(self) -> bool:
        """Збереження всіх незбережених змін"""
        if not self.has_unsaved_changes or len(self.pending_changes) == 0:
            return True
            
        try:
            # Застосовуємо всі незбережені зміни
            success = self.config_service.update_multiple(self.pending_changes)
            if success:
                self.pending_changes.clear()
                self.has_unsaved_changes = False
                # Оновлюємо поточні налаштування
                self.current_settings = self.load_settings()
            return success
        except Exception as e:
            print(f"Помилка збереження змін: {e}")
            return False

    def discard_pending_changes(self):
        """Скасування незбережених змін"""
        self.pending_changes.clear()
        self.has_unsaved_changes = False

    def get_current_value(self, key: str, default=None):
        """Отримання поточного значення (включаючи незбережені зміни)"""
        if key in self.pending_changes:
            return self.pending_changes[key]
        if self.current_settings:
            return self.current_settings.get(key, default)
        return self.get_setting(key, default)

    def is_real_api_enabled(self) -> bool:
        """Перевіряє чи увімкнено реальне API"""
        # Спочатку перевіряємо незбережені зміни
        if 'use_real_api' in self.pending_changes:
            return self.pending_changes['use_real_api']
        
        # Потім перевіряємо збережені налаштування
        return self.config_service.get('use_real_api', False)

    def get_api_config(self) -> Dict[str, Any]:
        """Повертає конфігурацію API"""
        return self.config_service.get('api_config', {
            'base_url': 'https://booking.uz.gov.ua/',
            'timeout': 30,
            'user_agent': 'TrainSchedule/1.0'
        })

    def export_settings(self, export_path: str) -> bool:
        """Експорт налаштувань у зовнішній файл"""
        try:
            settings = self.load_settings()
            with open(export_path, 'w', encoding='utf-8') as f:
                json.dump(settings, f, ensure_ascii=False, indent=2)
            return True
        except Exception as e:
            print(f"Помилка експорту налаштувань: {e}")
            return False

    def import_settings(self, import_path: str) -> bool:
        """Імпорт налаштувань із зовнішнього файлу"""
        try:
            if os.path.exists(import_path):
                with open(import_path, 'r', encoding='utf-8') as f:
                    imported_settings = json.load(f)
                    
                # Валідуємо імпортовані налаштування
                valid_keys = ['theme_mode', 'font_size', 'enable_animations', 'enable_sounds', 'use_real_api', 'language']
                valid_settings = {}
                for key, value in imported_settings.items():
                    if key in valid_keys:
                        valid_settings[key] = value
                
                return self.config_service.update_multiple(valid_settings)
            return False
        except Exception as e:
            print(f"Помилка імпорту налаштувань: {e}")
            return False

    def get_config_path(self) -> str:
        """Повертає шлях до конфігураційного файлу"""
        return self.config_service.get_config_path()
