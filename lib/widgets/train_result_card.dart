import 'package:flutter/material.dart';
import 'package:trainshedule/generated/l10n.dart';
import '../models/train_result.dart';

class TrainResultCard extends StatelessWidget {
  final TrainResult result;
  final bool showFullRoute;

  const TrainResultCard({
    super.key, 
    required this.result,
    this.showFullRoute = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    '${s.train_table_train} ${result.trainNumber}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getTrainTypeColor(result.trainType, context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getTrainTypeIcon(result.trainType, context),
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getTrainTypeName(context, result.trainType),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.departure_board,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            result.departureTime,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result.from,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      const SizedBox(height: 4),
                      Text(
                        _formatDuration(context, result.duration),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            result.arrivalTime,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result.to,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            showFullRoute ? 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.route,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        s.full_route,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.train,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            result.fullRoute,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${s.from_price} ${result.price}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    '${s.seats}: ${result.availableSeats}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: result.availableSeats > 50 ? Colors.green : 
                             result.availableSeats > 10 ? Colors.orange : Colors.red,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(BuildContext context, String duration) {
    // Очікується формат "2 г 15 хв" або "2 h 15 m"
    final s = S.of(context);
    return duration
      .replaceAll(RegExp(r'\bг\b'), s.duration_hour)
      .replaceAll(RegExp(r'\bгод\b'), s.duration_hour)
      .replaceAll(RegExp(r'\bh\b'), s.duration_hour)
      .replaceAll(RegExp(r'\bхв\b'), s.duration_minute)
      .replaceAll(RegExp(r'\bm\b'), s.duration_minute)
      .replaceAll('min', s.duration_minute);
  }

  String _getTrainTypeName(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'train_type_all':
        return s.train_type_all;
      case 'train_type_fast':
        return s.train_type_fast;
      case 'train_type_passenger':
        return s.train_type_passenger;
      case 'train_type_express':
        return s.train_type_express;
      case 'train_type_intercity':
        return s.train_type_intercity;
      case 'train_type_intercity_plus':
        return s.train_type_intercity_plus;
      case 'train_type_suburban':
        return s.train_type_suburban;
      case 'train_type_regional':
        return s.train_type_regional;
      default:
        return key;
    }
  }

  Color _getTrainTypeColor(String key, BuildContext context) {
    switch (key) {
      case 'train_type_intercity_plus':
        return Colors.red;
      case 'train_type_intercity':
        return Colors.purple;
      case 'train_type_express':
        return Colors.blue;
      case 'train_type_fast':
        return Colors.green;
      case 'train_type_passenger':
        return Colors.orange;
      case 'train_type_suburban':
        return Colors.teal;
      case 'train_type_regional':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  IconData _getTrainTypeIcon(String key, BuildContext context) {
    switch (key) {
      case 'train_type_intercity_plus':
        return Icons.speed;
      case 'train_type_intercity':
        return Icons.trending_up;
      case 'train_type_express':
        return Icons.flash_on;
      case 'train_type_fast':
        return Icons.directions_transit;
      case 'train_type_passenger':
        return Icons.train;
      case 'train_type_suburban':
        return Icons.directions_subway;
      case 'train_type_regional':
        return Icons.directions_railway;
      default:
        return Icons.train;
    }
  }

  String _getStatusName(BuildContext context, String status) {
    final s = S.of(context);
    switch (status) {
      case 'on_time':
      case 'Вчасно':
        return s.status_on_time;
      case 'delayed':
      case 'Затримка':
        return s.status_delayed;
      case 'departed':
      case 'Відправлено':
        return s.status_departed;
      case 'cancelled':
      case 'Скасовано':
        return s.status_cancelled;
      default:
        return status;
    }
  }
}

class ScheduleResultCard extends StatelessWidget {
  final ScheduleResult result;

  const ScheduleResultCard({super.key, required this.result});

  String _getTrainTypeName(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'train_type_all':
        return s.train_type_all;
      case 'train_type_fast':
        return s.train_type_fast;
      case 'train_type_passenger':
        return s.train_type_passenger;
      case 'train_type_express':
        return s.train_type_express;
      case 'train_type_intercity':
        return s.train_type_intercity;
      case 'train_type_intercity_plus':
        return s.train_type_intercity_plus;
      case 'train_type_suburban':
        return s.train_type_suburban;
      case 'train_type_regional':
        return s.train_type_regional;
      default:
        return key;
    }
  }

  String _getStatusName(BuildContext context, String status) {
    final s = S.of(context);
    switch (status) {
      case 'on_time':
      case 'Вчасно':
        return s.status_on_time;
      case 'delayed':
      case 'Затримка':
        return s.status_delayed;
      case 'departed':
      case 'Відправлено':
        return s.status_departed;
      case 'cancelled':
      case 'Скасовано':
        return s.status_cancelled;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).train_table_train} ${result.trainNumber}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getTrainTypeName(context, result.trainType),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      result.destination,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      result.departureTime,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${S.of(context).schedule_table_platform} ${result.platform}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(_getStatusName(context, result.status), context),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStatusName(context, result.status),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S.of(context).train_table_train} ${result.trainNumber}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getTrainTypeName(context, result.trainType),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(_getStatusName(context, result.status), context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusName(context, result.status),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result.destination,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        result.departureTime,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${S.of(context).schedule_table_platform} ${result.platform}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status, BuildContext context) {
    final s = S.of(context);
    switch (status) {
      case var t when t == s.status_on_time:
        return Colors.green;
      case var t when t == s.status_delayed:
        return Colors.red;
      case var t when t == s.status_departed:
        return Colors.blue;
      case var t when t == s.status_cancelled:
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }
}
