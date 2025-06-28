"""
Сервіс для роботи з розкладом поїздів
"""
from typing import List, Dict, Optional
from .data_adapter import DataSourceAdapter
from ..models.train import Train
from ..models.station import Station
from ..models.schedule import Schedule


class ScheduleService:
    """Основний сервіс для роботи з розкладом"""
    
    def __init__(self, settings_service=None):
        # Передаємо SettingsService в DataSourceAdapter
        self.data_adapter = DataSourceAdapter(settings_service)
        self.settings_service = settings_service
    
    async def search_route(self, from_station: str, to_station: str, date: str = None) -> List[Train]:
        """Пошук маршруту між станціями"""
        if not from_station or not to_station:
            return []
        
        return await self.data_adapter.search_trains(from_station, to_station, date or "")
    
    async def get_station_schedule(self, station_name: str) -> List[Dict]:
        """Отримання розкладу по станції"""
        if not station_name:
            return []
            
        return await self.data_adapter.get_station_schedule(station_name)
    
    async def find_train_by_number(self, train_number: str) -> Optional[Train]:
        """Пошук поїзда за номером"""
        if not train_number:
            return None
            
        return await self.data_adapter.get_train_by_number(train_number)
    
    async def search_stations(self, query: str) -> List[Station]:
        """Пошук станцій за назвою"""
        if not query or len(query) < 2:
            return []
            
        return await self.data_adapter.search_stations(query)
    
    def switch_data_source(self, use_real_api: bool = False):
        """Перемикання джерела даних"""
        if use_real_api:
            self.data_adapter.switch_to_real_api()
        else:
            self.data_adapter.switch_to_mock()
    
    def get_data_source_info(self) -> Dict[str, str]:
        """Інформація про поточне джерело даних"""
        return self.data_adapter.get_source_info()
    
    def is_service_available(self) -> bool:
        """Перевірка доступності сервісу"""
        return self.data_adapter.is_api_available()
    
    def refresh_data_source(self):
        """Оновлює джерело даних відповідно до поточних налаштувань"""
        self.data_adapter.refresh_data_source()

    # Старі методи для сумісності (deprecated)
    def get_schedule_between_stations(self, from_station: str, to_station: str):
        """Застарілий метод. Використовуйте search_route()"""
        import asyncio
        return asyncio.run(self.search_route(from_station, to_station))

    def get_schedule_by_station(self, station: str, train_type: str = None):
        """Застарілий метод. Використовуйте get_station_schedule()"""
        import asyncio
        return asyncio.run(self.get_station_schedule(station))

    def get_schedule_by_train_number(self, train_number: str):
        """Застарілий метод. Використовуйте find_train_by_number()"""
        import asyncio
        return asyncio.run(self.find_train_by_number(train_number))

