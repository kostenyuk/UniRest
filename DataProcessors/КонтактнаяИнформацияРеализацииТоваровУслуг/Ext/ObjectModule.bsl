﻿
// Процедура считывает контактную информацию связанную с владельцем.
//
Процедура Прочитать(Владелец, ОбъектКопирования = Неопределено) Экспорт

	// Выборка данных.
	Если (ОбъектКопирования = Неопределено) Тогда
		Документ = Владелец.Ссылка;
	Иначе
		Документ = ОбъектКопирования.Ссылка;
	КонецЕсли;
	
	Запись = РегистрыСведений.КонтактнаяИнформацияРеализацииТоваровУслуг.Выбрать(Новый Структура("Документ", Документ));
	
	Пока Запись.Следующий() Цикл
		
		// Адрес доставки.
		Если (Запись.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес) И (Запись.Вид = Справочники.ВидыКонтактнойИнформации.АдресДоставкиРеализацииТоваровУслуг) Тогда
			УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(АдресДоставки, УправлениеКонтактнойИнформацией.ПолучитьСтруктуруЗаписиРегистра(Запись));
		КонецЕсли;
		
		Если (Запись.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон) Тогда
		
			// Телефон.
			Если (Запись.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонРеализацииТоваровУслуг) Тогда
				УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(Телефон, УправлениеКонтактнойИнформацией.ПолучитьСтруктуруЗаписиРегистра(Запись));
			КонецЕсли;
			
			// Телефон дополнительный.
			Если (Запись.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонДополнительныйРеализацииТоваровУслуг) Тогда
				УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(ТелефонДополнительный, УправлениеКонтактнойИнформацией.ПолучитьСтруктуруЗаписиРегистра(Запись));
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры // Прочитать()

// Процедура записывает требуемую контактную информацию связанную с владельцем.
//
Процедура Записать(Владелец, Отказ) Экспорт
	
	// Отказ.
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	// Поиск.
	АдресДоставки.Поиск = УправлениеКонтактнойИнформацией.ПолучитьПоискАдреса(АдресДоставки);
	Телефон.Поиск = УправлениеКонтактнойИнформацией.ПолучитьПоискТелефона(Телефон);
	ТелефонДополнительный.Поиск = УправлениеКонтактнойИнформацией.ПолучитьПоискТелефона(ТелефонДополнительный);
	
	// Набор записей.
	Документ = Владелец.Ссылка;
	
	//Если (ТипЗнч(Документ) = Тип("ДокументСсылка.ЗаказПокупателя")) Тогда
	//	НаборЗаписей = РегистрыСведений.КонтактнаяИнформацияЗаказовПокупателей.СоздатьНаборЗаписей();
	//Иначе
	//	НаборЗаписей = РегистрыСведений.КонтактнаяИнформацияРеализацииТоваровУслуг.СоздатьНаборЗаписей();
	//КонецЕсли;
	
	//Костенюк Александр-Старт 22.05.2012
	НаборЗаписей = РегистрыСведений.КонтактнаяИнформацияРеализацииТоваровУслуг.СоздатьНаборЗаписей();
	//Костенюк Александр-Финиш 22.05.2012
	
	НаборЗаписей.Отбор.Документ.Установить(Документ);
	
	//Если (Владелец.Модуль = Перечисления.МодулиИПодсистемы.Доставка) Тогда
	//Костенюк Александр-Старт 22.05.2012
	ПравоИзменениеКонтактнойИнформацииЗаказов = УправлениеПользователями.ПолучитьЗначениеПрава(ПланыВидовХарактеристик.ПраваПользователей.FrontOfficeИзменениеКонтактнойИнформацииЗаказов);
	Если (Владелец.Модуль = Перечисления.МодулиИПодсистемы.Доставка) ИЛИ
		(ПравоИзменениеКонтактнойИнформацииЗаказов = Перечисления.ПраваДоступаПользователей.Разрешить) ИЛИ
		(ПравоИзменениеКонтактнойИнформацииЗаказов = Перечисления.ПраваДоступаПользователей.Привилегированные)
		Тогда
	//Костенюк Александр-Финиш 22.05.2012
		// Адрес доставки.
		Если (АдресДоставки.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес) И (Не УправлениеКонтактнойИнформацией.ПустаяКонтактнаяИнформация(АдресДоставки)) Тогда
			Запись = НаборЗаписей.Добавить();
			УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(Запись, УправлениеКонтактнойИнформацией.ПолучитьСтруктуруЗаписиРегистра(АдресДоставки));
			Запись.Документ = Документ;
			Запись.Объект = Владелец.Контрагент;
			Запись.Вид = Справочники.ВидыКонтактнойИнформации.АдресДоставкиРеализацииТоваровУслуг;
			Запись.ЗначениеПоУмолчанию = Ложь;
		КонецЕсли;
		
		// Телефон.
		Если (Телефон.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон) И (Не УправлениеКонтактнойИнформацией.ПустаяКонтактнаяИнформация(Телефон)) Тогда
			Запись = НаборЗаписей.Добавить();
			УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(Запись, УправлениеКонтактнойИнформацией.ПолучитьСтруктуруЗаписиРегистра(Телефон));
			Запись.Документ = Документ;
			Запись.Объект = Владелец.Контрагент;
			Запись.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонРеализацииТоваровУслуг;
			Запись.ЗначениеПоУмолчанию = Ложь;
		КонецЕсли;
		
		// Телефон дополнительный.
		Если (ТелефонДополнительный.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон) И (Не УправлениеКонтактнойИнформацией.ПустаяКонтактнаяИнформация(ТелефонДополнительный)) Тогда
			Запись = НаборЗаписей.Добавить();
			УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(Запись, УправлениеКонтактнойИнформацией.ПолучитьСтруктуруЗаписиРегистра(ТелефонДополнительный));
			Запись.Документ = Документ;
			Запись.Объект = Владелец.Контрагент;
			Запись.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонДополнительныйРеализацииТоваровУслуг;
			Запись.ЗначениеПоУмолчанию = Ложь;
		КонецЕсли;
		
	Иначе
		
		// Очистка контактной информации.
		УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(АдресДоставки, УправлениеКонтактнойИнформацией.ПолучитьПустуюСтруктуруАдреса()); АдресДоставки.Вид = Справочники.ВидыКонтактнойИнформации.АдресДоставкиРеализацииТоваровУслуг;
		УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(Телефон, УправлениеКонтактнойИнформацией.ПолучитьПустуюСтруктуруТелефона()); Телефон.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонРеализацииТоваровУслуг;
		УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(ТелефонДополнительный, УправлениеКонтактнойИнформацией.ПолучитьПустуюСтруктуруТелефона()); ТелефонДополнительный.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонДополнительныйРеализацииТоваровУслуг;
		
	КонецЕсли;
	
	// Запись.
	Попытка
		НаборЗаписей.Записать();
	Исключение
		ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), Отказ, ,, НаборЗаписей, Владелец);
	КонецПопытки;
	
КонецПроцедуры // Записать()


// Инициализация переменных.
УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(АдресДоставки, УправлениеКонтактнойИнформацией.ПолучитьПустуюСтруктуруАдреса()); АдресДоставки.Вид = Справочники.ВидыКонтактнойИнформации.АдресДоставкиРеализацииТоваровУслуг;
УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(Телефон, УправлениеКонтактнойИнформацией.ПолучитьПустуюСтруктуруТелефона()); Телефон.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонРеализацииТоваровУслуг;
УправлениеКонтактнойИнформацией.ЗаполнитьЗаписьРегистраПоСтруктуре(ТелефонДополнительный, УправлениеКонтактнойИнформацией.ПолучитьПустуюСтруктуруТелефона()); ТелефонДополнительный.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонДополнительныйРеализацииТоваровУслуг;
