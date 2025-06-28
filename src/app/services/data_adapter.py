"""
Адаптер для вибору джерела даних
Дозволяє перемикатися між mock-даними та реальним API
"""
from typing import List, Dict, Optional
from ..models.train import Train
from ..models.station import Station
from ..models.schedule import Schedule


class DataSourceAdapter:
    """Адаптер для роботи з різними джерелами даних"""
    
    def __init__(self, settings_service=None):
        # Інжектимо SettingsService або створюємо новий
        if settings_service is None:
            from .settings_service import SettingsService
            settings_service = SettingsService()
        
        self.settings_service = settings_service
        self.use_mock = not self.settings_service.is_real_api_enabled()
        
        # Lazy import для уникнення циклічних залежностей
        if self.use_mock:
            from .mock_data_service import MockDataService
            self.data_service = MockDataService()
        else:
            from .uz_api_service import UZApiService
            self.data_service = UZApiService()

    def refresh_data_source(self):
        """Оновлює джерело даних відповідно до поточних налаштувань"""
        use_mock_new = not self.settings_service.is_real_api_enabled()
        
        if use_mock_new != self.use_mock:
            self.use_mock = use_mock_new
            
            if self.use_mock:
                from .mock_data_service import MockDataService
                self.data_service = MockDataService()
            else:
                from .uz_api_service import UZApiService
                self.data_service = UZApiService()

    async def search_stations(self, query: str) -> List[Station]:
        """Пошук станцій"""
        if self.use_mock:
            return self.data_service.get_stations_by_query(query)
        else:
            return await self.data_service.search_stations(query)

    async def search_trains(self, from_station: str, to_station: str, date: str) -> List[Train]:
        """Пошук поїздів між станціями"""
        if self.use_mock:
            return self.data_service.get_trains_between_stations(from_station, to_station)
        else:
            return await self.data_service.search_trains(from_station, to_station, date)

    async def get_train_by_number(self, train_number: str) -> Optional[Train]:
        """Пошук поїзда за номером"""
        if self.use_mock:
            return self.data_service.get_train_by_number(train_number)
        else:
            # Для реального API може знадобитися додаткова логіка
            return None

    async def get_station_schedule(self, station_name: str) -> List[Dict]:
        """Розклад по станції"""
        if self.use_mock:
            return self.data_service.get_station_schedule(station_name)
        else:
            return await self.data_service.get_station_schedule(station_name, "")

    def switch_to_real_api(self):
        """Перемикання на реальний API"""
        if self.use_mock:
            self.use_mock = False
            from .uz_api_service import UZApiService
            self.data_service = UZApiService()
            APIConfig.USE_MOCK_DATA = False

    def switch_to_mock(self):
        """Перемикання на mock-дані"""
        if not self.use_mock:
            self.use_mock = True
            from .mock_data_service import MockDataService
            self.data_service = MockDataService()
            APIConfig.USE_MOCK_DATA = True

    def is_api_available(self) -> bool:
        """Перевірка доступності API"""
        if self.use_mock:
            return True
        else:
            return self.data_service.is_available()

    def get_source_info(self) -> Dict[str, str]:
        """Інформація про поточне джерело даних"""
        return {
            "type": "Mock Data" if self.use_mock else "Real API",
            "description": "Тестові дані" if self.use_mock else "УЗ API",
            "status": "Активно" if self.is_api_available() else "Недоступно"
        }
