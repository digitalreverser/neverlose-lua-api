# Neverlose Lua API

Документация Lua API для нашей сборки CS2: события, меню, отрисовка, игровые объекты, команда и
вспомогательные модули.

[Быстрый старт](docs/getting-started.md) · [Полный справочник](docs/reference.md) · [Примеры](examples/README.md)

## Первый скрипт

Создай скрипт через **Extensions → +**, вставь код и нажми **Save & Reload**:

```lua
print("Hello from Neverlose Lua!")

local font = render.load_font("verdana.ttf", 14)

events.render:set(function()
    render.text(font, vector2(24, 90), color(255, 255, 255, 255), "", "Hello, Lua!")
end)
```

Готовые примеры можно положить в `C:\neverwin\scripts` и загрузить через Extensions.

## Разделы API

| Раздел | Что внутри |
| --- | --- |
| [Окружение](docs/reference.md#окружение) | LuaJIT, стандартные библиотеки, пути, где что можно вызывать |
| [События](docs/reference/events.md) | `events.<имя>:set / :unset / :fire`, список событий, игровые события |
| [Типы](docs/reference/types.md) | `vector`, `angle`, `vector2`, `color` |
| [Команда](docs/reference/cmd.md) | `cmd` в `createmove`: углы, кнопки, движение |
| [Игрок в createmove](docs/reference/simulation.md) | `simulation.player`, оружие в руках, параметры движения |
| [Сущности](docs/reference/entity.md) | Игроки, оружие, хитбоксы |
| [Трассировки](docs/reference/trace.md) | Луч и бокс, фильтры, результат, маски |
| [Отрисовка](docs/reference/render.md) | Текст, фигуры, изображения, шрифты |
| [Меню](docs/reference/ui.md) | Вкладки, группы, элементы, привязки клавиш, наборы цветов |
| [Время и камера](docs/reference/globals.md) | `globals`, камера в `override_view` |
| [Утилиты](docs/reference/utils.md) | Консоль, отложенные вызовы, время, случайные числа |
| [Данные](docs/reference/data.md) | `json`, `msgpack`, `database`, `filesystem`, `http` |

## Как читать справочник

- `x?` или `[x]` — необязательный аргумент; `a | b` — один из типов.
- `obj:method()` — метод объекта, `space.func()` — функция таблицы, `obj.prop` — свойство.
- У свойств указан доступ: «чтение» или «чтение и запись».
- Пометка «нужен Allow Insecure» означает, что обращение работает только у скрипта с этим разрешением.

## Сообщить о проблеме

Создай [Issue](https://github.com/digitalreverser/neverlose-lua-api/issues) и приложи минимальный
пример, версию сборки, текст ошибки и ожидаемый результат.
