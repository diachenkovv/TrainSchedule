"""
Сервіс для роботи з API Укрзалізниці
Підключення до реальних даних розкладу поїздів
"""
import requests
import json
from datetime import datetime, timedelta
from typing import List, Dict, Optional
from ..models.train import Train
from ..models.station import Station
from ..models.schedule import Schedule


class UZApiService:
    """Сервіс для роботи з API Укрзалізниці"""
    
    BASE_URL = "https://booking.uz.gov.ua"
    API_URL = f"{BASE_URL}/purchase/search/"
    STATION_URL = f"{BASE_URL}/purchase/station/"
    
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Accept': 'application/json, text/javascript, */*; q=0.01',
            'Accept-Language': 'uk-UA,uk;q=0.9,en;q=0.8',
            'X-Requested-With': 'XMLHttpRequest'
        })

    async def search_stations(self, query: str) -> List[Station]:
        """Пошук станцій за назвою"""
        try:
            url = f"{self.STATION_URL}{query}/"
            response = self.session.get(url, timeout=10)
            
            if response.status_code == 200:
                data = response.json()
                stations = []
                
                for item in data.get('value', []):
                    station = Station(
                        station_id=item.get('station_id'),
                        name=item.get('title'),
                        region=item.get('region', ''),
                        code=item.get('value', '')
                    )
                    stations.append(station)
                
                return stations
            else:
                print(f"Помилка API: {response.status_code}")
                return []
                
        except Exception as e:
            print(f"Помилка при пошуку станцій: {e}")
            return []

    async def search_trains(self, from_station: str, to_station: str, date: str) -> List[Train]:
        """Пошук поїздів між станціями"""
        try:
            params = {
                'from': from_station,
                'to': to_station,
                'date': date,
                'time': '00:00'
            }
            
            response = self.session.post(self.API_URL, data=params, timeout=15)
            
            if response.status_code == 200:
                data = response.json()
                trains = []
                
                for item in data.get('value', []):
                    train = Train(
                        number=item.get('num'),
                        route=f"{item.get('from')} - {item.get('to')}",
                        departure_time=item.get('from_time'),
                        arrival_time=item.get('to_time'),
                        travel_time=item.get('travel_time'),
                        train_type=self._determine_train_type(item.get('num', '')),
                        departure_station=item.get('from'),
                        arrival_station=item.get('to'),
                        departure_date=date
                    )
                    trains.append(train)
                
                return trains
            else:
                print(f"Помилка API: {response.status_code}")
                return []
                
        except Exception as e:
            print(f"Помилка при пошуку поїздів: {e}")
            return []

    async def get_train_schedule(self, train_number: str, date: str) -> Optional[Schedule]:
        """Отримання детального розкладу поїзда"""
        try:
            # Тут буде логіка для отримання детального розкладу
            # УЗ API може мати обмеження, тому поки повертаємо None
            return None
                
        except Exception as e:
            print(f"Помилка при отриманні розкладу поїзда: {e}")
            return None

    async def get_station_schedule(self, station_code: str, date: str) -> List[Dict]:
        """Отримання розкладу по станції"""
        try:
            # Тут буде логіка для отримання розкладу по станції
            # УЗ API може не надавати такі дані публічно
            return []
                
        except Exception as e:
            print(f"Помилка при отриманні розкладу станції: {e}")
            return []

    def _determine_train_type(self, train_number: str) -> str:
        """Визначення типу поїзда за номером"""
        if not train_number:
            return "інший"
            
        try:
            num = int(train_number)
            
            # Логіка визначення типу поїзда за номером УЗ
            if 1 <= num <= 99:
                return "швидкий"
            elif 100 <= num <= 149:
                return "пасажирський" 
            elif 700 <= num <= 799:
                return "приміський"
            elif num >= 9000:
                return "нічний"
            else:
                return "пасажирський"
                
        except ValueError:
            return "інший"

    def format_date_for_api(self, date: datetime) -> str:
        """Форматування дати для API УЗ"""
        return date.strftime("%Y-%m-%d")

    def is_available(self) -> bool:
        """Перевірка доступності API"""
        try:
            response = self.session.get(self.BASE_URL, timeout=5)
            return response.status_code == 200
        except:
            return False
