﻿
Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	// Пользователь.
	Если Параметры.Свойство("Пользователь") Тогда
		
		СтандартнаяОбработка = Ложь; ДанныеВыбора = Новый СписокЗначений;
		
		УстановитьПривилегированныйРежим(Истина);
		
		Запрос = Новый Запрос("ВЫБРАТЬ
		                      |	ГруппыПользователей.ГруппаПользователей КАК Значение,
		                      |	ГруппыПользователей.ГруппаПользователей.ПометкаУдаления КАК ПометкаУдаления,
		                      |	ГруппыПользователей.ГруппаПользователей.Наименование КАК Наименование,
		                      |	ГруппыПользователей.ГруппаПользователей.Код КАК Код,
		                      |	ВЫБОР
		                      |		КОГДА ГруппыПользователей.ГруппаПользователей.Наименование ПОДОБНО &СтрокаПоиска
		                      |			ТОГДА ИСТИНА
		                      |		ИНАЧЕ ЛОЖЬ
		                      |	КОНЕЦ КАК НайденоПоНаименованию
		                      |ИЗ
		                      |	РегистрСведений.ГруппыПользователей КАК ГруппыПользователей
		                      |ГДЕ
		                      |	ГруппыПользователей.Пользователь = &Пользователь
		                      |	И (ГруппыПользователей.ГруппаПользователей.Наименование ПОДОБНО &СтрокаПоиска
		                      |			ИЛИ ГруппыПользователей.ГруппаПользователей.Код ПОДОБНО &СтрокаПоиска)
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	ГруппыПользователей.ГруппаПользователей.Наименование");
	    Запрос.УстановитьПараметр("СтрокаПоиска", Параметры.СтрокаПоиска + "%");
	    Запрос.УстановитьПараметр("Пользователь", Параметры.Пользователь);
		Выборка = Запрос.Выполнить().Выбрать();
		
		Пока Выборка.Следующий() Цикл
			
			Значение = Новый Структура("Значение,ПометкаУдаления"); ЗаполнитьЗначенияСвойств(Значение, Выборка);
			Если Выборка.НайденоПоНаименованию Тогда
				Представление = СокрП(Выборка.Наименование) + " " + "(" + СокрП(Выборка.Код) + ")";
			Иначе
				Представление = СокрП(Выборка.Код) + " " + "(" + СокрП(Выборка.Наименование) + ")";
			КонецЕсли;
			
		    ДанныеВыбора.Добавить(Значение, Представление);
		КонецЦикла;
		
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли;
	
КонецПроцедуры // ОбработкаПолученияДанныхВыбора()


Функция ОсновнаяГруппаПользователей() Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	                      |	ГруппыПользователей.Ссылка
	                      |ИЗ
	                      |	(ВЫБРАТЬ ПЕРВЫЕ 1
	                      |		ГруппыПользователей.Ссылка КАК Ссылка,
	                      |		ГруппыПользователей.Ранг КАК Ранг
	                      |	ИЗ
	                      |		(ВЫБРАТЬ
	                      |			Пользователи.ГруппаПользователей КАК Ссылка,
	                      |			КОЛИЧЕСТВО(Пользователи.Пользователь) КАК Ранг
	                      |		ИЗ
	                      |			РегистрСведений.ГруппыПользователей КАК Пользователи
	                      |		
	                      |		СГРУППИРОВАТЬ ПО
	                      |			Пользователи.ГруппаПользователей) КАК ГруппыПользователей
	                      |	
	                      |	ОБЪЕДИНИТЬ ВСЕ
	                      |	
	                      |	ВЫБРАТЬ ПЕРВЫЕ 1
	                      |		ГруппыПользователей.Ссылка,
	                      |		-1
	                      |	ИЗ
	                      |		Справочник.ГруппыПользователей КАК ГруппыПользователей
	                      |	
	                      |	УПОРЯДОЧИТЬ ПО
	                      |		Ранг УБЫВ,
	                      |		Ссылка) КАК ГруппыПользователей
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ГруппыПользователей.Ранг УБЫВ,
	                      |	ГруппыПользователей.Ссылка.ПометкаУдаления,
	                      |	ГруппыПользователей.Ссылка.Наименование");
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Справочники.ГруппыПользователей.ПустаяСсылка();

КонецФункции // ОсновнаяГруппаПользователей()
