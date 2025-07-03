class TrainResult {
  final String trainNumber;
  final String trainType;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String price;
  final int availableSeats;
  final String fullRoute; // Повний маршрут поїзда

  TrainResult({
    required this.trainNumber,
    required this.trainType,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.availableSeats,
    required this.fullRoute,
  });
}

class ScheduleResult {
  final String trainNumber;
  final String trainType;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String platform;
  final String status;

  ScheduleResult({
    required this.trainNumber,
    required this.trainType,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.platform,
    required this.status,
  });
}

class TrainInfo {
  final String trainNumber;
  final String trainType;
  final String route;
  final List<TrainStop> stops;

  TrainInfo({
    required this.trainNumber,
    required this.trainType,
    required this.route,
    required this.stops,
  });
}

class TrainStop {
  final String station;
  final String arrivalTime;
  final String departureTime;
  final int stayTime;
  final String platform;

  TrainStop({
    required this.station,
    required this.arrivalTime,
    required this.departureTime,
    required this.stayTime,
    required this.platform,
  });
}
