"""
Конфігурація API та зовнішніх сервісів
"""

class APIConfig:
    """Конфігурація для роботи з API"""
    
    # УЗ API endpoints
    UZ_BASE_URL = "https://booking.uz.gov.ua"
    UZ_SEARCH_URL = f"{UZ_BASE_URL}/purchase/search/"
    UZ_STATION_URL = f"{UZ_BASE_URL}/purchase/station/"
    
    # Тайм-аути
    REQUEST_TIMEOUT = 10
    CONNECTION_TIMEOUT = 5
    
    # Headers для запитів
    DEFAULT_HEADERS = {
        'User-Agent': 'TrainScheduleApp/1.0.0 (https://github.com/techbedo/trainschedule)',
        'Accept': 'application/json, text/javascript, */*; q=0.01',
        'Accept-Language': 'uk-UA,uk;q=0.9,en;q=0.8',
        'X-Requested-With': 'XMLHttpRequest'
    }
    
    # Режими роботи
    USE_MOCK_DATA = True  # True для тестування, False для реальних даних
    CACHE_ENABLED = True
    CACHE_DURATION = 300  # 5 хвилин
    
    # Альтернативні джерела даних
    ALTERNATIVE_APIs = [
        "https://api.railway.ua/",  # Гіпотетичний альтернативний API
        "https://traininfo.gov.ua/api/"  # Гіпотетичний державний API
    ]
