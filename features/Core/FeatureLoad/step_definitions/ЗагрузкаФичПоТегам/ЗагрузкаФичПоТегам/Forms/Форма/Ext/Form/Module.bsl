﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

//	ДобавитьШагВМассивТестов(ВсеТесты,"ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()","ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования","я открыл форму VanessaBehavoir в режиме самотестирования"); //уже был в H:\Commons\vanessa-behavoir\features\Libraries\step_definitions\ЗагрузкаФичи.epf
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавилТегВСписокТеговИсключений(Парам01Строка)","ЯДобавилТегВСписокТеговИсключений","Я добавил тег ""@IgnoreOnCIMainBuild"" в список тегов исключений");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилФичиИзСлужебногоКаталога(Парам01Строка)","ЯЗагрузилФичиИзСлужебногоКаталога","Я загрузил фичи из служебного каталога ""Support\Templates""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВДеревеФичНетФичиЗагруженнойИзФайла(Парам01Строка)","ВДеревеФичНетФичиЗагруженнойИзФайла","в дереве фич нет фичи загруженной из файла ""ОсновнаяТестоваяФича.feature""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавилТегВСписокТеговФильтров(Парам01Строка)","ЯДобавилТегВСписокТеговФильтров","Я добавил тег ""SpecialTag"" в список тегов фильтров");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВДеревеФичЕстьФичаЗагруженнаяИзФайла(Парам01Строка)","ВДеревеФичЕстьФичаЗагруженнаяИзФайла","в дереве фич есть фича загруженная из файла ""ОсновнаяТестоваяФича""");

	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	Попытка
		Если Контекст.Свойство("ОткрытаяФормаVanessaBehavoir") Тогда
			ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
			ОткрытаяФормаVanessaBehavoir.Закрыть();
		КонецЕсли;	 
	Исключение
		
	КонецПопытки;
КонецПроцедуры


&НаКлиенте
//Я добавил тег "@IgnoreOnCIMainBuild" в список тегов исключений
//@ЯДобавилТегВСписокТеговИсключений(Парам01Строка)
Процедура ЯДобавилТегВСписокТеговИсключений(ИмяТега) Экспорт
	ФормаVB = Контекст.ОткрытаяФормаVanessaBehavoir;
	ФормаVB.Объект.СписокТеговИсключение.Добавить(ИмяТега);
КонецПроцедуры

&НаКлиенте
//Я загрузил фичи из служебного каталога "Support\Templates"
//@ЯЗагрузилФичиИзСлужебногоКаталога(Парам01Строка)
Процедура ЯЗагрузилФичиИзСлужебногоКаталога(ОтносительныйПуть) Экспорт
	Путь = Ванесса.Объект.КаталогИнструментов + СтрЗаменить("\features\" + ОтносительныйПуть, "\", "/");
	ФормаVB = Контекст.ОткрытаяФормаVanessaBehavoir;
	
	ФормаVB.Объект.КаталогФич = Путь;
	
	ФормаVB.ЗагрузитьФичи();
КонецПроцедуры

&НаКлиенте
//в дереве фич нет фичи загруженной из файла "ОсновнаяТестоваяФича.feature"
//@ВДеревеФичНетФичиЗагруженнойИзФайла(Парам01Строка)
Процедура ВДеревеФичНетФичиЗагруженнойИзФайла(ИмяФичаФайла) Экспорт
	ФормаVB = Контекст.ОткрытаяФормаVanessaBehavoir;
	ЭлементыДерева = Контекст.ОткрытаяФормаVanessaBehavoir.Объект.ДеревоТестов.ПолучитьЭлементы();

	Ванесса.ПроверитьРавенство(ЭлементыДерева[0].Имя,"Templates","В корне дерева должен быть нужный каталог.");
	
	
	ЭлементыДерева = ЭлементыДерева[0].ПолучитьЭлементы();
	
	Для каждого Строка Из ЭлементыДерева Цикл
		Если НРег(Строка.Имя) = НРег(ИмяФичаФайла) Тогда
			ВызватьИсключение "Фича " + ИмяФичаФайла + " загрузилась в дерево, хотя не должна была загрузиться.";
		КонецЕсли;  
	КонецЦикла;
	
	//Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"В дереве тестов на первом уровне должны быть строки.");
	//
	//ЭлементыДерева = ЭлементыДерева.ПолучитьЭлементы();
	//Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"В дереве тестов на втором уровне должны быть строки.");
	
КонецПроцедуры

//Я добавил тег "SpecialTag" в список тегов фильтров
//@ЯДобавилТегВСписокТеговФильтров(Парам01Строка)
&НаКлиенте
Процедура ЯДобавилТегВСписокТеговФильтров(ИмяТега) Экспорт
	ФормаVB = Контекст.ОткрытаяФормаVanessaBehavoir;
	ФормаVB.Объект.СписокТеговОтбор.Добавить(ИмяТега);
КонецПроцедуры

//в дереве фич есть фича загруженная из файла "ОсновнаяТестоваяФича"
//@ВДеревеФичЕстьФичаЗагруженнаяИзФайла(Парам01Строка)
&НаКлиенте
Процедура ВДеревеФичЕстьФичаЗагруженнаяИзФайла(ИмяФичаФайла) Экспорт
	ФормаVB = Контекст.ОткрытаяФормаVanessaBehavoir;
	ЭлементыДерева = Контекст.ОткрытаяФормаVanessaBehavoir.Объект.ДеревоТестов.ПолучитьЭлементы();

	Ванесса.ПроверитьРавенство(ЭлементыДерева[0].Имя,"Templates","В корне дерева должен быть нужный каталог.");
	
	
	Нашел = Ложь;
	ЭлементыДерева = ЭлементыДерева[0].ПолучитьЭлементы();
	Для каждого Строка Из ЭлементыДерева Цикл
		Если НРег(Строка.Имя) = НРег(ИмяФичаФайла) Тогда
			Нашел = Истина;
		КонецЕсли;  
	КонецЦикла;
	
	Если Не Нашел Тогда
		ВызватьИсключение "Фича " + ИмяФичаФайла + " не загрузилась в дерево, хотя должна была загрузиться.";
	КонецЕсли;	 
КонецПроцедуры


//окончание текста модуля