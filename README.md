# Tasks

## Task 1

**Условия задачи:**
На вход подается матрица A x B (1 <= A, B <= 10^3; 1 <= A * B <= 10^3). Значение каждой ячейки - целое число 0 или 1.
Найти наименьшее расстояние от каждой ячейки до ближайшей ячейки со значением 1. Расстояние между соседними ячейками равно 1.

**Пример:**
Входная матрица:
[[1,0,1],
[0,1,0],
[0,0,0]]
Выходная матрица:
[[0,1,0],
[1,0,1],
[2,1,2]]

## Task 2

Написать приложение для iPhone генерирующее картинки по запросу.

Приложение состоит из двух табов.
Первый таб - главная страница. На ней содержится поле ввода в которое пользователь будет вводить запрос и кнопка подтверждения. По нажатию кнопки происходит генерация картинки после чего она выводится на эту же форму. Так же на этой форме есть кнопка чтобы добавить полученную картинку в избранное. Предусмотреть вывод ошибок. Предполагается, что API платное, а поэтому постараться минимизировать кол-во запросов к API. Картинка в ответ на один и тот же запрос всегда одинаковая.
Второй таб - избранное. Форма состоит из таблицы в каждой строчке которой находится 1 картинка добавленная пользователем в избранное и запрос по которому картинка была сгенерирована. Тут же картинку можно удалить из избранного. Ограничить кол-во картинок которое можно хранить в избранном. По достижении лимита удаляется самая старая картинка из избранного, после чего добавляется новая не выводя ошибок пользователю. Избранное должно сохраняться между сессиями.

**Язык: Swift.**
**Минимальная версия iOS: 12.**
Интерфейс реализовать средствами UIKit.
Запрещается использование сторонних библиотек. Исключением являются библиотеки для работы с SQLite, если SQLite будет использоваться в программе (способ хранения данных выбирается на ваше усмотрение).
Выбрать какой-то класс и написать для него 1-2 unit теста на свое усмотрение.   Весь класс покрывать не нужно. Выбрать форму и написать 1 UI тест на свое усмотрение. Всю форму покрывать тестами не нужно. 

Для генерации картинок можно использовать сервис https://dummyimage.com/
Пример запроса:[https://dummyimage.com/500x500&text=some+text](https://dummyimage.com/500x500&text=some+text) где "500x500" размер картинки (выбрать какой-то размер и зафиксировать), а "text=" запрос от пользователя.
