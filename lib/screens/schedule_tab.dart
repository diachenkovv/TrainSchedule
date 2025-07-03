import 'package:flutter/material.dart';
import '../providers/settings_provider.dart';
import '../models/train_result.dart';
import '../widgets/train_result_card.dart';
import '../widgets/station_autocomplete_field.dart';
import '../widgets/multi_select_train_type_field.dart';
import '../generated/l10n.dart';

class ScheduleTab extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const ScheduleTab({super.key, required this.settingsProvider});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  String? _selectedStation;
  DateTime _selectedDate = DateTime.now();
  List<String> _trainTypes = ['train_type_all'];
  String _scheduleType = 'departure'; // Використовуємо ключ
  List<ScheduleResult> _results = [];
  bool _isLoading = false;

  final List<String> _stations = [
    'Київ-Пасажирський',
    'Львів',
    'Одеса-Головна',
    'Харків-Пасажирський',
    'Дніпро-Головний',
    'Запоріжжя-1',
    'Івано-Франківськ',
    'Тернопіль',
    'Вінниця',
    'Чернівці',
    'Ужгород',
    'Полтава-Київська',
    'КривийРіг-Головний',
    'Маріуполь',
    'Херсон',
    'Черкаси',
    'Суми',
    'Чернігів',
  ];

  final List<String> _scheduleTypeKeys = [
    'departure',
    'arrival',
  ];

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

  void _searchSchedule() async {
    if (_selectedStation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).error_select_station)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _results = [];
    });

    // Симуляція запиту
    await Future.delayed(const Duration(seconds: 1));

    if (widget.settingsProvider.useMockData) {
      setState(() {
        _results = _getMockData();
        _isLoading = false;
      });
    }
  }

  List<ScheduleResult> _getMockData() {
    return [
      ScheduleResult(
        trainNumber: '091К',
        trainType: 'train_type_fast',
        destination: _scheduleType == 'departure' ? 'Львів' : 'Київ-Пасажирський',
        departureTime: '08:30',
        arrivalTime: '08:30',
        platform: '3',
        status: 'Вчасно',
      ),
      ScheduleResult(
        trainNumber: '743О',
        trainType: 'train_type_passenger',
        destination: _scheduleType == 'departure' ? 'Одеса-Головна' : 'Харків-Пасажирський',
        departureTime: '10:15',
        arrivalTime: '10:15',
        platform: '1',
        status: 'Затримка',
      ),
      ScheduleResult(
        trainNumber: '749К',
        trainType: 'train_type_express',
        destination: _scheduleType == 'departure' ? 'Дніпро-Головний' : 'Івано-Франківськ',
        departureTime: '12:45',
        arrivalTime: '12:45',
        platform: '2',
        status: 'Відправлено',
      ),
      ScheduleResult(
        trainNumber: '105І',
        trainType: 'train_type_intercity_plus',
        destination: _scheduleType == 'departure' ? 'Запоріжжя-1' : 'Тернопіль',
        departureTime: '14:20',
        arrivalTime: '14:20',
        platform: '4',
        status: 'Вчасно',
      ),
      ScheduleResult(
        trainNumber: '752П',
        trainType: 'train_type_passenger',
        destination: _scheduleType == 'departure' ? 'Вінниця' : 'Чернівці',
        departureTime: '16:55',
        arrivalTime: '16:55',
        platform: '5',
        status: 'Затримка',
      ),
    ];
  }

  String _getScheduleTypeName(BuildContext context, String key) {
    switch (key) {
      case 'departure':
        return S.of(context).schedule_type_departure;
      case 'arrival':
        return S.of(context).schedule_type_arrival;
      default:
        return key;
    }
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
                  StationAutocompleteField(
                    value: _selectedStation,
                    onChanged: (value) => setState(() => _selectedStation = value),
                    labelText: S.of(context).to_station,
                    prefixIcon: Icons.location_on,
                    stations: _stations,
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          children: [
                            Expanded(
                              child: InkWell(
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
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _scheduleType,
                                decoration: InputDecoration(
                                  labelText: S.of(context).schedule_type,
                                  prefixIcon: const Icon(Icons.schedule),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                ),
                                items: _scheduleTypeKeys.map((key) => DropdownMenuItem(
                                  value: key,
                                  child: Text(_getScheduleTypeName(context, key)),
                                )).toList(),
                                onChanged: (value) => setState(() => _scheduleType = value!),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
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
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _scheduleType,
                              decoration: InputDecoration(
                                labelText: S.of(context).schedule_type,
                                prefixIcon: const Icon(Icons.schedule),
                                border: const OutlineInputBorder(),
                                filled: true,
                              ),
                              items: _scheduleTypeKeys.map((key) => DropdownMenuItem(
                                value: key,
                                child: Text(_getScheduleTypeName(context, key)),
                              )).toList(),
                              onChanged: (value) => setState(() => _scheduleType = value!),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  MultiSelectTrainTypeField(
                    selectedTypes: _trainTypes,
                    onChanged: (value) => setState(() => _trainTypes = value),
                    labelText: S.of(context).train_type,
                    prefixIcon: Icons.train,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _searchSchedule,
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
          // Заголовок таблиці
          if (_results.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: constraints.maxWidth > 600 
                    ? Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(S.of(context).train_table_train, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(S.of(context).schedule_table_direction, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: Text(
                              _getScheduleTypeName(context, _scheduleType),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(S.of(context).schedule_table_platform, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                          Expanded(
                            child: Text(S.of(context).schedule_table_status, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(S.of(context).train_table_train, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(S.of(context).schedule_table_direction, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: Text(
                              _getScheduleTypeName(context, _scheduleType),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                );
              },
            ),
          // Результати пошуку
          if (_results.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) => ScheduleResultCard(
                  result: _results[index],
                ),
              ),
            ),
          if (_results.isEmpty && !_isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.schedule, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).empty_schedule_search,
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
