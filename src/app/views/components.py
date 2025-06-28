import flet as ft
from ..utils.constants import ThemeColors, TrainTypes


class LoadingIndicator:
    """Компонент індикатора завантаження"""
    
    @staticmethod
    def create(message: str = "Завантаження...") -> ft.Container:
        return ft.Container(
            content=ft.Column([
                ft.ProgressRing(color=ThemeColors.PRIMARY),
                ft.Text(message, text_align=ft.TextAlign.CENTER, size=14)
            ], 
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            spacing=10),
            alignment=ft.alignment.center,
            height=200
        )


class ErrorMessage:
    """Компонент для відображення помилок"""
    
    @staticmethod
    def create(message: str, icon: str = ft.Icons.ERROR) -> ft.Container:
        return ft.Container(
            content=ft.Column([
                ft.Icon(icon, size=48, color=ThemeColors.ERROR),
                ft.Text(message, 
                       text_align=ft.TextAlign.CENTER,
                       color=ThemeColors.ERROR,
                       size=16)
            ], 
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            spacing=10),
            alignment=ft.alignment.center,
            height=150
        )


class InfoMessage:
    """Компонент для відображення інформаційних повідомлень"""
    
    @staticmethod
    def create(message: str, icon: str = ft.Icons.INFO_OUTLINE) -> ft.Container:
        return ft.Container(
            content=ft.Row([
                ft.Icon(icon, size=16),
                ft.Text(message, size=12, italic=True)
            ], spacing=5),
            border_radius=8,
            padding=ft.padding.all(10),
            margin=ft.margin.only(top=10)
        )


class TrainTypeChip:
    """Компонент для відображення типу поїзда"""
    
    @staticmethod
    def create(train_type: str) -> ft.Chip:
        return ft.Chip(
            label=ft.Text(
                TrainTypes.LABELS.get(train_type, train_type), 
                size=12, 
                weight=ft.FontWeight.BOLD
            ),
            bgcolor=TrainTypes.BACKGROUND_COLORS.get(train_type, ft.Colors.GREY_100)
        )


class StatusIndicator:
    """Компонент для відображення статусу поїзда"""
    
    @staticmethod
    def create(status: str) -> ft.Container:
        is_on_time = "За розкладом" in status
        color = ThemeColors.SUCCESS if is_on_time else ThemeColors.ERROR
        bg_color = ThemeColors.SUCCESS_LIGHT if is_on_time else ThemeColors.ERROR_LIGHT
        icon = ft.Icons.CHECK_CIRCLE if is_on_time else ft.Icons.ACCESS_TIME
        
        return ft.Container(
            content=ft.Row([
                ft.Icon(icon, size=16, color=color),
                ft.Text(status, size=14, color=color, weight=ft.FontWeight.BOLD)
            ], spacing=5),
            bgcolor=bg_color,
            border_radius=8,
            padding=ft.padding.symmetric(horizontal=10, vertical=5)
        )


class CustomButton:
    """Компонент кастомної кнопки"""
    
    @staticmethod
    def create(
        text: str, 
        icon: str, 
        on_click,
        primary: bool = True,
        width: int = None
    ) -> ft.ElevatedButton:
        return ft.ElevatedButton(
            text=text,
            icon=icon,
            on_click=on_click,
            style=ft.ButtonStyle(
                bgcolor=ThemeColors.PRIMARY if primary else ThemeColors.SURFACE,
                color=ft.Colors.WHITE if primary else ThemeColors.PRIMARY,
                padding=ft.padding.symmetric(horizontal=30, vertical=15),
                shape=ft.RoundedRectangleBorder(radius=10)
            ),
            height=50,
            width=width
        )


class StyledTextField:
    """Компонент стилізованого текстового поля"""
    
    @staticmethod
    def create(
        label: str,
        hint_text: str = None,
        prefix_icon: str = None,
        on_change = None
    ) -> ft.TextField:
        return ft.TextField(
            label=label,
            hint_text=hint_text or f"Введіть {label.lower()}",
            prefix_icon=prefix_icon,
            border_radius=10,
            filled=True,
            bgcolor=ThemeColors.SURFACE_VARIANT,
            on_change=on_change
        )


class StyledDropdown:
    """Компонент стилізованого випадаючого списку"""
    
    @staticmethod
    def create(
        label: str,
        options: list,
        value: str = None,
        on_change = None
    ) -> ft.Dropdown:
        return ft.Dropdown(
            label=label,
            hint_text=f"Оберіть {label.lower()}",
            options=options,
            value=value,
            border_radius=10,
            filled=True,
            bgcolor=ThemeColors.SURFACE_VARIANT,
            on_change=on_change
        )


class HeaderCard:
    """Компонент заголовка секції"""
    
    @staticmethod
    def create(title: str, icon: str = None) -> ft.Container:
        content = [ft.Text(title, size=24, weight=ft.FontWeight.BOLD, color=ThemeColors.PRIMARY)]
        
        if icon:
            content.insert(0, ft.Icon(icon, size=30, color=ThemeColors.PRIMARY))
        
        return ft.Container(
            content=ft.Row(
                content,
                alignment=ft.MainAxisAlignment.CENTER,
                spacing=10
            ),
            padding=ft.padding.all(20),
            bgcolor=ThemeColors.SURFACE_VARIANT,
            border_radius=10,
            margin=ft.margin.only(bottom=10)
        )
