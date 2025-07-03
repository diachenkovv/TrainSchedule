import 'package:flutter/material.dart';
import '../providers/settings_provider.dart';
import '../models/train_result.dart';
import '../widgets/train_result_card.dart';
import '../widgets/station_autocomplete_field.dart';
import '../widgets/multi_select_train_type_field.dart';

class ScheduleTab extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const ScheduleTab({super.key, required this.settingsProvider});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  String? _selectedStation;
  DateTime _selectedDate = DateTime.now();
  List<String> _trainTypes = ['Усі'];
  String _scheduleType = 'Відправлення';
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

  final List<String> _scheduleTypes = [
    'Відправлення',
    'Прибуття',
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
        const SnackBar(content: Text('Оберіть станцію')),
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
        trainType: 'Швидкий',
        destination: _scheduleType == 'Відправлення' ? 'Львів' : 'Київ-Пасажирський',
        departureTime: '08:30',
        arrivalTime: '08:30',
        platform: '3',
        status: 'Вчасно',
      ),
      ScheduleResult(
        trainNumber: '743О',
        trainType: 'Пасажирський',
        destination: _scheduleType == 'Відправлення' ? 'Одеса-Головна' : 'Харків-Пасажирський',
        departureTime: '10:15',
        arrivalTime: '10:15',
        platform: '1',
        status: 'Затримка',
      ),
      ScheduleResult(
        trainNumber: '749К',
        trainType: 'Експрес',
        destination: _scheduleType == 'Відправлення' ? 'Дніпро-Головний' : 'Івано-Франківськ',
        departureTime: '12:45',
        arrivalTime: '12:45',
        platform: '2',
        status: 'Відправлено',
      ),
      ScheduleResult(
        trainNumber: '105І',
        trainType: 'Інтерсіті+',
        destination: _scheduleType == 'Відправлення' ? 'Запоріжжя-1' : 'Тернопіль',
        departureTime: '14:20',
        arrivalTime: '14:20',
        platform: '4',
        status: 'Вчасно',
      ),
      ScheduleResult(
        trainNumber: '752П',
        trainType: 'Пасажирський',
        destination: _scheduleType == 'Відправлення' ? 'Вінниця' : 'Чернівці',
        departureTime: '16:55',
        arrivalTime: '16:55',
        platform: '5',
        status: 'Затримка',
      ),
    ];
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
                    labelText: 'Станція',
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
                                  decoration: const InputDecoration(
                                    labelText: 'Дата',
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
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
                                decoration: const InputDecoration(
                                  labelText: 'Тип розкладу',
                                  prefixIcon: Icon(Icons.schedule),
                                  border: OutlineInputBorder(),
                                  filled: true,
                                ),
                                items: _scheduleTypes.map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
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
                                decoration: const InputDecoration(
                                  labelText: 'Дата',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
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
                              decoration: const InputDecoration(
                                labelText: 'Тип розкладу',
                                prefixIcon: Icon(Icons.schedule),
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                              items: _scheduleTypes.map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
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
                    labelText: 'Тип поїзда',
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
                    label: Text(_isLoading ? 'Пошук...' : 'Показати розклад'),
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
                    ? const Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('Поїзд', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text('Напрямок', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: Text('Час', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                          Expanded(
                            child: Text('Платф.', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                          Expanded(
                            child: Text('Статус', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text('Поїзд', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Text('Напрямок', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: Text(
                              _scheduleType == 'Відправлення' ? 'Відпр.' : 'Приб.',
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
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.schedule, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Оберіть станцію та натисніть "Показати розклад"',
                      style: TextStyle(color: Colors.grey),
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
