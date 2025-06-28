import flet as ft
from ..services.settings_service import SettingsService


class SettingsView:
    def __init__(self, page: ft.Page):
        self.page = page
        self.settings_service = SettingsService()
        
        # Завантажуємо поточні налаштування
        self.current_settings = self.settings_service.load_settings()
        
        # Кнопка збереження з badge
        self.save_button = ft.ElevatedButton(
            text="Зберегти налаштування",
            icon=ft.Icons.SAVE,
            on_click=self._save_all_settings,
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.GREEN_400,
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            ),
            disabled=True  # Спочатку відключена
        )
        
        self.save_badge = ft.Container(
            content=ft.Icon(ft.Icons.CIRCLE, size=8, color=ft.Colors.RED),
            width=12,
            height=12,
            border_radius=6,
            bgcolor=ft.Colors.RED,
            visible=False  # Badge зникає/з'являється
        )
        
        self.theme_mode_dropdown = ft.Dropdown(
            label="Тема інтерфейсу",
            hint_text="Оберіть тему",
            options=[
                ft.dropdown.Option("light", "Світла"),
                ft.dropdown.Option("dark", "Темна"),
                ft.dropdown.Option("system", "Системна")
            ],
            value=self.current_settings.get("theme_mode", "light"),
            border_radius=10,
            filled=True,
            bgcolor=None,
            color=None,
            on_change=self._on_theme_change
        )
        
        self.font_size_slider = ft.Slider(
            min=12,
            max=20,
            divisions=8,
            value=14,
            label="{value} px",
            on_change=self._on_font_size_change
        )
        
        self.enable_animations_switch = ft.Switch(
            label="Анімації інтерфейсу",
            value=True,
            on_change=self._on_animations_change
        )
        
        self.enable_sounds_switch = ft.Switch(
            label="Звукові сповіщення",
            value=False,
            on_change=self._on_sounds_change
        )
        
        self.use_real_api_switch = ft.Switch(
            label="Реальні дані УЗ",
            value=False,
            on_change=self._on_api_source_change
        )
        
        # Ініціалізуємо з поточними налаштуваннями
        self._init_current_settings()
        
        # Діалог "Про додаток"
        self.about_dialog = None

    def _init_current_settings(self):
        """Ініціалізація поточних налаштувань"""
        # Завантажуємо збережені налаштування
        settings = self.settings_service.load_settings()
        
        # Встановлюємо значення контролів
        self.theme_mode_dropdown.value = settings.get("theme_mode", "light")
        self.font_size_slider.value = settings.get("font_size", 14)
        self.enable_animations_switch.value = settings.get("enable_animations", True)
        self.enable_sounds_switch.value = settings.get("enable_sounds", False)
        self.use_real_api_switch.value = settings.get("use_real_api", False)
        
        # Застосовуємо тему
        self._apply_theme_change(self.theme_mode_dropdown.value)
        
        # Ініціалізуємо стан кнопки збереження
        self._update_save_button_state()

    def _on_theme_change(self, e):
        """Обробник зміни теми"""
        theme_value = self.theme_mode_dropdown.value
        
        # Зберігаємо як незбережену зміну
        self.settings_service.set_pending_change("theme_mode", theme_value)
        self._update_save_button_state()
        
        # НЕ застосовуємо зміну теми одразу - тільки після збереження

    def _apply_theme_change(self, theme_value):
        """Застосування зміни теми"""
        # Встановлюємо режим теми
        if theme_value == "light":
            self.page.theme_mode = ft.ThemeMode.LIGHT
        elif theme_value == "dark":
            self.page.theme_mode = ft.ThemeMode.DARK
        else:
            self.page.theme_mode = ft.ThemeMode.SYSTEM
        
        # Визначаємо акцентний колір залежно від теми
        if self.page.theme_mode == ft.ThemeMode.DARK:
            theme_color = "#3591E4"  # Блакитний для темної теми
        else:
            theme_color = "#213685"  # Синій для світлої теми (включаючи системну)
        
        # Оновлюємо тему з відповідним акцентним кольором
        self.page.theme = ft.Theme(
            color_scheme_seed=theme_color,
            use_material3=True
        )
        
        # Оновлюємо сторінку
        self.page.update()

    def _on_font_size_change(self, e):
        """Обробник зміни розміру шрифту"""
        font_size = int(self.font_size_slider.value)
        self.settings_service.set_pending_change("font_size", font_size)
        self._update_save_button_state()

    def _on_animations_change(self, e):
        """Обробник включення/відключення анімацій"""
        animations_enabled = self.enable_animations_switch.value
        self.settings_service.set_pending_change("enable_animations", animations_enabled)
        self._update_save_button_state()

    def _on_sounds_change(self, e):
        """Обробник включення/відключення звуків"""
        sounds_enabled = self.enable_sounds_switch.value
        self.settings_service.set_pending_change("enable_sounds", sounds_enabled)
        self._update_save_button_state()

    def _on_api_source_change(self, e):
        """Обробник зміни джерела даних"""
        use_real_api = self.use_real_api_switch.value
        self.settings_service.set_pending_change("use_real_api", use_real_api)
        self._update_save_button_state()

    def _update_save_button_state(self):
        """Оновлення стану кнопки збереження"""
        has_changes = self.settings_service.has_changes()
        self.save_button.disabled = not has_changes  # Кнопка активна при наявності змін
        self.save_badge.visible = has_changes  # Badge показується при змінах
        self.page.update()

    def _save_all_settings(self, e):
        """Збереження всіх налаштувань та оновлення додатку"""
        # Отримуємо нову тему перед збереженням
        new_theme = self.settings_service.pending_changes.get("theme_mode")
        
        success = self.settings_service.save_pending_changes()
        if success:
            self.save_button.disabled = True  # Відключаємо кнопку
            self.save_badge.visible = False   # Ховаємо badge
            
            # Застосовуємо тему після збереження, якщо вона була змінена
            if new_theme:
                self._apply_theme_change(new_theme)
            
            # Показуємо повідомлення про успішне збереження
            snackbar = ft.SnackBar(
                content=ft.Text("Налаштування збережено! Тема оновлена."),
                bgcolor=ft.Colors.GREEN_400,
                duration=2000
            )
            self.page.overlay.append(snackbar)
            snackbar.open = True
            
            self.page.update()
        else:
            snackbar = ft.SnackBar(
                content=ft.Text("Помилка збереження налаштувань"),
                bgcolor=ft.Colors.RED_400
            )
            self.page.overlay.append(snackbar)
            snackbar.open = True
            self.page.update()

    def _reset_settings(self, e: ft.ControlEvent):
        """Скидання налаштувань до значень за замовчуванням"""
        self.theme_mode_dropdown.value = "light"
        self.font_size_slider.value = 14
        self.enable_animations_switch.value = True
        self.enable_sounds_switch.value = False
        self.use_real_api_switch.value = False
        
        # Застосовуємо зміни теми
        self.page.theme_mode = ft.ThemeMode.LIGHT
        
        # Визначаємо колір теми після встановлення theme_mode
        theme_color = self._get_theme_color()
        
        # Оновлюємо тему з відповідним акцентним кольором
        self.page.theme = ft.Theme(
            color_scheme_seed=theme_color,
            use_material3=True
        )
        
        # Скидаємо незбережені зміни та зберігаємо налаштування
        self.settings_service.discard_pending_changes()
        self.settings_service.reset_settings()
        self.save_button.disabled = True  # Відключаємо кнопку
        self.save_badge.visible = False   # Ховаємо badge
        
        # Оновлюємо сторінку
        self.page.update()

    def _discard_changes(self):
        """Скасування незбережених змін"""
        # Завантажуємо збережені налаштування
        settings = self.settings_service.load_settings()
        
        # Повертаємо контроли до збережених значень
        self.theme_mode_dropdown.value = settings.get("theme_mode", "light")
        self.font_size_slider.value = settings.get("font_size", 14)
        self.enable_animations_switch.value = settings.get("enable_animations", True)
        self.enable_sounds_switch.value = settings.get("enable_sounds", False)
        self.use_real_api_switch.value = settings.get("use_real_api", False)
        
        # Застосовуємо збережену тему
        self._apply_theme_change(self.theme_mode_dropdown.value)
        
        # Скидаємо незбережені зміни
        self.settings_service.discard_pending_changes()
        self.save_button.disabled = True
        self.save_badge.visible = False
        
        self.page.update()

    def build(self):
        theme_color = self._get_theme_color()
        
        return ft.Container(
            content=ft.Column([
                # Заголовок
                ft.Container(
                    content=ft.Row([
                        ft.Icon(ft.Icons.SETTINGS, size=30, color=theme_color),
                        ft.Text(
                            "Налаштування",
                            size=24,
                            weight=ft.FontWeight.BOLD,
                            color=theme_color
                        )
                    ], 
                    alignment=ft.MainAxisAlignment.CENTER,
                    spacing=10),
                    padding=ft.padding.all(20),
                    bgcolor=None,
                    border_radius=10,
                    margin=ft.margin.only(bottom=20)
                ),
                
                # Налаштування теми
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            ft.Row([
                                ft.Icon(ft.Icons.PALETTE, color=theme_color),
                                ft.Text("Зовнішній вигляд", size=18, weight=ft.FontWeight.BOLD, color=theme_color)
                            ], spacing=10),
                            ft.Divider(height=1),
                            
                            # Вибір теми
                            ft.Row([
                                ft.Icon(ft.Icons.BRIGHTNESS_6),
                                ft.Container(self.theme_mode_dropdown, expand=True)
                            ], spacing=15),
                            
                            # Розмір шрифту
                            ft.Row([
                                ft.Icon(ft.Icons.FORMAT_SIZE),
                                ft.Text("Розмір шрифту:", size=14),
                                ft.Container(self.font_size_slider, expand=True)
                            ], spacing=15),
                        ], spacing=15),
                        padding=ft.padding.all(20)
                    ),
                    elevation=2,
                    margin=ft.margin.only(bottom=15)
                ),
                
                # Налаштування поведінки
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            ft.Row([
                                ft.Icon(ft.Icons.TUNE, color=theme_color),
                                ft.Text("Поведінка додатку", size=18, weight=ft.FontWeight.BOLD, color=theme_color)
                            ], spacing=10),
                            ft.Divider(height=1),
                            
                            # Анімації
                            ft.Row([
                                ft.Icon(ft.Icons.ANIMATION),
                                ft.Container(
                                    content=ft.Row([
                                        self.enable_animations_switch,
                                        ft.Text("Анімації інтерфейсу", size=14)
                                    ], spacing=10),
                                    expand=True
                                )
                            ], spacing=15),
                            
                            # Звуки
                            ft.Row([
                                ft.Icon(ft.Icons.VOLUME_UP),
                                ft.Container(
                                    content=ft.Row([
                                        self.enable_sounds_switch,
                                        ft.Text("Звукові сповіщення", size=14)
                                    ], spacing=10),
                                    expand=True
                                )
                            ], spacing=15),
                            
                            # Джерело даних
                            ft.Row([
                                ft.Icon(ft.Icons.CLOUD),
                                ft.Container(
                                    content=ft.Row([
                                        self.use_real_api_switch,
                                        ft.Text("Реальні дані УЗ", size=14)
                                    ], spacing=10),
                                    expand=True
                                )
                            ], spacing=15),
                        ], spacing=15),
                        padding=ft.padding.all(20)
                    ),
                    elevation=2,
                    margin=ft.margin.only(bottom=15)
                ),
                
                # Кнопки дій
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            ft.Row([
                                ft.Icon(ft.Icons.BUILD, color=theme_color),
                                ft.Text("Дії", size=18, weight=ft.FontWeight.BOLD, color=theme_color)
                            ], spacing=10),
                            ft.Divider(height=1),
                            
                            # Всі кнопки в одному рядку
                            ft.Row([
                                # Кнопка збереження з badge
                                ft.Container(
                                    content=ft.Stack([
                                        self.save_button,
                                        ft.Container(
                                            content=self.save_badge,
                                            right=0,
                                            top=0
                                        )
                                    ]),
                                    expand=True
                                ),
                                ft.ElevatedButton(
                                    text="Скинути",
                                    icon=ft.Icons.RESTORE,
                                    on_click=self._reset_settings,
                                    style=ft.ButtonStyle(
                                        bgcolor=ft.Colors.ORANGE_400,
                                        color=ft.Colors.WHITE,
                                        shape=ft.RoundedRectangleBorder(radius=10)
                                    )
                                ),
                                ft.ElevatedButton(
                                    text="Про додаток",
                                    icon=ft.Icons.INFO,
                                    on_click=self._show_about_dialog,
                                    style=ft.ButtonStyle(
                                        bgcolor=theme_color,
                                        color=ft.Colors.WHITE,
                                        shape=ft.RoundedRectangleBorder(radius=10)
                                    )
                                )
                            ], spacing=10, alignment=ft.MainAxisAlignment.SPACE_BETWEEN)
                        ], spacing=15),
                        padding=ft.padding.all(20)
                    ),
                    elevation=2
                )
            ], 
            scroll=ft.ScrollMode.AUTO),
            padding=ft.padding.all(10),
            expand=True
        )

    def _show_about_dialog(self, e: ft.ControlEvent):
        """Показує діалог 'Про додаток'"""
        theme_color = self._get_theme_color()
        
        self.about_dialog = ft.AlertDialog(
            modal=True,
            title=ft.Text("Про додаток", weight=ft.FontWeight.BOLD),
            content=ft.Container(
                content=ft.Column([
                    ft.Row([
                        ft.Icon(ft.Icons.TRAIN, size=40, color=theme_color),
                        ft.Column([
                            ft.Text("Розклад поїздів України", size=18, weight=ft.FontWeight.BOLD),
                            ft.Text("Версія 1.0.0", size=14)
                        ], spacing=5)
                    ], spacing=15),
                    ft.Divider(),
                    ft.Text("Сучасний додаток для перегляду розкладу поїздів України", size=14),
                    ft.Text("Створено на Flet v0.28.3", size=12),
                    ft.Divider(),
                    ft.Text("© 2025 Techbedo", size=12),
                    ft.Text("Автор: Дяченко Віктор", size=12)
                ], spacing=10, tight=True),
                width=400,
                height=250
            ),
            actions=[
                ft.TextButton("Закрити", on_click=self._close_dialog)
            ],
            actions_alignment=ft.MainAxisAlignment.END,
            on_dismiss=lambda e: print("About dialog dismissed!")
        )
        
        self.page.open(self.about_dialog)

    def _close_dialog(self, e: ft.ControlEvent):
        """Закриває діалог"""
        if self.about_dialog:
            self.page.close(self.about_dialog)

    def _get_theme_color(self):
        """Повертає колір залежно від поточної теми"""
        if self.page.theme_mode == ft.ThemeMode.DARK:
            return "#3591E4"
        else:
            return "#213685"
