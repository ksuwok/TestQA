﻿#language: ru

@tree

Функционал: Проверки документа РаходТовара

Как тестировщик я хочу
Протестировать полный функционал документа
чтобы документ соответствовал требованиям

Сценарий: 003.1 Проверка создания документа РасходТовара

	И я закрываю все окна клиентского приложения

*Создание и заполнение документа
	И В командном интерфейсе я выбираю 'Продажи' 'Продажи'
	Тогда открылось окно 'Продажи товара'
	И я нажимаю на кнопку 'Создать'
	Когда открылось окно 'Продажа товара (создание)'
	И из выпадающего списка с именем "Организация" я выбираю точное значение 'ООО "1000 мелочей"'
	И я нажимаю кнопку выбора у поля с именем "Покупатель"
	Тогда открылось окно 'Контрагенты'
	И в таблице  "Список" я перехожу на один уровень вниз
	И в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'           |
		| '000000016' | 'Магазин "Мясная лавка"' |
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Продажа товара (создание) *'
	И из выпадающего списка с именем "Склад" я выбираю точное значение 'Большой'
	И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
	И в таблице "Товары" я нажимаю кнопку выбора у реквизита "Товар"
	Тогда открылось окно 'Товары'
	И в таблице  "Список" я перехожу на один уровень вниз
	И в таблице "Список" я перехожу к строке:
		| 'Артикул' | 'Код'       |
		| 'Kros001' | '000000024' |
	И в таблице "Список" я выбираю текущую строку

*Проверка поддтягивания цены из регистра
	Тогда таблица "Товары" стала равной:
		| 'N' | 'Товар'     | 'Цена' | 'Количество' | 'Сумма' |
		| '1' | 'Кроссовки' | '*'    | '1,00'       | '*'     |
	
*Проверка редактирования колонок и подсчета суммы
	И в таблице "Товары" я выбираю текущую строку
	И в таблице "Товары" в поле 'Цена' я ввожу текст '5 000,00'
	И в таблице "Товары" я активизирую поле "Количество"
	И в таблице "Товары" в поле 'Количество' я ввожу текст '2,00'
	Тогда таблица "Товары" стала равной:
		| 'N' | 'Товар'     | 'Цена'     | 'Количество' | 'Сумма'     |
		| '1' | 'Кроссовки' | '5 000,00' | '2,00'       | '10 000,00' |
	
*Проверка итоговых показателей
	Тогда элемент формы с именем "ТоварыИтогКоличество" стал равен '2'		
	Тогда элемент формы с именем "ТоварыИтогСумма" стал равен '10 000'			

*Сохрание документа
	Когда открылось окно 'Продажа товара (создание) *'
	И я нажимаю на кнопку 'Записать'
	@screenshot
	И я запоминаю значение поля "Номер" как "НомерДокумента"
	И Я закрываю окно 'Продажа * от *'
	
*Открытие документа и проведение
	Когда открылось окно 'Продажи товара'
	И в таблице "Список" я перехожу к строке:
		| 'Номер'            |
		| '$НомерДокумента$' |
	И в таблице "Список" я выбираю текущую строку
	Когда открылось окно 'Продажа * от *'
	И я нажимаю на кнопку 'Провести'
	@screenshot

*Проверка движений по регистрам
	Когда открылось окно 'Продажа * от *'
	И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр взаиморасчетов с контрагентами'
	Тогда таблица "Список" стала равной:
		| 'Период' | 'Регистратор' | 'Номер строки' | 'Контрагент'             | 'Сумма'     | 'Валюта' |
		| '*'      | '*'   | '1'            | 'Магазин "Мясная лавка"' | '10 000,00' | ''       |

	И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр продаж'
	Тогда таблица "Список" стала равной:
		| 'Период' | 'Регистратор' | 'Номер строки' | 'Покупатель'             | 'Сумма'     | 'Товар'     | 'Количество' |
		| '*'      | '*'           | '1'            | 'Магазин "Мясная лавка"' | '10 000,00' | 'Кроссовки' | '2,00'       |
	
	И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр товарных запасов'
	Тогда таблица "Список" стала равной:
		| 'Период' | 'Регистратор' | 'Номер строки' | 'Склад'   | 'Товар'     | 'Количество' |
		| '*'      | '*'           | '1'            | 'Большой' | 'Кроссовки' | '2,00'       |
	
*Проверка печатной формы РасходнаяТоварнаяНакладная
	Когда открылось окно 'Продажа * от *'
	И В текущем окне я нажимаю кнопку командного интерфейса 'Основное'
	И я нажимаю на кнопку 'Печать расходной накладной'
	И Табличный документ 'SpreadsheetDocument' равен макету "МакетРасходнаяНакладная" по шаблону


Сценарий: 003.2 Проверка ошибки проведения 

	И я закрываю все окна клиентского приложения
	
*Проверка ошибки проведении при отсутвии требуемоего количества на складе

	И В командном интерфейсе я выбираю 'Продажи' 'Продажи'
	Когда открылось окно 'Продажи товара'
	И в таблице "Список" я перехожу к строке:
		| 'Организация'        | 'Покупатель'                | 'Склад'               | 'Вид цен'      |
		| 'ООО "1000 мелочей"' | 'Магазин "Мясная лавка"'    | 'Большой'             | 'Мелкооптовая' |
	
	И в таблице "Список" я выбираю текущую строку	
	Тогда открылось окно 'Продажа * от *'
	И в таблице "Товары" я выбираю текущую строку
	И в таблице "Товары" я нажимаю кнопку выбора у реквизита "Товар"
	Тогда открылось окно 'Товары'
	И в таблице "Список" я перехожу к строке:
		| 'Артикул' | 'Код'       | 'Количество' | 'Наименование' |
		| 'ОБ-008'  | '000000005' | '2,00'       | 'Тапочки'      |
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Продажа * от * *'
	И в таблице "Товары" я активизирую поле "Количество"
	И в таблице "Товары" в поле 'Количество' я ввожу текст '30,00'
	И в таблице "Товары" я завершаю редактирование строки
	И я нажимаю на кнопку 'Провести'
	Тогда открылось окно '1С:Предприятие'
	@screenshot
	И я нажимаю на кнопку с именем 'OK'
		