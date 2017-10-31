﻿#Использовать logos
#Использовать json
#Использовать 1commands

Перем Лог;
Перем ЭтоWindows;
Перем СтатусЗапускаВсехСборок;

Функция УбратьСлешСправа(Стр)
	Если Прав(Стр,1) = "\" Тогда
		Возврат Лев(Стр,СтрДлина(Стр)-1);
	КонецЕсли;
	Если Прав(Стр,1) = "/" Тогда
		Возврат Лев(Стр,СтрДлина(Стр)-1);
	КонецЕсли;

	Возврат Стр;
КонецФункции



Функция ПрочитатьФайлВСтроку(ИмяФайла)
	ФайлПроверкаСуществования = Новый Файл(ИмяФайла);
	Если НЕ ФайлПроверкаСуществования.Существует() Тогда
		ВызватьИсключение("Файл " + ИмяФайла + " не существует!");
	КонецЕсли;


	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайла,"UTF-8");
	Рез = "";

	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;

		Рез = Рез + Стр + Символы.ПС;
	КонецЦикла;

	Текст.Закрыть();

	Возврат  Рез;
КонецФункции

Функция ПреобразоватьПутьСТочкамиКНормальномуПути(ОригСтр)
	ИмяВременногоФайлаКоманда = ПолучитьИмяВременногоФайла("cmd");
	ИмяВременногоФайлаЛог     = ПолучитьИмяВременногоФайла("txt");

	//ИмяВременногоФайлаКоманда = "h:\commons\temp\111.cmd";
	//ИмяВременногоФайлаЛог     = "h:\commons\temp\111.txt";


	Команда = "@echo on
				|for %%f in ( """ + ОригСтр + """ ) do set fullname=%%~ff
				|echo %fullname% > " + ИмяВременногоФайлаЛог;


	//Сообщить(""+ Команда);

	ЗТ = Новый ЗаписьТекста(ИмяВременногоФайлаКоманда,"UTF-8",,Ложь);
	ЗТ.ЗаписатьСтроку(Команда);

	ЗТ.Закрыть();




	retCode = -1;
	ЗапуститьПриложение(ИмяВременногоФайлаКоманда,,Истина,retCode);


	Рез = ОригСтр;

	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяВременногоФайлаЛог,"UTF-8");

	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;

		Если СокрЛП(Стр) = "" Тогда
			Продолжить;
		КонецЕсли;


		Рез = Стр;

	КонецЦикла;

	Текст.Закрыть();

	Возврат Рез;

КонецФункции

Процедура ПреобразоватьПараметрыКоторыеНачинаютсяСТочкиКНормальнымПутям(ПараметрыСборки)
	МассивКлючей = Новый Массив;

	Для каждого ПараметрСборки Из ПараметрыСборки Цикл
		Если Лев(ПараметрСборки.Значение,1) = "." Тогда
			МассивКлючей.Добавить(ПараметрСборки.Ключ);
		КонецЕсли;
	КонецЦикла;

	Для каждого Ключ Из МассивКлючей Цикл
		Было  = ПараметрыСборки[Ключ];
		Стало = ПреобразоватьПутьСТочкамиКНормальномуПути(ПараметрыСборки[Ключ]);
		//Сообщить("Было=" + Было + ", Стало="+Стало);

		ПараметрыСборки.Вставить(Ключ,Стало);
	КонецЦикла;
КонецПроцедуры

Функция ПрочитатьФайлJSON(ИмяФайла)
	JsonСтрока  = ПрочитатьФайлВСтроку(ИмяФайла);
	ПарсерJSON  = Новый ПарсерJSON();
	Рез         = ПарсерJSON.ПрочитатьJSON(JsonСтрока);
	//ПреобразоватьПараметрыКоторыеНачинаютсяСТочкиКНормальнымПутям(Рез);
	Рез.Вставить("ИмяФайлаСборки",ИмяФайла);
	Возврат Рез;
КонецФункции

Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено) Экспорт

	Результат = Новый Массив;

	// для обеспечения обратной совместимости
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	//

	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;

	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Результат.Добавить(Строка);
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция ДобавитьНулейДоНужнойДлинны(Знач Стр,Кол)
	Пока СтрДлина(Стр) < Кол Цикл
		Стр = "0" + Стр;
	КонецЦикла;

	Возврат Стр;
КонецФункции

Функция СоздатьСтрокуДляСортировкиВерсии(Стр)
	Рез = "";

	Массив = РазложитьСтрокуВМассивПодстрок(Стр,".");
	Для каждого Элем Из Массив Цикл
		Рез = Рез + ДобавитьНулейДоНужнойДлинны(Элем,7);
	КонецЦикла;

	Возврат Рез;
КонецФункции



Функция НайтиСамуюПозднююВерсиюПлатформыПоСтрокеПоиска(СтрокаПоискаВерсияПлатформы,КаталогПоискаВерсииПлатформы,ПараметрыСборки)

	ТаблицаВерсий = Новый ТаблицаЗначений;
	ТаблицаВерсий.Колонки.Добавить("Имя");
	ТаблицаВерсий.Колонки.Добавить("ДляСортировки");

	Файлы = НайтиФайлы(КаталогПоискаВерсииПлатформы,СтрокаПоискаВерсияПлатформы + "*",Истина);
	Для каждого Файл Из Файлы Цикл
		Если Не Файл.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		ИмяФайлаExe = Файл.ПолноеИмя + "\bin\1cv8.exe";
		ФайлExe = Новый Файл(ИмяФайлаExe);
		Если Не ФайлExe.Существует() Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрТаблицаВерсий     = ТаблицаВерсий.Добавить();
		СтрТаблицаВерсий.Имя = Файл.Имя;
		СтрТаблицаВерсий.ДляСортировки = СоздатьСтрокуДляСортировкиВерсии(СтрТаблицаВерсий.Имя);
		//Сообщить("СтрТаблицаВерсий.ДляСортировки="+СтрТаблицаВерсий.ДляСортировки);
	КонецЦикла;

	Если ТаблицаВерсий.Количество() = 0 Тогда
		Стр = "Не найдено ни одной версии по строке <" + СтрокаПоискаВерсияПлатформы + ">" + " в каталоге <" + КаталогПоискаВерсииПлатформы + ">";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;

	ТаблицаВерсий.Сортировать("ДляСортировки убыв");

	ИмяФайлаЗапуска = "1cv8c.exe";
	Если НРег(ПараметрыСборки["ЗапускатьТолстыйКлиент"]) = "истина" Тогда
		ИмяФайлаЗапуска = "1cv8.exe";
	КонецЕсли;
	Рез = УбратьСлешСправа(КаталогПоискаВерсииПлатформы) + "\" +  ТаблицаВерсий[0].Имя + "\bin\" + ИмяФайлаЗапуска;

	Возврат """" + Рез + """";
КонецФункции

Функция ПолучитьСтрокуЗапускаСборки(ПараметрыСборки)
	//Стр = "start /wait /MAX """" " + ПараметрыСборки["ПутьК1С"];
	Стр = ПараметрыСборки["ПутьК1С"];
	Стр = Стр + " " + ПараметрыСборки["СтрокаПодключенияКБазе"];

	ФайлПараметров = Новый Файл(ПараметрыСборки["ИмяФайлаСборки"]);
	Стр = Стр + " /Execute " + ПараметрыСборки["ПутьКVanessaBehavior"] + " /C""StartFeaturePlayer;VBParams=" + ФайлПараметров.ПолноеИмя +  """ /TESTMANAGER ";

	Если ПараметрыСборки["ВыводитьСообщенияВФайл"] <> Неопределено Тогда
		Стр = Стр + " /Out""" + ПараметрыСборки["ВыводитьСообщенияВФайл"] + """";
	КонецЕсли;


	Возврат Стр;
КонецФункции

Функция ПолучитьСтрокуЗапускаИнициализации(ПараметрыСборки)
	Стр = ПараметрыСборки["ПутьК1С"];
	Стр = Стр + " " + ПараметрыСборки["СтрокаПодключенияКБазе"];

	Стр = Стр + " /Execute " + ПараметрыСборки["EpfДляИнициализацияБазы"] + " /C""VBParams=" + ПараметрыСборки["ПараметрыДляИнициализацияБазы"] + """";


	Возврат Стр;
КонецФункции

Процедура ЗавершитьВсеВозможноЗависшиеПроцессы()
	

	Если ЭтоWindows Тогда
		СтрокаКоманды = "TASKKILL /F /IM 1cv8c.exe"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);

		СтрокаКоманды = "TASKKILL /F /IM 1cv8.exe"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);

		СтрокаКоманды = "TASKKILL /F /IM 1cv8s.exe"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);

		СтрокаКоманды = "TASKKILL /F /IM vlc.exe"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);

	Иначе
		СтрокаКоманды = "pkill 1cv8c"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);

		СтрокаКоманды = "pkill 1cv8"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);

		СтрокаКоманды = "pkill 1cv8s"; retCode = -1;
		ЗапуститьПриложение(СтрокаКоманды,,Истина,retCode);
	КонецЕсли;

КонецПроцедуры

Процедура ВыполнитьЗапускОднойСборки(ПараметрыСборки)

	НадоЧитатьЛог         = Ложь;
	КолСтрокЛогаПрочитано = 0;
	ИмяФайлаЛога          = Неопределено;
	Если НРег(ПараметрыСборки["ДелатьЛогВыполненияСценариевВТекстовыйФайл"]) = "истина" Тогда
		НадоЧитатьЛог = Истина;
		ИмяФайлаЛога  = ПараметрыСборки["ИмяФайлаЛогВыполненияСценариев"];
		Файл = Новый Файл(ИмяФайлаЛога);
		Если Файл.Существует() Тогда
			УдалитьФайлы(ИмяФайлаЛога);
		КонецЕсли;	 
	КонецЕсли;	 
	
	ЗавершитьВсеВозможноЗависшиеПроцессы();

	EpfДляИнициализацияБазы = ПараметрыСборки["EpfДляИнициализацияБазы"];
	Если EpfДляИнициализацияБазы <> Неопределено Тогда
		
		СтрокаЗапуска = СтрШаблон(
			"runner run --command VBParams=%1 --execute %2 --ibconnection %3 --v8version %4",
			ПараметрыСборки["ПараметрыДляИнициализацияБазы"],
			EpfДляИнициализацияБазы,
			ПараметрыСборки["СтрокаПодключенияКБазе"],
			ПараметрыСборки["ВерсияПлатформы"]);
		Лог.Информация(СтрокаЗапуска);
		ЗапуститьИПодождать(СтрокаЗапуска);

	КонецЕсли;

	ФайлПараметров = Новый Файл(ПараметрыСборки["ИмяФайлаСборки"]);

	СтрокаЗапуска = СтрШаблон(
		"runner vanessa --pathvanessa %1 --v8version %2 --ibconnection %3 --vanessasettings %4 --workspace ./build", 
		"./build/bddRunner.epf --settings ./tools/epf/init.json",
		ПараметрыСборки["ВерсияПлатформы"], 
		ПараметрыСборки["СтрокаПодключенияКБазе"],
		ФайлПараметров.ПолноеИмя);
	Если ЗначениеЗаполнено(ПараметрыСборки["ДополнительныеПараметры"]) Тогда
		СтрокаЗапуска = СтрокаЗапуска + " --additional "+ Строка(ПараметрыСборки["ДополнительныеПараметры"]);
		Если Найти(ПараметрыСборки["ДополнительныеПараметры"], "RunModeOrdinaryApplication") > 0 Тогда
			Если НЕ ЭтоWindows Тогда
				Возврат;
			КонецЕсли;
			СтрокаЗапуска = СтрокаЗапуска + " --ordinaryapp 1";
		КонецЕсли;
		
	КонецЕсли;

	Если НЕ ЭтоWindows Тогда
		СистемнаяИнформация = Новый СистемнаяИнформация;
		Если ЗначениеЗаполнено(ПолучитьПеременнуюСреды("WAYLAND_DISPLAY")) Тогда
			УстановитьПеременнуюСреды("VANESSA_commandscreenshot", 
				"dbus-send --type=method_call --print-reply --dest=org.gnome.Shell.Screenshot /org/gnome/Shell/Screenshot org.gnome.Shell.Screenshot.Screenshot boolean:true boolean:false string:");
		Иначе
			УстановитьПеременнуюСреды("VANESSA_commandscreenshot", "import -window root ");
		КонецЕсли;
	КонецЕсли;

	Лог.Информация("Строка запуска сборки: " + СтрокаЗапуска);

	Результат = ЗапуститьИПодождать(СтрокаЗапуска);
	Если СтатусЗапускаВсехСборок = 0 Тогда
		СтатусЗапускаВсехСборок = ?(Результат.КодВозврата > 0, 1, 0);
	КонецЕсли;
		
	ЗавершитьВсеВозможноЗависшиеПроцессы();
КонецПроцедуры

Процедура ВывестиНовыеСообщения(ИмяФайлаЛога,КолСтрокЛогаПрочитано)
	Попытка                     
		МассивСтрок = ПолучитьНовыеСтрокиЛога(ИмяФайлаЛога,КолСтрокЛогаПрочитано);
		Для Каждого Стр Из МассивСтрок Цикл
			Если СокрЛП(Стр) = "" Тогда
				Продолжить;
			КонецЕсли;	 
			Сообщить(СокрП(Стр));
		КонецЦикла;	
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
		
КонецПроцедуры

Функция ПолучитьНовыеСтрокиЛога(ИмяФайла,КолСтрокЛогаПрочитано)
	Файл = Новый Файл(ИмяФайла);
	Если Не Файл.Существует() Тогда
		Возврат Новый Массив;
	КонецЕсли;	
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайла,"UTF-8");
	
	ВесьТекст = Текст.Прочитать();
	
	Текст.Закрыть();
	
	Массив = Новый Массив();
	
	МассивСтрок = СтрРазделить(ВесьТекст,Символы.ПС,Истина);
	Если МассивСтрок[МассивСтрок.Количество()-1] = "" Тогда
		МассивСтрок.Удалить(МассивСтрок.Количество()-1);
	КонецЕсли;
	
	Для Ккк = (КолСтрокЛогаПрочитано+1) По МассивСтрок.Количество() Цикл
		Массив.Добавить(МассивСтрок[Ккк-1]);
	КонецЦикла;	
	
	
	КолСтрокЛогаПрочитано = МассивСтрок.Количество();
	
	Возврат Массив;
КонецФункции	

Процедура ПроверитьПараметрыСборкиНаКорректность(ПараметрыСборки,ИмяФайлаВариантСборки)
	Если Не ЗначениеЗаполнено(ПараметрыСборки["ИмяСборки"]) Тогда
		Стр = ИмяФайлаВариантСборки + ". Не указан параметр ""ИмяСборки""!";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ПараметрыСборки["ВерсияПлатформы"]) Тогда
		Стр = ИмяФайлаВариантСборки + ". Не указан параметр ""ВерсияПлатформы""!";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ПараметрыСборки["КаталогПоискаВерсииПлатформы"]) Тогда
		Стр = ИмяФайлаВариантСборки + ". Не указан параметр ""КаталогПоискаВерсииПлатформы""!";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ПараметрыСборки["КаталогФич"]) Тогда
		Стр = ИмяФайлаВариантСборки + ". Не указан параметр ""КаталогФич""!";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ПараметрыСборки["СтрокаПодключенияКБазе"]) Тогда
		Стр = ИмяФайлаВариантСборки + ". Не указан параметр ""СтрокаПодключенияКБазе""!";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ПараметрыСборки["ПутьКVanessaBehavior"]) Тогда
		Стр = ИмяФайлаВариантСборки + ". Не указан параметр ""ПутьКVanessaBehavior""!";
		Лог.Ошибка(Стр);
		ВызватьИсключение(Стр);
	КонецЕсли;
КонецПроцедуры

Процедура ОчиститьКаталоги(МассивКаталогов)
	Для каждого Каталог Из МассивКаталогов Цикл
		ФайлПроверкаСуществования = Новый Файл(Каталог);
		Если НЕ ФайлПроверкаСуществования.Существует() Тогда
			Продолжить;
		КонецЕсли;


		Файлы = НайтиФайлы(Каталог,"*");
		Для каждого Файл Из Файлы Цикл
			УдалитьФайлы(Файл.ПолноеИмя);
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

Процедура УдалитьФайлСтатусВсехСборок(ПараметрыСборки)
	ВыгружатьСтатусВыполненияСценариевВФайл = ПараметрыСборки["ВыгружатьСтатусВыполненияСценариевВФайл"];
	Если НРег(ВыгружатьСтатусВыполненияСценариевВФайл) <> "истина" Тогда
		Возврат;
	КонецЕсли;

	ИмяФайлаСтатусаСборки = ПараметрыСборки["ПутьКФайлуДляВыгрузкиСтатусаВыполненияСценариев"];
	Сообщить(ИмяФайлаСтатусаСборки);
	ФайлПроверкаСуществования = Новый Файл(ИмяФайлаСтатусаСборки);
	Если  ФайлПроверкаСуществования.Существует() Тогда
		УдалитьФайлы(ФайлПроверкаСуществования.ПолноеИмя);
	КонецЕсли;
КонецПроцедуры

Процедура ОбновитьСтатусВсехСборок(СтатусЗапускаВсехСборок,ПараметрыСборки)
	ВыгружатьСтатусВыполненияСценариевВФайл = ПараметрыСборки["ВыгружатьСтатусВыполненияСценариевВФайл"];
	Если НРег(ВыгружатьСтатусВыполненияСценариевВФайл) <> "истина" Тогда
		Возврат;
	КонецЕсли;

	ИмяФайлаСтатусаСборки = ПараметрыСборки["ПутьКФайлуДляВыгрузкиСтатусаВыполненияСценариев"];
	ФайлПроверкаСуществования = Новый Файл(ИмяФайлаСтатусаСборки);
	Если НЕ ФайлПроверкаСуществования.Существует() Тогда
		ФайлВанесса = Новый Файл(ПараметрыСборки["ПутьКVanessaBehavior"]);
		ИмяФайлаСтатусаСборки = Новый Файл(ОбъединитьПути(ФайлВанесса.Путь, ИмяФайлаСтатусаСборки)).ПолноеИмя;
		ФайлПроверкаСуществования = Новый Файл(ИмяФайлаСтатусаСборки);
		Если НЕ ФайлПроверкаСуществования.Существует() Тогда
				Лог.Информация("Ошибка в ОбновитьСтатусВсехСборок. Файл " + ИмяФайлаСтатусаСборки + " не существует!");
				СтатусЗапускаВсехСборок = 1;
				Возврат;
		КонецЕсли;
	КонецЕсли;



	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайлаСтатусаСборки,"UTF-8");

	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;

		Если Стр <> "0" Тогда
			СтатусЗапускаВсехСборок = 1; //значит были упавшие шаги
			Лог.Информация("Найден флаг неудачной сборки.");
		КонецЕсли;
	КонецЦикла;

	Текст.Закрыть();
КонецПроцедуры

Процедура ВыполнитьЗапускВсехСборок(ОсновнойФайлПараметров, ФильтрСборки = Неопределено)
	ОсновныеПараметры = ПрочитатьФайлJSON(ОсновнойФайлПараметров);

	КаталогиДляОчистки = ОсновныеПараметры["КаталогиДляОчистки"];
	Если НЕ ЗначениеЗаполнено(ФильтрСборки) Тогда
		ОчиститьКаталоги(КаталогиДляОчистки);
	КонецЕсли;

	МассивВариантыСборок = ОсновныеПараметры["ВариантыСборок"];

	Сборки = Новый Массив;

	Лог.Информация("Проверяю корректность переданных параметров...");
	Для каждого ИмяФайлаВариантСборки Из МассивВариантыСборок Цикл
		Если ЗначениеЗаполнено(ФильтрСборки) и СтрЗаменить(ИмяФайлаВариантСборки, "\", "/") <> СтрЗаменить(ФильтрСборки, "\", "/") Тогда
			Продолжить;
		КонецЕсли;
		ФайлПроверкаСуществования = Новый Файл(ИмяФайлаВариантСборки);
		Если НЕ ФайлПроверкаСуществования.Существует() Тогда
			//ВызватьИсключение("Файл " + ИмяФайлаВариантСборки + " не существует!");
		КонецЕсли;



		ПараметрыСборки = ПрочитатьФайлJSON(ИмяФайлаВариантСборки);
		ПроверитьПараметрыСборкиНаКорректность(ПараметрыСборки,ИмяФайлаВариантСборки);

		Сборки.Добавить(Новый Структура("ИмяФайлаВариантСборки,ПараметрыСборки",ИмяФайлаВариантСборки,ПараметрыСборки));
	КонецЦикла;


	Лог.Информация("-----------------------------------------");

	СтатусЗапускаВсехСборок = 0;

	Для каждого Сборка Из Сборки Цикл
		Лог.Информация("Запускаю сборку по файлу <" + Сборка.ИмяФайлаВариантСборки + ">");

		ПараметрыСборки = ПрочитатьФайлJSON(Сборка.ИмяФайлаВариантСборки);
		Лог.Информация("ИмяСборки = <" + ПараметрыСборки["ИмяСборки"] + ">");

		УдалитьФайлСтатусВсехСборок(ПараметрыСборки);

		ВыполнитьЗапускОднойСборки(ПараметрыСборки);

		//ОбновитьСтатусВсехСборок(СтатусЗапускаВсехСборок,ПараметрыСборки);

		Лог.Информация("-----------------------------------------");
	КонецЦикла;

	Если СтатусЗапускаВсехСборок <> 0 Тогда
		Лог.Информация("БЫЛИ ОШИБКИ ВО ВРЕМЯ ВЫПОЛНЕНИЯ СЦЕНАРИЕВ!");
	Иначе
		Лог.Информация("Ошибок не было!");
	КонецЕсли;

	ЗавершитьРаботу(СтатусЗапускаВсехСборок);
КонецПроцедуры

Функция ЗапуститьИПодождать(СтрокаЗапуска)
	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.УстановитьСтроку();

	Процесс = СоздатьПроцесс(СтрокаЗапуска, "./", Истина, Истина);
	Попытка
		Процесс.Запустить();
	Исключение
		Если ЭтоWindows Тогда
			ШаблонЗапуска = "cmd /c %1";
		Иначе
			ШаблонЗапуска = "sh -c '%1'";
		КонецЕсли;
		Процесс = СоздатьПроцесс(СтрШаблон(ШаблонЗапуска, СтрокаЗапуска), "./", Истина, Истина);
		Процесс.Запустить();
	КонецПопытки;
	ПериодОпросаВМиллисекундах = 1000;
	Если ПериодОпросаВМиллисекундах <> 0 Тогда
		Приостановить(ПериодОпросаВМиллисекундах);
	КонецЕсли;
	Пока НЕ Процесс.Завершен ИЛИ Процесс.ПотокВывода.ЕстьДанные ИЛИ Процесс.ПотокОшибок.ЕстьДанные Цикл
		//Сообщить(""+ ТекущаяДата() + " Завершен:"+Строка(Процесс.Завершен) + Строка(Процесс.ПотокВывода.ЕстьДанные) + Строка(Процесс.ПотокОшибок.ЕстьДанные) );
		Если ПериодОпросаВМиллисекундах <> 0 Тогда
			Приостановить(ПериодОпросаВМиллисекундах);
		КонецЕсли;

		ОчереднаяСтрокаВывода = Процесс.ПотокВывода.Прочитать();
		ОчереднаяСтрокаОшибок = Процесс.ПотокОшибок.Прочитать();

		Если Не ПустаяСтрока(ОчереднаяСтрокаВывода) Тогда
			ОчереднаяСтрокаВывода = СтрЗаменить(ОчереднаяСтрокаВывода, Символы.ВК, "");
			Если ОчереднаяСтрокаВывода <> "" Тогда
				Лог.Информация("%2%1", ОчереднаяСтрокаВывода, Символы.ПС);
				ЗаписьXML.ЗаписатьБезОбработки(ОчереднаяСтрокаВывода);
			КонецЕсли;
		КонецЕсли;

		Если Не ПустаяСтрока(ОчереднаяСтрокаОшибок) Тогда
			ОчереднаяСтрокаОшибок = СтрЗаменить(ОчереднаяСтрокаОшибок, Символы.ВК, "");
			Если ОчереднаяСтрокаОшибок <> "" Тогда
				//Сообщить(ОчереднаяСтрокаОшибок);
				Лог.Информация("%2%1", ОчереднаяСтрокаОшибок, Символы.ПС);
				ЗаписьXML.ЗаписатьБезОбработки(ОчереднаяСтрокаОшибок);
			КонецЕсли;
		КонецЕсли;

	КонецЦикла;

	ОчереднаяСтрока = СтрЗаменить(Процесс.ПотокВывода.Прочитать(), Символы.ВК, "");
	Лог.Информация("%2%1", ОчереднаяСтрока, Символы.ПС);
	ЗаписьXML.ЗаписатьБезОбработки(ОчереднаяСтрока);
	РезультатРаботыПроцесса = ЗаписьXML.Закрыть();

	Возврат Новый Структура("КодВозврата, Результат", Процесс.КодВозврата, РезультатРаботыПроцесса);

КонецФункции // ЗапуститьИПодождать(СтрокаЗапуска)


Лог = Логирование.ПолучитьЛог("behavior.run.log");

СистемнаяИнформация = Новый СистемнаяИнформация;
ЭтоWindows = Найти(ВРег(СистемнаяИнформация.ВерсияОС), "WINDOWS") > 0;

Если АргументыКоманднойСтроки.Количество() = 0 Тогда
	Лог.Ошибка("Не передан файл параметров!");
	//Возврат;
ИначеЕсли АргументыКоманднойСтроки.Количество() > 2 Тогда
	Лог.Ошибка("Скрипт принимает только два параметра!");
	//Возврат;
Иначе
	ВыполнитьЗапускВсехСборок(АргументыКоманднойСтроки[0], 
		?(АргументыКоманднойСтроки.Количество() > 1, АргументыКоманднойСтроки[1], Неопределено));
КонецЕсли;
