﻿
Процедура ДобавитьСообщение(Получатель, Документ, Сообщение) Экспорт
	
	// Получатели.
	МассивПолучателей = Новый Массив;
	Если (ТипЗнч(Получатель.Ссылка) = Тип("СправочникСсылка.ГруппыПользователей")) Тогда
		Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		                      |	ГруппыПользователей.Пользователь КАК Получатель
		                      |ИЗ
		                      |	РегистрСведений.ГруппыПользователей КАК ГруппыПользователей
		                      |ГДЕ
		                      |	(НЕ ГруппыПользователей.Пароль = &ПустаяСтрока)");
		Запрос.УстановитьПараметр("ПустаяСтрока", Строка(Неопределено));
		Выборка = Запрос.Выполнить().Выбрать();
		
		Пока Выборка.Следующий() Цикл
			МассивПолучателей.Добавить(Выборка.Получатель);
		КонецЦикла;
		
	Иначе
		МассивПолучателей.Добавить(Получатель.Ссылка);
	КонецЕсли;
	Если Не Булево(МассивПолучателей.Количество()) Тогда
		Возврат;
	КонецЕсли;
		
	// Запись сообщений.
	НачатьТранзакцию();
	
	ТипРабочигоЦентра = Тип("СправочникСсылка.РабочиеЦентры");
	Для Каждого ЭлементПолучателей Из МассивПолучателей Цикл
		
		Если (ТипЗнч(ЭлементПолучателей) = ТипРабочигоЦентра) Тогда
			ДобавитьСообщениеПечатное(ЭлементПолучателей, Документ, Сообщение);
		Иначе
			ДобавитьСообщениеТекстовое(ЭлементПолучателей, Документ, Сообщение);
		КонецЕсли;
		
	КонецЦикла;
	
	ЗафиксироватьТранзакцию();
	
КонецПроцедуры // ДобавитьСообщение()

Процедура ДобавитьСообщениеТекстовое(Получатель, Документ, Сообщение)
	
	// Документ.
	Если (ТипЗнч(Получатель) = Тип("ДокументСсылка.РеализацияТоваровУслуг")) Тогда
		Документ = Получатель; Получатель = Документ.Ответственный;
	КонецЕсли;
	Если ЗначениеЗаполнено(Документ) Тогда
		Получатель = Документ.Сотрудник;
	КонецЕсли;
	
	// Запись сообщения.
	Запись = РегистрыСведений.__СостоянияСообщенийПользователей.СоздатьМенеджерЗаписи();
	Запись.Идентификатор = Новый УникальныйИдентификатор;
	Запись.Получатель = Получатель;
	Запись.Сообщение = Сообщение;
	Запись.Документ = Документ;
	Запись.Записать();
	
КонецПроцедуры // ДобавитьСообщениеТекстовое()

Процедура ДобавитьСообщениеПечатное(Получатель, Документ, Сообщение)
	
	// Документ.
	Если (ТипЗнч(Получатель) = Тип("ДокументСсылка.РеализацияТоваровУслуг")) Тогда
		Документ = Получатель; Получатель = Документ.Сотрудник;
	КонецЕсли;
	
КонецПроцедуры // ДобавитьСообщениеПечатное()

Процедура ПодтвердитьСообщение(Идентификатор) Экспорт
	
	Запись = РегистрыСведений.__СостоянияСообщенийПользователей.СоздатьМенеджерЗаписи();
	Запись.Идентификатор = Идентификатор;
	Запись.Прочитать();
	
	Если Запись.Выбран() И (Не Запись.Прочитано) Тогда
		Запись.Прочитано = Истина;
		Попытка
			Запись.Записать();
		Исключение
			// TODO
		КонецПопытки;
	КонецЕсли;

КонецПроцедуры // ПодтвердитьСообщение()


Функция ПолучитьСообщения() Экспорт
	
	ТаблицаРезультата = Новый ТаблицаЗначений;
	ТаблицаРезультата.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("УникальныйИдентификатор"));
	ТаблицаРезультата.Колонки.Добавить("Документ", Новый ОписаниеТипов("ДокументСсылка.РеализацияТоваровУслуг,Число"));
	ТаблицаРезультата.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	ТаблицаРезультата.Колонки.Добавить("Сообщение", Новый ОписаниеТипов("Строка"));
	ТаблицаРезультата.Колонки.Добавить("Дата", Новый ОписаниеТипов("Строка"));
	
	// Получение данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	__СостоянияСообщенийПользователей.Идентификатор,
	                      |	__СостоянияСообщенийПользователей.Сообщение,
	                      |	__СостоянияСообщенийПользователей.Получено,
	                      |	__СостоянияСообщенийПользователей.ДатаНачалаПериода КАК ДатаНачалаПериода,
	                      |	__СостоянияСообщенийПользователей.Документ КАК Ссылка,
	                      |	__СостоянияСообщенийПользователей.Документ.Модуль КАК Модуль,
	                      |	__СостоянияСообщенийПользователей.Документ.Номер КАК Номер,
	                      |	__СостоянияСообщенийПользователей.Документ.Дата КАК Дата,
	                      |	__СостоянияСообщенийПользователей.Документ.ПолныйНомерСтола КАК ПолныйНомерСтола
	                      |ИЗ
	                      |	РегистрСведений.__СостоянияСообщенийПользователей КАК __СостоянияСообщенийПользователей
	                      |ГДЕ
	                      |	(НЕ __СостоянияСообщенийПользователей.Прочитано)
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ДатаНачалаПериода,
	                      |	__СостоянияСообщенийПользователей.Сообщение");
	РузультатЗапроса = Запрос.Выполнить();
	
	Если Не РузультатЗапроса.Пустой() Тогда
		
		// Запись данных.
		НачатьТранзакцию();
		
		Запись = СоздатьМенеджерЗаписи();
		
		Выборка = РузультатЗапроса.Выбрать(); Пока Выборка.Следующий() Цикл
			
			// Установка признака получения.
			Если Не Выборка.Получено Тогда
				Запись.Идентификатор = Выборка.Идентификатор;
				Запись.Прочитать();
				Если Запись.Выбран() Тогда
					Попытка
						Запись.Получено = Истина;
						Запись.Записать();
					Исключение
						ОтменитьТранзакцию(); ВызватьИсключение;
					КонецПопытки;
				КонецЕсли;
			КонецЕсли;
			
			// Выборка данных.
			СтрокаТаблицы = ТаблицаРезультата.Добавить();
			СтрокаТаблицы.Идентификатор = Выборка.Идентификатор;
			Если ЗначениеЗаполнено(Выборка.Ссылка) Тогда
				СтрокаТаблицы.Документ = Выборка.Ссылка;
				СтрокаТаблицы.Представление = __ПередачаДанныхСервер.ПолучитьПредставлениеДокумента(Выборка);
			КонецЕсли;
			СтрокаТаблицы.Сообщение = Выборка.Сообщение;
			СтрокаТаблицы.Дата = __ПередачаДанныхСервер.ПолучитьПредставлениеДаты(Выборка.ДатаНачалаПериода);
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	КонецЕсли;
	
	// Результат.
	Возврат ТаблицаРезультата;
	
КонецФункции // ПолучитьСообщения()

Процедура УдалитьСообщения() Экспорт
	
КонецПроцедуры // УдалитьСообщения()


Процедура ПередЗаписьюДокумента(Документ, Отказ, РежимЗаписи) Экспорт
	
	Если Не Отказ Тогда
		
		Если ЗначениеЗаполнено(Документ.Ссылка) И ЗначениеЗаполнено(Документ.Сотрудник) И (Не Документ.Сотрудник = Документ.Ссылка.Сотрудник) Тогда
			
			Запрос = Новый Запрос("ВЫБРАТЬ
			                      |	__СостоянияСообщенийПользователей.Идентификатор
			                      |ИЗ
			                      |	РегистрСведений.__СостоянияСообщенийПользователей КАК __СостоянияСообщенийПользователей
			                      |ГДЕ
			                      |	(НЕ __СостоянияСообщенийПользователей.Прочитано)
			                      |	И __СостоянияСообщенийПользователей.Документ = &Документ");
			Запрос.УстановитьПараметр("Документ", Документ.Ссылка);
			РезультатЗапроса = Запрос.Выполнить();
			
			Если Не РезультатЗапроса.Пустой() Тогда
				Запись = СоздатьМенеджерЗаписи();
				
				Выборка = РезультатЗапроса.Выбрать();
				Пока Выборка.Следующий() Цикл
					Запись.Идентификатор = Выборка.Идентификатор;
					Запись.Прочитать();
					Если Запись.Выбран() И (Не Запись.Прочитано) Тогда // Прочитанные игнорируются, как неактуальные.
						Запись.Получатель = Документ.Сотрудник;
						Запись.Получено = Ложь;
						Попытка
							Запись.Записать();
						Исключение
							Отказ = Истина; Прервать; // TDOD
						КонецПопытки;
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
		
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры // ПередЗаписьюДокумента()
