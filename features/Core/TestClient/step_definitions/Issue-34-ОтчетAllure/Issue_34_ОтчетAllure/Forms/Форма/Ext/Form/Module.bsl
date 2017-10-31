﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Служебная функция.
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
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	ДобавитьШагВМассивТестов(ВсеТесты,"ВКаталогеАллюрПоявилсяХотяБыОдинСкриншот()","ВКаталогеАллюрПоявилсяХотяБыОдинСкриншот","И в каталоге аллюр появился хотя бы один скриншот");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеКаталогОтчетаАллюрЯУказываюПутьКОтносительномуКаталогу(Парам01)","ВПолеКаталогОтчетаАллюрЯУказываюПутьКОтносительномуКаталогу","И     в поле каталог отчета аллюр я указываю путь к относительному каталогу ""tools\Allure""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВКаталогеАллюрПоявилсяФайлXml(Парам01)","ВКаталогеАллюрПоявилсяФайлXml","И в каталоге аллюр появился 1 файл xml");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВКаталогеАллюрПоявилсяФайлJson(Парам01)","ВКаталогеАллюрПоявилсяФайлXml","И в каталоге аллюр появился 1 файл json");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И     в поле каталог отчета аллюр я указываю путь к относительному каталогу "tools\Allure"
//@ВПолеКаталогОтчетаАллюрЯУказываюПутьКОтносительномуКаталогу(Парам01)
Процедура ВПолеКаталогОтчетаАллюрЯУказываюПутьКОтносительномуКаталогу(ЧастьПути) Экспорт
	Каталог = Ванесса.Объект.КаталогИнструментов + "\" + ЧастьПути;
	Контекст.Вставить("КаталогAllure",Каталог);
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(Каталог) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(Каталог);
	Иначе
		Ванесса.УдалитьКаталогКомандаСистемы(Каталог);
		Ванесса.СоздатьКаталогКомандаСистемы(Каталог);
	КонецЕсли;	 
	
	Ванесса.Шаг("И В открытой форме в поле с именем ""КаталогOutputAllure"" я ввожу текст """ + Каталог + """");
КонецПроцедуры


&НаКлиенте
//И в каталоге аллюр появился хотя бы один скриншот
//@ВКаталогеАллюрПоявилсяХотяБыОдинСкриншот()
Процедура ВКаталогеАллюрПоявилсяХотяБыОдинСкриншот() Экспорт
КонецПроцедуры

//окончание текста модуля

&НаКлиенте
//И в каталоге аллюр появился 1 файл xml
//@ВКаталогеАллюрПоявилсяФайлXml(Парам01)
Процедура ВКаталогеАллюрПоявилсяФайлXml(ДолжноБытьФайлов) Экспорт
	ЛогФайл = ПолучитьИмяВременногоФайла("txt");
	Команда = "DIR " + Контекст.КаталогAllure + " > """ + ЛогФайл + """";
	
	КомандаСистемы(Команда);
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ЛогФайл,"Windows-1251");
	
	КолФайлов = 0;
	
	БылФайлAllure = Ложь;
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Если Найти(Стр,".xml") > 0 Тогда
			БылФайлAllure = Истина;
			КолФайлов = КолФайлов + 1;
		КонецЕсли;	 
	КонецЦикла;	
	
	Текст.Закрыть();
	
	Если Не БылФайлAllure Тогда
		ВызватьИсключение "В каталоге " + Контекст.КаталогAllure + " не найдено ни одного файла xml!";
	КонецЕсли;	
	
	Если КолФайлов <> ДолжноБытьФайлов Тогда
		ВызватьИсключение "Найдено " + КолФайлов + ", а должно быть " + ДолжноБытьФайлов + " файлов";
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//И в каталоге аллюр появился 1 файл xml
//@ВКаталогеАллюрПоявилсяФайлXml(Парам01)
Процедура ВКаталогеАллюрПоявилсяФайлJson(ДолжноБытьФайлов) Экспорт
	ЛогФайл = ПолучитьИмяВременногоФайла("txt");
	Команда = "DIR " + Контекст.КаталогAllure + " > """ + ЛогФайл + """";
	
	КомандаСистемы(Команда);
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ЛогФайл,"Windows-1251");
	
	КолФайлов = 0;
	
	БылФайлAllure = Ложь;
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Если Найти(Стр,".json") > 0 Тогда
			БылФайлAllure = Истина;
			КолФайлов = КолФайлов + 1;
		КонецЕсли;	 
	КонецЦикла;	
	
	Текст.Закрыть();
	
	Если Не БылФайлAllure Тогда
		ВызватьИсключение "В каталоге " + Контекст.КаталогAllure + " не найдено ни одного файла json!";
	КонецЕсли;	
	
	Если КолФайлов <> ДолжноБытьФайлов Тогда
		ВызватьИсключение "Найдено " + КолФайлов + ", а должно быть " + ДолжноБытьФайлов + " файлов";
	КонецЕсли;	 
КонецПроцедуры
