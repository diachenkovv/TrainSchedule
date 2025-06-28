import flet as ft
from datetime import datetime, timedelta


class RouteSearchView:
    def __init__(self, page: ft.Page):
        self.page = page
        self.departure_station = ft.TextField(
            label="Станція відправлення",
            hint_text="Введіть назву станції",
            prefix_icon=ft.Icons.LOCATION_ON,
            border_radius=10,
            filled=True
        )
        self.arrival_station = ft.TextField(
            label="Станція прибуття",
            hint_text="Введіть назву станції",
            prefix_icon=ft.Icons.LOCATION_ON_OUTLINED,
            border_radius=10,
            filled=True
        )
        self.departure_date = ft.DatePicker(
            first_date=datetime.now(),
            last_date=datetime.now() + timedelta(days=90),
            on_change=self._on_date_change
        )
        self.date_button = ft.ElevatedButton(
            text=datetime.now().strftime("%d.%m.%Y"),
            icon=ft.Icons.CALENDAR_TODAY,
            on_click=self._open_date_picker,
            style=ft.ButtonStyle(
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        )
        self.train_type = ft.Dropdown(
            label="Тип рухомого складу",
            hint_text="Оберіть тип",
            options=[
                ft.dropdown.Option("all", "Усі"),
                ft.dropdown.Option("passenger", "Пасажирський"),
                ft.dropdown.Option("suburban", "Приміський")
            ],
            value="all",
            border_radius=10,
            filled=True
        )
        self.results_container = ft.Container()
        
        # Додаємо DatePicker до сторінки
        self.page.overlay.append(self.departure_date)

    def _on_date_change(self, e):
        if self.departure_date.value:
            self.date_button.text = self.departure_date.value.strftime("%d.%m.%Y")
            self.page.update()

    def _open_date_picker(self, e):
        self.page.open(self.departure_date)

    def _search_routes(self, e):
        # Перевіряємо, чи заповнені поля
        if not self.departure_station.value or not self.arrival_station.value:
            # Показуємо повідомлення про помилку
            self.results_container.content = ft.Container(
                content=ft.Column([
                    ft.Icon(ft.Icons.ERROR, size=48),
                    ft.Text("Будь ласка, вкажіть станції відправлення та прибуття", 
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
                ft.Text("Пошук маршрутів...", text_align=ft.TextAlign.CENTER)
            ], 
            horizontal_alignment=ft.CrossAxisAlignment.CENTER),
            alignment=ft.alignment.center,
            height=200
        )
        self.page.update()
        
        # Імітація результатів пошуку
        import time
        time.sleep(1)
        
        results = self._generate_mock_results()
        self.results_container.content = ft.Column([
            ft.Text("Знайдені маршрути:", size=18, weight=ft.FontWeight.BOLD),
            *results
        ], spacing=10)
        self.page.update()

    def _generate_mock_results(self):
        """Генерує тестові результати пошуку"""
        theme_color = self._get_theme_color()
        
        routes = [
            {
                "train_number": "№ 143",
                "train_type": "Пасажирський",
                "route": "Харків - Львів",
                "departure_time": "08:15",
                "arrival_time": "14:30",
                "duration": "6г 15хв",
                "stations": "15 станцій"
            },
            {
                "train_number": "№ 748",
                "train_type": "Швидкий",
                "route": "Харків - Львів",
                "departure_time": "09:30",
                "arrival_time": "14:45",
                "duration": "5г 15хв",
                "stations": "10 станцій"
            },
            {
                "train_number": "№ 6301",
                "train_type": "Приміський",
                "route": "Київ - Фастів",
                "departure_time": "10:45",
                "arrival_time": "16:20",
                "duration": "5г 35хв",
                "stations": "8 станцій"
            },
            {
                "train_number": "№ 87",
                "train_type": "Пасажирський",
                "route": "Одеса - Суми",
                "departure_time": "15:20",
                "arrival_time": "22:10",
                "duration": "6г 50хв",
                "stations": "12 станцій"
            },
            {
                "train_number": "№ 15",
                "train_type": "Нічний",
                "route": "Київ - Дніпро",
                "departure_time": "22:45",
                "arrival_time": "06:30",
                "duration": "7г 45хв",
                "stations": "18 станцій"
            }
        ]
        
        result_cards = []
        for route in routes:
            # Визначаємо колір для номера поїзда та типу
            if "Швидкий" in route["train_type"]:
                number_color = "#E71212"  # Червоний для швидких
                type_bgcolor = ft.Colors.RED  # Фон лейбла червоний
                type_text_color = ft.Colors.WHITE  # Білий текст
            elif "Пасажирський" in route["train_type"]:
                number_color = "#3591E4"  # Блакитний для пасажирських
                type_bgcolor = ft.Colors.BLUE  # Фон лейбла блакитний
                type_text_color = ft.Colors.WHITE  # Білий текст
            elif "Приміський" in route["train_type"]:
                number_color = "#1BDA17"  # Зелений для приміських
                type_bgcolor = ft.Colors.GREEN  # Фон лейбла зелений
                type_text_color = ft.Colors.WHITE  # Білий текст
            elif "Нічний" in route["train_type"]:
                number_color = "#2B2E7F"  # Темно-синій для нічних
                type_bgcolor = ft.Colors.INDIGO  # Фон лейбла темно-синій
                type_text_color = ft.Colors.WHITE  # Білий текст
            else:
                number_color = "#878787"  # Сірий для інших
                type_bgcolor = ft.Colors.GREY  # Фон лейбла сірий
                type_text_color = ft.Colors.WHITE  # Білий текст
                
            card = ft.Card(
                content=ft.Container(
                    content=ft.Column([
                        ft.Row([
                            ft.Text(route["train_number"], size=16, weight=ft.FontWeight.BOLD, color=number_color),
                            ft.Text(route["route"], size=14, italic=True, expand=True, text_align=ft.TextAlign.CENTER),
                            ft.Container(
                                content=ft.Text(route["train_type"], size=12, weight=ft.FontWeight.BOLD, color=type_text_color),
                                bgcolor=type_bgcolor,
                                padding=ft.padding.symmetric(horizontal=12, vertical=6),
                                border_radius=16
                            )
                        ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
                        ft.Divider(height=1),
                        ft.Row([
                            ft.Column([
                                ft.Text("Відправлення", size=12),
                                ft.Text(route["departure_time"], size=18, weight=ft.FontWeight.BOLD)
                            ], spacing=5),
                            ft.Icon(ft.Icons.ARROW_FORWARD, color=theme_color),
                            ft.Column([
                                ft.Text("Прибуття", size=12),
                                ft.Text(route["arrival_time"], size=18, weight=ft.FontWeight.BOLD)
                            ], spacing=5),
                        ], alignment=ft.MainAxisAlignment.SPACE_AROUND),
                        ft.Row([
                            ft.Row([
                                ft.Icon(ft.Icons.ACCESS_TIME, size=16),
                                ft.Text(route["duration"], size=14)
                            ], spacing=5),
                            ft.Row([
                                ft.Icon(ft.Icons.LOCATION_ON, size=16),
                                ft.Text(route["stations"], size=14)
                            ], spacing=5)
                        ], alignment=ft.MainAxisAlignment.SPACE_AROUND)
                    ], spacing=10),
                    padding=ft.padding.all(15)
                ),
                elevation=2,
                margin=ft.margin.symmetric(vertical=5)
            )
            result_cards.append(card)
        
        return result_cards

    def _swap_stations(self, e):
        """Міняє місцями станції відправлення та прибуття"""
        temp = self.departure_station.value
        self.departure_station.value = self.arrival_station.value
        self.arrival_station.value = temp
        self.page.update()

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
                            ft.Text("Пошук маршруту", size=20, weight=ft.FontWeight.BOLD, color=theme_color),
                            ft.Divider(),
                            
                            # Станції
                            ft.Row([
                                ft.Container(self.departure_station, expand=True),
                                ft.Container(
                                    ft.IconButton(
                                        icon=ft.Icons.SWAP_VERT,
                                        tooltip="Поміняти місцями",
                                        on_click=self._swap_stations,
                                        icon_color=theme_color,
                                        bgcolor=None
                                    ),
                                    alignment=ft.alignment.center
                                ),
                                ft.Container(self.arrival_station, expand=True)
                            ], spacing=10),
                            
                            # Дата та тип поїзда
                            ft.Row([
                                ft.Container(
                                    content=ft.Column([
                                        ft.Text("Дата відправлення", size=14),
                                        self.date_button
                                    ], spacing=5),
                                    expand=True
                                ),
                                ft.Container(self.train_type, expand=True)
                            ], spacing=20),
                            
                            # Кнопка пошуку
                            ft.Container(
                                ft.ElevatedButton(
                                    text="Знайти маршрути",
                                    icon=ft.Icons.SEARCH,
                                    on_click=self._search_routes,
                                    style=ft.ButtonStyle(
                                        bgcolor=theme_color,
                                        color=ft.Colors.WHITE,
                                        padding=ft.padding.symmetric(horizontal=30, vertical=15),
                                        shape=ft.RoundedRectangleBorder(radius=10)
                                    ),
                                    height=50
                                ),
                                alignment=ft.alignment.center,
                                margin=ft.margin.only(top=20)
                            )
                        ], spacing=15),
                        padding=ft.padding.all(20)
                    ),
                    elevation=3,
                    margin=ft.margin.only(bottom=20)
                ),
                
                # Результати пошуку
                self.results_container
            ], 
            scroll=ft.ScrollMode.AUTO),
            padding=ft.padding.all(10),
            expand=True
        )
