# Утилиты — `utils`, `os`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

```lua
utils.console("value:", 42)
utils.schedule(1.5, function(tag) print(tag) end, "later")   -- отложенный вызов, секунды
print(utils.unix_time(), utils.timestamp())
print(utils.random_int(1, 6), utils.random_float(0, 1))
print(utils.username(), utils.strftime("%H:%M:%S", utils.unix_time()))
```

Из стандартной `os` доступны `os.clock()`, `os.time()` и `os.date()`.

## Справочник

### `utils`

| Обращение | Описание |
|---|---|
| `utils.random_seed(seed: integer)` | Задаёт начальное значение генератора случайных чисел. |
| `utils.random_int(a: integer, b: integer) -> integer` | Случайное целое в пределах от меньшего до большего из аргументов включительно. |
| `utils.random_float(a: number, b: number) -> number` | Случайное дробное число между аргументами. |
| `utils.timestamp() -> number` | Время в миллисекундах; подходит для измерения интервалов. |
| `utils.unix_time() -> number` | Текущее время: секунды с 1 января 1970 года. |
| `utils.interface(module: string, name: string) -> integer\|nil` | Адрес интерфейса игры по имени модуля и интерфейса. Нужен Allow Insecure. |
| `utils.pattern(module: string, pattern: string) -> integer\|nil` | Адрес последовательности байтов в модуле; байты через пробел, `?` — любой. Нужен Allow Insecure. |
| `utils.strftime(format: string [, time: number]) -> string\|nil` | Строка с датой и временем по формату `strftime`. Без второго аргумента — текущее время. |
| `utils.username() -> string` | Имя пользователя. |
| `utils.schedule(delay: number, callback: function, ...)` | Вызывает `callback` через `delay` секунд; лишние аргументы передаются в него. |
| `utils.console(...)` | Печатает аргументы в консоль через пробел. |

### `os`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `clipboard` | `string` | чтение и запись | Текст буфера обмена. Нужен Allow Insecure. |
