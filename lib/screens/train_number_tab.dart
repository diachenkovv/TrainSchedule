import 'package:flutter/material.dart';
import '../providers/settings_provider.dart';
import '../models/train_result.dart';
import '../generated/l10n.dart';

class TrainNumberTab extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const TrainNumberTab({super.key, required this.settingsProvider});

  @override
  State<TrainNumberTab> createState() => _TrainNumberTabState();
}

class _TrainNumberTabState extends State<TrainNumberTab> {
  final TextEditingController _trainNumberController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TrainInfo? _trainInfo;
  bool _isLoading = false;

  @override
  void dispose() {
    _trainNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('uk', 'UA'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: const Color(0xFF2B2E7F),
              headerForegroundColor: Colors.white,
              weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              dayStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _searchTrain() async {
    if (_trainNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).error_enter_train_number)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _trainInfo = null;
    });

    // Симуляція запиту
    await Future.delayed(const Duration(seconds: 1));

    if (widget.settingsProvider.useMockData) {
      setState(() {
        _trainInfo = _getMockData();
        _isLoading = false;
      });
    }
  }

  TrainInfo _getMockData() {
    return TrainInfo(
      trainNumber: _trainNumberController.text.trim(),
      trainType: 'Швидкий',
      route: 'Київ-Пасажирський — Львів',
      stops: [
        TrainStop(
          station: 'Київ-Пасажирський',
          arrivalTime: '—',
          departureTime: '08:30',
          stayTime: 0,
          platform: '3',
        ),
        TrainStop(
          station: 'Житомир',
          arrivalTime: '09:45',
          departureTime: '09:48',
          stayTime: 3,
          platform: '2',
        ),
        TrainStop(
          station: 'Новоград-Волинський',
          arrivalTime: '10:32',
          departureTime: '10:34',
          stayTime: 2,
          platform: '1',
        ),
        TrainStop(
          station: 'Рівне',
          arrivalTime: '11:18',
          departureTime: '11:22',
          stayTime: 4,
          platform: '3',
        ),
        TrainStop(
          station: 'Дубно',
          arrivalTime: '11:55',
          departureTime: '11:57',
          stayTime: 2,
          platform: '2',
        ),
        TrainStop(
          station: 'Радивилів',
          arrivalTime: '12:28',
          departureTime: '12:30',
          stayTime: 2,
          platform: '1',
        ),
        TrainStop(
          station: 'Красне',
          arrivalTime: '13:15',
          departureTime: '13:17',
          stayTime: 2,
          platform: '2',
        ),
        TrainStop(
          station: 'Львів',
          arrivalTime: '14:20',
          departureTime: '—',
          stayTime: 0,
          platform: '4',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Форма пошуку
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _trainNumberController,
                    decoration: InputDecoration(
                      labelText: S.of(context).train_number,
                      prefixIcon: const Icon(Icons.train),
                      hintText: S.of(context).train_number_hint,
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(8),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: S.of(context).date,
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: const OutlineInputBorder(),
                        filled: true,
                      ),
                      child: Text(
                        '${_selectedDate.day.toString().padLeft(2, '0')}.${_selectedDate.month.toString().padLeft(2, '0')}.${_selectedDate.year}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _searchTrain,
                    icon: _isLoading 
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.search),
                    label: Text(_isLoading ? S.of(context).search + '...' : S.of(context).find_trains),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Інформація про поїзд
          if (_trainInfo != null)
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Заголовок з інформацією про поїзд
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '${S.of(context).train_table_train} ${_trainInfo!.trainNumber}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                _trainInfo!.trainType,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.of(context).train_table_route + ': ${_trainInfo!.route}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Заголовок таблиці
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(S.of(context).train_table_station, style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                child: Text(S.of(context).train_table_arrival, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                              Expanded(
                                child: Text(S.of(context).train_table_departure, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                              Expanded(
                                child: Text(S.of(context).train_table_stop, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                              Expanded(
                                child: Text(S.of(context).train_table_platform, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Список зупинок
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _trainInfo!.stops.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final stop = _trainInfo!.stops[index];
                            final isFirst = index == 0;
                            final isLast = index == _trainInfo!.stops.length - 1;
                            
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: isFirst ? Colors.green : isLast ? Colors.red : Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            stop.station,
                                            style: TextStyle(
                                              fontWeight: isFirst || isLast ? FontWeight.bold : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      stop.arrivalTime,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: stop.arrivalTime == '—' ? Colors.grey : null,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      stop.departureTime,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: stop.departureTime == '—' ? Colors.grey : null,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      stop.stayTime > 0 ? '${stop.stayTime} ${S.of(context).duration_minute}' : '—',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: stop.stayTime == 0 ? Colors.grey : null,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      stop.platform,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (_trainInfo == null && !_isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.train, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).empty_train_search,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
