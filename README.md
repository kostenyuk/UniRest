# UniRest
# Unique Restaurant

**Как начать разработку.**
1. Скачать(https://git-scm.com/downloads) и установить Git.
2. Установить глобальные настройки Git.
	2.1. Открыть Git Bash.
	2.2. Установить имя пользователя:
		git config --global user.name "John Doe"
	2.3. Установить адрес электронной почты:
		git config --global user.email johndoe@example.com
	2.4. Проверить настройки:
		git config --list
3. Скачать(https://desktop.github.com/) и установить GitHub Desktop.
4. Склонировать проект на локальный компьютер.
	4.1. Открыть GitHub Desktop.
	4.2. Нажать кнопку "Clone a repository from Internet...".
	4.3. Перейти на закладку URL:
		- в поле "Repository URL" указать https://github.com/kostenyuk/UniRest.git
		- в поле "Local path" указать путь к каталогу в котором будет храниться проект
	4.4. Нажать кнопку "Clone".
5. Загрузить склонированную конфигурацию в локальную информационню базу.
	5.1. Открыть конфируартор.
	5.2. Меню "Конфигурация => Загрузить конфигурацию из файлов...".
6. Создать новую ветку для разработки.
	6.1. Открыть GitHub Desktop.
	6.2. Обновиться из ветки develop(Repository => Pull).
	6.3. Создать новую ветку(Branch => New branch...).
		Имя ветки задается по следующему шаблону:
		- [feature]_[name] - задача на разработку нового/улучшение существующего функционала, например feature_new_report либо feature_redesign_document_order
		- [bug]_[name] - исправление ошибки существующего функционала, например bug_document_sales_plan
7. Разработка.
	7.1. Открыть конфируартор.
	7.2. Внести необходимые изменения в конфигурацию.
	7.3. Увеличить порядковый номер версии конфигурации на единицу.
		- нажать правой кнопкой мыши на корне дерева конфигурации => Свойства => Версия
		- в модуле объекта обработки ОбновлениеИнформационнойБазы в процедуре ВыполнитьОбновление() установить значение переменной НоваяВерсияИБ
8. Сохранение и отправка изменений в репозиторий.
	8.1. Открыть GitHub Desktop.
	8.2. Сделать коммит(кнопка Commit в левой нижней части экрана). Описание коммита должно содержать номер и название задачи.
	8.3. Отправить изменения в репозиторий(Repository => Push).
	8.4. Создать Pull request своей ветки на ветку develop(Branch => Create pull request).
9. Ваш Pull request объединяется/отклоняется после проверки кода.