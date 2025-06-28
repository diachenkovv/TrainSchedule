"""
Демонстраційні дані для тестування додатку
"""

# Демонстраційні станції
DEMO_STATIONS = [
    {"name": "Київ-Пасажирський", "code": "2200001"},
    {"name": "Харків-Пасажирський", "code": "2200009"},
    {"name": "Львів", "code": "2200007"},
    {"name": "Одеса-Головна", "code": "2200006"},
    {"name": "Дніпро-Головний", "code": "2200004"},
    {"name": "Запоріжжя-1", "code": "2200002"},
    {"name": "Полтава-Київська", "code": "2200010"},
    {"name": "Житомир", "code": "2200011"},
    {"name": "Вінниця", "code": "2200012"},
    {"name": "Суми", "code": "2200013"},
    {"name": "Чернігів", "code": "2200014"},
    {"name": "Черкаси", "code": "2200015"},
    {"name": "Кременчук", "code": "2200016"},
    {"name": "Фастів", "code": "2200017"},
    {"name": "Ніжин", "code": "2200018"},
    {"name": "Васильків", "code": "2200019"},
    {"name": "Коростень", "code": "2200020"},
    {"name": "Рівне", "code": "2200021"},
    {"name": "Миколаїв", "code": "2200022"}
]

# Демонстраційні поїзди
DEMO_TRAINS = [
    {
        "number": "143",
        "name": "Харків - Львів",
        "type": "passenger",
        "stations": [
            {"station": "Харків-Пасажирський", "arrival": None, "departure": "07:50", "platform": "1"},
            {"station": "Полтава-Київська", "arrival": "09:32", "departure": "09:37", "platform": "2"},
            {"station": "Київ-Пасажирський", "arrival": "12:15", "departure": "12:35", "platform": "3"},
            {"station": "Житомир", "arrival": "14:28", "departure": "14:33", "platform": "1"},
            {"station": "Коростень", "arrival": "15:45", "departure": "15:50", "platform": "2"},
            {"station": "Рівне", "arrival": "17:22", "departure": "17:27", "platform": "1"},
            {"station": "Львів", "arrival": "20:30", "departure": None, "platform": "4"}
        ]
    },
    {
        "number": "87",
        "name": "Одеса - Суми",
        "type": "passenger", 
        "stations": [
            {"station": "Одеса-Головна", "arrival": None, "departure": "08:20", "platform": "2"},
            {"station": "Миколаїв", "arrival": "10:15", "departure": "10:22", "platform": "1"},
            {"station": "Кременчук", "arrival": "13:45", "departure": "13:52", "platform": "3"},
            {"station": "Полтава-Південна", "arrival": "15:30", "departure": "15:37", "platform": "2"},
            {"station": "Суми", "arrival": "18:45", "departure": None, "platform": "1"}
        ]
    },
    {
        "number": "291",
        "name": "Запоріжжя - Чернігів",
        "type": "passenger",
        "stations": [
            {"station": "Запоріжжя-1", "arrival": None, "departure": "06:30", "platform": "3"},
            {"station": "Дніпро-Головний", "arrival": "08:15", "departure": "08:25", "platform": "2"},
            {"station": "Полтава-Київська", "arrival": "11:40", "departure": "11:47", "platform": "1"},
            {"station": "Київ-Пасажирський", "arrival": "14:20", "departure": "14:40", "platform": "5"},
            {"station": "Ніжин", "arrival": "16:25", "departure": "16:30", "platform": "2"},
            {"station": "Чернігів", "arrival": "17:45", "departure": None, "platform": "1"}
        ]
    },
    {
        "number": "6301",
        "name": "Київ - Фастів",
        "type": "suburban",
        "stations": [
            {"station": "Київ-Пасажирський", "arrival": None, "departure": "09:15", "platform": "5"},
            {"station": "Васильків", "arrival": "09:52", "departure": "09:54", "platform": "1"},
            {"station": "Фастів", "arrival": "10:25", "departure": None, "platform": "2"}
        ]
    },
    {
        "number": "6455",
        "name": "Київ - Ніжин",
        "type": "suburban",
        "stations": [
            {"station": "Київ-Пасажирський", "arrival": None, "departure": "07:30", "platform": "4"},
            {"station": "Ніжин", "arrival": "09:45", "departure": None, "platform": "1"}
        ]
    }
]

# Статуси поїздів
TRAIN_STATUSES = [
    "За розкладом",
    "Затримка 5 хв",
    "Затримка 10 хв", 
    "Затримка 15 хв",
    "Затримка 20 хв",
    "Скасовано"
]

def get_stations_list():
    """Повертає список станцій для автодоповнення"""
    return [station["name"] for station in DEMO_STATIONS]

def get_train_by_number(number: str):
    """Знаходить поїзд за номером"""
    for train in DEMO_TRAINS:
        if train["number"] == number:
            return train
    return None

def get_trains_between_stations(departure: str, arrival: str):
    """Знаходить поїзди між станціями"""
    matching_trains = []
    
    for train in DEMO_TRAINS:
        stations = [s["station"] for s in train["stations"]]
        
        if departure in stations and arrival in stations:
            dep_index = stations.index(departure)
            arr_index = stations.index(arrival)
            
            # Перевіряємо, що станція відправлення йде раніше за станцію прибуття
            if dep_index < arr_index:
                departure_info = train["stations"][dep_index]
                arrival_info = train["stations"][arr_index]
                
                matching_trains.append({
                    "train": train,
                    "departure_time": departure_info["departure"],
                    "arrival_time": arrival_info["arrival"],
                    "departure_platform": departure_info["platform"],
                    "arrival_platform": arrival_info["platform"]
                })
    
    return matching_trains

def get_station_schedule(station_name: str):
    """Повертає розклад для станції"""
    schedule = []
    
    for train in DEMO_TRAINS:
        for station_info in train["stations"]:
            if station_info["station"] == station_name:
                schedule.append({
                    "train": train,
                    "arrival": station_info["arrival"],
                    "departure": station_info["departure"], 
                    "platform": station_info["platform"]
                })
                break
    
    return schedule

class MockDataService:
    """Сервіс для роботи з демонстраційними даними"""
    
    def get_stations_by_query(self, query: str):
        """Пошук станцій за запитом"""
        from ..models.station import Station
        
        if not query:
            return []
        
        query_lower = query.lower()
        result = []
        
        for station_data in DEMO_STATIONS:
            if query_lower in station_data["name"].lower():
                station = Station(
                    name=station_data["name"],
                    code=station_data["code"]
                )
                result.append(station)
        
        return result[:10]  # Обмежуємо до 10 результатів
    
    def search_trains(self, from_station: str, to_station: str, date: str = None):
        """Пошук поїздів між станціями"""
        from ..models.train import Train
        
        # Фільтруємо поїзди які проходять через обидві станції
        result = []
        
        for train_data in DEMO_TRAINS:
            stations = [s["station"] for s in train_data["stations"]]
            
            if from_station in stations and to_station in stations:
                # Перевіряємо порядок станцій
                from_idx = stations.index(from_station)
                to_idx = stations.index(to_station)
                
                if from_idx < to_idx:
                    train = Train(
                        number=train_data["number"],
                        train_type=train_data["type"]
                    )
                    # Додаємо додаткові атрибути
                    train.name = train_data["name"]
                    train.from_station = from_station
                    train.to_station = to_station
                    train.departure_time = train_data["stations"][from_idx]["departure"]
                    train.arrival_time = train_data["stations"][to_idx]["arrival"]
                    result.append(train)
        
        return result
    
    def get_station_schedule(self, station_name: str):
        """Отримання розкладу для станції"""
        schedule = []
        
        for train in DEMO_TRAINS:
            for station_info in train["stations"]:
                if station_info["station"] == station_name:
                    schedule.append({
                        "train": train,
                        "arrival": station_info["arrival"],
                        "departure": station_info["departure"], 
                        "platform": station_info["platform"]
                    })
                    break
        
        return schedule
