﻿@tree
@IgnoreOnCIMainBuild

Функциональность: Тест


Сценарий: Сценарий №1
	*Первая группа
		И Я запоминаю значение выражения "1" в переменную "ТестоваяПеременная"
		И Я запоминаю значение выражения "2" в переменную "ТестоваяПеременная"
		Дано Я задаю таблицу строк "Таблица"
				| 'Товар1' |
	*Вторая группа
		*Третья группа
			И Я запоминаю значение выражения "3" в переменную "ТестоваяПеременная"
			И для каждого значения "ЗначениеИзМассива" из таблицы в памяти "Таблица"
					Если 'Контекст.ТестоваяПеременная=0' Тогда
						Тогда Я вызываю исключение "Исключение!"
					Дано Я задаю таблицу строк "Таблица1"
							| 'Товар1' |
					Если 'Контекст.ТестоваяПеременная=0' Тогда
						Тогда Я вызываю исключение "Исключение!"
					И Я запоминаю значение выражения "0" в переменную "ТестоваяПеременная"	
					И Я запоминаю значение выражения "0" в переменную "ТестоваяПеременная"	
					И Я запоминаю значение выражения "0" в переменную "ТестоваяПеременная"	
		*Четвертая группа
			И Я запоминаю значение выражения "1" в переменную "ТестоваяПеременная"

