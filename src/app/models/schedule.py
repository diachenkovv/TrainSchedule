from .train import Train
from .station import Station

class Schedule:
    def __init__(self, train: Train, departure_station: Station, arrival_station: Station, departure_time: str, arrival_time: str):
        self.train = train
        self.departure_station = departure_station
        self.arrival_station = arrival_station
        self.departure_time = departure_time
        self.arrival_time = arrival_time

