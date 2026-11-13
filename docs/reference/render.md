# Отрисовка — `render`, `font`, `image`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

Рисовать можно только внутри события `render`. Позиции и размеры — `vector2`, цвета — `color`.

```lua
local font = render.load_font("verdana.ttf", 14)
local white = color(255, 255, 255, 255)

events.render:set(function()
    local screen = render.screen_size()
    render.rect(vector2(20, 80), vector2(190, 35), color(15, 18, 25, 210), 6)   -- залитый
    render.rect_outline(vector2(20, 80), vector2(190, 35), white, 1, 6)         -- контур
    render.line(vector2(0, 0), vector2(screen.x, screen.y), white, 1)
    render.circle(vector2(300, 300), color(255, 0, 0, 255), 20)
    render.text(font, vector2(30, 90), white, "", "hp: ", 100)                  -- части склеиваются
    local size = render.measure_text(font, "", "hp: 100")

    local me = entity.local_pawn()
    local on_screen = me and render.world_to_screen(me:origin())
    if on_screen then render.circle(on_screen, white, 4) end
end)
```

- У `render.text` четвёртый аргумент — флаги (`""`, `"c"` — по центру, `"r"` — по правому краю), текст
  начинается с пятого аргумента.
- Шрифт задаётся именем файла из `scripts\fonts` или `Windows\Fonts`. Он подгружается к следующему
  кадру; до этого текст рисуется шрифтом по умолчанию.
- Изображения из файлов берутся из папки `scripts\images`.

## Справочник

### `render`

| Обращение | Описание |
|---|---|
| `render.camera_angles() -> angle` | Текущие углы камеры. |
| `render.world_to_screen(pos: vector) -> vector2 \| nil` | Проекция точки мира на экран; `nil`, если точка не видна. |
| `render.load_image_from_file(path: string, size: vector2) -> image` | Загружает изображение из файла в папке `scripts\images`. |
| `render.screen_size() -> vector2` | Размер экрана. |
| `render.line(from: vector2, to: vector2, color: color [, thickness: number])` | Линия между двумя точками. |
| `render.bezier(p1: vector2, p2: vector2, p3: vector2, p4: vector2, color: color, thickness: number [, segments: integer])` | Кубическая кривая Безье по четырём точкам. |
| `render.rect(pos: vector2, size: vector2, color: color [, rounding: number])` | Залитый прямоугольник. `rounding` — радиус скругления углов. |
| `render.rect_outline(pos: vector2, size: vector2, color: color [, thickness: number [, rounding: number]])` | Контур прямоугольника. |
| `render.rect_shadow(pos: vector2, size: vector2, color: color [, rounding: number [, thickness: number [, offset: vector2]]])` | Тень прямоугольника. |
| `render.rect_gradient(pos: vector2, size: vector2, c1: color, c2: color, c3: color, c4: color)` | Прямоугольник с четырьмя цветами по углам. |
| `render.circle(center: vector2, color: color, radius: number [, start_deg: number [, fraction: number]])` | Залитый круг. С `start_deg` и `fraction` — сектор: начало в градусах и доля окружности. |
| `render.circle_outline(center: vector2, color: color, radius: number [, start_deg: number [, fraction: number [, thickness: number]]])` | Окружность или дуга. |
| `render.circle_gradient(center: vector2, c_inner: color, c_outer: color, radius: number)` | Круг с градиентом от центра к краю. |
| `render.triangle(p1: vector2, p2: vector2, p3: vector2, color: color)` | Залитый треугольник. |
| `render.triangle_outline(p1: vector2, p2: vector2, p3: vector2, color: color [, thickness: number])` | Контур треугольника. |
| `render.poly(points: table, color: color)` | Залитый выпуклый многоугольник; `points` — массив `vector2`. |
| `render.polyline(points: table, color: color, closed: boolean, thickness: number)` | Ломаная по точкам; `closed` замыкает контур. |
| `render.image(img: image, pos: vector2 [, size: vector2 [, color: color]])` | Рисует изображение. Без `size` — в натуральном размере; `color` — оттенок. |
| `render.load_image(data: string, size: vector2) -> image` | Создаёт изображение из SVG-данных в строке. |
| `render.load_image_rgba(data: string, size: vector2) -> image` | Создаёт изображение из сырых пикселей RGBA (4 байта на пиксель). |
| `render.push_clip_rect(pos: vector2, size: vector2 [, intersect: boolean])` | Ограничивает отрисовку прямоугольником до парного `pop_clip_rect`. |
| `render.pop_clip_rect()` | Снимает последнее ограничение отрисовки. |
| `render.load_font(name: string, size: number [, effect: string]) -> font` | Загружает шрифт из файла (`scripts\fonts` или `Windows\Fonts`). `effect`: `"dropshadow"` или `"outline"`. |
| `render.text(font: font, pos: vector2, color: color [, flags: string], ...)` | Рисует текст. `flags`: `"c"` — по центру, `"r"` — по правому краю. Все аргументы после флагов склеиваются в одну строку. |
| `render.measure_text(font: font [, flags: string], ...) -> vector2` | Размер текста в пикселях. |

### `font`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `size` | `number` | чтение и запись | Размер шрифта. |

### `image`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `size` | `vector2` | чтение | Размер изображения в пикселях (`vector2`). |
