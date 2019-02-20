﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Базовая функциональность".
// Внутренние процедуры и функции для работы с журналом регистрации.
//  
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЙ ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Открывает форму для просмотра дополнительных данных события.
//
// Параметры:
//	ТекущиеДанные - Строка таблицы значений - строка журнала регистрации.
//
Процедура ОткрытьДанныеДляПросмотра(ТекущиеДанные) Экспорт
	
	Если ТекущиеДанные = Неопределено Или ТекущиеДанные.Данные = Неопределено Тогда
		Предупреждение(НСтр("ru = 'Эта запись журнала регистрации не связана с данными (см. колонку ""Данные"")'"));
		Возврат;
	КонецЕсли;
	
	Попытка
		ОткрытьЗначение(ТекущиеДанные.Данные);
	Исключение
		ТекстПредупреждения = НСтр("ru = 'Эта запись журнала регистрации связана с данными, но отобразить их невозможно.
									|%1'");
		Если ТекущиеДанные.Событие = "_$Data$_.Delete" Тогда 
			// это - событие удаления
			ТекстПредупреждения =
					СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						ТекстПредупреждения,
						НСтр("ru = 'Данные удалены из информационной базы'"));
		Иначе
			ТекстПредупреждения =
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						ТекстПредупреждения,
						НСтр("ru = 'Возможно, данные удалены из информационной базы'"));
		КонецЕсли;
		Предупреждение(ТекстПредупреждения);
	КонецПопытки;
	
КонецПроцедуры // ОткрытьДанныеДляПросмотра

// Открывает форму просмотра события обработки "Журнал регистрации"
//  для отображения в ней подробных данных выбранного события
//
// Параметры:
//	Данные  - Строка таблицы значений - строрка журнала регистрации.
//
Процедура ПросмотрТекущегоСобытияВОтдельномОкне(Данные) Экспорт
	
	Если Данные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Дата",                    Данные.Дата);
	ПараметрыФормы.Вставить("ИмяПользователя",         Данные.ИмяПользователя);
	ПараметрыФормы.Вставить("ПредставлениеПриложения", Данные.ПредставлениеПриложения);
	ПараметрыФормы.Вставить("Компьютер",               Данные.Компьютер);
	ПараметрыФормы.Вставить("Событие",                 Данные.Событие);
	ПараметрыФормы.Вставить("ПредставлениеСобытия",    Данные.ПредставлениеСобытия);
	ПараметрыФормы.Вставить("Комментарий",             Данные.Комментарий);
	ПараметрыФормы.Вставить("ПредставлениеМетаданных", Данные.ПредставлениеМетаданных);
	ПараметрыФормы.Вставить("Данные",                  Данные.Данные);
	ПараметрыФормы.Вставить("ПредставлениеДанных",     Данные.ПредставлениеДанных);
	ПараметрыФормы.Вставить("Транзакция",              Данные.Транзакция);
	ПараметрыФормы.Вставить("СтатусТранзакции",        Данные.СтатусТранзакции);
	ПараметрыФормы.Вставить("Сеанс",                   Данные.Сеанс);
	ПараметрыФормы.Вставить("РабочийСервер",           Данные.РабочийСервер);
	ПараметрыФормы.Вставить("ОсновнойIPПорт",          Данные.ОсновнойIPПорт);
	ПараметрыФормы.Вставить("ВспомогательныйIPПорт",   Данные.ВспомогательныйIPПорт);
	
	Если Данные.Свойство("ПредставлениеРазделенияДанныхСеанса") Тогда
		ПараметрыФормы.Вставить("ПредставлениеРазделенияДанныхСеанса", Данные.ПредставлениеРазделенияДанныхСеанса);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Данные.АдресДанных) Тогда
		ПараметрыФормы.Вставить("АдресДанных", Данные.АдресДанных);
	КонецЕсли;
	
	ОткрытьФорму("Обработка.ЖурналРегистрации.Форма.ФормаСобытия", ПараметрыФормы);
	
КонецПроцедуры // ПросмотрТекущегоСобытияВОтдельномОкне

// Запрашивает у пользователя ограничение периода 
// и включает его в отбор журнала регистрации
//
// Параметры:
//	ИнтервалДат - СтандартныйПериод, интервал дат отбора
//	ОтборЖурналаРегистрации - Структура, отбор журнала регистрации
//
Функция УстановитьИнтервалДатДляПросмотра(ИнтервалДат, ОтборЖурналаРегистрации) Экспорт
	
	ИнтервалУстановлен = Ложь;
		
	// Получение текущего периода
	ДатаНачала    = Неопределено;
	ДатаОкончания = Неопределено;
	ОтборЖурналаРегистрации.Свойство("ДатаНачала", ДатаНачала);
	ОтборЖурналаРегистрации.Свойство("ДатаОкончания", ДатаОкончания);
	ДатаНачала    = ?(ТипЗнч(ДатаНачала)    = Тип("Дата"), ДатаНачала, '00010101000000');
	ДатаОкончания = ?(ТипЗнч(ДатаОкончания) = Тип("Дата"), ДатаОкончания, '00010101000000');
	
	Если ИнтервалДат.ДатаНачала <> ДатаНачала Тогда
		ИнтервалДат.ДатаНачала = ДатаНачала;
	КонецЕсли;
	
	Если ИнтервалДат.ДатаОкончания <> ДатаОкончания Тогда
		ИнтервалДат.ДатаОкончания = ДатаОкончания;
	КонецЕсли;
	
	// Редактирование текущего периода
	Диалог = Новый ДиалогРедактированияСтандартногоПериода;
	Диалог.Период = ИнтервалДат;
	
	Если Диалог.Редактировать() Тогда
		// Обновление текущего периода
		ИнтервалДат = Диалог.Период;
		Если ИнтервалДат.ДатаНачала = '00010101000000' Тогда
			ОтборЖурналаРегистрации.Удалить("ДатаНачала");
		Иначе
			ОтборЖурналаРегистрации.Вставить("ДатаНачала", ИнтервалДат.ДатаНачала);
		КонецЕсли;
		Если ИнтервалДат.ДатаОкончания = '00010101000000' Тогда
			ОтборЖурналаРегистрации.Удалить("ДатаОкончания");
		Иначе
			ОтборЖурналаРегистрации.Вставить("ДатаОкончания", ИнтервалДат.ДатаОкончания);
		КонецЕсли;
		ИнтервалУстановлен = Истина;
	КонецЕсли;
	
	Возврат ИнтервалУстановлен;
	
КонецФункции // УстановитьИнтервалДатДляПросмотра

// Выполняет обработку выбора отдельного события в таблице событий
//
// Параметры:
//	ТекущиеДанные - Строка таблицы значений - строка журнала регистрации.
//	Поле - Поле таблицы значений - поле.
//	ИнтервалДат - интервал.
//	ОтборЖурналаРегистрации - Отбор - отбор журнала регистрации.
//
Процедура СобытияВыбор(ТекущиеДанные, Поле, ИнтервалДат, ОтборЖурналаРегистрации) Экспорт
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Поле.Имя = "Данные" Или Поле.Имя = "ПредставлениеДанных" Тогда
		Если ТекущиеДанные.Данные <> Неопределено И (ТипЗнч(ТекущиеДанные.Данные) <> Тип("Строка") И ЗначениеЗаполнено(ТекущиеДанные.Данные)) Тогда
			ОткрытьДанныеДляПросмотра(ТекущиеДанные);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Если Поле.Имя = "Дата" Тогда
		УстановитьИнтервалДатДляПросмотра(ИнтервалДат, ОтборЖурналаРегистрации);
		Возврат;
	КонецЕсли;
	
	ПросмотрТекущегоСобытияВОтдельномОкне(ТекущиеДанные);
	
КонецПроцедуры // СобытияВыбор

// Заполняет отбор в соответствии с значением в текущей колонке событий.
//
// Параметры:
//	ТекущиеДанные - Строка таблицы значений.
//	ТекущийЭлемент - Текущий элемент строки таблицы значений.
//	ОтборЖурналаРегистрации - Отбор - отбор журнала регистрации.
//	КолонкиИсключения - Список значений - колонки исключения.
//
// Возвращаемое значение:
//	Булево - Истина, если отбор установлен, Ложь - Иначе.
//
Функция УстановитьОтборПоЗначениюВТекущейКолонке(ТекущиеДанные, ТекущийЭлемент, ОтборЖурналаРегистрации, КолонкиИсключения) Экспорт
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	ИмяКолонкиПредставления = ТекущийЭлемент.Имя;
	Если КолонкиИсключения.Найти(ИмяКолонкиПредставления) <> Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	ЗначениеОтбора = ТекущиеДанные[ИмяКолонкиПредставления];
	Представление  = ТекущиеДанные[ИмяКолонкиПредставления];
	
	ИмяЭлементаОтбора = ИмяКолонкиПредставления;
	Если ИмяКолонкиПредставления = "ИмяПользователя" Тогда 
		ИмяЭлементаОтбора = "Пользователь";
		ЗначениеОтбора = ТекущиеДанные["Пользователь"];
	ИначеЕсли ИмяКолонкиПредставления = "ПредставлениеПриложения" Тогда
		ИмяЭлементаОтбора = "ИмяПриложения";
		ЗначениеОтбора = ТекущиеДанные["ИмяПриложения"];
	ИначеЕсли ИмяКолонкиПредставления = "ПредставлениеСобытия" Тогда
		ИмяЭлементаОтбора = "Событие";
		ЗначениеОтбора = ТекущиеДанные["Событие"];
	КонецЕсли;
	
	// По пустым строкам не отбираем
	Если ТипЗнч(ЗначениеОтбора) = Тип("Строка") И ПустаяСтрока(ЗначениеОтбора) Тогда
		// Для пользователя по умолчанию имя пустое, разрешаем отбирать
		Если ИмяКолонкиПредставления <> "ИмяПользователя" Тогда 
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
	ТекущееЗначение = Неопределено;
	Если ОтборЖурналаРегистрации.Свойство(ИмяЭлементаОтбора, ТекущееЗначение) Тогда
		// Уже установлен отбор
		ОтборЖурналаРегистрации.Удалить(ИмяЭлементаОтбора);
	Иначе
		Если ИмяЭлементаОтбора = "Данные" Или          // не списочные отборы, только 1 значение
			 ИмяЭлементаОтбора = "Комментарий" Или
			 ИмяЭлементаОтбора = "Транзакция" Или
			 ИмяЭлементаОтбора = "ПредставлениеДанных" Тогда 
			ОтборЖурналаРегистрации.Вставить(ИмяЭлементаОтбора, ЗначениеОтбора);
		Иначе
			СписокОтбора = Новый СписокЗначений;
			СписокОтбора.Добавить(ЗначениеОтбора, Представление);
			ОтборЖурналаРегистрации.Вставить(ИмяЭлементаОтбора, СписокОтбора);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции // УстановитьОтборПоЗначениюВТекущейКолонке

