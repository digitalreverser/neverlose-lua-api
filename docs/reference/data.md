# Данные — `json`, `msgpack`, `database`, `filesystem`, `http`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

```lua
local text = json.encode({ name = "x", list = { 1, 2, 3 } })
local value, err = json.decode(text)          -- при ошибке: nil, сообщение

local bytes = msgpack.pack({ a = 1 })
local back = msgpack.unpack(bytes)

database.settings = { volume = 0.5 }          -- постоянное хранилище скрипта
print(database.settings.volume)

local fs = require("filesystem")              -- нужен Allow Insecure
fs.write("notes.txt", "hello")
print(fs.read("notes.txt"))

local http = require("http")                  -- нужен Allow Insecure
http.get("https://example.com/api", { timeout = 5 }, function(response)
    print(response.status, response.body)
end)
```

- `database` — таблица, которая сохраняется между запусками: `database[ключ] = значение` записывает,
  `database[ключ]` читает. Ключи — строки; значения — числа, строки, булевы и таблицы из них.
- `filesystem` и `http` подключаются через `require` и работают только с Allow Insecure. Пути
  `filesystem` отсчитываются от `C:\neverwin\scripts\data`.
- В `callback` запроса приходит таблица `{ status, body }`.

## Справочник

### `json`

| Обращение | Описание |
|---|---|
| `json.encode(value) -> string` | Превращает значение в строку JSON. При ошибке возвращает `nil` и сообщение. |
| `json.decode(text: string) -> any` | Разбирает строку JSON. При ошибке возвращает `nil` и сообщение. |
| `json.encode_sparse_array([convert: boolean [, ratio: integer [, safe: integer]]]) -> boolean, integer, integer` | Настройка кодирования разреженных массивов; без аргументов возвращает текущие значения. |
| `json.encode_max_depth([depth: integer]) -> integer` | Предел вложенности при кодировании; без аргумента возвращает текущий. |
| `json.decode_max_depth([depth: integer]) -> integer` | Предел вложенности при разборе; без аргумента возвращает текущий. |
| `json.encode_number_precision([precision: integer]) -> integer` | Число значащих цифр у чисел, 1..14; без аргумента возвращает текущее. |
| `json.encode_keep_buffer([keep: boolean]) -> boolean` | Хранить ли буфер кодировщика между вызовами. |
| `json.encode_invalid_numbers([setting: boolean\|'null']) -> boolean\|string` | Как кодировать NaN и бесконечность. |
| `json.decode_invalid_numbers([setting: boolean]) -> boolean` | Принимать ли NaN и бесконечность при разборе. |
| `json.new() -> table` | Независимый экземпляр модуля со своими настройками. |
| `json.null` | Значение JSON `null`; сравнивать через `v == json.null`. |

### `msgpack`

| Обращение | Описание |
|---|---|
| `msgpack.pack(...) -> string` | Упаковывает значения в строку MessagePack. |
| `msgpack.unpack(data: string) -> ...` | Распаковывает все значения из строки. При ошибке возвращает `nil` и сообщение. |
| `msgpack.unpack_one(data: string [, offset: integer]) -> integer, any` | Распаковывает одно значение начиная с `offset`; возвращает смещение следующего и значение. |
| `msgpack.unpack_limit(data: string, limit: integer [, offset: integer]) -> integer, ...` | Распаковывает не больше `limit` значений начиная с `offset`. |

### `filesystem`

| Обращение | Описание |
|---|---|
| `filesystem.read(path: string) -> string\|nil` | Читает файл целиком; `nil`, если файла нет или путь недопустим. |
| `filesystem.write(path: string, data: string [, append: boolean]) -> boolean` | Записывает строку в файл; с `append = true` дописывает в конец. Возвращает успех. |
| `filesystem.delete(path: string)` | Удаляет файл. |
| `filesystem.list(path: string) -> table` | Имена файлов в папке — массив строк. |

### `http`

| Обращение | Описание |
|---|---|
| `http.get(url: string, options: table\|nil, callback: function)` | Асинхронный запрос GET. `options` — таблица (`headers`, `timeout`, `params`) или `nil`; ответ приходит в `callback`. |
| `http.post(url: string, options: table\|nil, callback: function)` | Асинхронный запрос POST. В `options` дополнительно `body` или `json`. |
| `http.cookies() -> cookies` | Создаёт объект cookies для передачи в options.cookie. |
