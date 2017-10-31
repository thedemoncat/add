# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb
@IgnoreIfNotIrfanView



Функционал: Проверка формирования отчета Markdown

Как разработчик
Я хочу чтобы корректно формировался отчет Markdown
Чтобы я мог видеть результат работы сценариев


Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Проверка отчета Markdown
	Когда Я открываю VanessaBehavior в режиме TestClient
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаДляПроверкиОтчетаMarkdown"
	И     В открытой форме я перехожу к закладке с заголовком "Сервис"
	И     В открытой форме я изменяю флаг "Создавать Markdown инструкцию"
	И     В открытой форме в поле "Консольная команда создания скриншотов" я ввожу команду для IrfanView 
	И     в поле каталог отчета Markdown я указываю путь к относительному каталогу "tools\Markdown"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Behavior TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Behavior TestClient
	И в каталоге Markdown появился 1 файл Markdown
