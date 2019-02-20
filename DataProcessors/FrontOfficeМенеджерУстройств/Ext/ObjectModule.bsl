﻿
#Если Клиент Тогда
	
// Процедура инициализация модуля рабочего места.
//
Процедура Инициализация() Экспорт
	
	// Проверка режима.
	Если ПолучитьСерверFrontOffice().РежимBackOffice Тогда
		Возврат;
	КонецЕсли;
	
	// Создание формы.
	Если (Форма = Неопределено) Тогда
		Форма = ЭтотОбъект.ПолучитьФорму("Форма");
		ПолучитьСерверFrontOffice().__ОткрытьФорму(Форма);
	КонецЕсли;
		
КонецПроцедуры // Инициализация()

// Процедура открытия формы рабочего места.
//
Процедура Открыть() Экспорт
	
	// Открытие формы.
	ПолучитьСерверFrontOffice().__ОткрытьФорму(Форма);
		
КонецПроцедуры // Открыть()


// Процедура заполнения табличного поля.
//
// Параметры:
//	ТабличноеПоле - TouchТабличноеПоле. Табличное поле;
//	Производство - Булево. Режим производста.
//
Процедура ТаблицаУстройствПрочитать(ТабличноеПоле) Экспорт
	
	// Данные.
	Данные = ТабличноеПоле.Данные();
	Если (Данные = Неопределено) Тогда
		Данные = Новый ТаблицаЗначений;
		
		Данные.Колонки.Добавить("Ссылка", Новый ОписаниеТипов("СправочникСсылка.Компьютеры"), НСтр("ru = 'Устройство'; uk = 'Пристрій'"));
		Данные.Колонки.Добавить("Пользователь", Новый ОписаниеТипов("СправочникСсылка.Пользователи"), НСтр("ru = 'Пользователь'; uk = 'Користувач'"));
		
		ТабличноеПоле.Данные(Данные); ТабличноеПоле.СоздатьКолонки("Картинка,Ссылка,Пользователь");
		ТабличноеПоле.Колонки.Получить("Ссылка").Ширина = 400 * 0.50;
		ТабличноеПоле.Колонки.Получить("Пользователь").Ширина = 400 * 0.50;
		ТабличноеПоле.РежимВыделенияСтроки = РежимВыделенияСтрокиТабличногоПоля.Строка;
		
		Возврат;
	Иначе
		// -- Текущая позиция (I).
		Если (Не ТабличноеПоле.ТекущаяСтрока() = Неопределено) Тогда
			ТекущееУстройство = ТабличноеПоле.ТекущиеДанные().Ссылка;
		КонецЕсли;
		
		Данные.Очистить();
	КонецЕсли;
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	Компьютеры.Ссылка КАК Ссылка,
	                      |	Компьютеры.Пользователь
	                      |ИЗ
	                      |	Справочник.Компьютеры КАК Компьютеры
	                      |ГДЕ
	                      |	Компьютеры.Актуальность
	                      |	И Компьютеры.Устройство
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	Ссылка
	                      |АВТОУПОРЯДОЧИВАНИЕ");
	РезультатЗапроса = Запрос.Выполнить();
	
	// -- Пустая выборка.
	Если РезультатЗапроса.Пустой() Тогда
		ТабличноеПоле.ОбновитьСтроки();
		Возврат;
	КонецЕсли;
	
	// Перенос данных в табличное поле.
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
	
		СтрокаДанных = Данные.Добавить();
		СтрокаДанных.Ссылка = Выборка.Ссылка;
		СтрокаДанных.Пользователь = Выборка.Пользователь;
		
		// -- Текущая позиция (II).
		Если (СтрокаДанных.Ссылка = ТекущееУстройство) Тогда
			ТекущаяСтрока = СтрокаДанных;
		КонецЕсли;
	
	КонецЦикла;
	
	// -- Текущая позиция (II).
	Если (Не ТекущаяСтрока = Неопределено) Тогда
		ТабличноеПоле.ТекущаяСтрока(ТекущаяСтрока);
	КонецЕсли;
	
	// Обновление.
	Если (ТекущаяСтрока = Неопределено) Тогда
		ТабличноеПоле.ОбновитьСтроки();
	КонецЕсли;

КонецПроцедуры // ТаблицаДокументовПрочитать()

// Процедура обработчик события ПриВыводеСтроки табличного поля.
//
Процедура ТаблицаУстройствВывестиСтроку(Элемент, ОформлениеСтроки, ДанныеСтроки) Экспорт

	ОформлениеСтроки.Ячейки("Картинка").УстановитьКартинку = БиблиотекаКартинок.ЭлементСправочника;
	
КонецПроцедуры // ТаблицаУстройствВывестиСтроку()


Функция УстройствоВыдать(Устройство, Пользователь, ГруппаПользователей) Экспорт
	
	Попытка
		Справочники.Компьютеры.УстановитьПользователяКомпьютера(Устройство.Ссылка, Пользователь, ГруппаПользователей);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции // УстройствоВыдать()

Функция УстройствоПринять(Устройство) Экспорт
	
	Возврат УстройствоВыдать(Устройство, Неопределено, Неопределено);
	
КонецФункции // УстройствоПринять()

#КонецЕсли
