# language: ru


@tree
@IgnoreOnCIMainBuild


Функционал: 	 Тестовая фича, проверяющая генерацию видео
Как 	 Разработчик
Я 	 хочу 	 проверить работу генерации видео файла
Чтобы 	 я 		 	мог использовать видео автодокументирование
 
Контекст: 
	Дано я выполняю простой шаг контекста

Сценарий: Выполнение первого 	  простого сценария
	Это верхний уровень дерева
		Это второй уровень дерева
			Когда я выполняю простой шаг
		И обратите внимание "Текст обратите 		 внимание Начало"
		
		#[autodoc.text] В интерфейсе я выбираю \[ %1 \] [ТекущаяДата()] текст1 ["" + 1 + 2] текст2
		И обратите внимание "Текст обратите внимание Окончание"
	
	

