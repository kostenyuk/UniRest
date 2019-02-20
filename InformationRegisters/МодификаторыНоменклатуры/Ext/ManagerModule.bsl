﻿
Функция ПолучитьСписокНоменклатуры(Модификатор = Неопределено, Регистр = "МодификаторыНоменклатуры") Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	                      |	МодификаторыНоменклатуры.Номенклатура
	                      |ИЗ
	                      |	РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
	                      |ГДЕ
	                      |	МодификаторыНоменклатуры.Актуальность
	                      |	И (&Модификатор = НЕОПРЕДЕЛЕНО
	                      |			ИЛИ МодификаторыНоменклатуры.Модификатор = &Модификатор)");
	Запрос.УстановитьПараметр("Модификатор", Модификатор);
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрСведений.МодификаторыНоменклатуры", "РегистрСведений." + Регистр);
	Если (Регистр = "СопутствующаяНоменклатура") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "МодификаторыНоменклатуры.Модификатор", "МодификаторыНоменклатуры.Сопутствующая");
	ИначеЕсли (Регистр = "УсловияНоменклатуры") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "МодификаторыНоменклатуры.Модификатор", "МодификаторыНоменклатуры.Условия");
	КонецЕсли; 
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Номенклатура");
	
КонецФункции // ПолучитьСписокНоменклатуры()


Процедура ПолучитьПравилаМодификаторов(Ссылка, Родитель, Объект, Регистр = "МодификаторыНоменклатуры") Экспорт

	// Связанный справочник.
	Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	МодификаторыНоменклатуры.Ссылка КАК Модификатор,
		|	МодификаторыНоменклатуры.Актуальность КАК АктуальностьСправочника,
		|	ВЫБОР
		|		КОГДА &РодительТекущий = &РодительНовый
		|			ТОГДА ЕСТЬNULL(МодификаторыНоменклатурыЭлемент.Актуальность, ЛОЖЬ)
		|		ИНАЧЕ ВЫБОР
		|				КОГДА ЕСТЬNULL(МодификаторыНоменклатурыЭлемент.Актуальность, ЛОЖЬ) = ЕСТЬNULL(МодификаторыНоменклатурыРодительТекущий.Актуальность, ЛОЖЬ)
		|					ТОГДА ЕСТЬNULL(МодификаторыНоменклатурыРодительНовый.Актуальность, ЛОЖЬ)
		|				ИНАЧЕ ЕСТЬNULL(МодификаторыНоменклатурыЭлемент.Актуальность, ЛОЖЬ)
		|			КОНЕЦ
		|	КОНЕЦ КАК Актуальность,
		|	ВЫБОР
		|		КОГДА МодификаторыНоменклатуры.ЭтоГруппа
		|			ТОГДА 2
		|		ИНАЧЕ 0
		|	КОНЕЦ + ВЫБОР
		|		КОГДА МодификаторыНоменклатуры.ПометкаУдаления
		|			ТОГДА 1
		|		ИНАЧЕ 0
		|	КОНЕЦ КАК ИндексКартинки
		|ИЗ
		|	Справочник.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатурыЭлемент
		|		ПО (МодификаторыНоменклатурыЭлемент.Номенклатура = &Номенклатура)
		|			И (МодификаторыНоменклатурыЭлемент.Модификатор = МодификаторыНоменклатуры.Ссылка)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатурыРодительТекущий
		|		ПО (МодификаторыНоменклатурыРодительТекущий.Номенклатура = &РодительТекущий)
		|			И (МодификаторыНоменклатурыРодительТекущий.Модификатор = МодификаторыНоменклатуры.Ссылка)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатурыРодительНовый
		|		ПО (МодификаторыНоменклатурыРодительНовый.Номенклатура = &РодительНовый)
		|			И (МодификаторыНоменклатурыРодительНовый.Модификатор = МодификаторыНоменклатуры.Ссылка)
		|
		|УПОРЯДОЧИТЬ ПО
		|	Модификатор ИЕРАРХИЯ
		|АВТОУПОРЯДОЧИВАНИЕ");
	Запрос.УстановитьПараметр("Номенклатура", Ссылка.Ссылка);
	Запрос.УстановитьПараметр("РодительТекущий", Ссылка.Ссылка.Родитель);
	Запрос.УстановитьПараметр("РодительНовый", Родитель);
	
	Если (Регистр = "СопутствующаяНоменклатура") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.МодификаторыНоменклатуры", "Справочник.Номенклатура");
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.МодификаторыНоменклатуры", "Справочник." + Регистр);
	КонецЕсли; 
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрСведений.МодификаторыНоменклатуры", "РегистрСведений." + Регистр);
	Если (Регистр = "СопутствующаяНоменклатура") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Ссылка КАК Модификатор", ".Ссылка КАК Сопутствующая");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Актуальность КАК АктуальностьСправочника", ".ПометкаУдаления КАК АктуальностьСправочника");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Модификатор", ".Сопутствующая");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Модификатор ИЕРАРХИЯ", "Сопутствующая ИЕРАРХИЯ");
	ИначеЕсли (Регистр = "УсловияНоменклатуры") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Ссылка КАК Модификатор", ".Ссылка КАК Условия");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Модификатор", ".Условия");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Модификатор ИЕРАРХИЯ", "Условия ИЕРАРХИЯ");
	КонецЕсли; 
	
	ПравилаМодификаторов = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	ЗначениеВДанныеФормы(ПравилаМодификаторов, Объект);	
	
КонецПроцедуры // ПолучитьПравилаМодификаторов()

Процедура УстановитьПравилаМодификаторов(Ссылка, Родитель, Объект, Отказ, Регистр = "МодификаторыНоменклатуры") Экспорт

	Если Не Отказ Тогда
		
		ПравилаМодификаторов = ДанныеФормыВЗначение(Объект, Тип("ДеревоЗначений"));
		
		НаборЗаписей = РегистрыСведений[Регистр].СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Номенклатура.Установить(Ссылка.Ссылка);
		
		// Актуальные.
		Для Каждого СтрокаПравилМодификаторов Из ПравилаМодификаторов.Строки.НайтиСтроки(Новый Структура("Актуальность", Истина), Истина) Цикл 
			Запись = НаборЗаписей.Добавить();
			ЗаполнитьЗначенияСвойств(Запись, СтрокаПравилМодификаторов);
			Запись.Номенклатура = Ссылка.Ссылка;
		КонецЦикла; 

		Попытка
			НаборЗаписей.Записать(Истина);
		Исключение
			// ERR
			Отказ = Истина;
		КонецПопытки;
	
	КонецЕсли; 
	
КонецПроцедуры // УстановитьПравилаМодификаторов()


Процедура ПередЗаписьюНабораЗаписей(НаборЗаписей, Отказ, Замещение) Экспорт

	// При обмене данными ничего не проверяем.
	Если НаборЗаписей.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Наследование.
	Если Не Отказ Тогда
		Если Не НаборЗаписей.ДополнительныеСвойства.Свойство("ПредотвратитьРегистрациюПравилаИспользования") Тогда
			Если НаборЗаписей.Отбор.Номенклатура.Использование И НаборЗаписей.Отбор.Номенклатура.Значение.ЭтоГруппа Тогда
				УстановитьПривилегированныйРежим(Истина);
			
				Имя = __ОбщегоНазначенияСервер.Метаданные(НаборЗаписей).Имя;
			
				Запрос = Новый Запрос("ВЫБРАТЬ
				                      |	ТаблицаПравилаИспользования.Номенклатура КАК Номенклатура,
				                      |	ТаблицаПравилаИспользования.Модификатор КАК Модификатор,
				                      |	ТаблицаПравилаИспользования.Актуальность КАК Актуальность
				                      |ПОМЕСТИТЬ ТаблицаПравилаИспользования
				                      |ИЗ
				                      |	&ТаблицаПравилаИспользования КАК ТаблицаПравилаИспользования
				                      |;
				                      |
				                      |////////////////////////////////////////////////////////////////////////////////
				                      |ВЫБРАТЬ
				                      |	ВложенныйЗапрос.Номенклатура,
				                      |	ВложенныйЗапрос.Модификатор,
				                      |	ВложенныйЗапрос.АктуальностьНового КАК Актуальность
				                      |ИЗ
				                      |	(ВЫБРАТЬ
				                      |		ВложенныйЗапрос.Номенклатура КАК Номенклатура,
				                      |		ВложенныйЗапрос.Модификатор КАК Модификатор,
				                      |		ЕСТЬNULL(ВложенныйЗапрос.АктуальностьЭлемента, ЛОЖЬ) КАК АктуальностьЭлемента,
				                      |		ЕСТЬNULL(ВложенныйЗапрос.АктуальностьРодителя, ЛОЖЬ) КАК АктуальностьРодителя,
				                      |		ЕСТЬNULL(ВложенныйЗапрос.АктуальностьНового, ЛОЖЬ) КАК АктуальностьНового
				                      |	ИЗ
				                      |		(ВЫБРАТЬ
				                      |			ВложенныйЗапрос.Номенклатура КАК Номенклатура,
				                      |			ВложенныйЗапрос.Модификатор КАК Модификатор,
				                      |			МАКСИМУМ(ВложенныйЗапрос.АктуальностьЭлемента) КАК АктуальностьЭлемента,
				                      |			МАКСИМУМ(ВложенныйЗапрос.АктуальностьРодителя) КАК АктуальностьРодителя,
				                      |			МАКСИМУМ(ВложенныйЗапрос.АктуальностьНового) КАК АктуальностьНового
				                      |		ИЗ
				                      |			(ВЫБРАТЬ
				                      |				МодификаторыНоменклатуры.Номенклатура КАК Номенклатура,
				                      |				МодификаторыНоменклатуры.Модификатор КАК Модификатор,
				                      |				МодификаторыНоменклатуры.Актуальность КАК АктуальностьЭлемента,
				                      |				NULL КАК АктуальностьРодителя,
				                      |				NULL КАК АктуальностьНового
				                      |			ИЗ
				                      |				РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
				                      |			ГДЕ
				                      |				МодификаторыНоменклатуры.Номенклатура.Родитель = &Номенклатура
				                      |				И (МодификаторыНоменклатуры.Модификатор = &Модификатор
				                      |						ИЛИ &Модификатор = ЗНАЧЕНИЕ(Справочник.МодификаторыНоменклатуры.ПустаяСсылка))
				                      |			
				                      |			ОБЪЕДИНИТЬ ВСЕ
				                      |			
				                      |			ВЫБРАТЬ
				                      |				НоменклатураПодчиненная.Ссылка,
				                      |				МодификаторыНоменклатуры.Модификатор,
				                      |				NULL,
				                      |				МодификаторыНоменклатуры.Актуальность,
				                      |				NULL
				                      |			ИЗ
				                      |				РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
				                      |					ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК НоменклатураПодчиненная
				                      |					ПО МодификаторыНоменклатуры.Номенклатура = НоменклатураПодчиненная.Родитель
				                      |			ГДЕ
				                      |				МодификаторыНоменклатуры.Номенклатура = &Номенклатура
				                      |				И (МодификаторыНоменклатуры.Модификатор = &Модификатор
				                      |						ИЛИ &Модификатор = ЗНАЧЕНИЕ(Справочник.МодификаторыНоменклатуры.ПустаяСсылка))
				                      |			
				                      |			ОБЪЕДИНИТЬ ВСЕ
				                      |			
				                      |			ВЫБРАТЬ
				                      |				НоменклатураПодчиненная.Ссылка,
				                      |				МодификаторыНоменклатуры.Модификатор,
				                      |				NULL,
				                      |				NULL,
				                      |				МодификаторыНоменклатуры.Актуальность
				                      |			ИЗ
				                      |				ТаблицаПравилаИспользования КАК МодификаторыНоменклатуры
				                      |					ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК НоменклатураПодчиненная
				                      |					ПО МодификаторыНоменклатуры.Номенклатура = НоменклатураПодчиненная.Родитель) КАК ВложенныйЗапрос
				                      |		
				                      |		СГРУППИРОВАТЬ ПО
				                      |			ВложенныйЗапрос.Номенклатура,
				                      |			ВложенныйЗапрос.Модификатор) КАК ВложенныйЗапрос) КАК ВложенныйЗапрос
				                      |ГДЕ
				                      |	ВложенныйЗапрос.АктуальностьЭлемента = ВложенныйЗапрос.АктуальностьРодителя
				                      |	И (НЕ ВложенныйЗапрос.АктуальностьЭлемента = ВложенныйЗапрос.АктуальностьНового)
				                      |;
				                      |
				                      |////////////////////////////////////////////////////////////////////////////////
				                      |УНИЧТОЖИТЬ ТаблицаПравилаИспользования");
			    Запрос.УстановитьПараметр("Номенклатура", НаборЗаписей.Отбор.Номенклатура.Значение);
				
				Если (Имя = "СопутствующаяНоменклатура") Тогда
					Запрос.Текст = СтрЗаменить(СтрЗаменить(СтрЗаменить(Запрос.Текст, "МодификаторыНоменклатуры", "СопутствующаяНоменклатура"),
																					 "Модификатор", "Сопутствующая"),
																					 "Справочник.СопутствующаяНоменклатура.ПустаяСсылка", "Справочник.Номенклатура.ПустаяСсылка");
				    Запрос.УстановитьПараметр("Сопутствующая", НаборЗаписей.Отбор.Сопутствующая.Значение);
				    Запрос.УстановитьПараметр("ТаблицаПравилаИспользования", НаборЗаписей.Выгрузить( , "Номенклатура,Сопутствующая,Актуальность"));
				ИначеЕсли (Имя = "УсловияНоменклатуры") Тогда
					Запрос.Текст = СтрЗаменить(СтрЗаменить(Запрос.Текст, "МодификаторыНоменклатуры", "УсловияНоменклатуры"),
																		 "Модификатор", "Условия");
				    Запрос.УстановитьПараметр("Условия", НаборЗаписей.Отбор.Условия.Значение);
				    Запрос.УстановитьПараметр("ТаблицаПравилаИспользования", НаборЗаписей.Выгрузить( , "Номенклатура,Условия,Актуальность"));
				Иначе
				    Запрос.УстановитьПараметр("Модификатор", НаборЗаписей.Отбор.Модификатор.Значение);
				    Запрос.УстановитьПараметр("ТаблицаПравилаИспользования", НаборЗаписей.Выгрузить( , "Номенклатура,Модификатор,Актуальность"));
				КонецЕсли; 
				
				ТаблицаПравилаИспользования = Запрос.Выполнить().Выгрузить();
				Если ТаблицаПравилаИспользования.Количество() Тогда
					НаборЗаписей.ДополнительныеСвойства.Вставить("РегистрацияПравилаИспользования", ТаблицаПравилаИспользования);
				КонецЕсли; 
			
				УстановитьПривилегированныйРежим(Ложь);
			КонецЕсли; 
		КонецЕсли;
		НаборЗаписей.ДополнительныеСвойства.Удалить("ПредотвратитьРегистрациюПравилаИспользования");
	КонецЕсли; 	
	
КонецПроцедуры // ПередЗаписьюНабораЗаписей()

Процедура ПриЗаписиНабораЗаписей(НаборЗаписей, Отказ, Замещение) Экспорт
	
	Перем ТаблицаПравилаИспользования;

	// При обмене данными ничего не проверяем.
	Если НаборЗаписей.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Наследование.
	Если Не Отказ Тогда
		Если НаборЗаписей.ДополнительныеСвойства.Свойство("РегистрацияПравилаИспользования", ТаблицаПравилаИспользования) Тогда
			НаборЗаписей.ДополнительныеСвойства.Удалить("РегистрацияПравилаИспользования");
			УстановитьПривилегированныйРежим(Истина);
			
			Имя = __ОбщегоНазначенияСервер.Метаданные(НаборЗаписей).Имя;
			
			Для Каждого СтрокаТаблицыПравилИспользования Из ТаблицаПравилаИспользования Цикл
				Запись = РегистрыСведений[Имя].СоздатьМенеджерЗаписи();
				ЗаполнитьЗначенияСвойств(Запись, СтрокаТаблицыПравилИспользования);
				Попытка
					Если Запись.Актуальность Тогда
						Запись.Записать(Истина);
					Иначе
						Запись.Удалить();
					КонецЕсли;
				Исключение
					Отказ = Истина;	// ERR
					Прервать;
				КонецПопытки;
			КонецЦикла; 
		
			УстановитьПривилегированныйРежим(Ложь);
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры // ПриЗаписиНабораЗаписей()

//Костенюк Александр-Старт 05.11.2012
// Функция получает список модификаторов номенклатуры
// 
// Параметры:
// Ссылка - Тип: СправочникОбъект.Номенклатура.
// Родитель - Тип: СправочникОбъект.Номенклатура.
// Объект - Тип: СправочникОбъект.Номенклатура.
// Регистр - Тип: Строка.
//
// Возвращаемое значение:
// ПравилаМодификаторов - Тип: ДеревоЗначений. 
//
Функция ПолучитьСписокМодификаторов(Ссылка, Родитель, Объект, Регистр = "МодификаторыНоменклатуры") Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	МодификаторыНоменклатуры.Ссылка КАК Модификатор,
	               |	МодификаторыНоменклатуры.Актуальность КАК АктуальностьСправочника,
	               |	ВЫБОР
	               |		КОГДА &РодительТекущий = &РодительНовый
	               |			ТОГДА ЕСТЬNULL(МодификаторыНоменклатурыЭлемент.Актуальность, ЛОЖЬ)
	               |		ИНАЧЕ ВЫБОР
	               |				КОГДА ЕСТЬNULL(МодификаторыНоменклатурыЭлемент.Актуальность, ЛОЖЬ) = ЕСТЬNULL(МодификаторыНоменклатурыРодительТекущий.Актуальность, ЛОЖЬ)
	               |					ТОГДА ЕСТЬNULL(МодификаторыНоменклатурыРодительНовый.Актуальность, ЛОЖЬ)
	               |				ИНАЧЕ ЕСТЬNULL(МодификаторыНоменклатурыЭлемент.Актуальность, ЛОЖЬ)
	               |			КОНЕЦ
	               |	КОНЕЦ КАК Актуальность,
	               |	ВЫБОР
	               |		КОГДА МодификаторыНоменклатуры.ЭтоГруппа
	               |			ТОГДА 2
	               |		ИНАЧЕ 0
	               |	КОНЕЦ + ВЫБОР
	               |		КОГДА МодификаторыНоменклатуры.ПометкаУдаления
	               |			ТОГДА 1
	               |		ИНАЧЕ 0
	               |	КОНЕЦ КАК ИндексКартинки
	               |ИЗ
	               |	Справочник.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатурыЭлемент
	               |		ПО (МодификаторыНоменклатурыЭлемент.Номенклатура = &Номенклатура)
	               |			И (МодификаторыНоменклатурыЭлемент.Модификатор = МодификаторыНоменклатуры.Ссылка)
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатурыРодительТекущий
	               |		ПО (МодификаторыНоменклатурыРодительТекущий.Номенклатура = &РодительТекущий)
	               |			И (МодификаторыНоменклатурыРодительТекущий.Модификатор = МодификаторыНоменклатуры.Ссылка)
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатурыРодительНовый
	               |		ПО (МодификаторыНоменклатурыРодительНовый.Номенклатура = &РодительНовый)
	               |			И (МодификаторыНоменклатурыРодительНовый.Модификатор = МодификаторыНоменклатуры.Ссылка)
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Модификатор ИЕРАРХИЯ
	               |АВТОУПОРЯДОЧИВАНИЕ";
	Запрос.УстановитьПараметр("Номенклатура", Ссылка.Ссылка);
	Запрос.УстановитьПараметр("РодительТекущий", Ссылка.Ссылка.Родитель);
	Запрос.УстановитьПараметр("РодительНовый", Родитель);
	
	Если (Регистр = "СопутствующаяНоменклатура") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.МодификаторыНоменклатуры", "Справочник.Номенклатура");
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.МодификаторыНоменклатуры", "Справочник." + Регистр);
	КонецЕсли; 
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрСведений.МодификаторыНоменклатуры", "РегистрСведений." + Регистр);
	Если (Регистр = "СопутствующаяНоменклатура") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Ссылка КАК Модификатор", ".Ссылка КАК Сопутствующая");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Актуальность КАК АктуальностьСправочника", ".ПометкаУдаления КАК АктуальностьСправочника");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Модификатор", ".Сопутствующая");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Модификатор ИЕРАРХИЯ", "Сопутствующая ИЕРАРХИЯ");
	ИначеЕсли (Регистр = "УсловияНоменклатуры") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Ссылка КАК Модификатор", ".Ссылка КАК Условия");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ".Модификатор", ".Условия");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Модификатор ИЕРАРХИЯ", "Условия ИЕРАРХИЯ");
	КонецЕсли; 
	
	ПравилаМодификаторов = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	Возврат ПравилаМодификаторов;

КонецФункции
//Костенюк Александр-Финиш 05.11.2012
