# 🚂 Розклад поїздів України

Сучасний веб-додаток для перегляду розкладу руху поїздів, створений на Flet v0.28.3.

## 🎯 Функціональність

### 📍 Пошук маршруту
- Пошук поїздів між станціями відправлення та прибуття
- Фільтрація за типом рухомого складу (Пасажирський, Приміський, Усі)
- Вибір дати відправлення
- Можливість поміняти станції місцями

### 🚉 Розклад станції
- Перегляд розкладу всіх поїздів для конкретної станції
- Вибір дати
- Фільтрація за типом поїзда
- Відображення часу прибуття/відправлення та номера платформи
- Статус поїздів (за розкладом/затримка)

### 🔢 Пошук за номером поїзда
- Детальна інформація про конкретний поїзд
- Повний маршрут з усіма станціями
- Час прибуття/відправлення на кожній станції
- Номери платформ та тривалість зупинок

### ⚙️ Налаштування
- **Вибір теми**: Світла, темна або системна тема
- **Збереження налаштувань**: Автоматичне збереження вибору користувача
- **Розмір шрифту**: Налаштування розміру тексту (12-20px)
- **Анімації**: Включення/відключення анімацій інтерфейсу
- **Звукові сповіщення**: Контроль звукових ефектів
- **Скидання налаштувань**: Повернення до значень за замовчуванням
- **Про додаток**: Інформація про версію та автора

## 🎨 Дизайн

- **Акцентний колір**: #213685 (синій)
- **Material Design 3**: Сучасний та інтуїтивний інтерфейс
- **Адаптивність**: Підтримка різних розмірів екранів
- **Доступність**: Зрозумілі іконки та підписи

## 🏗️ Архітектура

Проект побудований за принципами SOLID:

```
src/
├── main.py                 # Точка входу
├── app/
│   ├── models/            # Моделі даних
│   │   ├── train.py
│   │   ├── station.py
│   │   └── schedule.py
│   ├── views/             # UI компоненти
│   │   ├── main_view.py
│   │   ├── route_search_view.py
│   │   ├── station_schedule_view.py
│   │   ├── train_number_view.py
│   │   └── components.py
│   ├── services/          # Бізнес логіка
│   │   ├── schedule_service.py
│   │   ├── search_service.py
│   │   └── uz_api_service.py
│   ├── repositories/      # Доступ до даних
│   │   └── schedule_repository.py
│   └── utils/            # Допоміжні функції
│       ├── constants.py
│       └── helpers.py
```

## 🚀 Запуск

### uv

Run as a desktop app:

```
uv run flet run
```

Run as a web app:

```
uv run flet run --web
```

### Poetry

Install dependencies from `pyproject.toml`:

```
poetry install
```

Run as a desktop app:

```
poetry run flet run
```

Run as a web app:

```
poetry run flet run --web
```

For more details on running the app, refer to the [Getting Started Guide](https://flet.dev/docs/getting-started/).

## Build the app

### Android

```
flet build apk -v
```

For more details on building and signing `.apk` or `.aab`, refer to the [Android Packaging Guide](https://flet.dev/docs/publish/android/).

### iOS

```
flet build ipa -v
```

For more details on building and signing `.ipa`, refer to the [iOS Packaging Guide](https://flet.dev/docs/publish/ios/).

### macOS

```
flet build macos -v
```

For more details on building macOS package, refer to the [macOS Packaging Guide](https://flet.dev/docs/publish/macos/).

### Linux

```
flet build linux -v
```

For more details on building Linux package, refer to the [Linux Packaging Guide](https://flet.dev/docs/publish/linux/).

### Windows

```
flet build windows -v
```

For more details on building Windows package, refer to the [Windows Packaging Guide](https://flet.dev/docs/publish/windows/).