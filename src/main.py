import flet as ft
from app.views.main_view import MainView
from app.config import APP_CONFIG
from app.services.settings_service import SettingsService


def main(page: ft.Page):
    # Завантажуємо налаштування користувача
    settings_service = SettingsService()
    user_settings = settings_service.load_settings()
    
    # Налаштування сторінки з конфігурації та користувацьких налаштувань
    page.title = APP_CONFIG["title"]
    page.window.width = APP_CONFIG["window_width"]
    page.window.height = APP_CONFIG["window_height"]
    page.window.resizable = APP_CONFIG["resizable"]
    page.scroll = None
    
    # Встановлення теми з користувацьких налаштувань
    theme_mode = user_settings.get("theme_mode", "light")
    if theme_mode == "light":
        page.theme_mode = ft.ThemeMode.LIGHT
        theme_color = APP_CONFIG["theme_color_light"]  # Синій для світлої теми
    elif theme_mode == "dark":
        page.theme_mode = ft.ThemeMode.DARK
        theme_color = APP_CONFIG["theme_color"]  # Блакитний для темної теми
    else:
        page.theme_mode = ft.ThemeMode.SYSTEM
        theme_color = APP_CONFIG["theme_color"]  # За замовчуванням блакитний
    
    # Встановлення теми з відповідним акцентним кольором
    page.theme = ft.Theme(
        color_scheme_seed=theme_color,
        use_material3=True
    )
    
    # Створення головного вигляду з передачею settings_service
    main_view = MainView(page, settings_service)
    page.add(main_view.build())


if __name__ == "__main__":
    ft.app(main, view=ft.AppView.WEB_BROWSER)
