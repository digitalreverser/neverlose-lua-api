# Lua API — справочник

[Главная](../README.md) · [Быстрый старт](getting-started.md) · [Примеры](../examples/README.md)

- Рантайм: **LuaJIT 2.1 / Lua 5.1**.
- `x?` или `[x]` — необязательный аргумент; `a | b` — один из типов.
- `obj:method()` — метод объекта, `space.func()` — функция таблицы, `obj.prop` — свойство.

## Содержание

| Раздел | Обращений |
|---|---|
| [События — `events`](reference/events.md) | 3 |
| [Типы — `vector`, `angle`, `vector2`, `color`](reference/types.md) | 84 |
| [Команда — `cmd`](reference/cmd.md) | 21 |
| [Игрок в `createmove` — `simulation.player`](reference/simulation.md) | 96 |
| [Сущности — `entity`, `hitbox`](reference/entity.md) | 27 |
| [Трассировки — `trace`](reference/trace.md) | 14 |
| [Отрисовка — `render`, `font`, `image`](reference/render.md) | 27 |
| [Меню — `ui`, `tab`, `group`, `variable`](reference/ui.md) | 93 |
| [Время и камера — `globals`, `view_context`](reference/globals.md) | 6 |
| [Утилиты — `utils`, `os`](reference/utils.md) | 12 |
| [Данные — `json`, `msgpack`, `database`, `filesystem`, `http`](reference/data.md) | 22 |

## Окружение

| Что | Как устроено |
|---|---|
| Стандартные библиотеки | `_G` (base), `table`, `string`, `math`, `bit`, `jit` |
| `ffi` | только при включённом **Allow Insecure** |
| `io`, `debug`, `package` | не загружаются |
| `dofile`, `loadfile` | `nil` |
| `os` | `os.clock()`, `os.time()`, `os.date()`, свойство `os.clipboard` |
| `require` | модули `http` и `filesystem`, затем файлы `scripts\lib\<имя>.lua` |
| `print(...)` | пишет в вывод Lua |

Где что можно вызывать:

- `render.*` — только внутри события `render`.
- `trace.*` — внутри `createmove` и колбэков игровых событий.
- `cmd` и `simulation.player` действительны только внутри своего `createmove`, `view_context` — внутри `override_view`, объект игрового события — внутри своего колбэка.

Папки на диске:

| Путь | Назначение |
|---|---|
| `C:\neverwin\scripts` | Скрипты `.lua` |
| `C:\neverwin\scripts\lib` | Модули для `require` |
| `C:\neverwin\scripts\images` | Изображения |
| `C:\neverwin\scripts\fonts` | Шрифты (также ищутся в `Windows\Fonts`) |
| `C:\neverwin\scripts\data` | Файлы модуля `filesystem` |
| `C:\neverwin\scripts\data\db` | Хранилище `database` |
