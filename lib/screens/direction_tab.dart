import 'package:flutter/material.dart';
import '../providers/settings_provider.dart';
import '../models/train_result.dart';
import '../widgets/train_result_card.dart';
import '../widgets/station_autocomplete_field.dart';
import '../widgets/multi_select_train_type_field.dart';
import '../generated/l10n.dart';

class DirectionTab extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const DirectionTab({super.key, required this.settingsProvider});

  @override
  State<DirectionTab> createState() => _DirectionTabState();
}

class _DirectionTabState extends State<DirectionTab> {
  String? _fromStation;
  String? _toStation;
  DateTime _selectedDate = DateTime.now();
  List<String> _trainTypes = ['train_type_all'];
  List<TrainResult> _results = [];
  bool _isLoading = false;

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _fromController.addListener(() {
      if (_fromController.text != _fromStation) {
        setState(() {
          _fromStation = _fromController.text.isEmpty ? null : _fromController.text;
        });
      }
    });
    _toController.addListener(() {
      if (_toController.text != _toStation) {
        setState(() {
          _toStation = _toController.text.isEmpty ? null : _toController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
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

  void _searchTrains() async {
    if (_fromStation == null || _toStation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).error_select_stations)),
      );
      return;
    }

    if (_fromStation == _toStation) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).error_same_stations)),
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

  List<TrainResult> _getMockData() {
    return [
      TrainResult(
        trainNumber: '091К',
        trainType: 'train_type_fast',
        from: _fromStation!,
        to: _toStation!,
        departureTime: '08:30',
        arrivalTime: '14:20',
        duration: '5г 50хв',
        price: '450 грн',
        availableSeats: 120,
        fullRoute: 'Київ-Пас. → Житомир → Рівне → Луцьк → Львів',
      ),
      TrainResult(
        trainNumber: '743О',
        trainType: 'train_type_passenger',
        from: _fromStation!,
        to: _toStation!,
        departureTime: '22:15',
        arrivalTime: '06:40',
        duration: '8г 25хв',
        price: '320 грн',
        availableSeats: 85,
        fullRoute: 'Київ-Пас. → Фастів → Житомир → Коростень → Сарни → Ковель → Львів',
      ),
      TrainResult(
        trainNumber: '749К',
        trainType: 'train_type_express',
        from: _fromStation!,
        to: _toStation!,
        departureTime: '15:45',
        arrivalTime: '20:30',
        duration: '4г 45хв',
        price: '580 грн',
        availableSeats: 45,
        fullRoute: 'Київ-Пас. → Житомир → Новоград-Волинський → Рівне → Дубно → Львів',
      ),
      TrainResult(
        trainNumber: '105І',
        trainType: 'train_type_intercity',
        from: _fromStation!,
        to: _toStation!,
        departureTime: '12:00',
        arrivalTime: '16:15',
        duration: '4г 15хв',
        price: '780 грн',
        availableSeats: 68,
        fullRoute: 'Київ-Пас. → Житомир → Рівне → Львів',
      ),
      TrainResult(
        trainNumber: '047І+',
        trainType: 'train_type_intercity_plus',
        from: _fromStation!,
        to: _toStation!,
        departureTime: '16:30',
        arrivalTime: '19:50',
        duration: '3г 20хв',
        price: '950 грн',
        availableSeats: 32,
        fullRoute: 'Київ-Пас. → Житомир → Львів',
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
                  Row(
                    children: [
                      Expanded(
                        child: StationAutocompleteField(
                          value: _fromStation,
                          onChanged: (value) {
                            setState(() => _fromStation = value);
                            _fromController.text = value ?? '';
                          },
                          labelText: S.of(context).from_station,
                          prefixIcon: Icons.departure_board,
                          stations: _stations,
                          controller: _fromController,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.swap_horiz),
                        tooltip: S.of(context).swap_stations,
                        onPressed: () {
                          setState(() {
                            final temp = _fromStation;
                            _fromStation = _toStation;
                            _toStation = temp;
                            final tempText = _fromController.text;
                            _fromController.text = _toController.text;
                            _toController.text = tempText;
                            _results = [];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  StationAutocompleteField(
                    value: _toStation,
                    onChanged: (value) {
                      setState(() => _toStation = value);
                      _toController.text = value ?? '';
                    },
                    labelText: S.of(context).to_station,
                    prefixIcon: Icons.location_on,
                    stations: _stations,
                    controller: _toController,
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
                              child: MultiSelectTrainTypeField(
                                selectedTypes: _trainTypes,
                                onChanged: (value) => setState(() => _trainTypes = value),
                                labelText: S.of(context).train_type,
                                prefixIcon: Icons.train,
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
                            MultiSelectTrainTypeField(
                              selectedTypes: _trainTypes,
                              onChanged: (value) => setState(() => _trainTypes = value),
                              labelText: S.of(context).train_type,
                              prefixIcon: Icons.train,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _searchTrains,
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
          // Результати пошуку
          if (_results.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) => TrainResultCard(
                  result: _results[index],
                  showFullRoute: true,
                ),
              ),
            ),
          if (_results.isEmpty && !_isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).empty_direction_search,
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
