# Image-Generator

Реализовано приложение для iPhone генерирующее картинки по запросу.

Экраны:
1. Первый экран - главная страница. На ней содержится поле ввода, в котором вводится запрос и кнопка подтверждения.
    По нажатию кнопки происходит генерация картинки после чего она выводится на эту же форму. Также есть кнопка, чтобы добавить полученную картинку в избранное.
2. Второй экран - избранное.  Экран состоит из таблицы, ограниченно кол-во картинок которое, можно хранить в избранном.
    По достижении лимита удаляется самая старая картинка из избранного, после чего добавляется новая, не выводя ошибок.

Примечание: Предполагается, что API платное, картинка в ответ на один и тот же запрос всегда одинаковая. Избранное сохраняться между сессиями.
____________________________________
Стэк: UIKit, Core Data, Верстка кодом без сторонних библиотек.

![Alt-LaunchScreen](https://github.com/skokdmitriy/Image-Generator/blob/main/Screenshots/IG1.png)
![Alt-LaunchScreen](https://github.com/skokdmitriy/Image-Generator/blob/main/Screenshots/IG2.png)
![Alt-LaunchScreen](https://github.com/skokdmitriy/Image-Generator/blob/main/Screenshots/IG3.png)