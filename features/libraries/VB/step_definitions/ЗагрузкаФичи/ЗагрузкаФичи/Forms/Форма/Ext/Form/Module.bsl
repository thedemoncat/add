﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;


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

	ДобавитьШагВМассивТестов(ВсеТесты,"ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()","ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования","я открыл форму VanessaBehavoir в режиме самотестирования");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)","ЯЗагрузилСпециальнуюТестовуюФичу","Я загрузил специальную тестовую фичу ""ОсновнаяТестоваяФича""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ДеревоТестовЗаполнилосьСтрокамиИзФичи()","ДеревоТестовЗаполнилосьСтрокамиИзФичи","ДеревоТестов заполнилось строками из фичи");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеСИменемЯУказываюПутьККаталогуФич(Парам01,Парам02)","ВПолеСИменемЯУказываюПутьККаталогуФич","И В поле с именем ""КаталогФичСлужебный"" я указываю путь к каталогу фич ""StepsRunner""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaBehavoir()","ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaBehavoir","И я скопировал каталоги библиотек во второй экземпляр VanessaBehavoir");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВТестируемомЭкземпляреЯНажалНаКнопку(Парам01)","ВТестируемомЭкземпляреЯНажалНаКнопку","И в тестируемом экземпляре я нажал на кнопку ""ВыполнитьОдинШаг""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗакрываюТестируемыйЭкземплярVanessaBehavoir()","ЯЗакрываюТестируемыйЭкземплярVanessaBehavoir","И я закрываю тестируемый экземпляр VanessaBehavoir");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную(Парам01,Парам02)","ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную","И я запоминаю порт подключения сеанса ""Кладовщик"" из тестируемого экземпляра в переменную ""ПортПодключения""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения(Парам01)","ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения","И я добавил в таблицу TestClient запись с теми же данными подключения ""ДанныеПодключения""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную(Парам01)","ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную","Дано Я запоминаю количество открытых сеансов 1С в переменную ""КоличествоНачальное2""");
	
	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	//безусловное закрытие формы если она осталась
	Попытка
	    ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
		ОткрытаяФормаVanessaBehavoir.Закрыть();
	Исключение
		
	КонецПопытки;
КонецПроцедуры


&НаКлиенте
//я открыл форму VanessaBehavoir в режиме самотестирования
//@ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()
Процедура ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования() Экспорт
	ПутьКОбработке = Ванесса.Объект.КаталогИнструментов + "/bddRunner.epf";
	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		Файл = Новый Файл(ПутьКОбработке);
		Ванесса.ПроверитьРавенство(Файл.Существует(),Истина,"Существует файл bddRunner.epf");
	КонецЕсли;	 
	
	
	ИмяОбработки = Ванесса.ПодключитьВнешнююОбработкуКлиент(ПутьКОбработке);
	ФормаОбработки = ПолучитьФорму("ВнешняяОбработка." + ИмяОбработки + ".Форма.УправляемаяФорма",,,Истина);
	Ванесса.ПроверитьНеРавенство(ФормаОбработки.Открыта(),Истина,"Форма обработки должна быть закрыта.");
	
	ФормаОбработки.Объект.РежимСамотестирования = Истина;
	ФормаОбработки.Объект.DebugLog = Истина; //режим самотестирования удобен при полном консольном выводе в режиме отладки
	ФормаОбработки.ХостСистема = Ванесса;
	ФормаОбработки.Объект.ВерсияПлатформыДляГенерацииEPF = Ванесса.Объект.ВерсияПлатформыДляГенерацииEPF;
	ФормаОбработки.Объект.КаталогИнструментов = Ванесса.Объект.КаталогИнструментов;
	ФормаОбработки.Открыть();
	
	Ванесса.ПроверитьРавенство(ФормаОбработки.Открыта(),Истина,"Форма обработки должна открыться.");
	
	Контекст.Вставить("ОткрытаяФормаVanessaBehavoir",ФормаОбработки);
	
КонецПроцедуры


&НаКлиенте
Процедура СделатьЗагрзукуФичВОткрытойФорме()
	ОткрытаяФормаVanessaBehavoir                   = Контекст.ОткрытаяФормаVanessaBehavoir;
	ОткрытаяФормаVanessaBehavoir.Объект.КаталогФич = Контекст.ПутьКФиче;
	ОткрытаяФормаVanessaBehavoir.ЗагрузитьФичи();
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикНачатьПроверкуСуществования(Существует,ДополнительныеПараметры) Экспорт
	Если НЕ Существует Тогда
		ВызватьИсключение "Файл " + Контекст.ПутьКФиче + " не существует!";
	КонецЕсли;	 
	СделатьЗагрзукуФичВОткрытойФорме();
	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры


&НаКлиенте
//Я загрузил специальную тестовую фичу "ОсновнаяТестоваяФича"
//@ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)
Процедура ЯЗагрузилСпециальнуюТестовуюФичу(ИмяФичи) Экспорт
	Контекст.Вставить("ИмяТестовойФичи",ИмяФичи);
	
	ОткрытаяФормаVanessaBehavoir            = Контекст.ОткрытаяФормаVanessaBehavoir;
	ПутьКФиче = ОткрытаяФормаVanessaBehavoir.Объект.КаталогИнструментов + "/features/Support/Templates/" + ИмяФичи + ".feature";
	Контекст.Вставить("ПутьКФиче",ПутьКФиче);
	
	
	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		ФайлПроверкаСуществования = Новый Файл(ПутьКФиче);
		Если НЕ ФайлПроверкаСуществования.Существует() Тогда
			ВызватьИсключение "Файл " + ПутьКФиче + " не существует!";
		КонецЕсли;	 
		СделатьЗагрзукуФичВОткрытойФорме();
	Иначе
		Ванесса.ЗапретитьВыполнениеШагов();
		Файл = Новый Файл(ПутьКФиче);
		ДополнительныеПараметры = Неопределено;
		ОписаниеОповещения = Вычислить("Новый ОписаниеОповещения(""ОбработчикНачатьПроверкуСуществования"",ЭтаФорма,ДополнительныеПараметры)");
		Выполнить("Файл.НачатьПроверкуСуществования(ОписаниеОповещения)");
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//ДеревоТестов заполнилось строками из фичи
//@ДеревоТестовЗаполнилосьСтрокамиИзФичи()
Процедура ДеревоТестовЗаполнилосьСтрокамиИзФичи() Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	
	ЭлементыДерева = ОткрытаяФормаVanessaBehavoir.Объект.ДеревоТестов.ПолучитьЭлементы();
	
	Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"В дереве тестов на первом уровне должны быть строки.");
	
	ЭлементыДерева = ЭлементыДерева[0].ПолучитьЭлементы();
	Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"В дереве тестов на втором уровне должны быть строки.");
КонецПроцедуры

&НаКлиенте
//И В поле с именем "КаталогФичСлужебный" я указываю путь к каталогу фич "StepsRunner"
//@ВПолеСИменемЯУказываюПутьККаталогуФич(Парам01,Парам02)
Процедура ВПолеСИменемЯУказываюПутьККаталогуФич(ИмяПоля,ИмяФичи) Экспорт
	//Ванесса.ПосмотретьЗначение(КонтекстСохраняемый,Истина);
	ПутьКФичам = Ванесса.Объект.КаталогИнструментов + "/features/" + ИмяФичи;
	Ванесса.Шаг("И В открытой форме в поле с именем """ + ИмяПоля + """ я ввожу текст """ + ПутьКФичам + """");
КонецПроцедуры

&НаКлиенте
//И я скопировал каталоги библиотек во второй экземпляр VanessaBehavoir
//@ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaBehavoir(Парам01,Парам02)
Процедура ЯСкопировалКаталогиБиблиотекВоВторойЭкземплярVanessaBehavoir() Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	ОткрытаяФормаVanessaBehavoir.Объект.КаталогиБиблиотек.Очистить();
	Для Каждого ЭлемКаталогиБиблиотек Из Ванесса.Объект.КаталогиБиблиотек Цикл
		ОткрытаяФормаVanessaBehavoir.Объект.КаталогиБиблиотек.Добавить(ЭлемКаталогиБиблиотек.Значение);
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
//И в тестируемом экземпляре я нажал на кнопку "ВыполнитьСценарии"
//@ВТестируемомЭкземпляреЯНажалНаКнопку(Парам01)
Процедура ВТестируемомЭкземпляреЯНажалНаКнопку(ИмяПроцедуры) Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	Выполнить("ОткрытаяФормаVanessaBehavoir." + ИмяПроцедуры +"();");
КонецПроцедуры

&НаКлиенте
//И я закрываю тестируемый экземпляр VanessaBehavoir
//@ЯЗакрываюТестируемыйЭкземплярVanessaBehavoir()
Процедура ЯЗакрываюТестируемыйЭкземплярVanessaBehavoir() Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	ОткрытаяФормаVanessaBehavoir.Закрыть();
КонецПроцедуры

&НаКлиенте
//И я запоминаю данные подключения сеанса "Кладовщик" из тестируемого экземпляра в переменную "ПортПодключения"
//@ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную()
Процедура ЯЗапоминаюДанныеПодключенияСеансаИзТестируемогоЭкземпляраВПеременную(ИмяПрофиля,ИмяПеременной) Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	Нашли = Ложь;
	Для Каждого ЭлемДанныеКлиентовТестирования Из ОткрытаяФормаVanessaBehavoir.ДанныеКлиентовТестирования Цикл
		Если ЭлемДанныеКлиентовТестирования.Имя = ИмяПрофиля Тогда
			Нашли = Истина;
			ДанныеПодключения = Новый Структура;
			ДанныеПодключения.Вставить("ПортЗапускаТестКлиента",ЭлемДанныеКлиентовТестирования.ПортЗапускаТестКлиента);
			ДанныеПодключения.Вставить("ПутьКИнфобазе",ЭлемДанныеКлиентовТестирования.ПутьКИнфобазе);
			ДанныеПодключения.Вставить("ТипКлиента",ЭлемДанныеКлиентовТестирования.ТипКлиента);
			ДанныеПодключения.Вставить("Имя",ЭлемДанныеКлиентовТестирования.Имя);
			Контекст.Вставить(ИмяПеременной,ДанныеПодключения);
		КонецЕсли;	 
	КонецЦикла;	
	
	Если Не Нашли Тогда
		ВызватьИсключение "Не нашли профиль <" + ИмяПрофиля + "> в тестируемом экземпляре Vanessa-behavior.";
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//И я добавил в таблицу TestClient запись с теми же данными подключения "ДанныеПодключения"
//@ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения(Парам01)
Процедура ЯДобавилВТаблицуTestClientЗаписьСТемиЖеДаннымиПодключения(ИмяПеременной) Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	
	СтрокаДанныеКлиентовТестирования                        = ОткрытаяФормаVanessaBehavoir.ДанныеКлиентовТестирования.Добавить();	
	СтрокаДанныеКлиентовТестирования.ПортЗапускаТестКлиента = Контекст[ИмяПеременной].ПортЗапускаТестКлиента;
	СтрокаДанныеКлиентовТестирования.ПутьКИнфобазе          = Контекст[ИмяПеременной].ПутьКИнфобазе;
	СтрокаДанныеКлиентовТестирования.ТипКлиента             = Контекст[ИмяПеременной].ТипКлиента;
	СтрокаДанныеКлиентовТестирования.Имя                    = Контекст[ИмяПеременной].Имя;
КонецПроцедуры

&НаКлиенте
//Дано Я запоминаю количество открытых сеансов 1С в переменную "КоличествоНачальное"
//@ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную(Парам01)
Процедура ЯЗапоминаюКоличествоОткрытыхСеансов1СВПеременную(ИмяПеременной) Экспорт
	МассивPIDОкон1С = Ванесса.ПолучитьМассивPIDОкон1С();
	Контекст.Вставить(ИмяПеременной,МассивPIDОкон1С.Количество());
КонецПроцедуры

//окончание текста модуля