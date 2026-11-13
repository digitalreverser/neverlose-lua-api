# Типы — `vector`, `angle`, `vector2`, `color`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

```lua
local a = vector(1, 2, 3)
local b = a + vector(0, 0, 10)          -- операторы + - * / и унарный минус
local dist = a:dist(b)
local dir = angle(0, 90, 0):forward()   -- направление из углов
local p = vector2(100, 50)
local red = color(255, 0, 0, 255)       -- альфу указывать всегда
```

- `color(255, 0, 0)` даёт альфу **0**: пропущенные каналы равны нулю, а не 255.
- Длина вектора — `v:length()`; оператор `#` для этих типов не используется.
- Операторы `+ - * /` принимают второй операнд того же типа или число.
- Глобальные `Vector`, `QAngle`, `Vector2D`, `Color` — таблицы методов этих типов.

## Справочник

### `vector`

| Обращение | Описание |
|---|---|
| `new(...): vector` | Создаёт вектор; пропущенные компоненты равны 0. `vector(v)` — копия. |
| `strval(vec: vector)` | string.format('%f, %f, %f', x, y, z). |
| `angles(fwd: vector[, pseudo_up: vector]): angle` | Вектор направления -> QAngle (градусы). Без pseudo_up: если x==0 и y==0 — QAngle(z>0 ? -90 : 90, 0, 0), иначе QAngle(deg(atan2(-z, length2d)), deg(atan2(y, x)), 0). С pseudo_up: left = normalize(cross(pseudo_up, fwd)); если length2d(fwd) > 0.001 — QAngle(deg(atan2(-z, len2d)), deg(atan2(y, x)), deg(atan2(left.z, left.y*fwd.x - left.x*fwd.y))), иначе QAngle(deg(atan2(-z, len2d)), deg(atan2(-left.x, left.y)), 0) (схема VectorAngles Source). |
| `copy(src: vector, dst: vector)` | dst.x, dst.y, dst.z = src.x, src.y, src.z (на месте, ничего не возвращает). |
| `cross(a: vector, b: vector): vector` | Векторное произведение: Vector(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x). |
| `dist(a: vector, b: vector): number` | length(a - b). |
| `dist2d(a: vector, b: vector): number` | length2d(a - b) = sqrt(dx*dx + dy*dy). |
| `dist2dsqr(a: vector, b: vector): number` | length2dsqr(a - b) = dx*dx + dy*dy. |
| `distsqr(a: vector, b: vector): number` | lengthsqr(a - b). |
| `dot(a: vector, b: vector): number` | a.x*b.x + a.y*b.y + a.z*b.z. |
| `init(vec: vector, ...)` | Перезаписывает vec значениями Vector(...) (copy(new(...), vec)): init(v) обнуляет, init(v, x, y, z) задаёт, init(v, other) копирует. |
| `length(vec: vector): number` | sqrt(x*x + y*y + z*z). |
| `length2d(vec: vector): number` | sqrt(x*x + y*y). |
| `length2dsqr(vec: vector): number` | x*x + y*y. |
| `lengthsqr(vec: vector): number` | x*x + y*y + z*z. |
| `lerp(a: vector, b: vector, t: number): vector` | Новый Vector: покомпонентно a + (b - a)*t (t не ограничивается). |
| `negate(vec: vector)` | На месте: x, y, z = -x, -y, -z. |
| `normalize(vec: vector): number` | На месте: len = length(vec); если len == 0 — vec обнуляется (init) и возвращается 0, иначе vec *= 1/len и возвращается len. |
| `normalize_safe(vec: vector, fallback: vector): number` | len = vec:normalize(); если len == 0 — vec := fallback (init(vec, fallback)); возвращает len. |
| `normalized(vec: vector): vector` | Копия vec, нормализованная (normalize); нулевой вектор даёт (0,0,0). |
| `normalized_safe(vec: vector, fallback: vector): vector` | c = нормализованная копия vec; если её длина была 0 — возвращает сам объект fallback (не копию), иначе c. |
| `scale(vec: vector, scalar: number)` | На месте: x, y, z *= scalar. |
| `scaled(vec: vector, scalar: number): vector` | Копия vec, умноженная на scalar. |
| `to(a: vector, b: vector): vector` | Единичное направление от a к b: normalized(b - a). |
| `unpack(vec: vector): number, number, number` | Возвращает x, y, z. |
| `vectors(fwd: vector): vector, vector` | Два перпендикуляра к нормализованному fwd: если f.x==0 и f.y==0 — (Vector(0,1,0), Vector(-f.z,0,0)); иначе l = normalize(cross((0,0,1), f)), u = normalize(cross(f, l)); возвращает l, u. Для fwd=(1,0,0) даёт (0,1,0) и (0,0,1), т.е. «влево» (= −right Source) и «вверх». |
| `ray_dist(vec: vector, start: vector, dir: vector): number` | \|dir × (vec − start)\| = length(cross(dir, vec - start)); расстояние от точки до прямой, если dir единичный (dir не нормализуется). |
| `to_2d_direction(vec: vector): number` | deg(atan2(y, x)) — yaw направления в градусах. |
| `closest_line_point(vec: vector, a: vector, b: vector): vector` | t, d = inverse_lerp(vec, a, b); t = clamp(t, 0, 1); d *= t (на месте); возвращает a + d — ближайшая к vec точка отрезка a..b. |
| `inverse_lerp(vec: vector, a: vector, b: vector): number, vector` | d = b - a; dd = dot(d, d); если dd < 1e-5 — возвращает 0, d; иначе (dot(d, vec) - dot(d, a)) / dd, d. |
| `typesafe(typesafe: boolean)` | Включает/выключает проверку типов аргументов по сигнатурам для всех методов Vector (по умолчанию false). |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `x` | `number` | чтение и запись | Компонента X. |
| `y` | `number` | чтение и запись | Компонента Y. |
| `z` | `number` | чтение и запись | Компонента Z. |

Операторы: `+`, `-`, `*`, `/`, `унарный -`, `==`, `#`.

### `angle`

| Обращение | Описание |
|---|---|
| `new(...): angle` | Создаёт углы (pitch, yaw, roll); пропущенные компоненты равны 0. `angle(a)` — копия. |
| `copy(src: angle, dst: angle)` | dst.x, dst.y, dst.z = src.x, src.y, src.z (на месте). |
| `pitch(ang: angle): number` | Возвращает ang.x. |
| `yaw(ang: angle): number` | Возвращает ang.y. |
| `roll(ang: angle): number` | Возвращает ang.z. |
| `init(ang: angle, ...)` | Перезаписывает ang значениями QAngle(...) (copy(new(...), ang)). |
| `strval(ang: angle): string` | string.format('%f, %f, %f', x, y, z). |
| `normalize(ang: angle\|number): angle\|number` | Число: x - floor(x/360 + 0.5)*360 (приведение к [-180, 180)), возвращает число. |
| `normalized(ang: angle): angle` | Копия ang, нормализованная покомпонентно к [-180, 180). |
| `unpack(ang: angle): number, number, number` | Возвращает x, y, z. |
| `forward(ang: angle): vector` | Vector(cp*cy, cp*sy, -sp), где p = rad(x), y = rad(y) (roll не используется). |
| `vectors(ang: angle): vector, vector, vector` | forward = (cp*cy, cp*sy, -sp); второй = (sr*sp*cy - cr*sy, sr*sp*sy + cr*cy, sr*cp) — это −right в терминах AngleVectors Source (т.е. «влево»); up = (cr*sp*cy + sr*sy, cr*sp*sy - sr*cy, cr*cp); s*/c* — sin/cos от rad(x), rad(y), rad(z). |
| `length(ang: angle): number` | sqrt(x*x + y*y + z*z). |
| `lengthsqr(ang: angle): number` | x*x + y*y + z*z. |
| `negate(ang: angle)` | На месте: x, y, z = -x, -y, -z. |
| `typesafe(typesafe: boolean)` | Включает/выключает проверку типов аргументов по сигнатурам для всех методов QAngle (по умолчанию false). |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `x` | `number` | чтение и запись | Pitch (наклон). |
| `y` | `number` | чтение и запись | Yaw (поворот). |
| `z` | `number` | чтение и запись | Roll (крен). |

Операторы: `==`, `+`, `-`, `*`, `/`, `унарный -`.

### `vector2`

| Обращение | Описание |
|---|---|
| `new(...): vector2` | Создаёт двумерный вектор; пропущенные компоненты равны 0. `vector2(v)` — копия. |
| `strval(vec: vector2): string` | string.format('%f, %f', x, y). |
| `unpack(vec: vector2): number, number, number` | Возвращает `x, y`. |
| `copy(src: vector2, dst: vector2)` | dst.x, dst.y = src.x, src.y (на месте). |
| `init(vec: vector2, ...)` | Перезаписывает vec значениями Vector2D(...). |
| `as_vector(vec: vector2[, z: number]): vector` | Трёхмерный вектор `(x, y, z)` из двумерного. |
| `cross(a: vector2, b: vector2): number` | Скаляр a.x*b.y - a.y*b.x (z-компонента векторного произведения). |
| `dist(a: vector2, b: vector2): number` | length(a - b). |
| `distsqr(a: vector2, b: vector2): number` | lengthsqr(a - b). |
| `dot(a: vector2, b: vector2): number` | a.x*b.x + a.y*b.y. |
| `length(vec: vector2): number` | sqrt(x*x + y*y). |
| `lengthsqr(vec: vector2): number` | x*x + y*y. |
| `lerp(a: vector2, b: vector2, t: number): vector2` | Новый Vector2D: покомпонентно a + (b - a)*t. |
| `normalize(vec: vector2): number` | На месте: len = length; если len == 0 — vec обнуляется, иначе vec *= 1/len; возвращает len. |
| `normalized(vec: vector2): vector2` | Нормализованная копия vec. |
| `scale(vec: vector2, s: number)` | На месте: x, y *= s. |
| `scaled(vec: vector2, s: number): vector2` | Копия vec, умноженная на s. |
| `to_2d_direction(vec: vector2): number` | deg(atan2(y, x)). |
| `typesafe(typesafe: boolean)` | Включает/выключает проверку типов аргументов по сигнатурам для всех методов Vector2D (по умолчанию false). |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `x` | `number` | чтение и запись | Компонента X. |
| `y` | `number` | чтение и запись | Компонента Y. |

Операторы: `+`, `-`, `*`, `/`, `унарный -`, `==`, `#`.

### `color`

| Обращение | Описание |
|---|---|
| `new(...): color` | Создаёт цвет; пропущенные каналы равны 0, поэтому альфу нужно указывать явно. |
| `strval(col: color): string` | string.format('%d, %d, %d, %d', r, g, b, a). |
| `unpack(col: color): number, number, number, number` | Возвращает r, g, b, a. |
| `lerp(a: color, b: color, t: number): color` | Новый Color: для каждого канала clamp(floor(a + (b - a)*t + 0.5), 0, 255). |
| `hex(col: color): string` | string.format('%02X%02X%02X%02X', r, g, b, a) — 'RRGGBBAA' заглавными, без '#'. |
| `typesafe(typesafe: boolean)` | Включает/выключает проверку типов аргументов по сигнатурам для всех методов Color (по умолчанию false). |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `r` | `number` | чтение и запись | Красный, 0..255. |
| `g` | `number` | чтение и запись | Зелёный, 0..255. |
| `b` | `number` | чтение и запись | Синий, 0..255. |
| `a` | `number` | чтение и запись | Альфа, 0..255. |

Операторы: `==`.
