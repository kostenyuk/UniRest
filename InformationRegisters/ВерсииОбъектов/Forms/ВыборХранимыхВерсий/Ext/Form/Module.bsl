﻿////////////////////////////////////////////////////////////////////////////////
// Секция обработчиков событий формы и элементов формы

// Обработчик события формы "ПриСозданииНаСервере"
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Ссылка = Параметры.Ссылка;
	
	Если ВерсионированиеОбъектов.ПолучитьКоличествоВерсийОбъекта(Ссылка) = 0 Тогда
		Элементы.ОсновнаяСтраница.ТекущаяСтраница = Элементы.ВерсииДляСравненияОтсутствуют;
		Текст_ВерсииОтсутствуют = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		                               НСтр("ru = 'Нет хранимых версий, относящихся к объекту <%1>.'"),
		                               Строка(Ссылка));
	КонецЕсли;
	
	ЗначениеВРеквизитФормы(СформироватьТаблицуВерсий(Ссылка), "СписокВерсий");
	
КонецПроцедуры

// Функция возвращает список номеров версий объекта переданного по ссылке
//
// Параметры:
// Ссылка        - СправочникСсылка, ДокументСсылка - ссылка на объект
//
&НаСервереБезКонтекста
Функция СформироватьТаблицуВерсий(Ссылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ НомерВерсии, АвторВерсии, ДатаВерсии
	                | ИЗ РегистрСведений.ВерсииОбъектов
	                | ГДЕ Объект=&Ссылка
	                | УПОРЯДОЧИТЬ ПО НомерВерсии Убыв";
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Обработчик события "Выбор" табличного поля "СписокВерсий"
//
&НаКлиенте
Процедура СписокВерсийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОткрытьВерсиюОбъекта();
	
КонецПроцедуры

// Обработчик нажатия на кнопку "ОткрытьВерсиюОбъекта"
//
&НаКлиенте
Процедура ОткрытьВерсиюОбъектаВыполнить()
	
	ОткрытьВерсиюОбъекта();
	
КонецПроцедуры

// Обработчик нажатия на кнопку "ОтчетПоИзменениям"
//
&НаКлиенте
Процедура СформироватьОтчетПоИзменениямВыполнить()
	
	ВыделенныеСтроки = Элементы.СписокВерсий.ВыделенныеСтроки;
	
	ВыбранныеВерсии = СформироватьСписокВыбранныхВерсий(ВыделенныеСтроки);
	
	Если ВыбранныеВерсии.Количество() < 2 Тогда
		Предупреждение(НСтр("ru = 'Для формирования отчета по изменениям, необходимо выбрать, как минимум, две версии.'"));
	Иначе
		ОткрытьФормуОтчета(ВыбранныеВерсии);
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Секция вспомогательных функций

// Проверяет, что в списке версий выбрана версия и вызывает форму
// отчета с переданным параметром - номером выбранной версии.
//
&НаКлиенте
Процедура ОткрытьВерсиюОбъекта()
	
	Если ЗначениеЗаполнено(Элементы.СписокВерсий.ТекущиеДанные.НомерВерсии) Тогда
		ВыбранныеВерсии = Новый СписокЗначений;
		ВыбранныеВерсии.Добавить(Элементы.СписокВерсий.ТекущиеДанные.НомерВерсии);
		
		Если ВыбранныеВерсии <> Неопределено Тогда
			ОткрытьФормуОтчета(ВыбранныеВерсии);
		КонецЕсли;
	Иначе
		Предупреждение(НСтр("ru = 'Для продолжения необходимо выбрать версию объекта'"));
	КонецЕсли;
	
КонецПроцедуры

// Открывает форму отчета по изменениям, с требуемыми параметрами
//
&НаКлиенте
Процедура ОткрытьФормуОтчета(СписокВерсийПараметр)
	
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("Ссылка", Ссылка);
	ПараметрыОтчета.Вставить("СписокВерсий", СписокВерсийПараметр);
	
	ОткрытьФорму("Отчет.ОтчетПоВерсиям.Форма.ФормаОтчета",
	             ПараметрыОтчета,
	             ЭтаФорма,
	             УникальныйИдентификатор);
	
КонецПроцедуры

// Функция возвращает список номеров выбранных версий
//
&НаКлиенте
Функция СформироватьСписокВыбранныхВерсий(ВыделенныеСтроки)
	
	ВыбранныеВерсии = Новый СписокЗначений;
	
	Для Каждого НомерВыделеннойСтроки Из ВыделенныеСтроки Цикл
		ВыбранныеВерсии.Добавить(СписокВерсий[НомерВыделеннойСтроки].НомерВерсии);
	КонецЦикла;
	
	ВыбранныеВерсии.СортироватьПоЗначению(НаправлениеСортировки.Возр);
	
	Возврат ВыбранныеВерсии;
	
КонецФункции
