﻿
Функция ПолучитьДанныеСеанса(Идентификатор, Имя, Блокировка = Неопределено) Экспорт
	
	Возврат ПолучитьЗначениеСеанса(Идентификатор, Имя, Истина, Блокировка);
	
КонецФункции // ПолучитьДанныеСеанса()

Функция ПроверитьДанныеСеанса(Идентификатор, Имя) Экспорт
	
	Возврат ПроверитьЗначениеСеанса(Идентификатор, Имя, Истина);
	
КонецФункции // ПроверитьДанныеСеанса()

Процедура ЗаписатьДанныеСеанса(Идентификатор, Имя, Значение) Экспорт

	ЗаписатьЗначениеСеанса(Идентификатор, Имя, Значение, Истина);

КонецПроцедуры // ЗаписатьДанныеСеанса()


Функция ВосстановитьЗначениеСеанса(Идентификатор, Имя) Экспорт
	
	Возврат ПолучитьЗначениеСеанса(Идентификатор, Имя, Ложь);
	
КонецФункции // ВосстановитьЗначениеСеанса()

Процедура СохранитьЗначениеСеанса(Идентификатор, Имя, Значение) Экспорт

	ЗаписатьЗначениеСеанса(Идентификатор, Имя, Значение, Ложь);

КонецПроцедуры // СохранитьЗначениеСеанса()


Процедура ПередатьЗначенияСеансов(ТекущийИдентификатор, НовыйИдентификатор) Экспорт 
	
	УстановитьПривилегированныйРежим(Истина);

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	__ЗначенияСеансовВебСервиса.Идентификатор,
	                      |	__ЗначенияСеансовВебСервиса.Имя,
	                      |	__ЗначенияСеансовВебСервиса.ВнутреннееЗначение
	                      |ИЗ
	                      |	РегистрСведений.__ЗначенияСеансовВебСервиса КАК __ЗначенияСеансовВебСервиса
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.__СостояниеСеансовВебСервиса КАК __СостояниеСеансовВебСервиса
	                      |		ПО __ЗначенияСеансовВебСервиса.Идентификатор = __СостояниеСеансовВебСервиса.Идентификатор");
	Запрос.УстановитьПараметр("Идентификатор", ТекущийИдентификатор);
	РузультатЗапроса = Запрос.Выполнить();
	
	Если Не РузультатЗапроса.Пустой() Тогда
		
		// Передача данных.
		Запись = РегистрыСведений.__ЗначенияСеансовВебСервиса.СоздатьМенеджерЗаписи();
		
		Выборка = РузультатЗапроса.Выбрать(); Пока Выборка.Следующий() Цикл
			Если (Выборка.Идентификатор = ТекущийИдентификатор) Тогда
				
				ЗаполнитьЗначенияСвойств(Запись, Выборка);
				Запись.Прочитать();
				
				Запись.Идентификатор = НовыйИдентификатор;
				
				Попытка
					Запись.Записать(Истина);
				Исключение
					// ERR
				КонецПопытки;
				
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры // ПередатьЗначенияСеансов()

Процедура ОчиститьЗначенияСеансов(Идентификатор = Неопределено, Полностью = Ложь) Экспорт 

	УстановитьПривилегированныйРежим(Истина);

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	__ЗначенияСеансовВебСервиса.Идентификатор,
	                      |	__ЗначенияСеансовВебСервиса.Имя,
	                      |	__ЗначенияСеансовВебСервиса.ВнутреннееЗначение
	                      |ИЗ
	                      |	РегистрСведений.__ЗначенияСеансовВебСервиса КАК __ЗначенияСеансовВебСервиса
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.__СостояниеСеансовВебСервиса КАК __СостояниеСеансовВебСервиса
	                      |		ПО __ЗначенияСеансовВебСервиса.Идентификатор = __СостояниеСеансовВебСервиса.Идентификатор
	                      |ГДЕ
	                      |	(&Полностью
	                      |			ИЛИ __СостояниеСеансовВебСервиса.Идентификатор ЕСТЬ NULL )");
	Запрос.УстановитьПараметр("Полностью", Полностью);
	РузультатЗапроса = Запрос.Выполнить();
	
	Если Не РузультатЗапроса.Пустой() Тогда
		
		// Удаление данных.
		Запись = РегистрыСведений.__ЗначенияСеансовВебСервиса.СоздатьМенеджерЗаписи();
		
		Выборка = РузультатЗапроса.Выбрать(); Пока Выборка.Следующий() Цикл
			Если (Идентификатор = Неопределено) Или (Выборка.Идентификатор = Идентификатор) Тогда
			
				ЗаполнитьЗначенияСвойств(Запись, Выборка);
				Попытка
					Запись.Удалить();
				Исключение
					// ERR
				КонецПопытки;
				
			КонецЕсли; 
		КонецЦикла;
		
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры // ОчиститьСеансы()


Функция ПолучитьЗначениеСеанса(Идентификатор, Имя, Внутреннее, Блокировка = Неопределено)
	
	// Блокировка.
	Если (Не Блокировка = Неопределено) Тогда
		//ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.__ЗначенияСеансовВебСервиса");
		//ЭлементБлокировки.УстановитьЗначение("Идентификатор", Идентификатор);
		//ЭлементБлокировки.УстановитьЗначение("Имя", Имя);
		//ЭлементБлокировки.УстановитьЗначение("ВнутреннееЗначение", Внутреннее);
		//ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		//Блокировка.Заблокировать();
	КонецЕсли;
	
	// Получение значения.
	Запись = РегистрыСведений.__ЗначенияСеансовВебСервиса.СоздатьМенеджерЗаписи();
	Запись.Идентификатор = Идентификатор;
	Запись.Имя = ТРег(Имя);
	Запись.ВнутреннееЗначение = Внутреннее;
	Запись.Прочитать();
	
	// Значение найдено.
	Если Запись.Выбран() Тогда
		Если Запись.Примитивное Тогда
			Возврат Запись.ЗначениеПримитивное;
		Иначе
			Возврат РаспаковатьЗначение(Запись.ЗначениеХранилище);
		КонецЕсли;
	КонецЕсли;
	
	// Пустое значение.
	Возврат Неопределено;
	
КонецФункции // ПолучитьЗначениеСеанса()

Функция ПроверитьЗначениеСеанса(Идентификатор, Имя, Внутреннее)
	
	// Поиск значения.
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	__ЗначенияСеансовВебСервиса.Идентификатор
	                      |ИЗ
	                      |	РегистрСведений.__ЗначенияСеансовВебСервиса КАК __ЗначенияСеансовВебСервиса
	                      |ГДЕ
	                      |	__ЗначенияСеансовВебСервиса.Идентификатор = &Идентификатор
	                      |	И __ЗначенияСеансовВебСервиса.Имя = &Имя
	                      |	И __ЗначенияСеансовВебСервиса.ВнутреннееЗначение = &ВнутреннееЗначение");
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	Запрос.УстановитьПараметр("Имя", Имя);
	Запрос.УстановитьПараметр("ВнутреннееЗначение", Внутреннее);
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции // ПроверитьЗначениеСеанса()

Процедура ЗаписатьЗначениеСеанса(Идентификатор, Имя, Значение, Внутреннее)

	// Примитивные типы.
	ПримитивныеТипы = Новый ОписаниеТипов("Булево,Строка,Дата,Число"); Тип = ТипЗнч(Значение);
	
	// Запись/удаление значения.
	Запись = РегистрыСведений.__ЗначенияСеансовВебСервиса.СоздатьМенеджерЗаписи();
	Запись.Идентификатор = Идентификатор;
	Запись.Имя = ТРег(Имя);
	Запись.ВнутреннееЗначение = Внутреннее;
	Если (Значение = Неопределено) Или (Значение = Null) Тогда
		Запись.Удалить();
	Иначе
		Если ПримитивныеТипы.СодержитТип(Тип) Или
			Метаданные.РегистрыСведений.__ЗначенияСеансовВебСервиса.Ресурсы.ЗначениеПримитивное.Тип.СодержитТип(Тип) Тогда
			Запись.Примитивное = Истина;
			Запись.ЗначениеПримитивное = Значение;
		Иначе
			Запись.Примитивное = Ложь;
			Запись.ЗначениеХранилище = УпаковатьЗначение(Значение, Запись.Документ);
		КонецЕсли;
		Запись.Представление = Значение;
		Запись.Записать(Истина);
	КонецЕсли;
	
КонецПроцедуры // ЗаписатьЗначениеСеанса()

Функция РаспаковатьЗначение(Значение)
	
	// Результат.
	Результат = Значение.Получить();	
	
	// Порядок распаковки.
	Если (ТипЗнч(Результат) = Тип("ФиксированнаяСтруктура")) Тогда
		Обертка = Результат;
		
		ЧтениеXML = Новый ЧтениеFastInfoSet;
		ЧтениеXML.УстановитьДвоичныеДанные(Обертка.Объект);
		
		Результат = ПрочитатьXML(ЧтениеXML);
		
		Для Каждого Элемент Из Обертка.ДополнительныеСвойства Цикл Результат.ДополнительныеСвойства.Вставить(Элемент.Ключ, Элемент.Значение); КонецЦикла;

		Возврат Результат;
	КонецЕсли;
			
	Возврат Результат;
	
КонецФункции // РаспаковатьЗначение()

Функция УпаковатьЗначение(Значение, Документ)
	
	// Упаковываемые типы.
	ОписаниеТипов = Новый ОписаниеТипов("ДокументОбъект.РеализацияТоваровУслуг,ДокументОбъект.СписаниеТоваров");//в конфе нет дока: ,ДокументОбъект.ЗаказПокупателя");
	
	// Порядок упаковки.
	Если ОписаниеТипов.СодержитТип(ТипЗнч(Значение)) Тогда
		ЗаписьXML = Новый ЗаписьFastInfoset;
		ЗаписьXML.УстановитьДвоичныеДанные();
		ЗаписьXML.ЗаписатьОбъявлениеXML();
		ЗаписатьXML(ЗаписьXML, Значение, НазначениеТипаXML.Явное);
		
		ДополнительныеСвойства = Новый Структура("РазделениеСкидок"); ЗаполнитьЗначенияСвойств(ДополнительныеСвойства, Значение.ДополнительныеСвойства);
		
		Обертка = Новый ФиксированнаяСтруктура("Объект,ДополнительныеСвойства", 
			ЗаписьXML.Закрыть(), 
			ДополнительныеСвойства);
			
		Документ = Значение.Ссылка;
		Возврат Новый ХранилищеЗначения(Обертка);
	КонецЕсли;
			
	Документ = Неопределено;
	Возврат Новый ХранилищеЗначения(Значение);
	
КонецФункции // УпаковатьЗначение()
