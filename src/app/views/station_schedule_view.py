import flet as ft
from datetime import datetime, timedelta


class StationScheduleView:
    def __init__(self, page: ft.Page):
        self.page = page
        self.station_name = ft.TextField(
            label="Назва станції",
            hint_text="Введіть назву станції",
            prefix_icon=ft.Icons.TRAIN,
            border_radius=10,
            filled=True,
            bgcolor=None
        )
        self.schedule_date = ft.DatePicker(
            first_date=datetime.now() - timedelta(days=1),
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
            filled=True,
            bgcolor=None,
            color=None  # Прибираємо фіксований чорний колір тексту
        )
        self.results_container = ft.Container()
        
        # Елементи, які будуть створені в build() та потребують оновлення теми
        self.search_button = None
        self.title_text = None
        
        # Додаємо DatePicker до сторінки
        self.page.overlay.append(self.schedule_date)

    def _on_date_change(self, e):
        if self.schedule_date.value:
            self.date_button.text = self.schedule_date.value.strftime("%d.%m.%Y")
            self.page.update()

    def _open_date_picker(self, e):
        self.page.open(self.schedule_date)

    def _search_schedule(self, e):
        # Перевіряємо, чи заповнено поле станції
        if not self.station_name.value:
            # Показуємо повідомлення про помилку
            self.results_container.content = ft.Container(
                content=ft.Column([
                    ft.Icon(ft.Icons.ERROR, size=48),
                    ft.Text("Будь ласка, введіть назву станції", 
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
                ft.Text("Завантаження розкладу...", text_align=ft.TextAlign.CENTER)
            ], 
            horizontal_alignment=ft.CrossAxisAlignment.CENTER),
            alignment=ft.alignment.center,
            height=200
        )
        self.page.update()
        
        # Імітація результатів пошуку
        import time
        time.sleep(1)
        
        results = self._generate_mock_schedule()
        self.results_container.content = ft.Column([
            ft.Text(f"Розклад станції '{self.station_name.value or 'Київ-Пасажирський'}'", 
                   size=18, weight=ft.FontWeight.BOLD),
            ft.Text(f"на {self.date_button.text}", size=14),
            ft.Divider(),
            *results
        ], spacing=10)
        self.page.update()

    def _generate_mock_schedule(self):
        """Генерує тестовий розклад станції"""
        schedule_data = [
            {
                "train_number": "№ 143",
                "train_type": "Пасажирський",
                "direction": "Харків → Львів",
                "arrival_time": "08:15",
                "departure_time": "08:20",
                "platform": "2",
                "status": "За розкладом"
            },
            {
                "train_number": "№ 6301",
                "train_type": "Приміський",
                "direction": "Київ → Фастів",
                "arrival_time": "10:30",
                "departure_time": "10:35",
                "platform": "5",
                "status": "За розкладом"
            },
            {
                "train_number": "№ 87",
                "train_type": "Пасажирський",
                "direction": "Одеса → Суми",
                "arrival_time": "12:45",
                "departure_time": "12:50",
                "platform": "1",
                "status": "Затримка 15 хв"
            },
            {
                "train_number": "№ 748",
                "train_type": "Швидкий",
                "direction": "Харків → Львів",
                "arrival_time": "13:30",
                "departure_time": "13:35",
                "platform": "2",
                "status": "За розкладом"
            },
            {
                "train_number": "№ 6455",
                "train_type": "Приміський",
                "direction": "Київ → Ніжин",
                "arrival_time": "14:20",
                "departure_time": "14:25",
                "platform": "4",
                "status": "За розкладом"
            },
            {
                "train_number": "№ 291",
                "train_type": "Пасажирський",
                "direction": "Запоріжжя → Чернігів",
                "arrival_time": "16:10",
                "departure_time": "16:15",
                "platform": "3",
                "status": "За розкладом"
            },
            {
                "train_number": "№ 15",
                "train_type": "Нічний",
                "direction": "Київ → Дніпро",
                "arrival_time": "22:45",
                "departure_time": "22:50",
                "platform": "6",
                "status": "За розкладом"
            }
        ]
        
        result_cards = []
        for train in schedule_data:
            # Визначаємо колір для номера поїзда та типу
            if "Швидкий" in train["train_type"]:
                number_color = "#E71212"  # Червоний для швидких
                type_bgcolor = number_color  # Фон лейбла червоний
                type_text_color = ft.Colors.WHITE  # Білий текст
            elif "Пасажирський" in train["train_type"]:
                number_color = "#3591E4"  # Блакитний для пасажирських
                type_bgcolor = number_color  # Фон лейбла блакитний
                type_text_color = ft.Colors.WHITE  # Білий текст
            elif "Приміський" in train["train_type"]:
                number_color = "#1BDA17"  # Зелений для приміських
                type_bgcolor = number_color  # Фон лейбла зелений
                type_text_color = ft.Colors.WHITE  # Білий текст
            elif "Нічний" in train["train_type"]:
                number_color = "#2B2E7F"  # Темно-синій для нічних
                type_bgcolor = ft.Colors.INDIGO  # Фон лейбла темно-синій
                type_text_color = ft.Colors.WHITE  # Білий текст
            else:
                number_color = "#878787"  # Сірий для інших
                type_bgcolor = ft.Colors.GREY  # Фон лейбла сірий
                type_text_color = ft.Colors.WHITE  # Білий текст
            
            # Визначаємо колір статусу
            status_color = ft.Colors.GREEN_600 if "За розкладом" in train["status"] else ft.Colors.RED_600
            status_bgcolor = ft.Colors.GREEN_100 if "За розкладом" in train["status"] else ft.Colors.RED_100
            
            card = ft.Card(
                content=ft.Container(
                    content=ft.Column([
                        # Заголовок з номером поїзда та типом
                        ft.Row([
                            ft.Text(train["train_number"], size=16, weight=ft.FontWeight.BOLD, color=number_color),
                            ft.Text(train["direction"], size=14, italic=True, expand=True, text_align=ft.TextAlign.CENTER),
                            ft.Container(
                                content=ft.Text(train["train_type"], size=12, weight=ft.FontWeight.BOLD, color=type_text_color),
                                bgcolor=type_bgcolor,
                                padding=ft.padding.symmetric(horizontal=12, vertical=6),
                                border_radius=16
                            )
                        ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
                        
                        ft.Divider(height=1),
                        
                        # Часи прибуття/відправлення та платформа
                        ft.Row([
                            ft.Column([
                                ft.Text("Прибуття", size=12),
                                ft.Text(train["arrival_time"], size=16, weight=ft.FontWeight.BOLD)
                            ], spacing=5),
                            ft.Icon(ft.Icons.ARROW_FORWARD, color=self._get_theme_color()),
                            ft.Column([
                                ft.Text("Відправлення", size=12),
                                ft.Text(train["departure_time"], size=16, weight=ft.FontWeight.BOLD)
                            ], spacing=5),
                            ft.Container(
                                content=ft.Column([
                                    ft.Text("Платформа", size=12),
                                    ft.Container(
                                        content=ft.Text(train["platform"], size=16, weight=ft.FontWeight.BOLD, color=ft.Colors.WHITE),
                                        bgcolor=self._get_theme_color(),
                                        border_radius=20,
                                        padding=ft.padding.symmetric(horizontal=12, vertical=6),
                                        alignment=ft.alignment.center
                                    )
                                ], spacing=5, horizontal_alignment=ft.CrossAxisAlignment.CENTER),
                                margin=ft.margin.only(left=20)
                            )
                        ], alignment=ft.MainAxisAlignment.SPACE_BETWEEN),
                        
                        # Статус
                        ft.Container(
                            content=ft.Row([
                                ft.Icon(
                                    ft.Icons.CHECK_CIRCLE if "За розкладом" in train["status"] else ft.Icons.ACCESS_TIME,
                                    size=16,
                                    color=status_color
                                ),
                                ft.Text(train["status"], size=14, color=status_color, weight=ft.FontWeight.BOLD)
                            ], spacing=5),
                            bgcolor=status_bgcolor,
                            border_radius=8,
                            padding=ft.padding.symmetric(horizontal=10, vertical=5),
                            margin=ft.margin.only(top=10)
                        )
                    ], spacing=10),
                    padding=ft.padding.all(15)
                ),
                elevation=2,
                margin=ft.margin.symmetric(vertical=5)
            )
            result_cards.append(card)
        
        return result_cards

    def update_theme(self):
        """Оновлює кольори елементів відповідно до поточної теми"""
        theme_color = self._get_theme_color()
        
        # Оновлюємо кнопку пошуку
        if self.search_button:
            self.search_button.style = ft.ButtonStyle(
                bgcolor=theme_color,
                color=ft.Colors.WHITE,
                padding=ft.padding.symmetric(horizontal=30, vertical=15),
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        
        # Оновлюємо заголовок
        if self.title_text:
            self.title_text.color = theme_color
        
        # Оновлюємо результати, якщо вони є
        if self.results_container.content and hasattr(self.results_container.content, 'controls'):
            self._refresh_results()

    def _refresh_results(self):
        """Оновлює результати пошуку з новими кольорами теми"""
        if hasattr(self.results_container.content, 'controls') and self.results_container.content.controls:
            # Якщо є результати, регенеруємо їх з новими кольорами
            results = self._generate_mock_schedule()
            self.results_container.content = ft.Column([
                ft.Text(f"Розклад станції '{self.station_name.value or 'Київ-Пасажирський'}'", 
                       size=18, weight=ft.FontWeight.BOLD),
                ft.Text(f"на {self.date_button.text}", size=14),
                ft.Divider(),
                *results
            ], spacing=10)

    def _get_theme_color(self):
        """Повертає колір залежно від поточної теми"""
        if self.page.theme_mode == ft.ThemeMode.DARK:
            return "#3591E4"
        else:
            return "#213685"

    def build(self):
        theme_color = self._get_theme_color()
        
        # Створюємо заголовок з посиланням для оновлення
        self.title_text = ft.Text("Розклад станції", size=20, weight=ft.FontWeight.BOLD, color=theme_color)
        
        # Створюємо кнопку пошуку з посиланням для оновлення
        self.search_button = ft.ElevatedButton(
            text="Показати розклад",
            icon=ft.Icons.SCHEDULE,
            on_click=self._search_schedule,
            style=ft.ButtonStyle(
                bgcolor=theme_color,
                color=ft.Colors.WHITE,
                padding=ft.padding.symmetric(horizontal=30, vertical=15),
                shape=ft.RoundedRectangleBorder(radius=10)
            ),
            height=50
        )
        
        return ft.Container(
            content=ft.Column([
                # Форма пошуку
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            self.title_text,
                            ft.Divider(),
                            
                            # Назва станції
                            self.station_name,
                            
                            # Дата та тип поїзда
                            ft.Row([
                                ft.Container(
                                    content=ft.Column([
                                        ft.Text("Дата", size=14),
                                        self.date_button
                                    ], spacing=5),
                                    expand=True
                                ),
                                ft.Container(self.train_type, expand=True)
                            ], spacing=20),
                            
                            # Кнопка пошуку
                            ft.Container(
                                self.search_button,
                                alignment=ft.alignment.center,
                                margin=ft.margin.only(top=20)
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
