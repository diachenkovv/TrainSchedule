import flet as ft
from ..services.settings_service import SettingsService


class SettingsView:
    def __init__(self, page: ft.Page, on_settings_changed=None, on_theme_changed=None):
        self.page = page
        self.settings_service = SettingsService()
        self.on_settings_changed = on_settings_changed
        self.on_theme_changed = on_theme_changed
        self.suppress_callback = True  # Додаємо прапорець для блокування callback
        
        # Завантажуємо поточні налаштування
        self.current_settings = self.settings_service.load_settings()
        
        # Кнопка збереження
        self.save_button = ft.ElevatedButton(
            text="Зберегти налаштування",
            icon=ft.Icons.SAVE,
            on_click=self._save_all_settings,
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.GREY_400,  # Початково сіра
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            ),
            disabled=True  # Спочатку неактивна
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
        self.suppress_callback = False  # Дозволяємо callback після ініціалізації
        
        # Діалог "Про додаток"
        self.about_dialog = None

    @property
    def has_unsaved_changes(self):
        """Повертає True, якщо є незбережені зміни"""
        return self.settings_service.has_changes()

    def _init_current_settings(self):
        """Ініціалізація поточних налаштувань"""
        # Завантажуємо збережені налаштування
        settings = self.settings_service.load_settings()
        
        # Встановлюємо значення контролів
        self.theme_mode_dropdown.value = settings.get("theme_mode", "light")
        self.enable_animations_switch.value = settings.get("enable_animations", True)
        self.enable_sounds_switch.value = settings.get("enable_sounds", False)
        self.use_real_api_switch.value = settings.get("use_real_api", False)
        
        # Застосовуємо тему
        self._apply_theme_change(self.theme_mode_dropdown.value)
        
        # Ініціалізуємо стан кнопки збереження (без виклику callback)
        self._update_save_button_state(suppress_callback=True)

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

    def _update_save_button_state(self, suppress_callback=False):
        """Оновлення стану кнопки збереження"""
        has_changes = self.settings_service.has_changes()
        
        # Оновлюємо стан кнопки та її стиль
        self.save_button.disabled = not has_changes  # Активна лише при наявності змін
        
        if has_changes:
            # Зелена кнопка коли є зміни
            self.save_button.style = ft.ButtonStyle(
                bgcolor=ft.Colors.GREEN_400,
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        else:
            # Сіра кнопка коли немає змін
            self.save_button.style = ft.ButtonStyle(
                bgcolor=ft.Colors.GREY_400,
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        
        self.page.update()
        
        # Повідомляємо про зміни для оновлення Badge у вкладці
        if self.on_settings_changed and not getattr(self, 'suppress_callback', False) and not suppress_callback:
            self.on_settings_changed()

    def _save_all_settings(self, e):
        """Збереження всіх налаштувань та оновлення додатку"""
        # Отримуємо нову тему перед збереженням
        new_theme = self.settings_service.pending_changes.get("theme_mode")
        
        success = self.settings_service.save_pending_changes()
        if success:
            # Оновлюємо стан кнопки (стане сірою і неактивною)
            self._update_save_button_state(suppress_callback=False)  # Дозволяємо callback для оновлення Badge
            
            # Застосовуємо тему після збереження, якщо вона була змінена
            if new_theme:
                self._apply_theme_change(new_theme)
                # Повідомляємо про зміну теми
                if self.on_theme_changed:
                    self.on_theme_changed()
            
            # Показуємо повідомлення про успішне збереження
            snackbar = ft.SnackBar(
                content=ft.Text("Налаштування збережено!"),
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
        # Оновлюємо стан кнопки і викликаємо callback для Badge
        self._update_save_button_state(suppress_callback=False)
        
        # Повідомляємо про зміну теми
        if self.on_theme_changed:
            self.on_theme_changed()
        
        # Оновлюємо сторінку
        self.page.update()

    def _discard_changes(self):
        """Скасування незбережених змін"""
        # Завантажуємо збережені налаштування
        settings = self.settings_service.load_settings()
        
        # Повертаємо контроли до збережених значень
        self.theme_mode_dropdown.value = settings.get("theme_mode", "light")
        self.enable_animations_switch.value = settings.get("enable_animations", True)
        self.enable_sounds_switch.value = settings.get("enable_sounds", False)
        self.use_real_api_switch.value = settings.get("use_real_api", False)
        
        # Застосовуємо збережену тему
        self._apply_theme_change(self.theme_mode_dropdown.value)
        
        # Скидаємо незбережені зміни
        self.settings_service.discard_pending_changes()
        # Оновлюємо стан кнопки
        self._update_save_button_state(suppress_callback=True)
        self.page.update()

    def build(self):
        theme_color = self._get_theme_color()
        
        # Створюємо елементи з посиланнями для оновлення теми
        
        self.appearance_icon = ft.Icon(ft.Icons.PALETTE, color=theme_color)
        self.appearance_title = ft.Text("Зовнішній вигляд", size=18, weight=ft.FontWeight.BOLD, color=theme_color)
        
        self.behavior_icon = ft.Icon(ft.Icons.TUNE, color=theme_color)
        self.behavior_title = ft.Text("Поведінка додатку", size=18, weight=ft.FontWeight.BOLD, color=theme_color)
        
        self.actions_icon = ft.Icon(ft.Icons.BUILD, color=theme_color)
        self.actions_title = ft.Text("Дії", size=18, weight=ft.FontWeight.BOLD, color=theme_color)
        
        self.reset_button = ft.ElevatedButton(
            text="Скинути",
            icon=ft.Icons.RESTORE,
            on_click=self._show_reset_dialog,  # Змінено на показ діалогу
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.ORANGE_400,
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        )
        
        self.about_button = ft.ElevatedButton(
            text="Про додаток",
            icon=ft.Icons.INFO,
            on_click=self._show_about_dialog,
            style=ft.ButtonStyle(
                bgcolor=theme_color,
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        )
        
        # --- Гнучкий адаптивний блок теми ---
        theme_block = ft.ResponsiveRow([
            ft.Container(ft.Icon(ft.Icons.BRIGHTNESS_6), col={"xs": 12, "sm": 2, "md": 2, "lg": 2}),
            ft.Container(self.theme_mode_dropdown, expand=True, col={"xs": 12, "sm": 10, "md": 10, "lg": 10})
        ], spacing=15)
        # --- Гнучкий адаптивний блок анімацій ---
        anim_block = ft.ResponsiveRow([
            ft.Container(ft.Icon(ft.Icons.ANIMATION), col={"xs": 12, "sm": 2, "md": 2, "lg": 2}),
            ft.Container(
                content=ft.Row([
                    self.enable_animations_switch,
                    ft.Text("Анімації інтерфейсу", size=14)
                ], spacing=10),
                expand=True, col={"xs": 12, "sm": 10, "md": 10, "lg": 10}
            )
        ], spacing=15)
        # --- Гнучкий адаптивний блок звуків ---
        sound_block = ft.ResponsiveRow([
            ft.Container(ft.Icon(ft.Icons.VOLUME_UP), col={"xs": 12, "sm": 2, "md": 2, "lg": 2}),
            ft.Container(
                content=ft.Row([
                    self.enable_sounds_switch,
                    ft.Text("Звукові сповіщення", size=14)
                ], spacing=10),
                expand=True, col={"xs": 12, "sm": 10, "md": 10, "lg": 10}
            )
        ], spacing=15)
        # --- Гнучкий адаптивний блок джерела даних ---
        api_block = ft.ResponsiveRow([
            ft.Container(ft.Icon(ft.Icons.CLOUD), col={"xs": 12, "sm": 2, "md": 2, "lg": 2}),
            ft.Container(
                content=ft.Row([
                    self.use_real_api_switch,
                    ft.Text("Реальні дані УЗ", size=14)
                ], spacing=10),
                expand=True, col={"xs": 12, "sm": 10, "md": 10, "lg": 10}
            )
        ], spacing=15)
        # --- Гнучкий адаптивний блок кнопок дій ---
        actions_buttons = ft.ResponsiveRow([
            ft.Container(self.save_button, col={"xs": 12, "sm": 4, "md": 4, "lg": 4}),
            ft.Container(self.reset_button, col={"xs": 12, "sm": 4, "md": 4, "lg": 4}),
            ft.Container(self.about_button, col={"xs": 12, "sm": 4, "md": 4, "lg": 4})
        ], spacing=10)

        return ft.Container(
            content=ft.Column([
                # Налаштування теми
                ft.Card(
                    content=ft.Container(
                        content=ft.Column([
                            ft.Row([
                                self.appearance_icon,
                                self.appearance_title
                            ], spacing=10),
                            ft.Divider(height=1),
                            ft.Row([
                                ft.Icon(ft.Icons.BRIGHTNESS_6),
                                ft.Container(self.theme_mode_dropdown, expand=True)
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
                                self.behavior_icon,
                                self.behavior_title
                            ], spacing=10),
                            ft.Divider(height=1),
                            ft.Row([
                                ft.Icon(ft.Icons.ANIMATION),
                                ft.Container(
                                    content=ft.Row([
                                        self.enable_animations_switch,
                                    ], spacing=10),
                                    expand=True
                                )
                            ], spacing=15),
                            ft.Row([
                                ft.Icon(ft.Icons.VOLUME_UP),
                                ft.Container(
                                    content=ft.Row([
                                        self.enable_sounds_switch,
                                    ], spacing=10),
                                    expand=True
                                )
                            ], spacing=15),
                            ft.Row([
                                ft.Icon(ft.Icons.CLOUD),
                                ft.Container(
                                    content=ft.Row([
                                        self.use_real_api_switch,
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
                                self.actions_icon,
                                self.actions_title
                            ], spacing=10),
                            ft.Divider(height=1),
                            actions_buttons
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

    def _show_reset_dialog(self, e):
        """Показує діалог підтвердження скидання налаштувань"""
        theme_color = self._get_theme_color()
        
        self.reset_dialog = ft.AlertDialog(
            modal=True,
            title=ft.Row([
                ft.Icon(ft.Icons.WARNING, color=ft.Colors.ORANGE, size=24),
                ft.Text("Підтвердження скидання", weight=ft.FontWeight.BOLD)
            ], spacing=10),
            content=ft.Container(
                content=ft.Column([
                    ft.Text(
                        "Ви дійсно хочете скинути всі налаштування до значень за замовчуванням?",
                        size=16
                    ),
                    ft.Text(
                        "Ця дія незворотна і всі ваші персональні налаштування будуть втрачені.",
                        size=14,
                        color=ft.Colors.GREY_600
                    )
                ], spacing=10, tight=True),
                width=400,
                height=100
            ),
            actions=[
                ft.TextButton(
                    "Скасувати",
                    on_click=self._close_reset_dialog,
                    style=ft.ButtonStyle(
                        color=ft.Colors.GREY_600
                    )
                ),
                ft.ElevatedButton(
                    "Скинути",
                    icon=ft.Icons.RESTORE,
                    on_click=self._confirm_reset,
                    style=ft.ButtonStyle(
                        bgcolor=ft.Colors.ORANGE_400,
                        color=ft.Colors.WHITE
                    )
                )
            ],
            actions_alignment=ft.MainAxisAlignment.END
        )
        
        self.page.open(self.reset_dialog)

    def _close_reset_dialog(self, e):
        """Закриває діалог скидання"""
        if hasattr(self, 'reset_dialog'):
            self.page.close(self.reset_dialog)

    def _confirm_reset(self, e):
        """Підтверджує скидання налаштувань"""
        # Закриваємо діалог
        self._close_reset_dialog(e)
        
        # Виконуємо скидання
        self._reset_settings(e)

    def _get_theme_color(self):
        """Повертає колір залежно від поточної теми"""
        if self.page.theme_mode == ft.ThemeMode.DARK:
            return "#3591E4"
        else:
            return "#213685"
    
    def update_theme(self):
        """Оновлює кольори елементів відповідно до поточної теми"""
        theme_color = self._get_theme_color()
        
        # Оновлюємо всі елементи, які мають theme-залежні кольори
        if hasattr(self, 'appearance_icon'):
            self.appearance_icon.color = theme_color
        if hasattr(self, 'appearance_title'):
            self.appearance_title.color = theme_color
        if hasattr(self, 'behavior_icon'):
            self.behavior_icon.color = theme_color
        if hasattr(self, 'behavior_title'):
            self.behavior_title.color = theme_color
        if hasattr(self, 'actions_icon'):
            self.actions_icon.color = theme_color
        if hasattr(self, 'actions_title'):
            self.actions_title.color = theme_color
        if hasattr(self, 'about_button'):
            self.about_button.style = ft.ButtonStyle(
                bgcolor=theme_color,
                color=ft.Colors.WHITE,
                shape=ft.RoundedRectangleBorder(radius=10)
            )
        if hasattr(self, 'header_icon'):
            self.header_icon.color = theme_color
        if hasattr(self, 'header_title'):
            self.header_title.color = theme_color
