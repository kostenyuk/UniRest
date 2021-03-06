﻿
Перем мКонтрагент, мНаименование, мЮрФизЛицо; // Изменяемые реквизиты контрагента.


// Функция возвращает или устанавливает наименование контрагента связанного с владельцем.
//
Функция Наименование(Владелец, Значение = Неопределено) Экспорт
	
	// Изменение.
	Если (мКонтрагент = Владелец.Контрагент) И (Не Значение = Неопределено) Тогда
		мНаименование = Строка(Значение);
	КонецЕсли;
	
	// Актуализация.
	Если (Не мКонтрагент = Владелец.Контрагент) Тогда
		мКонтрагент = Владелец.Контрагент;
		мНаименование = Владелец.Контрагент.Наименование;
	КонецЕсли;
	
	// Результат.
	Возврат мНаименование;
	
КонецФункции // Наименование()

// Функция возвращает или устанавливает тип контрагента связанного с владельцем.
//
Функция ЮрФизЛицо(Владелец, Значение = Неопределено) Экспорт
	
	// Изменение.
	Если Владелец.Контрагент.Пустая() И (Не Значение = Неопределено) Тогда
		Если (Значение = Перечисления.ЮрФизЛицо.ЮрЛицо) Тогда 
			мЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо;
		Иначе
			мЮрФизЛицо = Перечисления.ЮрФизЛицо.ФизЛицо;
		КонецЕсли;
	КонецЕсли;
	
	// Актуализация.
	Если Не Владелец.Контрагент.Пустая() Тогда
		Если (Владелец.Контрагент.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо) Тогда 
			мЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо;
		Иначе
			мЮрФизЛицо = Перечисления.ЮрФизЛицо.ФизЛицо;
		КонецЕсли;
	КонецЕсли;
	
	// Результат.
	Возврат мЮрФизЛицо;
	
КонецФункции // ЮрФизЛицо()


// Процедура считывает требуемые реквизиты контрагента связанного с владельцем.
//
Процедура Прочитать(Владелец) Экспорт
	
	// Выборка данных.
	мКонтрагент = Владелец.Контрагент;
	мНаименование = Владелец.Контрагент.Наименование;
	
КонецПроцедуры // Прочитать()

// Процедура записывает требуемые реквизиты контрагента связанного с владельцем и при необходимости
// созадет нового контрагента.
//
Процедура Записать(Владелец, Отказ) Экспорт
	
	// Отказ.
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	// Запись.
	Попытка
		// -- Проверка необходимости записи.
		Если Владелец.Контрагент.Пустая() Тогда
			Если Не ПустаяСтрока(мНаименование) Тогда
				КонтрагентОбъект = Справочники.Контрагенты.СоздатьЭлемент();
				КонтрагентОбъект.ЮрФизЛицо = мЮрФизЛицо;
			КонецЕсли;
		Иначе
			Если (Владелец.Контрагент = мКонтрагент) И (Не Владелец.Контрагент.Наименование = мНаименование) Тогда
				КонтрагентОбъект = Владелец.Контрагент.ПолучитьОбъект();
			КонецЕсли;
		КонецЕсли;
		Если (КонтрагентОбъект = Неопределено) Тогда
			Возврат;
		КонецЕсли;
		
		// -- Изменение объекта и запись.
		КонтрагентОбъект.Наименование = мНаименование;
		КонтрагентОбъект.НаименованиеПолное = КонтрагентОбъект.Наименование;
		КонтрагентОбъект.Записать();
		
		// -- Связывание.
		Владелец.Контрагент = КонтрагентОбъект.Ссылка;
	Исключение
		ОбщегоНазначения.СообщитьОбОшибке(ОписаниеОшибки(), Отказ);
	КонецПопытки;
	
КонецПроцедуры // Записать()


// Инициализация переменных.
мНаименование = Строка(Неопределено);
мЮрФизЛицо = Перечисления.ЮрФизЛицо.ФизЛицо;
