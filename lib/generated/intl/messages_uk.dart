// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Про додаток"),
    "app_info": MessageLookupByLibrary.simpleMessage(
      "Додаток для розкладу поїздів Укрзалізниці.",
    ),
    "appearance": MessageLookupByLibrary.simpleMessage("Зовнішній вигляд"),
    "board": MessageLookupByLibrary.simpleMessage("Табло"),
    "button_apply": MessageLookupByLibrary.simpleMessage("Застосувати"),
    "button_close": MessageLookupByLibrary.simpleMessage("Закрити"),
    "button_ok": MessageLookupByLibrary.simpleMessage("ОК"),
    "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "dart": MessageLookupByLibrary.simpleMessage("Dart"),
    "date": MessageLookupByLibrary.simpleMessage("Дата"),
    "datepicker_hint": MessageLookupByLibrary.simpleMessage("Оберіть дату"),
    "developer": MessageLookupByLibrary.simpleMessage("Для розробників"),
    "direction": MessageLookupByLibrary.simpleMessage("Напрямок"),
    "direction_table_date": MessageLookupByLibrary.simpleMessage("Дата"),
    "direction_table_from": MessageLookupByLibrary.simpleMessage(
      "Станція відправлення",
    ),
    "direction_table_to": MessageLookupByLibrary.simpleMessage(
      "Станція прибуття",
    ),
    "direction_table_type": MessageLookupByLibrary.simpleMessage("Тип поїзда"),
    "dropdown_hint": MessageLookupByLibrary.simpleMessage("Оберіть опцію"),
    "duration_hour": MessageLookupByLibrary.simpleMessage("г"),
    "duration_minute": MessageLookupByLibrary.simpleMessage("хв"),
    "empty_direction_search": MessageLookupByLibrary.simpleMessage(
      "Виберіть станції та натисніть \'Знайти поїзди\'",
    ),
    "empty_schedule_search": MessageLookupByLibrary.simpleMessage(
      "Оберіть станцію та натисніть \'Показати розклад\'",
    ),
    "empty_train_search": MessageLookupByLibrary.simpleMessage(
      "Введіть номер поїзда та натисніть \'Знайти поїзд\'",
    ),
    "error_enter_train_number": MessageLookupByLibrary.simpleMessage(
      "Введіть номер поїзда",
    ),
    "error_same_stations": MessageLookupByLibrary.simpleMessage(
      "Станції відправлення та прибуття не можуть збігатися",
    ),
    "error_select_station": MessageLookupByLibrary.simpleMessage(
      "Оберіть станцію",
    ),
    "error_select_stations": MessageLookupByLibrary.simpleMessage(
      "Оберіть станції відправлення та прибуття",
    ),
    "find_trains": MessageLookupByLibrary.simpleMessage("Знайти поїзди"),
    "flutter": MessageLookupByLibrary.simpleMessage("Flutter"),
    "from_price": MessageLookupByLibrary.simpleMessage("Від"),
    "from_station": MessageLookupByLibrary.simpleMessage(
      "Станція відправлення",
    ),
    "full_route": MessageLookupByLibrary.simpleMessage("Повний маршрут:"),
    "home": MessageLookupByLibrary.simpleMessage("Головна"),
    "language": MessageLookupByLibrary.simpleMessage("Мова"),
    "language_en": MessageLookupByLibrary.simpleMessage("Англійська"),
    "language_uk": MessageLookupByLibrary.simpleMessage("Українська"),
    "save": MessageLookupByLibrary.simpleMessage("Зберегти"),
    "schedule_table_arrival": MessageLookupByLibrary.simpleMessage("Приб."),
    "schedule_table_departure": MessageLookupByLibrary.simpleMessage("Відпр."),
    "schedule_table_direction": MessageLookupByLibrary.simpleMessage(
      "Напрямок",
    ),
    "schedule_table_platform": MessageLookupByLibrary.simpleMessage("Платф."),
    "schedule_table_status": MessageLookupByLibrary.simpleMessage("Статус"),
    "schedule_table_time": MessageLookupByLibrary.simpleMessage("Час"),
    "schedule_type": MessageLookupByLibrary.simpleMessage("Тип розкладу"),
    "schedule_type_arrival": MessageLookupByLibrary.simpleMessage("Прибуття"),
    "schedule_type_departure": MessageLookupByLibrary.simpleMessage(
      "Відправлення",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Пошук"),
    "seats": MessageLookupByLibrary.simpleMessage("Місць"),
    "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
    "status_cancelled": MessageLookupByLibrary.simpleMessage("Скасовано"),
    "status_delayed": MessageLookupByLibrary.simpleMessage("Затримка"),
    "status_departed": MessageLookupByLibrary.simpleMessage("Відправлено"),
    "status_on_time": MessageLookupByLibrary.simpleMessage("Вчасно"),
    "swap_stations": MessageLookupByLibrary.simpleMessage(
      "Поміняти станції місцями",
    ),
    "tab_board": MessageLookupByLibrary.simpleMessage("Табло"),
    "tab_direction": MessageLookupByLibrary.simpleMessage("Напрямок"),
    "tab_train_number": MessageLookupByLibrary.simpleMessage("Номер поїзда"),
    "textfield_hint": MessageLookupByLibrary.simpleMessage("Введіть текст"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("Темна тема"),
    "themeModeDarkDesc": MessageLookupByLibrary.simpleMessage(
      "Завжди темна тема",
    ),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("Світла тема"),
    "themeModeLightDesc": MessageLookupByLibrary.simpleMessage(
      "Завжди світла тема",
    ),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage("Системна тема"),
    "themeModeSystemDesc": MessageLookupByLibrary.simpleMessage(
      "Слідувати налаштуванням системи",
    ),
    "title": MessageLookupByLibrary.simpleMessage(
      "Розклад поїздів Укрзалізниці",
    ),
    "to_station": MessageLookupByLibrary.simpleMessage("Станція прибуття"),
    "train_number": MessageLookupByLibrary.simpleMessage("Номер поїзда"),
    "train_number_hint": MessageLookupByLibrary.simpleMessage(
      "Введіть номер поїзда",
    ),
    "train_table_arrival": MessageLookupByLibrary.simpleMessage("Приб."),
    "train_table_departure": MessageLookupByLibrary.simpleMessage("Відпр."),
    "train_table_platform": MessageLookupByLibrary.simpleMessage("Платф."),
    "train_table_route": MessageLookupByLibrary.simpleMessage("Маршрут"),
    "train_table_station": MessageLookupByLibrary.simpleMessage("Станція"),
    "train_table_stop": MessageLookupByLibrary.simpleMessage("Стоянка"),
    "train_table_train": MessageLookupByLibrary.simpleMessage("Поїзд"),
    "train_type": MessageLookupByLibrary.simpleMessage("Тип поїзда"),
    "train_type_all": MessageLookupByLibrary.simpleMessage("Усі"),
    "train_type_express": MessageLookupByLibrary.simpleMessage("Експрес"),
    "train_type_fast": MessageLookupByLibrary.simpleMessage("Швидкий"),
    "train_type_intercity": MessageLookupByLibrary.simpleMessage("Інтерсіті"),
    "train_type_intercity_plus": MessageLookupByLibrary.simpleMessage(
      "Інтерсіті+",
    ),
    "train_type_night": MessageLookupByLibrary.simpleMessage("Нічний експрес"),
    "train_type_passenger": MessageLookupByLibrary.simpleMessage(
      "Пасажирський",
    ),
    "train_type_regional": MessageLookupByLibrary.simpleMessage("Регіональний"),
    "train_type_suburban": MessageLookupByLibrary.simpleMessage("Приміський"),
    "use_mock_data": MessageLookupByLibrary.simpleMessage(
      "Використовувати mock-дані",
    ),
    "use_mock_data_subtitle": MessageLookupByLibrary.simpleMessage(
      "Замість реальних даних з Укрзалізниці",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Версія"),
  };
}
