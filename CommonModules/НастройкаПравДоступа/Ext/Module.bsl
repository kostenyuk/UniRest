﻿
// РежимВключенияПолей: 
//              Истина       - сравниваются только поля из СписокПолей
//              Ложь         - сравниваются поля кроме СписокПолей
//..............Неопределено.- сравниваются все поля
Функция СравнитьТаблицыНаборовЗаписей(ТаблицаЗначений1, ТаблицаЗначений2, РежимВключенияПолей = Неопределено, СписокПолей = "") Экспорт
	
	Если ТипЗнч(ТаблицаЗначений1) <> Тип("ТаблицаЗначений") ИЛИ ТипЗнч(ТаблицаЗначений2) <> Тип("ТаблицаЗначений") Тогда
		Возврат Ложь;
	КонецЕсли; 
	
	Если ТаблицаЗначений1.Количество() <> ТаблицаЗначений2.Количество() Тогда
		Возврат Ложь;
	КонецЕсли; 

	Если ТаблицаЗначений1.Колонки.Количество() <> ТаблицаЗначений2.Колонки.Количество() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Проверим поля
	Для каждого Колонка Из ТаблицаЗначений1.Колонки Цикл
		Если ТаблицаЗначений2.Колонки.Найти(Колонка.Имя) = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла; 
	Для каждого Колонка Из ТаблицаЗначений2.Колонки Цикл
		Если ТаблицаЗначений1.Колонки.Найти(Колонка.Имя) = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла; 
	
	СтруктураСпискаПолей = Новый Структура(СписокПолей);
	// Проверим записи
	Для каждого СтрокаТаблицы Из ТаблицаЗначений1 Цикл
		СтруктураПоиска = Новый Структура;
		Для каждого Колонка Из ТаблицаЗначений1.Колонки Цикл
			Если РежимВключенияПолей = Неопределено или РежимВключенияПолей = СтруктураСпискаПолей.Свойство(Колонка.Имя) Тогда
				СтруктураПоиска.Вставить(Колонка.Имя, СтрокаТаблицы[Колонка.Имя]);
			КонецЕсли;
		КонецЦикла;
		СтрокиТаблицы2 = ТаблицаЗначений2.НайтиСтроки(СтруктураПоиска);
		Если СтрокиТаблицы2.Количество() <> 1 Тогда
			Возврат Ложь;
		КонецЕсли; 
	КонецЦикла;
	
	Для каждого СтрокаТаблицы Из ТаблицаЗначений2 Цикл
		СтруктураПоиска = Новый Структура;
		Для каждого Колонка Из ТаблицаЗначений2.Колонки Цикл
			Если РежимВключенияПолей = Неопределено или РежимВключенияПолей = СтруктураСпискаПолей.Свойство(Колонка.Имя) Тогда
				СтруктураПоиска.Вставить(Колонка.Имя, СтрокаТаблицы[Колонка.Имя]);
			КонецЕсли;
		КонецЦикла;
		СтрокиТаблицы1 = ТаблицаЗначений1.НайтиСтроки(СтруктураПоиска);
		Если СтрокиТаблицы1.Количество() <> 1 Тогда
			Возврат Ложь;
		КонецЕсли; 
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции // СравнитьТаблицыЗначений()

Функция  ПолучитьДополнительноеЗначениеПравАПользователя(Право, Пользователь) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("Право", Право);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЗначенияДополнительныхПравПользователя.Значение
	               |ИЗ
	               |	РегистрСведений.ЗначенияДополнительныхПравПользователя КАК ЗначенияДополнительныхПравПользователя
	               |ГДЕ
	               |	ЗначенияДополнительныхПравПользователя.Пользователь.Ссылка = &Пользователь
	               |	И ЗначенияДополнительныхПравПользователя.Право.Ссылка = &Право";
	
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.Прямой);
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Значение;
	Иначе 
 		Возврат Неопределено;
	КонецЕсли; 
	
КонецФункции
 
// Функция подготовки текста первого запроса, для события записи элемента иерархического справочника 
// используемого в правилах использования или настройках прав доступа пользователей, в случае если у элемента
// изменяется родитель.
//
// Параметры:
//	Источник - Строка. Имя справочника;
//	Регистр - Строка. Имя регистра.
//
// Возвращаемое значение:
//	Строка. Подготовленный текст запроса.
//
// Описание:
//	Задачей первого запроса определить, в разрезе владельцев правил использования или права доступа, необходимость изменения 
//	данных регистра связанных с изменяемым элементом справочника.
//	Изменение состояния происходит по следующему правилу, если
//		Элемент.Актуальность  = Элемент.Родитель.Актуальность
//	тогда
//		Элемент.Актуальность' = Элемент.Родитель'.Актуальность
//	где:
//		Элемент - элемент справочника родитель которого изменяется;
//		Родитель - родитель элемента справочника до изменения;
//		Родитель' - родитель элемента справочника после изменения;
//		Актуальность - состояние элемента справочника (самого элемента, его родитель справочника до изменения или его родителя после изменения);
//		Актуальность' - новое состояния элемента справочника.
//	При этом правило соблюдаются в разрезе владельцев правила или права доступа, 
//	то есть для каждого владельца правил использования или права доступа, независмо.
//
Функция ПодготовитьТекстПервогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник, Регистр)
	
	// Запрос.
	Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	        |	&Ссылка КАК Объект____,
	        |	ВложенныйЗапрос.Владелец____ КАК Владелец____,
	        |	ВложенныйЗапрос.АктуальностьНового КАК Актуальность
	        |ИЗ
	        |	(ВЫБРАТЬ
	        |		ВложенныйЗапрос.Владелец____ КАК Владелец____,
	        |		ВЫБОР
	        |			КОГДА ВложенныйЗапрос.АктуальностьЭлемента ЕСТЬ NULL 
	        |				ТОГДА ИСТИНА
	        |			ИНАЧЕ ВложенныйЗапрос.АктуальностьЭлемента
	        |		КОНЕЦ КАК АктуальностьЭлемента,
	        |		ВЫБОР
	        |			КОГДА ВложенныйЗапрос.АктуальностьРодителя ЕСТЬ NULL 
	        |				ТОГДА ИСТИНА
	        |			ИНАЧЕ ВложенныйЗапрос.АктуальностьРодителя
	        |		КОНЕЦ КАК АктуальностьРодителя,
	        |		ВЫБОР
	        |			КОГДА ВложенныйЗапрос.АктуальностьНового ЕСТЬ NULL 
	        |				ТОГДА ИСТИНА
	        |			ИНАЧЕ ВложенныйЗапрос.АктуальностьНового
	        |		КОНЕЦ КАК АктуальностьНового
	        |	ИЗ
	        |		(ВЫБРАТЬ
	        |			ВложенныйЗапрос.Владелец____ КАК Владелец____,
	        |			МАКСИМУМ(ВложенныйЗапрос.АктуальностьЭлемента) КАК АктуальностьЭлемента,
	        |			МАКСИМУМ(ВложенныйЗапрос.АктуальностьРодителя) КАК АктуальностьРодителя,
	        |			МАКСИМУМ(ВложенныйЗапрос.АктуальностьНового) КАК АктуальностьНового
	        |		ИЗ
	        |			(ВЫБРАТЬ
	        |				ПравилаИспользования.Владелец____ КАК Владелец____,
	        |				ПравилаИспользования.Актуальность КАК АктуальностьЭлемента,
	        |				NULL КАК АктуальностьРодителя,
	        |				NULL КАК АктуальностьНового
	        |			ИЗ
	        |				РегистрСведений.____ КАК ПравилаИспользования
	        |			ГДЕ
	        |				ПравилаИспользования.Объект____ = &Ссылка
	        |			
	        |			ОБЪЕДИНИТЬ ВСЕ
	        |			
	        |			ВЫБРАТЬ
	        |				ПравилаИспользования.Владелец____,
	        |				NULL,
	        |				ПравилаИспользования.Актуальность,
	        |				NULL
	        |			ИЗ
	        |				РегистрСведений.____ КАК ПравилаИспользования
	        |			ГДЕ
	        |				ПравилаИспользования.Объект____ = &РодительСсылки
	        |			
	        |			ОБЪЕДИНИТЬ ВСЕ
	        |			
	        |			ВЫБРАТЬ
	        |				ПравилаИспользования.Владелец____,
	        |				NULL,
	        |				NULL,
	        |				ПравилаИспользования.Актуальность
	        |			ИЗ
	        |				РегистрСведений.____ КАК ПравилаИспользования
	        |			ГДЕ
	        |				ПравилаИспользования.Объект____ = &РодительОбъекта) КАК ВложенныйЗапрос
	        |		
	        |		СГРУППИРОВАТЬ ПО
	        |			ВложенныйЗапрос.Владелец____) КАК ВложенныйЗапрос) КАК ВложенныйЗапрос
	        |ГДЕ
	        |	ВложенныйЗапрос.АктуальностьЭлемента = ВложенныйЗапрос.АктуальностьРодителя
	        |	И (НЕ ВложенныйЗапрос.АктуальностьЭлемента = ВложенныйЗапрос.АктуальностьНового)";
			
	// Модификация.			
	Текст = СтрЗаменить(Текст, "РегистрСведений.____", "РегистрСведений." + Регистр);
	Если (Нрег(Регистр) = "настройкиправдоступапользователей") Тогда
		Текст = СтрЗаменить(Текст, "Объект____", "ОбъектДоступа");
		Текст = СтрЗаменить(Текст, "Владелец____", "ВладелецПравДоступа");
	Иначе
		Текст = СтрЗаменить(Текст, "Объект____", "ОбъектИспользования");
		Текст = СтрЗаменить(Текст, "Владелец____", "ВладелецПравилИспользования");
	КонецЕсли;
	
	Возврат Текст;
	
КонецФункции // ПодготовитьТекстПервогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей()

// Функция подготовки текста второго запроса, для события записи элемента иерархического справочника 
// используемого в правилах использования или настройках прав доступа пользователей, в случае если у элемента
// изменяется родитель и его сотояние изменяется согласно данным первого запроса.
//
// Параметры:
//	Источник - Строка. Имя справочника;
//	Регистр - Строка. Имя регистра.
//
// Возвращаемое значение:
//	Строка. Подготовленный текст запроса.
//
// Описание:
//	Задачей второго запроса определить, в разрезе владельцев правил использования или права доступа, необходимость изменения 
//	данных регистра связанных с подчиненными элементами изменяемого элемента справочника.
//	Изменение состояния происходит по следующему правилу, если
//		ПодчиненныйЭлемент.Актуальность  = ПодчиненныйЭлемент.Родитель.Актуальность
//	тогда
//		ПодчиненныйЭлемент.Актуальность' = Элемент.Актуальность'
//	где:
//		Элемент - элемент справочника родитель которого изменяется;
//		ПодчиненныйЭлемент - подчиненный, в иерархии, элемент элемента справочника родитель которого изменяется;
//		Родитель - родитель подчиненного элемента справочника;
//		Актуальность' - новое состояния элемента справочника, для элемента справочника родитель которого изменяется равно значению определенному в первом запросе.
//	При этом правило соблюдаются в разрезе владельцев правила или права доступа, 
//	то есть для каждого владельца правил использования или права доступа, независмо.
//
Функция ПодготовитьТекстВторогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник, Регистр)
	
	// Запрос.
	Текст =    "ВЫБРАТЬ РАЗРЕШЕННЫЕ
			   |	ВладелецыПравилИспользования.Объект____ КАК Объект____,
			   |	ВладелецыПравилИспользования.Владелец____ КАК Владелец____,
			   |	ВладелецыПравилИспользования.Актуальность КАК Актуальность
			   |ПОМЕСТИТЬ ВременнаяВладелецыПравилИспользования
			   |ИЗ
			   |	&ТаблицаПравилаИспользования КАК ВладелецыПравилИспользования
			   |;
			   |
			   |////////////////////////////////////////////////////////////////////////////////
			   |ВЫБРАТЬ
			   |	ВложенныйЗапрос.Объект____,
			   |	ВложенныйЗапрос.Владелец____,
			   |	ВложенныйЗапрос.Родитель КАК Объект____Родитель,
			   |	ВЫБОР
			   |		КОГДА ПравилаИспользования.Актуальность ЕСТЬ NULL 
			   |			ТОГДА ИСТИНА
			   |		ИНАЧЕ ПравилаИспользования.Актуальность
			   |	КОНЕЦ КАК Актуальность
			   |ПОМЕСТИТЬ ВременнаяПересечениеОбъекты
			   |ИЗ
			   |	(ВЫБРАТЬ
			   |		НоменклатураМеню.Ссылка КАК Объект____,
			   |		ВладелецыПравилИспользования.Владелец____ КАК Владелец____,
			   |		НоменклатураМеню.Родитель КАК Родитель
			   |	ИЗ
			   |		Справочник.____ КАК НоменклатураМеню,
			   |		ВременнаяВладелецыПравилИспользования КАК ВладелецыПравилИспользования
			   |	ГДЕ
			   |		НоменклатураМеню.Ссылка В ИЕРАРХИИ(&Ссылка)) КАК ВложенныйЗапрос
			   |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.____ КАК ПравилаИспользования
			   |		ПО ВложенныйЗапрос.Объект____ = ПравилаИспользования.Объект____
			   |			И ВложенныйЗапрос.Владелец____ = ПравилаИспользования.Владелец____
			   |;
			   |
			   |////////////////////////////////////////////////////////////////////////////////
			   |ВЫБРАТЬ
			   |	ПересечениеОбъекты.Объект____,
			   |	ПересечениеОбъекты.Объект____Родитель,
			   |	ПересечениеОбъекты.Владелец____,
			   |	ПересечениеОбъекты.Актуальность КАК АктуальностьОбъекта,
			   |	ВЫБОР
			   |		КОГДА ПересечениеРодители.Актуальность ЕСТЬ NULL 
			   |			ТОГДА ПересечениеОбъекты.Актуальность
			   |		ИНАЧЕ ПересечениеРодители.Актуальность
			   |	КОНЕЦ КАК АктуальностьРодителя
			   |ПОМЕСТИТЬ ВременнаяПересечениеПравила
			   |ИЗ
			   |	ВременнаяПересечениеОбъекты КАК ПересечениеОбъекты
			   |		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяПересечениеОбъекты КАК ПересечениеРодители
			   |		ПО ПересечениеОбъекты.Объект____Родитель = ПересечениеРодители.Объект____
			   |			И ПересечениеОбъекты.Владелец____ = ПересечениеРодители.Владелец____
			   |;
			   |
			   |////////////////////////////////////////////////////////////////////////////////
			   |ВЫБРАТЬ
			   |	ПересечениеПравила.Объект____,
			   |	ПересечениеПравила.Владелец____
			   |ПОМЕСТИТЬ ВременнаяПересечениеРодители
			   |ИЗ
			   |	ВременнаяПересечениеПравила КАК ПересечениеПравила
			   |ГДЕ
			   |	ПересечениеПравила.АктуальностьОбъекта = ПересечениеПравила.АктуальностьРодителя
			   |;
			   |
			   |////////////////////////////////////////////////////////////////////////////////
			   |ВЫБРАТЬ
			   |	ВременнаяПересечениеПравила.Объект____,
			   |	ВременнаяПересечениеПравила.Владелец____,
			   |	ВременнаяВладелецыПравилИспользования.Актуальность
			   |ИЗ
			   |	ВременнаяПересечениеПравила КАК ВременнаяПересечениеПравила
			   |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВременнаяПересечениеРодители КАК ВременнаяПересечениеРодители
			   |		ПО ВременнаяПересечениеПравила.Объект____Родитель = ВременнаяПересечениеРодители.Объект____
			   |			И ВременнаяПересечениеПравила.Владелец____ = ВременнаяПересечениеРодители.Владелец____
			   |		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяВладелецыПравилИспользования КАК ВременнаяВладелецыПравилИспользования
			   |		ПО ВременнаяПересечениеПравила.Владелец____ = ВременнаяВладелецыПравилИспользования.Владелец____
			   |
			   |ОБЪЕДИНИТЬ ВСЕ
			   |
			   |ВЫБРАТЬ
			   |	ВременнаяВладелецыПравилИспользования.Объект____,
			   |	ВременнаяВладелецыПравилИспользования.Владелец____,
			   |	ВременнаяВладелецыПравилИспользования.Актуальность
			   |ИЗ
			   //|	ВременнаяВладелецыПравилИспользования КАК ВременнаяВладелецыПравилИспользования";
			   //Костенюк Александр-Старт 23.10.2012
			   // Уничтожение временных таблиц
			   |	ВременнаяВладелецыПравилИспользования КАК ВременнаяВладелецыПравилИспользования
			   |;
			   |
			   |////////////////////////////////////////////////////////////////////////////////
			   |УНИЧТОЖИТЬ ВременнаяВладелецыПравилИспользования;
			   |УНИЧТОЖИТЬ ВременнаяПересечениеОбъекты;
			   |УНИЧТОЖИТЬ ВременнаяПересечениеПравила;
			   |УНИЧТОЖИТЬ ВременнаяПересечениеРодители";
			   //Костенюк Александр-Финиш 23.10.2012

			
	// Модификация.			
	Текст = СтрЗаменить(Текст, "Справочник.____", "Справочник." + Источник);
	Текст = СтрЗаменить(Текст, "РегистрСведений.____", "РегистрСведений." + Регистр);
	Если (Нрег(Регистр) = "настройкиправдоступапользователей") Тогда
		Текст = СтрЗаменить(Текст, "Объект____", "ОбъектДоступа");
		Текст = СтрЗаменить(Текст, "Владелец____", "ВладелецПравДоступа");
	Иначе
		Текст = СтрЗаменить(Текст, "Объект____", "ОбъектИспользования");
		Текст = СтрЗаменить(Текст, "Владелец____", "ВладелецПравилИспользования");
	КонецЕсли;
	
	Возврат Текст;
	
КонецФункции // ПодготовитьТекстВторогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей()

Процедура ПередЗаписьюСправочникаРегистрацияПравилИспользования(Источник, Отказ) Экспорт
	
	// Дополнительные свойства.
	ДополнительныеСвойства = Источник.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("РегистрацияПравилИспользования", Неопределено);
	
	// Проверка.
	Если (Не Источник.Метаданные().Иерархический) Или
		 (Не Метаданные.РегистрыСведений.ПравилаИспользования.Измерения.ОбъектИспользования.Тип.СодержитТип(ТипЗнч(Источник.Ссылка))) Тогда
		Возврат;
	КонецЕсли;
	
	// Выборка данных.
	
	// -- Источник.
	Если Источник.ЭтоНовый() Тогда
		Если Источник.Родитель.Пустая() Тогда
			Возврат;
		Иначе
			Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
			                      |	&РодительОбъекта КАК ОбъектИспользования,
			                      |	ПравилаИспользования.ВладелецПравилИспользования КАК ВладелецПравилИспользования,
			                      |	ПравилаИспользования.Актуальность КАК Актуальность
			                      |ИЗ
			                      |	РегистрСведений.ПравилаИспользования КАК ПравилаИспользования
			                      |ГДЕ
			                      |	ПравилаИспользования.ОбъектИспользования = &РодительОбъекта");
		КонецЕсли;							  
	Иначе
		Если (Источник.Родитель = Источник.Ссылка.Родитель) Тогда
			Возврат;
		КонецЕсли;
		//Запрос = Новый Запрос(ПодготовитьТекстПервогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Синоним, "ПравилаИспользования"));
		//Костенюк Александр-Старт 03.10.2012
		// Синоним объекта передавать нельзя, т.к. в дальнейшем идет обращение к объекту через точку
		Запрос = Новый Запрос(ПодготовитьТекстПервогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Имя, "ПравилаИспользования"));
		//Костенюк Александр-Финиш 03.10.2012
	КонецЕсли;
	Запрос.УстановитьПараметр("Ссылка", Источник.Ссылка);
	Запрос.УстановитьПараметр("РодительСсылки", Источник.Ссылка.Родитель);
	Запрос.УстановитьПараметр("РодительОбъекта", Источник.Родитель);
	ТаблицаПравилаИспользования = Запрос.Выполнить().Выгрузить();
	
	// -- Подчиненные объекты. Источник.Метаданные().Синоним
	Если (Не Источник.ЭтоНовый()) И Булево(ТаблицаПравилаИспользования.Количество()) Тогда
		//Запрос.Текст = ПодготовитьТекстВторогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Синоним, "ПравилаИспользования");
		//Костенюк Александр-Старт 25.04.2012
		// Синоним объекта передавать нельзя, т.к. в дальнейшем идет обращение к объекту через точку 
		Запрос.Текст = ПодготовитьТекстВторогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Имя, "ПравилаИспользования");
		//Костенюк Александр-Финиш 25.04.2012
		Запрос.УстановитьПараметр("ТаблицаПравилаИспользования", ТаблицаПравилаИспользования);
		ТаблицаПравилаИспользования = Запрос.Выполнить().Выгрузить();
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("РегистрацияПравилИспользования", ТаблицаПравилаИспользования);
	
КонецПроцедуры // ПередЗаписьюСправочникаРегистрацияПравилИспользования()

Процедура ПриЗаписиСправочникаРегистрацияПравилИспользования(Источник, Отказ) Экспорт
	
	Перем ТаблицаПравилаИспользования;
	
	// Дополнительные свойства.
	ДополнительныеСвойства = Источник.ДополнительныеСвойства;
	
	// Проверка.
	Если (Не ДополнительныеСвойства.Свойство("РегистрацияПравилИспользования", ТаблицаПравилаИспользования)) Или
		 (ТаблицаПравилаИспользования = Неопределено) Или
		 (Не Булево(ТаблицаПравилаИспользования.Количество())) Тогда
		Возврат;
	КонецЕсли;
	
	// Запись данных.
	Ссылка = Источник.Ссылка;
	
	Для Каждого СтрокаТаблицы Из ТаблицаПравилаИспользования Цикл
		
		Запись = РегистрыСведений.ПравилаИспользования.СоздатьМенеджерЗаписи();
		Запись.ОбъектИспользования = СтрокаТаблицы.ОбъектИспользования;
		Запись.ВладелецПравилИспользования = СтрокаТаблицы.ВладелецПравилИспользования;
		
		Попытка
			Если СтрокаТаблицы.Актуальность Тогда
				Запись.Удалить();
			Иначе
				Запись.Записать();
			КонецЕсли;
		Исключение
			ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), Отказ, ,, РегистрыСведений.ПравилаИспользования.СоздатьНаборЗаписей(), Источник);
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры // ПриЗаписиСправочникаРегистрацияПравилИспользования()

Процедура ПередЗаписьюСправочникаРегистрацияНастроекПравДоступаПользователей(Источник, Отказ) Экспорт
	
	// Дополнительные свойства.
	ДополнительныеСвойства = Источник.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("РегистрацияНастроекПравДоступаПользователей", Неопределено);
	
	// Проверка.
	Если (Не Источник.Метаданные().Иерархический) Или
		 (Не Метаданные.РегистрыСведений.НастройкиПравДоступаПользователей.Измерения.ОбъектДоступа.Тип.СодержитТип(ТипЗнч(Источник.Ссылка))) Тогда
		Возврат;
	КонецЕсли;
	
	// Выборка данных.
	
	// -- Источник.
	Если Источник.ЭтоНовый() Тогда
		Если Источник.Родитель.Пустая() Тогда
			Возврат;
		Иначе
			Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
			                      |	&РодительОбъекта КАК ОбъектДоступа,
			                      |	НастройкиПравДоступаПользователей.ВладелецПравДоступа КАК ВладелецПравДоступа,
			                      |	НастройкиПравДоступаПользователей.Актуальность КАК Актуальность
			                      |ИЗ
			                      |	РегистрСведений.НастройкиПравДоступаПользователей КАК НастройкиПравДоступаПользователей
			                      |ГДЕ
			                      |	НастройкиПравДоступаПользователей.ОбъектДоступа = &РодительОбъекта");
		КонецЕсли;							  
	Иначе
		Если (Источник.Родитель = Источник.Ссылка.Родитель) Тогда
			Возврат;
		КонецЕсли;
		Запрос = Новый Запрос(ПодготовитьТекстПервогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Синоним, "НастройкиПравДоступаПользователей"));
	КонецЕсли;
	Запрос.УстановитьПараметр("Ссылка", Источник.Ссылка);
	Запрос.УстановитьПараметр("РодительСсылки", Источник.Ссылка.Родитель);
	Запрос.УстановитьПараметр("РодительОбъекта", Источник.Родитель);
	ТаблицаПравилаИспользования = Запрос.Выполнить().Выгрузить();
	
	// -- Подчиненные объекты. Источник.Метаданные().Синоним
	Если (Не Источник.ЭтоНовый()) И Булево(ТаблицаПравилаИспользования.Количество()) Тогда
		//Запрос.Текст = ПодготовитьТекстВторогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Синоним, "НастройкиПравДоступаПользователей");
		//Костенюк Александр-Старт 12.03.2013
		Запрос.Текст = ПодготовитьТекстВторогоЗапросаРегистрацииПравилИспользованияИНастройкиПравДоступаПользователей(Источник.Метаданные().Имя, "НастройкиПравДоступаПользователей");
		//Костенюк Александр-Финиш 12.03.2013
		Запрос.УстановитьПараметр("ТаблицаПравилаИспользования", ТаблицаПравилаИспользования);
		ТаблицаПравилаИспользования = Запрос.Выполнить().Выгрузить();
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("РегистрацияНастроекПравДоступаПользователей", ТаблицаПравилаИспользования);
	
КонецПроцедуры // ПередЗаписьюСправочникаРегистрацияНастроекПравДоступаПользователей()

Процедура ПриЗаписиСправочникаРегистрацияНастроекПравДоступаПользователей(Источник, Отказ) Экспорт
	
	Перем ТаблицаПравилаИспользования;
	
	// Дополнительные свойства.
	ДополнительныеСвойства = Источник.ДополнительныеСвойства;
	
	// Проверка.
	Если (Не ДополнительныеСвойства.Свойство("РегистрацияНастроекПравДоступаПользователей", ТаблицаПравилаИспользования)) Или
		 (ТаблицаПравилаИспользования = Неопределено) Или
		 (Не Булево(ТаблицаПравилаИспользования.Количество())) Тогда
		Возврат;
	КонецЕсли;
	
	// Запись данных.
	Ссылка = Источник.Ссылка;
	
	Для Каждого СтрокаТаблицы Из ТаблицаПравилаИспользования Цикл
		
		Запись = РегистрыСведений.НастройкиПравДоступаПользователей.СоздатьМенеджерЗаписи();
		Запись.ОбъектДоступа = СтрокаТаблицы.ОбъектДоступа;
		Запись.ВладелецПравДоступа = СтрокаТаблицы.ВладелецПравДоступа;
		
		Попытка
			Если СтрокаТаблицы.Актуальность Тогда
				Запись.Удалить();
			Иначе
				Запись.Записать();
			КонецЕсли;
		Исключение
			ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), Отказ, ,, РегистрыСведений.НастройкиПравДоступаПользователей.СоздатьНаборЗаписей(), Источник);
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры // ПриЗаписиСправочникаРегистрацияНастроекПравДоступаПользователей()



Функция ОпределитьДоступностьВозможностьИзмененияДокументаПоДатеЗапрета(ДокументОбъект, ФормаДокумента) Экспорт
	
	Возможность = Истина;	
	
	// Проверка.
	Если (Не (ДокументОбъект.Проведен Или ДокументОбъект.ПометкаУдаления)) Тогда
		Возврат Возможность;
	КонецЕсли;
	Если (Не ФормаДокумента = Неопределено) И ФормаДокумента.ТолькоПросмотр Тогда
		Возврат Возможность;
	КонецЕсли;
	
	// Полные права.
	Если ПользователиИнформационнойБазы.ТекущийПользователь().Роли.Содержит(Метаданные.Роли.ПолныеПрава) Тогда
		Возврат Возможность;
	КонецЕсли;
	
	// Граница запрета редактирования.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
						  |	ЕСТЬNULL(МАКСИМУМ(ГраницыЗапретаИзмененияДанных.ГраницаЗапретаИзменений), &ТекущаяДата) КАК ГраницаЗапретаИзменений
						  |ИЗ
						  |	РегистрСведений.ГраницыЗапретаИзмененияДанных КАК ГраницыЗапретаИзмененияДанных
						  |ГДЕ
						  |	(ГраницыЗапретаИзмененияДанных.Ресторан = &Ресторан
						  |			ИЛИ (НЕ ИСТИНА В
						  |					(ВЫБРАТЬ ПЕРВЫЕ 1
						  |						ИСТИНА
						  |					ИЗ
						  |						РегистрСведений.ГраницыЗапретаИзмененияДанных КАК ГраницыЗапретаИзмененияДанных
						  |					ГДЕ
						  |						ГраницыЗапретаИзмененияДанных.Ресторан = &Ресторан)))");
	Запрос.УстановитьПараметр("Ресторан", ДокументОбъект.Ресторан);
	Запрос.УстановитьПараметр("ТекущаяДата", НачалоДня(ТекущаяДата())); 
	
	ГраницыЗапретаИзмененияДанных = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ГраницаЗапретаИзменений").Получить(0);
	
	Возможность = (ДокументОбъект.Дата >= ГраницыЗапретаИзмененияДанных);
	
	// Только просмотр.
	Если (Не ФормаДокумента = Неопределено) Тогда
		ФормаДокумента.ТолькоПросмотр = Не Возможность; 
	КонецЕсли;
	
	Возврат Возможность;
	
КонецФункции

Процедура ОпределитьДоступностьВозможностьИзмененияОсновныхПолейОбъекта(Объект, ФормаОбъекта) Экспорт
	
	
КонецПроцедуры

Функция ОпределитьДоступностьВыполненияОтчетаОбработки(ОтчетОбъект) Экспорт

	// Полные права.
	Если ПользователиИнформационнойБазы.ТекущийПользователь().Роли.Содержит(Метаданные.Роли.ПолныеПрава) Тогда
		Возврат Истина;
	КонецЕсли;
	
	// Объект доступа.
	Если (ТипЗнч(ОтчетОбъект) = Тип("ОбъектМетаданных")) Тогда
		МетаданныеОбъекта = ОтчетОбъект;
	Иначе
		МетаданныеОбъекта = ОтчетОбъект.Метаданные();
	КонецЕсли;
	
	Если Метаданные.Обработки.Содержит(МетаданныеОбъекта) Тогда
		ОбъектДоступа = "Обработка." + МетаданныеОбъекта.Имя;
	Иначе
		ОбъектДоступа = "Отчет." + МетаданныеОбъекта.Имя;
	КонецЕсли;
	
	// Проверка.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	НастройкиПравДоступаОтчетов.Выполнение КАК Выполнение
	                      |ИЗ
	                      |	(ВЫБРАТЬ
	                      |		МИНИМУМ(НастройкиПравДоступаОтчетов.Выполнение) КАК Выполнение,
	                      |		КОЛИЧЕСТВО(НастройкиПравДоступаОтчетов.ОбъектДоступа) КАК Количество
	                      |	ИЗ
	                      |		РегистрСведений.НастройкиПравДоступаОтчетов КАК НастройкиПравДоступаОтчетов
	                      |	ГДЕ
	                      |		(НастройкиПравДоступаОтчетов.ВладелецПравДоступа = &ТекущийПользователь
	                      |				ИЛИ НастройкиПравДоступаОтчетов.ВладелецПравДоступа = &ТекущаяГруппаПользователей)
	                      |		И НастройкиПравДоступаОтчетов.ОбъектДоступа = &ОбъектДоступа) КАК НастройкиПравДоступаОтчетов
	                      |ГДЕ
	                      |	НастройкиПравДоступаОтчетов.Количество = 2");
	Запрос.УстановитьПараметр("ОбъектДоступа", ОбъектДоступа);
	Запрос.УстановитьПараметр("ТекущийПользователь", глЗначениеПеременной("глТекущийПользователь"));
	Запрос.УстановитьПараметр("ТекущаяГруппаПользователей", глЗначениеПеременной("глТекущаяГруппаПользователей"));
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать(); Выборка.Следующий();
	
	Возврат (Выборка.Выполнение = Истина);

КонецФункции // ОпределитьДоступностьВыполненияОтчетаОбработки()


//	Процедура установки флага ТолькоПросмотр для поля ввода кода/номера в зависимости от стратегии автонумерации объекта
//
// Параметры
//  МетаданныеОбъекта  - метаданные объекта.
//  ФормаОбъекта      - форма объекта.
//  ПодменюДействия - меню "Действия" командной панели формы. В этот меню должен присутствовать пункт "Редактировать код/номер"
//  ПолеВводаНомера - поле вводе, связанное с кодом/номером объекта
//
Процедура УстановитьДоступностьПоляВводаНомера(МетаданныеОбъекта, ФормаОбъекта, ПодменюДействия, ПолеВводаНомера) Экспорт
	
	// TODO: Реализовать.
	
	//Если ФормаОбъекта.Автонумерация = АвтонумерацияВФорме.Авто Тогда
	//	Возврат;
	//КонецЕсли;	
	//
	//СтратегияРедактирования = ПолучитьСтратегиюРедактированияНомераОбъекта(МетаданныеОбъекта);
	//
	//Если СтратегияРедактирования = Перечисления.СтратегияРедактированияНомеровОбъектов.Доступно Тогда
	//	Если ПодменюДействия.Кнопки.Найти("РедактироватьКодНомер") <> Неопределено Тогда
	//		ПодменюДействия.Кнопки.Удалить(ПодменюДействия.Кнопки.РедактироватьКодНомер);
	//	КонецЕсли;
	//	ПолеВводаНомера.ТолькоПросмотр = Ложь;		
	//КонецЕсли;
	//
	//ПолеВводаНомера.ПропускатьПриВводе = ПолеВводаНомера.ТолькоПросмотр;		
	//УстановитьПодсказкуПоляВводаКодаНомера(ПолеВводаНомера, ПодменюДействия, СтратегияРедактирования);	
		
КонецПроцедуры // УстановитьДоступностьПоляВводаНомера()
