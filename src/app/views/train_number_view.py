import flet as ft
from datetime import datetime, timedelta


class TrainNumberView:
    def __init__(self, page: ft.Page):
        self.page = page
        self.train_number = ft.TextField(
            label="Номер поїзда",
            hint_text="Введіть номер поїзда (наприклад: 143)",
            prefix_icon=ft.Icons.NUMBERS,
            border_radius=10,
            filled=True,
            bgcolor=None
        )
        self.search_date = ft.DatePicker(
            first_date=datetime.now() - timedelta(days=7),
            last_date=datetime.now() + timedelta(days=90),
            on_change=self._on_date_change
        )
        self.date_button = ft.ElevatedButton(
            text=datetime.now().strftime("%d.%m.%Y"),
            icon=ft.Icons.CALENDAR_TODAY,
            on_click=self._open_date_picker,
            style=ft.ButtonStyle(
                bgcolor=None,
                color=None,
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        )
        self.results_container = ft.Container()
        
        # Додаємо DatePicker до сторінки
        self.page.overlay.append(self.search_date)

    def _on_date_change(self, e):
        if self.search_date.value:
            self.date_button.text = self.search_date.value.strftime("%d.%m.%Y")
            self.page.update()

    def _open_date_picker(self, e):
        self.page.open(self.search_date)

    def _search_train(self, e):
        if not self.train_number.value:
            # Показуємо повідомлення про помилку
            self.results_container.content = ft.Container(
                content=ft.Column([
                    ft.Icon(ft.Icons.ERROR, size=48),
                    ft.Text("Будь ласка, введіть номер поїзда", 
                           text_align=ft.TextAlign.CENTER,
                           size=16)
                ], 
                horizontal_alignment=ft.CrossAxisAlignment.CENTER),
                alignment=ft.alignment.center,
                height=150
            )
            self.page.update()
            return
        
        # Показуємо індикатор завантаження
        self.results_container.content = ft.Container(
            content=ft.Column([
                ft.ProgressRing(),
                ft.Text("Пошук інформації про поїзд...", text_align=ft.TextAlign.CENTER)
            ], 
            horizontal_alignment=ft.CrossAxisAlignment.CENTER),
            alignment=ft.alignment.center,
            height=200
        )
        self.page.update()
        
        # Імітація результатів пошуку
        import time
        time.sleep(1)
        
        train_info = self._generate_mock_train_info()
        if train_info:
            self.results_container.content = ft.Column([
                ft.Text(f"Інформація про поїзд № {self.train_number.value}", 
                       size=18, weight=ft.FontWeight.BOLD),
                ft.Text(f"на {self.date_button.text}", size=14),
                ft.Divider(),
                train_info
            ], spacing=10)
        else:
            self.results_container.content = ft.Container(
                content=ft.Column([
                    ft.Icon(ft.Icons.SEARCH_OFF, size=48),
                    ft.Text(f"Поїзд № {self.train_number.value} не знайдено", 
                           text_align=ft.TextAlign.CENTER,
                           size=16),
                    ft.Text("Перевірте номер та дату", 
                           text_align=ft.TextAlign.CENTER,
                           size=14)
                ], 
                horizontal_alignment=ft.CrossAxisAlignment.CENTER),
                alignment=ft.alignment.center,
                height=200
            )
        self.page.update()

    def _generate_mock_train_info(self):
        """Генерує тестову інформацію про поїзд"""
        theme_color = self._get_theme_color()
        train_number = self.train_number.value
        
        # Перевіряємо, чи є номер у нашій базі
        known_trains = ["143", "748", "87", "291", "6301", "6455", "15", "101", "5432"]
        if train_number not in known_trains:
            return None
        
        # Генеруємо інформацію в залежності від номера
        if train_number == "143":
            train_data = {
                "number": "143",
                "name": "Харків - Львів",
                "type": "Пасажирський",
                "stations": [
                    {"name": "Харків-Пасажирський", "arrival": "--:--", "departure": "07:50", "platform": "1", "stop_duration": "--"},
                    {"name": "Полтава-Київська", "arrival": "09:32", "departure": "09:37", "platform": "2", "stop_duration": "5 хв"},
                    {"name": "Київ-Пасажирський", "arrival": "12:15", "departure": "12:35", "platform": "3", "stop_duration": "20 хв"},
                    {"name": "Житомир", "arrival": "14:28", "departure": "14:33", "platform": "1", "stop_duration": "5 хв"},
                    {"name": "Коростень", "arrival": "15:45", "departure": "15:50", "platform": "2", "stop_duration": "5 хв"},
                    {"name": "Рівне", "arrival": "17:22", "departure": "17:27", "platform": "1", "stop_duration": "5 хв"},
                    {"name": "Львів", "arrival": "20:30", "departure": "--:--", "platform": "4", "stop_duration": "--"}
                ]
            }
        elif train_number == "748":
            train_data = {
                "number": "748",
                "name": "Харків - Львів",
                "type": "Швидкий",
                "stations": [
                    {"name": "Харків-Пасажирський", "arrival": "--:--", "departure": "09:30", "platform": "1", "stop_duration": "--"},
                    {"name": "Полтава-Київська", "arrival": "11:05", "departure": "11:08", "platform": "2", "stop_duration": "3 хв"},
                    {"name": "Київ-Пасажирський", "arrival": "13:40", "departure": "13:45", "platform": "5", "stop_duration": "5 хв"},
                    {"name": "Львів", "arrival": "16:45", "departure": "--:--", "platform": "2", "stop_duration": "--"}
                ]
            }
        elif train_number == "87":
            train_data = {
                "number": "87",
                "name": "Одеса - Суми",
                "type": "Пасажирський",
                "stations": [
                    {"name": "Одеса-Головна", "arrival": "--:--", "departure": "08:20", "platform": "2", "stop_duration": "--"},
                    {"name": "Миколаїв", "arrival": "10:15", "departure": "10:22", "platform": "1", "stop_duration": "7 хв"},
                    {"name": "Кременчук", "arrival": "13:45", "departure": "13:52", "platform": "3", "stop_duration": "7 хв"},
                    {"name": "Полтава-Південна", "arrival": "15:30", "departure": "15:37", "platform": "2", "stop_duration": "7 хв"},
                    {"name": "Суми", "arrival": "18:45", "departure": "--:--", "platform": "1", "stop_duration": "--"}
                ]
            }
        elif train_number == "15":
            train_data = {
                "number": "15",
                "name": "Київ - Дніпро",
                "type": "Нічний",
                "stations": [
                    {"name": "Київ-Пасажирський", "arrival": "--:--", "departure": "22:45", "platform": "6", "stop_duration": "--"},
                    {"name": "Черкаси", "arrival": "01:20", "departure": "01:25", "platform": "2", "stop_duration": "5 хв"},
                    {"name": "Кременчук", "arrival": "03:45", "departure": "03:50", "platform": "1", "stop_duration": "5 хв"},
                    {"name": "Дніпро-Головний", "arrival": "06:30", "departure": "--:--", "platform": "3", "stop_duration": "--"}
                ]
            }
        elif train_number == "101":
            train_data = {
                "number": "101",
                "name": "Київ - Берлін",
                "type": "Швидкий",
                "stations": [
                    {"name": "Київ-Пасажирський", "arrival": "--:--", "departure": "10:30", "platform": "4", "stop_duration": "--"},
                    {"name": "Львів", "arrival": "16:20", "departure": "16:40", "platform": "1", "stop_duration": "20 хв"},
                    {"name": "Перемишль", "arrival": "19:15", "departure": "19:25", "platform": "2", "stop_duration": "10 хв"},
                    {"name": "Берлін", "arrival": "08:45+1", "departure": "--:--", "platform": "8", "stop_duration": "--"}
                ]
            }
        elif train_number == "5432":
            train_data = {
                "number": "5432",
                "name": "Київ - Біла Церква",
                "type": "Приміський",
                "stations": [
                    {"name": "Київ-Пасажирський", "arrival": "--:--", "departure": "14:20", "platform": "8", "stop_duration": "--"},
                    {"name": "Васильків", "arrival": "14:58", "departure": "15:01", "platform": "1", "stop_duration": "3 хв"},
                    {"name": "Біла Церква", "arrival": "15:35", "departure": "--:--", "platform": "2", "stop_duration": "--"}
                ]
            }
        else:
            # Для приміських поїздів
            train_data = {
                "number": train_number,
                "name": "Київ - Фастів",
                "type": "Приміський",
                "stations": [
                    {"name": "Київ-Пасажирський", "arrival": "--:--", "departure": "09:15", "platform": "5", "stop_duration": "--"},
                    {"name": "Васильків", "arrival": "09:52", "departure": "09:54", "platform": "1", "stop_duration": "2 хв"},
                    {"name": "Фастів", "arrival": "10:25", "departure": "--:--", "platform": "2", "stop_duration": "--"}
                ]
            }
        
        # Визначаємо колір для номера поїзда та типу
        if "Швидкий" in train_data["type"]:
            number_color = "#E71212"  # Червоний для швидких
            type_bgcolor = ft.Colors.RED  # Фон лейбла червоний
            type_text_color = ft.Colors.WHITE  # Білий текст
        elif "Пасажирський" in train_data["type"]:
            number_color = "#3591E4"  # Блакитний для пасажирських  
            type_bgcolor = ft.Colors.BLUE  # Фон лейбла блакитний
            type_text_color = ft.Colors.WHITE  # Білий текст
        elif "Приміський" in train_data["type"]:
            number_color = "#1BDA17"  # Зелений для приміських
            type_bgcolor = ft.Colors.GREEN  # Фон лейбла зелений
            type_text_color = ft.Colors.WHITE  # Білий текст
        elif "Нічний" in train_data["type"]:
            number_color = "#2B2E7F"  # Темно-синій для нічних
            type_bgcolor = ft.Colors.INDIGO  # Фон лейбла темно-синій
            type_text_color = ft.Colors.WHITE  # Білий текст
        else:
            number_color = "#878787"  # Сірий для інших
            type_bgcolor = ft.Colors.GREY  # Фон лейбла сірий
            type_text_color = ft.Colors.WHITE  # Білий текст
        
        # Створюємо картку з інформацією про поїзд
        train_info_card = ft.Card(
            content=ft.Container(
                content=ft.Column([
                    # Заголовок поїзда
                    ft.Row([
                        ft.Text(f"№ {train_data['number']}", size=20, weight=ft.FontWeight.BOLD, color=number_color),
                        ft.Container(
                            content=ft.Text(train_data["type"], size=12, weight=ft.FontWeight.BOLD, color=type_text_color),
                            bgcolor=type_bgcolor,
                            padding=ft.padding.symmetric(horizontal=12, vertical=6),
                            border_radius=16
                        )
                    ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
                    
                    ft.Text(train_data["name"], size=16, italic=True),
                    ft.Divider(),
                    
                    ft.Text("Маршрут слідування:", size=16, weight=ft.FontWeight.BOLD, color=theme_color),
                ], spacing=10),
                padding=ft.padding.all(20)
            ),
            elevation=3,
            margin=ft.margin.only(bottom=15)
        )
        
        # Створюємо список станцій
        station_cards = []
        for i, station in enumerate(train_data["stations"]):
            is_first = i == 0
            is_last = i == len(train_data["stations"]) - 1
            
            # Іконка в залежності від типу станції
            if is_first:
                icon = ft.Icons.RADIO_BUTTON_CHECKED
                icon_color = ft.Colors.GREEN_600
            elif is_last:
                icon = ft.Icons.STOP_CIRCLE
                icon_color = ft.Colors.RED_600
            else:
                icon = ft.Icons.CIRCLE
                icon_color = ft.Colors.BLUE_600
            
            station_card = ft.Card(
                content=ft.Container(
                    content=ft.Row([
                        # Іконка станції
                        ft.Container(
                            content=ft.Icon(icon, color=icon_color, size=20),
                            width=40,
                            alignment=ft.alignment.center
                        ),
                        
                        # Інформація про станцію
                        ft.Container(
                            content=ft.Column([
                                ft.Text(station["name"], size=16, weight=ft.FontWeight.BOLD),
                                ft.Row([
                                    ft.Row([
                                        ft.Icon(ft.Icons.LOGIN, size=16),
                                        ft.Text(station["arrival"], size=14, weight=ft.FontWeight.BOLD)
                                    ], spacing=5) if station["arrival"] != "--:--" else ft.Container(),
                                    
                                    ft.Row([
                                        ft.Icon(ft.Icons.LOGOUT, size=16),
                                        ft.Text(station["departure"], size=14, weight=ft.FontWeight.BOLD)
                                    ], spacing=5) if station["departure"] != "--:--" else ft.Container(),
                                ], spacing=20),
                                
                                ft.Row([
                                    ft.Row([
                                        ft.Icon(ft.Icons.TRAIN, size=14),
                                        ft.Text(f"Платформа {station['platform']}", size=12)
                                    ], spacing=5),
                                    
                                    ft.Row([
                                        ft.Icon(ft.Icons.ACCESS_TIME, size=14),
                                        ft.Text(station["stop_duration"], size=12)
                                    ], spacing=5) if station["stop_duration"] != "--" else ft.Container(),
                                ], spacing=15)
                            ], spacing=5),
                            expand=True
                        )
                    ], spacing=10),
                    padding=ft.padding.all(15)
                ),
                elevation=1,
                margin=ft.margin.symmetric(vertical=3)
            )
            station_cards.append(station_card)
        
        return ft.Column([
            train_info_card,
            ft.Text("Станції маршруту:", size=16, weight=ft.FontWeight.BOLD),
            *station_cards
        ], spacing=5)

    def _get_theme_color(self):
        """Повертає колір залежно від поточної теми"""
        if self.page.theme_mode == ft.ThemeMode.DARK:
            return "#3591E4"
        else:
            return "#213685"

    def build(self):
        theme_color = self._get_theme_color()
        
        return ft.Container(
            content=ft.Column([
                # Форма пошуку
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            ft.Text("Пошук за номером поїзда", size=20, weight=ft.FontWeight.BOLD, color=theme_color),
                            ft.Divider(),
                            
                            # Номер поїзда
                            self.train_number,
                            
                            # Дата
                            ft.Container(
                                content=ft.Column([
                                    ft.Text("Дата", size=14),
                                    self.date_button
                                ], spacing=5),
                            ),
                            
                            # Кнопка пошуку
                            ft.Container(
                                ft.ElevatedButton(
                                    text="Знайти поїзд",
                                    icon=ft.Icons.SEARCH,
                                    on_click=self._search_train,
                                    style=ft.ButtonStyle(
                                        bgcolor=theme_color,  # Автоматичний колір
                                        color=ft.Colors.WHITE,    # Автоматичний колір тексту
                                        padding=ft.padding.symmetric(horizontal=30, vertical=15),
                                        shape=ft.RoundedRectangleBorder(radius=10)
                                    ),
                                    height=50
                                ),
                                alignment=ft.alignment.center,
                                margin=ft.margin.only(top=20)
                            ),
                            
                            # Підказка
                            ft.Container(
                                content=ft.Row([
                                    ft.Icon(ft.Icons.INFO_OUTLINE, size=16),
                                    ft.Text("Доступні номери для тесту: 143, 748, 87, 15, 101, 5432", 
                                           size=12, italic=True)
                                ], spacing=5),
                                border_radius=8,
                                padding=ft.padding.all(10),
                                margin=ft.margin.only(top=10)
                            )
                        ], spacing=15),
                        padding=ft.padding.all(20)
                    ),
                    elevation=3,
                    margin=ft.margin.only(bottom=20)
                ),
                
                # Результати
                self.results_container
            ], 
            scroll=ft.ScrollMode.AUTO),
            padding=ft.padding.all(10),
            expand=True
        )
