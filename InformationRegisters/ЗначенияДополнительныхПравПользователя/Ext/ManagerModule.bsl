﻿
Процедура ПолучитьПраваПользователей(Ссылка, Объект) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ПраваПользователейСтруктура.Ссылка КАК Право,
	                      |	ПраваПользователейСтруктура.ТипЗначения,
	                      |	ЛОЖЬ КАК ТипЗначенияБулево,
	                      |	ЗначенияДополнительныхПравПользователяЗначения.Значение,
	                      |	ЗначенияДополнительныхПравПользователяЗначения.Значение КАК Флажок,
	                      |	ВЫБОР
	                      |		КОГДА ЗначенияДополнительныхПравПользователяЗначения.Право ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК Актуальность,
	                      |	ПраваПользователейСтруктура.ЭтоГруппа КАК ТолькоПросмотр,
	                      |	ВЫБОР
	                      |		КОГДА ПраваПользователейСтруктура.ЭтоГруппа
	                      |			ТОГДА 2
	                      |		ИНАЧЕ 0
	                      |	КОНЕЦ + ВЫБОР
	                      |		КОГДА ПраваПользователейСтруктура.ПометкаУдаления
	                      |			ТОГДА 1
	                      |		ИНАЧЕ 0
	                      |	КОНЕЦ КАК ИндексКартинки
	                      |ИЗ
	                      |	ПланВидовХарактеристик.ПраваПользователей КАК ПраваПользователейСтруктура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗначенияДополнительныхПравПользователя КАК ЗначенияДополнительныхПравПользователяЗначения
	                      |		ПО (ЗначенияДополнительныхПравПользователяЗначения.Право = ПраваПользователейСтруктура.Ссылка)
	                      |			И (ЗначенияДополнительныхПравПользователяЗначения.Пользователь = &Владелец)
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ПраваПользователейСтруктура.Ссылка ИЕРАРХИЯ
	                      |АВТОУПОРЯДОЧИВАНИЕ");
	Если (Ссылка = Неопределено) Тогда
		Запрос.УстановитьПараметр("Владелец", Ссылка);
	Иначе
		Запрос.УстановитьПараметр("Владелец", Ссылка.Ссылка);
	КонецЕсли;
	
	ПраваПользователей = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	// Булевый тип.
	Для Каждого СтрокаПрав Из ПраваПользователей.Строки.НайтиСтроки(Новый Структура("ТолькоПросмотр,ТипЗначения", Ложь, Новый ОписаниеТипов("Булево")), Истина) Цикл
		СтрокаПрав.ТипЗначенияБулево = Истина;
	КонецЦикла; 
	
	ЗначениеВДанныеФормы(ПраваПользователей, Объект);	

	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры // ПолучитьПраваПользователей()

Процедура УстановитьПраваПользователей(Ссылка, Объект, Отказ) Экспорт

	Если Не Отказ Тогда

		УстановитьПривилегированныйРежим(Истина);
		
		ПраваПользователей = ДанныеФормыВЗначение(Объект, Тип("ДеревоЗначений"));
		
		НаборЗаписей = РегистрыСведений.ЗначенияДополнительныхПравПользователя.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Пользователь.Установить(Ссылка.Ссылка);
		
		// Актуальные.
		Для Каждого СтрокаПравДоступа Из ПраваПользователей.Строки.НайтиСтроки(Новый Структура("Актуальность,ТолькоПросмотр", Истина, Ложь), Истина) Цикл 
			Запись = НаборЗаписей.Добавить();
			ЗаполнитьЗначенияСвойств(Запись, СтрокаПравДоступа);
			Запись.Пользователь = Ссылка.Ссылка;
		КонецЦикла; 

		Попытка
			НаборЗаписей.Записать(Истина);
		Исключение
			// TODO: Регистрация ошибки.
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось изменить права'; uk = 'Не вдалося змінити права'"), ,, "ДополнительныеПраваПользователей", Отказ);
		КонецПопытки;

		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли; 
	
КонецПроцедуры // УстановитьПраваПользователей()


Функция ПолучитьПрисутсвиеПравПользователей(Ссылка) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	ЗначенияДополнительныхПравПользователя.Право
	                      |ИЗ
	                      |	РегистрСведений.ЗначенияДополнительныхПравПользователя КАК ЗначенияДополнительныхПравПользователя
	                      |ГДЕ
	                      |	ЗначенияДополнительныхПравПользователя.Пользователь = &Владелец");
	Запрос.УстановитьПараметр("Владелец", Ссылка.Ссылка);
	
	Результат = Не Запрос.Выполнить().Пустой();

	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
	
КонецФункции // ПолучитьПрисутсвиеПравПользователей()
