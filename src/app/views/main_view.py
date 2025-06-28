import flet as ft
from .route_search_view import RouteSearchView
from .station_schedule_view import StationScheduleView
from .train_number_view import TrainNumberView
from .settings_view import SettingsView


class MainView:
    def __init__(self, page: ft.Page, settings_service=None):
        self.page = page
        self.settings_service = settings_service
        
        # Створюємо view'и
        self.route_search_view = RouteSearchView(page)
        self.station_schedule_view = StationScheduleView(page) 
        self.train_number_view = TrainNumberView(page)
        self.settings_view = SettingsView(page)

    def _get_theme_color(self):
        """Повертає колір залежно від поточної теми"""
        if self.page.theme_mode == ft.ThemeMode.DARK:
            return "#3591E4"
        else:
            return "#213685"

    def build(self):
        # Створення вкладок
        tabs = ft.Tabs(
            selected_index=0,
            animation_duration=300,
            expand=True,
            tab_alignment=ft.TabAlignment.CENTER,
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
                    icon=ft.Icons.SETTINGS,
                    content=self.settings_view.build()
                )
            ]
        )

        # Головний контейнер
        return ft.Container(
            content=ft.Column([
                # Заголовок додатку
                ft.Container(
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
                ),
                # Вкладки
                tabs
            ]),
            padding=ft.padding.all(20),
            expand=True
        )

