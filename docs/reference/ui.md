# Меню — `ui`, `tab`, `group`, `variable`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

```lua
local tab = ui.tab("My script")
local group = tab:group("Main")

local enabled = group:toggle("Enabled", true)
local speed   = group:slider("Speed", 0, 100, 50)
local mode    = group:combo("Mode", { "Off", "Legit", "Rage" })
local tint    = group:color_picker("Color", color(255, 255, 255, 255))
local key     = group:hotkey("Key")
local button  = group:button("Reset")

button:add_callback(function() speed:set_value(50) end)
enabled:add_callback(function() speed:set_visible(enabled:get()) end, true)   -- true: вызвать сразу

events.render:set(function()
    if not enabled:get() then return end
    print(speed:get(), mode:get(), tint:get())
end)

local existing = ui.find("Ragebot", "Main", "Enabled")   -- элемент встроенного меню по пути
```

- `variable:get()` — значение с учётом привязок клавиш, `variable:get_value()` — само значение.
- `combo` и `list` возвращают имя выбранного пункта; записать можно имя или номер пункта с нуля.
- У элементов встроенного меню, найденных через `ui.find`, имя, иконка, подсказка и список пунктов не
  меняются; у элементов, созданных скриптом, меняется всё.
- Значение `color_set` и `color_modes` — объект `colors`: `colors[имя]` или `colors[номер]` читает цвет,
  `#colors` — число цветов, `pairs(colors)` и `ipairs(colors)` перебирают их.

## Справочник

### `ui`

| Обращение | Описание |
|---|---|
| `ui.find(path1: string, ...: string) -> tab\|group\|variable\|nil` | Находит существующий элемент меню по пути (вкладка, группа, элемент). Возвращает найденное или `nil`. |
| `ui.tab(name: string) -> tab` | Создаёт вкладку скрипта или возвращает уже созданную. |
| `ui.binds(flag?: boolean) -> table` | Массив активных привязок клавиш — объекты `bind`. |
| `ui.alpha() -> number` | Текущая прозрачность меню, 0..1. |
| `ui.scale(name?: string, value?: number) -> number` | Масштаб интерфейса. |
| `ui.position() -> vector2\|nil` | Позиция окна меню или `nil`, если оно не открыто. |
| `ui.size() -> vector2\|nil` | Размер окна меню или `nil`, если оно не открыто. |
| `ui.cursor() -> vector2` | Позиция курсора мыши. |
| `ui.style(name?: string) -> any\|nil` | Цвет или параметр оформления меню по имени. |
| `ui.sidebar(name?: string, icon?: string)` | Задаёт заголовок и иконку пункта скрипта в боковой панели. |
| `ui.localize(lang: string, key: string, text: string)` | Добавляет перевод строки интерфейса для языка `lang`. |
| `ui.units(value?: number) -> string \| (number, string, string)` | Система единиц измерения; с числом — перевод величины в неё. |

### `tab`

| Обращение | Описание |
|---|---|
| `tab:group(name: string, column?: string) -> group` | Создаёт группу на вкладке или возвращает существующую. |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `name` | `string` | чтение и запись | Имя вкладки. |

Операторы: `==`.

### `group`

| Обращение | Описание |
|---|---|
| `group:toggle(name: string, default?: boolean) -> variable` | Переключатель. Значение — `boolean`. |
| `group:combo(name: string, items: table) -> variable` | Выпадающий список с одним выбором. Значение — имя выбранного пункта. |
| `group:multicombo(name: string, items: table) -> variable` | Выпадающий список с несколькими выборами. |
| `group:list(name: string, items: table) -> variable` | Список с одним выбором. Значение — имя выбранного пункта. |
| `group:textbox(name: string, default?: string) -> variable` | Поле ввода текста. Значение — строка. |
| `group:label(text: string) -> variable` | Текстовая метка. |
| `group:button(name: string) -> variable` | Кнопка. Нажатие обрабатывается через `variable:add_callback`. |
| `group:hotkey(name: string, key?: integer) -> variable` | Поле назначения клавиши. |
| `group:color_picker(name: string, color?: color) -> variable` | Выбор одного цвета. Значение — `color`. |
| `group:color_set(name: string, colors: table) -> variable` | Набор именованных цветов в одном элементе. Значение — объект `colors`. |
| `group:color_modes(name: string, modes: table) -> variable` | Цвет с переключаемыми режимами. Значение — объект `colors`. |
| `group:slider(name: string, min: number, max: number, default?: number) -> variable` | Ползунок. Целочисленный, если границы и значение по умолчанию целые. |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `name` | `string` | чтение и запись | Имя группы. |

Операторы: `==`.

### `variable`

| Обращение | Описание |
|---|---|
| `variable:export() -> string` | Значение элемента строкой, пригодной для `import`. |
| `variable:import(data: string)` | Восстанавливает значение из строки, полученной от `export`. |
| `variable:group() -> group\|nil` | Вложенная группа настроек элемента (значок шестерёнки) — в неё добавляются свои элементы. |
| `variable:add_callback(fn: function, run_now?: boolean) -> variable` | Подписывает функцию на изменение значения или нажатие. `run_now = true` вызывает её сразу. |
| `variable:remove_callback(fn: function) -> variable` | Снимает подписку функции. |
| `variable:get(...) -> any` | Значение с учётом привязок клавиш. |
| `variable:get_value(...) -> any` | Значение элемента. |
| `variable:set_value(value, ...)` | Задаёт значение. |
| `variable:get_raw_value(...) -> any` | Значение, переопределённое скриптом. |
| `variable:set_raw_value(value, ...)` | Переопределяет значение; без аргумента или с `nil` снимает переопределение. |
| `variable:get_values() -> table\|nil` | Выбранные пункты `multicombo` — таблица с именами пунктов в ключах. |
| `variable:set_values(values, ...)` | Задаёт выбранные пункты `multicombo`. |
| `variable:get_raw_values() -> table\|nil` | Выбранные пункты, переопределённые скриптом. |
| `variable:set_raw_values(values, ...)` | Переопределяет выбранные пункты. |
| `variable:get_effective_values() -> table\|nil` | Выбранные пункты с учётом привязок клавиш. |
| `variable:get_default(...) -> any` | Значение по умолчанию. |
| `variable:set_default(value, ...)` | Задаёт значение по умолчанию. |
| `variable:get_name() -> string` | Имя элемента. |
| `variable:set_name(name: string)` | Переименовывает элемент. |
| `variable:get_visible() -> boolean` | Виден ли элемент. |
| `variable:set_visible(visible: boolean)` | Показывает или скрывает элемент. |
| `variable:get_disabled() -> boolean` | Заблокирован ли элемент. |
| `variable:set_disabled(disabled: boolean)` | Блокирует или разблокирует элемент. |
| `variable:get_tooltip() -> string` | Текст подсказки. |
| `variable:set_tooltip(text: string)` | Задаёт подсказку. |
| `variable:get_icon() -> string` | Иконка элемента. |
| `variable:set_icon(icon: string)` | Задаёт иконку. |
| `variable:get_id() -> integer` | Идентификатор элемента. |
| `variable:get_type() -> string` | Тип элемента. |
| `variable:get_is_down() -> boolean` | Нажата ли сейчас клавиша (для `hotkey`). |
| `variable:get_parent() -> group\|nil` | Группа, в которой лежит элемент. |
| `variable:get_items() -> table\|nil` | Пункты `combo` или `list` — массив строк. |
| `variable:set_items(items: table)` | Заменяет пункты `combo` или `list`. |
| `variable:get_min() -> number` | Нижняя граница ползунка. |
| `variable:set_min(value: number)` | Задаёт нижнюю границу ползунка. |
| `variable:get_max() -> number` | Верхняя граница ползунка. |
| `variable:set_max(value: number)` | Задаёт верхнюю границу ползунка. |
| `variable:get_category() -> integer` | Текущая категория набора цветов. |
| `variable:set_category(category, ...)` | Переключает категорию набора цветов. |
| `variable:get_categories() -> table\|nil` | Список категорий набора цветов. |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `value` | `any` | чтение и запись | То же, что `get_value()` / `set_value(v)`. |
| `raw_value` | `any` | чтение и запись | То же, что `get_raw_value()` / `set_raw_value(v)`. |
| `default` | `any` | чтение и запись | То же, что `get_default()` / `set_default(v)`. |
| `effective_value` | `any` | чтение | То же, что `get()`. |
| `values` | `table` | чтение и запись | То же, что `get_values()` / `set_values(t)`. |
| `raw_values` | `table\|nil` | чтение и запись | То же, что `get_raw_values()` / `set_raw_values(t)`. |
| `effective_values` | `table` | чтение | То же, что `get_effective_values()`. |
| `min` | `number` | чтение и запись | То же, что `get_min()` / `set_min(n)`. |
| `max` | `number` | чтение и запись | То же, что `get_max()` / `set_max(n)`. |
| `items` | `table` | чтение и запись | То же, что `get_items()` / `set_items(t)`. |
| `parent` | `group\|nil` | чтение | То же, что `get_parent()`. |
| `category` | `integer` | чтение и запись | То же, что `get_category()` / `set_category(n)`. |
| `categories` | `table\|nil` | чтение | То же, что `get_categories()`. |
| `is_down` | `boolean` | чтение | То же, что `get_is_down()`. |
| `tooltip` | `string` | чтение и запись | То же, что `get_tooltip()` / `set_tooltip(s)`. |
| `type` | `string` | чтение | То же, что `get_type()`. |
| `id` | `integer` | чтение | То же, что `get_id()`. |
| `name` | `string` | чтение и запись | То же, что `get_name()` / `set_name(s)`. |
| `visible` | `boolean` | чтение и запись | То же, что `get_visible()` / `set_visible(b)`. |
| `disabled` | `boolean` | чтение и запись | То же, что `get_disabled()` / `set_disabled(b)`. |
| `icon` | `string` | чтение и запись | То же, что `get_icon()` / `set_icon(s)`. |

Операторы: `==`.

### `bind`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `name` | `string` | чтение | Имя привязки. |
| `mode` | `number` | чтение | Режим привязки (число). |
| `value` | `any` | чтение | Значение, которое задаёт привязка. |
| `is_active` | `boolean` | чтение | Активна ли привязка сейчас. |
| `reference` | `variable\|nil` | чтение | Элемент меню, к которому относится привязка. |
