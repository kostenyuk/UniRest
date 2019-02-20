﻿
Функция ПолучитьСтолы(Сеанс, Иерархия)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	Столы.Ссылка КАК Ссылка,
	                      |	Столы.Родитель,
	                      |	Столы.ЭтоГруппа КАК ЭтоГруппа,
	                      |	Столы.Код,
	                      |	Столы.Наименование КАК Наименование
	                      |ИЗ
	                      |	Справочник.Столы КАК Столы
	                      |ГДЕ
	                      |	ИСТИНА
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	Ссылка ИЕРАРХИЯ");
						  
	// Иерархия.
	Если Иерархия Тогда
		Обход = ОбходРезультатаЗапроса.ПоГруппировкамСИерархией;
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИСТИНА", "НЕ Столы.ЭтоГруппа");
		Обход = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	// Выборка данных.
	Результат = Запрос.Выполнить().Выгрузить(Обход);
	
	// Результат.
	Возврат __В(Результат);

КонецФункции // ПолучитьСтолы()

Функция ПолучитьКатегорииКонтрагентов(Сеанс, Иерархия)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	КатегорииКонтрагентов.Ссылка,
	                      |	КатегорииКонтрагентов.Родитель,
	                      |	КатегорииКонтрагентов.ЭтоГруппа КАК ЭтоГруппа,
	                      |	КатегорииКонтрагентов.Наименование КАК Наименование
	                      |ИЗ
	                      |	Справочник.КатегорииКонтрагентов КАК КатегорииКонтрагентов
	                      |ГДЕ
	                      |	ИСТИНА
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ЭтоГруппа УБЫВ,
	                      |	Наименование");
						  
	// Иерархия.
	Если Иерархия Тогда
		Обход = ОбходРезультатаЗапроса.ПоГруппировкамСИерархией;
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИСТИНА", "НЕ КатегорииКонтрагентов.ЭтоГруппа");
		Обход = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	// Выборка данных.
	Результат = Запрос.Выполнить().Выгрузить(Обход);
	
	// Результат.
	Возврат __В(Результат);

КонецФункции // ПолучитьКатегорииКонтрагентов()

Функция GetTables(Session, Hierarchy)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	Столы.Ссылка КАК Ссылка,
	                      |	Столы.Родитель,
	                      |	Столы.ЭтоГруппа КАК ЭтоГруппа,
	                      |	Столы.Код КАК Наименование
	                      |ИЗ
	                      |	Справочник.Столы КАК Столы
	                      |ГДЕ
	                      |	ИСТИНА
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ЭтоГруппа УБЫВ,
	                      |	Наименование");
	// Иерархия.
	Если Hierarchy Тогда
		Обход = ОбходРезультатаЗапроса.ПоГруппировкамСИерархией;
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИСТИНА", "НЕ Столы.ЭтоГруппа");
		Обход = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	// Выборка данных.
	Результат = Запрос.Выполнить().Выгрузить(Обход);
	
	// Результат.
	Возврат __В(Результат);

КонецФункции

Функция GetClientsCategories(Session, Hierarchy)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	КатегорииКонтрагентов.Ссылка,
	                      |	КатегорииКонтрагентов.Родитель,
	                      |	КатегорииКонтрагентов.ЭтоГруппа КАК ЭтоГруппа,
	                      |	КатегорииКонтрагентов.Наименование КАК Наименование
	                      |ИЗ
	                      |	Справочник.КатегорииКонтрагентов КАК КатегорииКонтрагентов
	                      |ГДЕ
	                      |	ИСТИНА
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ЭтоГруппа УБЫВ,
	                      |	Наименование");
	// Иерархия.
	Если Hierarchy Тогда
		Обход = ОбходРезультатаЗапроса.ПоГруппировкамСИерархией;
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИСТИНА", "НЕ КатегорииКонтрагентов.ЭтоГруппа");
		Обход = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	// Выборка данных.
	Результат = Запрос.Выполнить().Выгрузить(Обход);
	
	// Результат.
	Возврат __В(Результат);

КонецФункции

//Костенюк Александр-Старт 12.06.2015
Функция GetDocumentsCategories(Session, Hierarchy)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	КатегорииДокументов.Ссылка,
	                      |	КатегорииДокументов.Родитель,
	                      |	КатегорииДокументов.ЭтоГруппа КАК ЭтоГруппа,
	                      |	КатегорииДокументов.Наименование КАК Наименование
	                      |ИЗ
	                      |	Справочник.КатегорииДокументов КАК КатегорииДокументов
	                      |ГДЕ
	                      |	ИСТИНА
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ЭтоГруппа УБЫВ,
	                      |	Наименование");
	// Иерархия.
	Если Hierarchy Тогда
		Обход = ОбходРезультатаЗапроса.ПоГруппировкамСИерархией;
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИСТИНА", "НЕ КатегорииКонтрагентов.ЭтоГруппа");
		Обход = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	// Выборка данных.
	Результат = Запрос.Выполнить().Выгрузить(Обход);
	
	// Результат.
	Возврат __В(Результат);

КонецФункции
//Костенюк Александр-Финиш 12.06.2015