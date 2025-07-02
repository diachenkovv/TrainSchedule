import flet as ft
from .route_search_view import RouteSearchView
from .station_schedule_view import StationScheduleView
from .train_number_view import TrainNumberView
from .settings_view import SettingsView


class MainView:
    def __init__(self, page: ft.Page, settings_service=None):
        self.page = page
        self.settings_service = settings_service
        self.tabs = None
        self.active_tab_index = 0  # Додаємо збереження активної вкладки
        
        # Створюємо view'и
        def on_settings_changed():
            if self.tabs:
                # Оновлюємо лише Badge у вкладці "Налаштування"
                has_changes = self.settings_view.has_unsaved_changes
                self.tabs.tabs[3].icon = ft.Icon(
                    ft.Icons.SETTINGS,
                    badge=ft.Badge(small_size=8) if has_changes else None
                )
                self.tabs.update()
                
        def on_theme_changed():
            # Викликається коли тема змінюється - оновлюємо всі view
            if hasattr(self, 'route_search_view'):
                self.route_search_view.update_theme()
            if hasattr(self, 'station_schedule_view'):
                self.station_schedule_view.update_theme()
            if hasattr(self, 'train_number_view'):
                self.train_number_view.update_theme()
            if hasattr(self, 'settings_view'):
                self.settings_view.update_theme()
            # Оновлюємо заголовок
            self._update_header_theme()
            self.page.update()
        
        self.route_search_view = RouteSearchView(page)
        self.station_schedule_view = StationScheduleView(page) 
        self.train_number_view = TrainNumberView(page)
        self.settings_view = SettingsView(page, on_settings_changed=on_settings_changed, on_theme_changed=on_theme_changed)

    def _get_theme_color(self):
        """Повертає колір залежно від поточної теми"""
        if self.page.theme_mode == ft.ThemeMode.DARK:
            return "#3591E4"
        else:
            return "#213685"

    def _update_header_theme(self):
        """Оновлює тему заголовка"""
        if hasattr(self, 'header_container'):
            # Оновлюємо кольори заголовка відповідно до поточної теми
            theme_color = self._get_theme_color()
            # Заголовок завжди залишається синім
            self.header_container.bgcolor = "#213685"

    def build(self):
        # Створення вкладок
        def on_tab_change(e):
            self.active_tab_index = e.control.selected_index
        self.tabs = ft.Tabs(
            selected_index=self.active_tab_index,
            animation_duration=300,
            expand=True,
            tab_alignment=ft.TabAlignment.CENTER,
            on_change=on_tab_change,
            tabs=[
                ft.Tab(
                    text="Пошук маршруту",
                    icon=ft.Icons.ROUTE,
                    content=self.route_search_view.build()
                ),
                ft.Tab(
                    text="Розклад станції",
                    icon=ft.Icons.TRAIN,
                    content=self.station_schedule_view.build()
                ),
                ft.Tab(
                    text="За номером поїзда",
                    icon=ft.Icons.NUMBERS,
                    content=self.train_number_view.build()
                ),
                ft.Tab(
                    text="Налаштування",
                    icon=ft.Icon(
                        ft.Icons.SETTINGS, 
                        badge=ft.Badge(small_size=8) if self.settings_view.has_unsaved_changes else None
                    ),
                    content=self.settings_view.build()
                )
            ]
        )

        # Створюємо заголовок з посиланням для оновлення
        self.header_container = ft.Container(
            content=ft.Row([
                ft.Icon(ft.Icons.TRAIN, size=30, color=ft.Colors.WHITE),
                ft.Text(
                    "Розклад поїздів України",
                    size=24,
                    weight=ft.FontWeight.BOLD,
                    color=ft.Colors.WHITE
                )
            ], 
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=10),
            padding=ft.padding.all(20),
            bgcolor="#213685",  # Фіксований синій колір для заголовка
            border_radius=10,
            margin=ft.margin.only(bottom=10)
        )

        # Головний контейнер
        return ft.Container(
            content=ft.Column([
                # Заголовок додатку
                self.header_container,
                # Вкладки
                self.tabs
            ]),
            padding=ft.padding.all(20),
            expand=True
        )

