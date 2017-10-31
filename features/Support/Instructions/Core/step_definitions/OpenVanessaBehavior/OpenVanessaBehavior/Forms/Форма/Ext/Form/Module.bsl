﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебная часть
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
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;
	
	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапускаю1СВРежимеКлиентаТестирвания()","ЯЗапускаю1СВРежимеКлиентаТестирвания","Дано Я запускаю 1С в режиме клиента тестирвания");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВЗапущеномЭкземпляре1СВРежимеКлиентаТесторованияОткрываюОбработкуVanessa_behavior()","ЯВЗапущеномЭкземпляре1СВРежимеКлиентаТесторованияОткрываюОбработкуVanessa_behavior","И Я в запущеном экземпляре 1С в режиме клиента тесторования открываю обработку vanessa-behavior");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗакрываюЗапущенныйВРежимеКлиентТестированияЭкземпляр1С()","ЯЗакрываюЗапущенныйВРежимеКлиентТестированияЭкземпляр1С","Дано Я закрываю запущенный в режиме клиент тестирования экземпляр 1С");
	
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
//Дано Я запускаю 1С в режиме клиента тестирвания
//@ЯЗапускаю1СВРежимеКлиентаТестирвания()
Процедура ЯЗапускаю1СВРежимеКлиентаТестирвания() Экспорт
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");
	Если НЕ Ванесса.ОткрытьНовыйСеансTestClientИлиПодключитьУжеСуществующий("/out""" + ИмяВременногоФайла + """") Тогда
		ВызватьИсключение "Не смог подключить TestClient!";
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
//И Я в запущеном экземпляре 1С в режиме клиента тесторования открываю обработку vanessa-behavior
//@ЯВЗапущеномЭкземпляре1СВРежимеКлиентаТесторованияОткрываюОбработкуVanessa_behavior()
Процедура ЯВЗапущеномЭкземпляре1СВРежимеКлиентаТесторованияОткрываюОбработкуVanessa_behavior() Экспорт
	Команда = ПолучитьСтрокуВызоваSikuli() + Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\OpenBehavior.sikuli """ + Ванесса.Объект.КаталогИнструментов + "bddRunner.epf""";
	
	Результат = Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);
	
	Ванесса.ПроверитьРавенство(Результат, 0 , "");
КонецПроцедуры

&НаКлиенте
//Дано Я закрываю запущенный в режиме клиент тестирования экземпляр 1С
//@ЯЗакрываюЗапущенныйВРежимеКлиентТестированияЭкземпляр1С()
Процедура ЯЗакрываюЗапущенныйВРежимеКлиентТестированияЭкземпляр1С() Экспорт
	Команда = ПолучитьСтрокуВызоваSikuli() + Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\Exit1C.sikuli";
	
	Результат = Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);
	
	Ванесса.ПроверитьРавенство(Результат, 0 , "");
КонецПроцедуры

&НаКлиенте
Функция ПолучитьСтрокуВызоваSikuli()
	Возврат """C:\Program Files (x86)\Java\jre6\bin\java.exe"" -Xms64M -Xmx512M -Dfile.encoding=UTF-8 -Dpython.path=""C:\Program Files (x86)\Sikuli Xi\sikuli-script.jar/"" -jar ""C:\Program Files (x86)\Sikuli X\sikuli-ide.jar"" -r ";
КонецФункции	

//окончание текста модуля