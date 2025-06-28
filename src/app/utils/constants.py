import flet as ft


class ThemeColors:
    """Клас з колірною схемою програми"""
    # Головні кольори з дизайн-системи
    PRIMARY = "#3591E4"  # Новий акцентний колір для темної теми
    PRIMARY_LIGHT = "#213685"  # Зберігаємо старий як світлий варіант
    PRIMARY_DARK = "#2B2E7F"
    
    # Додаткові кольори з дизайн-системи
    SECONDARY = "#71FB6E"
    SECONDARY_LIGHT = "#C2DCFC"
    SECONDARY_DARK = "#0610FF"
    
    # Системні кольори
    SUCCESS = "#1BDA17"
    SUCCESS_LIGHT = "#ADFFAB"
    
    WARNING = "#FED403"
    WARNING_LIGHT = "#EEFFAB"
    
    ERROR = "#E71212"
    ERROR_LIGHT = "#FED4D4"
    
    # Нейтральні кольори
    BACKGROUND = "#FFFFFF"
    SURFACE = "#FFFFFF"
    SURFACE_VARIANT = "#F8F9FA"
    TEXT_PRIMARY = "#000000"
    TEXT_SECONDARY = "#878787"
    BORDER = "#DEDEDE"


class TrainTypes:
    """Типи поїздів"""
    ALL = "all"
    PASSENGER = "passenger"
    SUBURBAN = "suburban"
    
    LABELS = {
        ALL: "Усі",
        PASSENGER: "Пасажирський", 
        SUBURBAN: "Приміський"
    }
    
    COLORS = {
        PASSENGER: ft.Colors.BLUE_600,
        SUBURBAN: ft.Colors.ORANGE_600
    }
    
    BACKGROUND_COLORS = {
        PASSENGER: ft.Colors.BLUE_100,
        SUBURBAN: ft.Colors.ORANGE_100
    }
