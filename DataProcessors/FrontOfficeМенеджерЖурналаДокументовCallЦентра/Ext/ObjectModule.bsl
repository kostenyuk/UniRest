﻿
#Если Клиент Тогда
	
Перем мРежимПоиска, мДанныеПоиска;
	
Перем мТипДокументаРеализацияТоваровУслуг;

	
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


// Процедура заполнения табличного поля открытых документов.
//
// Параметры:
//	ТабличноеПоле - TouchТабличноеПоле. Табличное поле;
//	ТребуемыеПолномочия - ПланыВидовХарактеристикСсылка.ПраваПользователей. Требуемые полномочия при просмотре документов;
//	СписокИсключаемых - СписокЗначений. Список исключаемых документов;
//	Реализация - Булево. Сигнализирует о необходимости включения в вборку документов реализаций и нарядов;
//	Списание - Булево. Сигнализирует о необходимости включения в вборку документов списаний;
//	Открытые - Булево. Сигнализирует о необходимости формирования списка открытых или закрытых и удаленных документов.
//
Процедура ТаблицаОткрытыхДокументовПрочитать(ТабличноеПоле, ТребуемыеПолномочия = "ПросмотрСпискаОткрытых", СписокИсключаемых = Неопределено, Реализация = Истина, Списание = Истина, Открытые = Истина) Экспорт
	
	// Данные.
	Данные = ТабличноеПоле.Данные();
	Если (Данные = Неопределено) Тогда
		Данные = Новый ТаблицаЗначений;
		Данные.Колонки.Добавить("Ссылка", Новый ОписаниеТипов("ДокументСсылка.РеализацияТоваровУслуг,ДокументСсылка.СписаниеТоваров"));
		Данные.Колонки.Добавить("Номер", Новый ОписаниеТипов("Строка"), "Документ");
		Данные.Колонки.Добавить("Дата", Новый ОписаниеТипов("Дата"));
		Данные.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.СотрудникиОрганизаций"),НСтр("ru='Сотрудник';uk='Працівник'") );
		Если Открытые Тогда
			Данные.Колонки.Добавить("СотрудникПредставление", Новый ОписаниеТипов("Строка"), НСтр("ru='Экспедитор/сотрудник';uk='Експедитор/працівник'") );
		Иначе
			Данные.Колонки.Добавить("СотрудникПредставление", Новый ОписаниеТипов("Строка"), НСтр("ru='Сотрудник';uk='Працівник'") );
		КонецЕсли;
		Данные.Колонки.Добавить("Экспедитор", Новый ОписаниеТипов("СправочникСсылка.СотрудникиОрганизаций"));
		Данные.Колонки.Добавить("ЭкспедиторПредставление", Новый ОписаниеТипов("Строка"));
		Если Открытые Тогда
			Данные.Колонки.Добавить("ИнформацияОсновная", Новый ОписаниеТипов("Дата"), "Доставка");
		Иначе
			Данные.Колонки.Добавить("ИнформацияОсновная", Новый ОписаниеТипов("Строка"), НСтр("ru='Вид оплаты';uk='Вид оплати'") );
		КонецЕсли;
		Если Открытые Тогда
			Данные.Колонки.Добавить("ИнформацияВспомогательная", Новый ОписаниеТипов("Дата"), НСтр("ru='Начало доставки';uk='Початок доставки'") );
		Иначе
			Данные.Колонки.Добавить("ИнформацияВспомогательная", Новый ОписаниеТипов("Число"), НСтр("ru='Сумма';uk='Сума'") );
		КонецЕсли;
		Данные.Колонки.Добавить("Контрагент", Новый ОписаниеТипов("СправочникСсылка.Контрагенты"));
		Данные.Колонки.Добавить("КонтрагентПредставление", Новый ОписаниеТипов("Строка"), НСтр("ru='Клиент и адрес';uk='Клієнт та адреса'") );
		Данные.Колонки.Добавить("СуммаДокумента", Новый ОписаниеТипов("Число"), НСтр("ru='Сумма';uk='Сума'") );
		Данные.Колонки.Добавить("АдресДоставкиПредставление", Новый ОписаниеТипов("Строка"));
		Данные.Колонки.Добавить("ТелефонПредставление", Новый ОписаниеТипов("Строка"), "Телефон");
		Данные.Колонки.Добавить("ТелефонДополнительныйПредставление", Новый ОписаниеТипов("Строка"));
		Данные.Колонки.Добавить("АдресДоставкиПоиск", Новый ОписаниеТипов("Строка"));
		Данные.Колонки.Добавить("ТелефонПоиск", Новый ОписаниеТипов("Строка"));
		Данные.Колонки.Добавить("ТелефонДополнительныйПоиск", Новый ОписаниеТипов("Строка"));
		Данные.Колонки.Добавить("Состояние", Новый ОписаниеТипов("ПеречислениеСсылка.СостоянияДокументов"));
		
		ТабличноеПоле.Данные(Данные); ТабличноеПоле.СоздатьКолонки("Номер,СотрудникПредставление,ИнформацияОсновная,ИнформацияВспомогательная,КонтрагентПредставление,ТелефонПредставление");
		ТабличноеПоле.Колонки.Получить("Номер").Ширина = 400 * 0.10;
		ТабличноеПоле.Колонки.Получить("Номер").ГоризонтальноеПоложениеВКолонке = ГоризонтальноеПоложение.Центр;
		ТабличноеПоле.Колонки.Получить("СотрудникПредставление").Ширина = 400 * 0.30;
			ТабличноеПоле.Колонки.Получить("ИнформацияОсновная").Ширина = 400 * 0.15;
			ТабличноеПоле.Колонки.Получить("ИнформацияОсновная").Положение = ПоложениеКолонки.НаСледующейСтроке;
			ТабличноеПоле.Колонки.Получить("ИнформацияВспомогательная").Ширина = 400 * 0.15;
			ТабличноеПоле.Колонки.Получить("ИнформацияВспомогательная").Положение = ПоложениеКолонки.ВТойЖеКолонке;
			ТабличноеПоле.Колонки.Получить("ИнформацияВспомогательная").Формат = "ЧЦ=" + Метаданные.Документы.РеализацияТоваровУслуг.Реквизиты.СуммаДокумента.Тип.КвалификаторыЧисла.Разрядность + "; ЧДЦ=" + Метаданные.Документы.РеализацияТоваровУслуг.Реквизиты.СуммаДокумента.Тип.КвалификаторыЧисла.РазрядностьДробнойЧасти + "; ЧН=";
		ТабличноеПоле.Колонки.Получить("КонтрагентПредставление").Ширина = 400 * 0.40;
		ТабличноеПоле.Колонки.Получить("ТелефонПредставление").Ширина = 400 * 0.20;
		ТабличноеПоле.Колонки.Получить("ТелефонПредставление").ГоризонтальноеПоложениеВКолонке = ГоризонтальноеПоложение.Центр;
		ТабличноеПоле.РежимВыделенияСтроки = РежимВыделенияСтрокиТабличногоПоля.Строка;
		
		Возврат;
	Иначе
		// -- Текущая позиция (I).
		Если (Не ТабличноеПоле.ТекущаяСтрока() = Неопределено) Тогда
			ТекущийДокумент = ТабличноеПоле.ТекущиеДанные().Ссылка;
		КонецЕсли;
		
		Данные.Очистить();
	КонецЕсли;

	// Выборка данных.
	ТекущийРесторан = ПолучитьСерверFrontOffice().ТекущийРесторан();
	ТекущийСотрудник = УправлениеПользователями.ОпределитьСотрудникаПоПользователю(глЗначениеПеременной("глТекущийПользователь"));
	
	// -- Документы.
	ДоступностьЗаказов = ПолучитьСерверFrontOffice().МенеджерДокумента.ДокументПолучитьЗначениеПрава(Тип("ДокументСсылка.РеализацияТоваровУслуг"), ТребуемыеПолномочия);
	ДоступностьСписаний = ПолучитьСерверFrontOffice().МенеджерДокумента.ДокументПолучитьЗначениеПрава(Тип("ДокументСсылка.СписаниеТоваров"), ТребуемыеПолномочия);
	Если Реализация Тогда
		Если (ДоступностьЗаказов = Перечисления.ПраваДоступаПользователей.Привилегированные) Тогда
			ЗапросГдеЗаказы = "СостояниеДокументов.Документ ССЫЛКА Документ.РеализацияТоваровУслуг"
		ИначеЕсли (ДоступностьЗаказов = Перечисления.ПраваДоступаПользователей.Разрешить) Тогда
			ЗапросГдеЗаказы = "СостояниеДокументов.Документ ССЫЛКА Документ.РеализацияТоваровУслуг И СостояниеДокументов.Сотрудник = &Сотрудник"
		КонецЕсли;
	КонецЕсли;
	Если Списание Тогда
		Если (ДоступностьСписаний = Перечисления.ПраваДоступаПользователей.Привилегированные) Тогда
			ЗапросГдеСписания = "СостояниеДокументов.Документ ССЫЛКА Документ.СписаниеТоваров"
		ИначеЕсли (ДоступностьСписаний = Перечисления.ПраваДоступаПользователей.Разрешить) Тогда
			ЗапросГдеСписания = "СостояниеДокументов.Документ ССЫЛКА Документ.СписаниеТоваров И СостояниеДокументов.Сотрудник = &Сотрудник"
		КонецЕсли;
	КонецЕсли;
	
	// -- 100% пустая выборка.
	Если (ЗапросГдеЗаказы = Неопределено) И (ЗапросГдеСписания = Неопределено) Тогда
		ТабличноеПоле.ОбновитьСтроки();
		Возврат;
	КонецЕсли;
	
	Если (Не ЗапросГдеЗаказы = Неопределено) Тогда
		ЗапросГде = "(" + ЗапросГдеЗаказы + ")";
	КонецЕсли;
	Если (Не ЗапросГдеСписания = Неопределено) Тогда
		Если ПустаяСтрока(ЗапросГде) Тогда
			ЗапросГде = "(" + ЗапросГдеСписания + ")";
		Иначе
			ЗапросГде = ЗапросГде + " ИЛИ " + "(" + ЗапросГдеСписания + ")";
		КонецЕсли;
	КонецЕсли;
	Если (ТипЗнч(СписокИсключаемых) = Тип("СписокЗначений")) Тогда
		ЗапросГде = "(" + ЗапросГде + ") И (НЕ СостояниеДокументов.Документ В &СписокИсключаемых)";
	ИначеЕсли (Не СписокИсключаемых = Неопределено) Тогда
		ЗапросГде = "(" + ЗапросГде + ") И (НЕ СостояниеДокументов.Документ = &СписокИсключаемых)";
	КонецЕсли;
	
	// -- Запрос.
	Если Открытые Тогда
		Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                      |	СостояниеДокументов.Документ КАК Ссылка,
		                      |	СостояниеДокументов.Номер КАК Номер,
		                      |	СостояниеДокументов.Дата КАК Дата,
		                      |	СостояниеДокументов.Сотрудник КАК Сотрудник,
		                      |	СостояниеДокументов.Сотрудник.Представление КАК СотрудникПредставление,
		                      |	ВЫБОР
		                      |		КОГДА СостояниеДокументов.Документ ССЫЛКА Документ.РеализацияТоваровУслуг
		                      |			ТОГДА СостояниеДокументовОснованийНакладныхНаДоставку.Сотрудник
		                      |		ИНАЧЕ СостояниеДокументов.Сотрудник
		                      |	КОНЕЦ КАК Экспедитор,
		                      |	ВЫБОР
		                      |		КОГДА СостояниеДокументов.Документ ССЫЛКА Документ.РеализацияТоваровУслуг
		                      |			ТОГДА СостояниеДокументовОснованийНакладныхНаДоставку.Сотрудник.Представление
		                      |		ИНАЧЕ СостояниеДокументов.Сотрудник.Представление
		                      |	КОНЕЦ КАК ЭкспедиторПредставление,
		                      |	СостояниеДокументов.ТребуемаяДатаОкончанияПериода КАК ТребуемаяДатаОкончанияПериода,
		                      |	СостояниеДокументов.ФактическаяДатаНачалаПериода КАК ФактическаяДатаНачалаПериода,
		                      |	СостояниеДокументов.Контрагент,
		                      |	СостояниеДокументов.Контрагент.Представление КАК КонтрагентПредставление,
		                      |	СостояниеДокументов.СуммаДокумента,
		                      |	СостояниеДокументов.АдресДоставкиПоиск КАК АдресДоставкиПоиск,
		                      |	СостояниеДокументов.ТелефонПоиск КАК ТелефонПоиск,
		                      |	СостояниеДокументов.ТелефонДополнительныйПоиск КАК ТелефонДополнительныйПоиск,
		                      |	СостояниеДокументов.АдресДоставкиПредставление КАК АдресДоставкиПредставление,
		                      |	СостояниеДокументов.ТелефонПредставление КАК ТелефонПредставление,
		                      |	СостояниеДокументов.ТелефонДополнительныйПредставление КАК ТелефонДополнительныйПредставление,
		                      |	СостояниеДокументов.Состояние КАК Состояние
		                      |ИЗ
		                      |	РегистрСведений.СостояниеДокументов КАК СостояниеДокументов
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СостояниеДокументовОснованийНакладныхНаДоставку КАК СостояниеДокументовОснованийНакладныхНаДоставку
		                      |		ПО СостояниеДокументов.Документ = СостояниеДокументовОснованийНакладныхНаДоставку.ДокументОснование
		                      |ГДЕ
		                      |	СостояниеДокументов.Модуль = ЗНАЧЕНИЕ(Перечисление.МодулиИПодсистемы.Доставка)
		                      |	И СостояниеДокументов.Ресторан = &Ресторан
		                      |	И СостояниеДокументов.Документ = СостояниеДокументов.Документ
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	СостояниеДокументов.ДатаНачалаПериода,
		                      |	Номер");
	Иначе
		ЗакрытыеСостояния = УправлениеЗаказами.СостоянияЗакрытыхДокументов(Истина);
		
		СписокТипов = Новый СписокЗначений; СписокТипов.Добавить(Перечисления.ТипыКонтактнойИнформации.Адрес); СписокТипов.Добавить(Перечисления.ТипыКонтактнойИнформации.Телефон);
		СписокВидов = Новый СписокЗначений; СписокВидов.Добавить(Справочники.ВидыКонтактнойИнформации.АдресДоставкиРеализацииТоваровУслуг); СписокВидов.Добавить(Справочники.ВидыКонтактнойИнформации.ТелефонРеализацииТоваровУслуг); СписокВидов.Добавить(Справочники.ВидыКонтактнойИнформации.ТелефонДополнительныйРеализацииТоваровУслуг);
		
		Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                      |	СостояниеДокументов.Ссылка,
		                      |	СостояниеДокументов.Номер,
		                      |	СостояниеДокументов.Дата,
		                      |	СостояниеДокументов.Сотрудник,
		                      |	СостояниеДокументов.СотрудникПредставление,
		                      |	СостояниеДокументов.Экспедитор,
		                      |	СостояниеДокументов.ЭкспедиторПредставление,
		                      |	СостояниеДокументов.Контрагент,
		                      |	СостояниеДокументов.КонтрагентПредставление,
		                      |	СостояниеДокументов.ОплатаПредставление,
		                      |	СостояниеДокументов.СуммаДокумента,
		                      |	СостояниеДокументов.Состояние КАК Состояние,
		                      |	СостояниеДокументов.ДатаНачалаПериода,
		                      |	СостояниеДокументов.ДатаОкончанияПериода,
		                      |	СостояниеДокументов.Документ
		                      |ПОМЕСТИТЬ ВременнаяВыборкаДокументов
		                      |ИЗ
		                      |	(ВЫБРАТЬ
		                      |		РеализацияТоваровУслуг.Ссылка КАК Ссылка,
		                      |		РеализацияТоваровУслуг.Номер КАК Номер,
		                      |		РеализацияТоваровУслуг.Дата КАК Дата,
		                      |		РеализацияТоваровУслуг.Сотрудник КАК Сотрудник,
		                      |		РеализацияТоваровУслуг.Сотрудник.Представление КАК СотрудникПредставление,
		                      |		РеализацияТоваровУслуг.Сотрудник КАК Экспедитор,
		                      |		РеализацияТоваровУслуг.Сотрудник.Представление КАК ЭкспедиторПредставление,
		                      |		РеализацияТоваровУслуг.Контрагент КАК Контрагент,
		                      |		РеализацияТоваровУслуг.Контрагент.Представление КАК КонтрагентПредставление,
		                      |		РеализацияТоваровУслуг.Оплата.Представление КАК ОплатаПредставление,
		                      |		РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента,
		                      |		РеализацияТоваровУслуг.Состояние КАК Состояние,
		                      |		РеализацияТоваровУслуг.ДатаНачалаПериода КАК ДатаНачалаПериода,
		                      |		РеализацияТоваровУслуг.ДатаОкончанияПериода КАК ДатаОкончанияПериода,
		                      |		РеализацияТоваровУслуг.Ссылка КАК Документ
		                      |	ИЗ
		                      |		Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		                      |	ГДЕ
		                      |		РеализацияТоваровУслуг.Ресторан = &Ресторан
		                      |		И НАЧАЛОПЕРИОДА(РеализацияТоваровУслуг.Дата, ДЕНЬ) = НАЧАЛОПЕРИОДА(&Дата, ДЕНЬ)
		                      |		И РеализацияТоваровУслуг.Модуль = ЗНАЧЕНИЕ(Перечисление.МодулиИПодсистемы.Доставка)
		                      |		И РеализацияТоваровУслуг.Состояние В(&ЗакрытыеСостояния)
		                      |	
		                      |	ОБЪЕДИНИТЬ ВСЕ
		                      |	
		                      |	ВЫБРАТЬ
		                      |		СписаниеТоваров.Ссылка,
		                      |		СписаниеТоваров.Номер,
		                      |		СписаниеТоваров.Дата,
		                      |		СписаниеТоваров.Сотрудник,
		                      |		СписаниеТоваров.Сотрудник.Представление,
		                      |		СписаниеТоваров.Сотрудник,
		                      |		СписаниеТоваров.Сотрудник.Представление,
		                      |		NULL,
		                      |		NULL,
		                      |		СписаниеТоваров.Оплата.Представление,
		                      |		СписаниеТоваров.СуммаДокумента,
		                      |		СписаниеТоваров.Состояние,
		                      |		СписаниеТоваров.ДатаНачалаПериода,
		                      |		СписаниеТоваров.ДатаОкончанияПериода,
		                      |		СписаниеТоваров.Ссылка
		                      |	ИЗ
		                      |		Документ.СписаниеТоваров КАК СписаниеТоваров
		                      |	ГДЕ
		                      |		СписаниеТоваров.Ресторан = &Ресторан
		                      |		И НАЧАЛОПЕРИОДА(СписаниеТоваров.Дата, ДЕНЬ) = НАЧАЛОПЕРИОДА(&Дата, ДЕНЬ)
		                      |		И СписаниеТоваров.Модуль = ЗНАЧЕНИЕ(Перечисление.МодулиИПодсистемы.Доставка)
		                      |		И СписаниеТоваров.Состояние В(&ЗакрытыеСостояния)) КАК СостояниеДокументов
		                      |ГДЕ
		                      |	СостояниеДокументов.Документ = СостояниеДокументов.Документ
		                      |;
		                      |
		                      |////////////////////////////////////////////////////////////////////////////////
		                      |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                      |	СостояниеДокументов.Ссылка КАК Ссылка,
		                      |	КИРТУ.Тип КАК Тип,
		                      |	КИРТУ.Вид КАК Вид,
		                      |	КИРТУ.Поле6 КАК Поле6,
		                      |	КИРТУ.Поле7 КАК Поле7,
		                      |	КИРТУ.Представление КАК Представление,
		                      |	КИРТУ.Поиск КАК Поиск
		                      |ПОМЕСТИТЬ ВременнаяКИРТУ
		                      |ИЗ
		                      |	ВременнаяВыборкаДокументов КАК СостояниеДокументов
		                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.КонтактнаяИнформацияРеализацииТоваровУслуг КАК КИРТУ
		                      |		ПО СостояниеДокументов.Ссылка = КИРТУ.Документ
		                      |ГДЕ
		                      |	КИРТУ.Тип В(&СписокТипов)
		                      |	И КИРТУ.Вид В(&СписокВидов)
		                      |;
		                      |
		                      |////////////////////////////////////////////////////////////////////////////////
		                      |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                      |	СостояниеДокументов.Ссылка,
		                      |	СостояниеДокументов.Номер КАК Номер,
		                      |	СостояниеДокументов.Дата КАК Дата,
		                      |	СостояниеДокументов.Сотрудник,
		                      |	СостояниеДокументов.СотрудникПредставление,
		                      |	СостояниеДокументов.Экспедитор,
		                      |	СостояниеДокументов.ЭкспедиторПредставление,
		                      |	СостояниеДокументов.Контрагент,
		                      |	СостояниеДокументов.КонтрагентПредставление,
		                      |	СостояниеДокументов.ОплатаПредставление,
		                      |	СостояниеДокументов.СуммаДокумента,
		                      |	СостояниеДокументов.Состояние КАК Состояние,
		                      |	КИРТУАдресДоставки.Представление КАК АдресДоставкиПредставление,
		                      |	КИРТУАдресДоставки.Поиск КАК АдресДоставкиПоиск,
		                      |	КИРТУТелефон.Представление КАК ТелефонПредставление,
		                      |	КИРТУТелефон.Поиск КАК ТелефонПоиск,
		                      |	КИРТУТелефонДополнительный.Представление КАК ТелефонДополнительныйПредставление,
		                      |	КИРТУТелефонДополнительный.Поиск КАК ТелефонДополнительныйПоиск
		                      |ИЗ
		                      |	ВременнаяВыборкаДокументов КАК СостояниеДокументов
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяКИРТУ КАК КИРТУАдресДоставки
		                      |		ПО СостояниеДокументов.Ссылка = КИРТУАдресДоставки.Ссылка
		                      |			И (КИРТУАдресДоставки.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Адрес))
		                      |			И (КИРТУАдресДоставки.Вид = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.АдресДоставкиРеализацииТоваровУслуг))
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяКИРТУ КАК КИРТУТелефон
		                      |		ПО СостояниеДокументов.Ссылка = КИРТУТелефон.Ссылка
		                      |			И (КИРТУТелефон.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон))
		                      |			И (КИРТУТелефон.Вид = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.ТелефонРеализацииТоваровУслуг))
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ ВременнаяКИРТУ КАК КИРТУТелефонДополнительный
		                      |		ПО СостояниеДокументов.Ссылка = КИРТУТелефонДополнительный.Ссылка
		                      |			И (КИРТУТелефонДополнительный.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон))
		                      |			И (КИРТУТелефонДополнительный.Вид = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.ТелефонДополнительныйРеализацииТоваровУслуг))
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	СостояниеДокументов.ДатаНачалаПериода,
		                      //|	Номер");
							  //Костенюк Александр-Старт 23.10.2012
							  |	Номер
							  |;
							  |
							  |////////////////////////////////////////////////////////////////////////////////
							  |УНИЧТОЖИТЬ ВременнаяВыборкаДокументов
							  |;
							  |
							  |////////////////////////////////////////////////////////////////////////////////
							  |УНИЧТОЖИТЬ ВременнаяКИРТУ");
							  //Костенюк Александр-Финиш 23.10.2012
		Запрос.УстановитьПараметр("Дата", ПолучитьСерверFrontOffice().ТекущаяКассоваяДата());
		Запрос.УстановитьПараметр("ЗакрытыеСостояния", ЗакрытыеСостояния);
		Запрос.УстановитьПараметр("СписокТипов", СписокТипов);
		Запрос.УстановитьПараметр("СписокВидов", СписокВидов);
	КонецЕсли;
	Запрос.УстановитьПараметр("Сотрудник", ТекущийСотрудник);
	Запрос.УстановитьПараметр("СписокИсключаемых", СписокИсключаемых);
	Запрос.УстановитьПараметр("Ресторан", ТекущийРесторан);
	Если ТекущийРесторан.Пустая() Или УправлениеПользователями.ПолучитьЗначениеПрава(ПланыВидовХарактеристик.ПраваПользователей.FrontOfficeИгнорироватьРазделениеПоРесторанам) Тогда
		Если Открытые Тогда
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "СостояниеДокументов.Ресторан = &Ресторан", "ИСТИНА");
		Иначе
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "РеализацияТоваровУслуг.Ресторан = &Ресторан", "ИСТИНА");
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "СписаниеТоваров.Ресторан = &Ресторан", "ИСТИНА");
		КонецЕсли;
	КонецЕсли;
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "СостояниеДокументов.Документ = СостояниеДокументов.Документ", ЗапросГде);
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
		СтрокаДанных.Номер = Выборка.Номер;
		СтрокаДанных.Дата = Выборка.Дата;
		СтрокаДанных.Сотрудник = Выборка.Сотрудник;
		Если Открытые Тогда
			Если (ТипЗнч(СтрокаДанных.Ссылка) = мТипДокументаРеализацияТоваровУслуг) Тогда
				СтрокаДанных.СотрудникПредставление = Выборка.ЭкспедиторПредставление;
				СтрокаДанных.ИнформацияОсновная = Выборка.ТребуемаяДатаОкончанияПериода;
				СтрокаДанных.ИнформацияВспомогательная = Выборка.ФактическаяДатаНачалаПериода;
			Иначе
				СтрокаДанных.СотрудникПредставление = Выборка.СотрудникПредставление;
			КонецЕсли;
		Иначе
			СтрокаДанных.СотрудникПредставление = Выборка.СотрудникПредставление;
			СтрокаДанных.ИнформацияОсновная = Выборка.ОплатаПредставление;
			СтрокаДанных.ИнформацияВспомогательная = Выборка.СуммаДокумента;
		КонецЕсли;
		СтрокаДанных.Экспедитор = Выборка.Экспедитор;
		СтрокаДанных.ЭкспедиторПредставление = Выборка.ЭкспедиторПредставление;
		СтрокаДанных.Контрагент = Выборка.Контрагент;
		СтрокаДанных.КонтрагентПредставление = Выборка.КонтрагентПредставление;
		СтрокаДанных.СуммаДокумента = Выборка.СуммаДокумента;
		СтрокаДанных.АдресДоставкиПредставление = Выборка.АдресДоставкиПредставление;
		СтрокаДанных.ТелефонПредставление = Выборка.ТелефонПредставление;
		СтрокаДанных.ТелефонДополнительныйПредставление = Выборка.ТелефонДополнительныйПредставление;
		СтрокаДанных.АдресДоставкиПоиск = Выборка.АдресДоставкиПоиск;
		СтрокаДанных.ТелефонПоиск = Выборка.ТелефонПоиск;
		СтрокаДанных.ТелефонДополнительныйПоиск = Выборка.ТелефонДополнительныйПоиск;
		СтрокаДанных.Состояние = Выборка.Состояние;
		
		// -- Текущая позиция (II).
		Если (СтрокаДанных.Ссылка = ТекущийДокумент) Тогда
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

КонецПроцедуры // ТаблицаОткрытыхДокументовПрочитать()

// Процедура обработчик события ПриВыводеСтроки табличного поля открытых документов.
//
Процедура ТаблицаОткрытыхДокументовВывестиСтроку(Элемент, ОформлениеСтроки, ДанныеСтроки, Открытые = Истина) Экспорт

	// Оформление строки.
	СтруктураСтиля = FrontOffice.ПараметрыСтиляСостоянияДокумента(ДанныеСтроки.Состояние, ,,, Ложь); СтруктураСтиля.Шрифт = Новый Шрифт(ОформлениеСтроки.Шрифт, ,, СтруктураСтиля.Шрифт.Жирный, СтруктураСтиля.Шрифт.Наклонный, СтруктураСтиля.Шрифт.Подчеркивание, СтруктураСтиля.Шрифт.Зачеркивание);
	
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("Номер"), СтруктураСтиля);
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("СотрудникПредставление"), СтруктураСтиля);
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("ИнформацияОсновная"), СтруктураСтиля);
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("ИнформацияВспомогательная"), СтруктураСтиля);
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("КонтрагентПредставление"), СтруктураСтиля);
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("ТелефонПредставление"), СтруктураСтиля);
	
	// Номер.
	ОформлениеСтроки.Ячейки("Номер").Текст = FrontOffice.ПредставлениеНомера(ДанныеСтроки.Номер) + Символы.ПС + FrontOffice.ПредставлениеДаты(ДанныеСтроки.Дата);
	
	Если Открытые Тогда
		
		// ИнформацияОсновная.
		Если (ТипЗнч(ДанныеСтроки.Ссылка) = мТипДокументаРеализацияТоваровУслуг) Тогда
			ОформлениеСтроки.Ячейки("ИнформацияОсновная").Выравнивание = ГоризонтальноеПоложение.Центр;
			ОформлениеСтроки.Ячейки("ИнформацияОсновная").Текст = FrontOffice.ПредставлениеДаты(ДанныеСтроки.ИнформацияОсновная);
		КонецЕсли;

		// ИнформацияВспомогательная.
		Если (ТипЗнч(ДанныеСтроки.Ссылка) = мТипДокументаРеализацияТоваровУслуг) Тогда
			ОформлениеСтроки.Ячейки("ИнформацияВспомогательная").Выравнивание = ГоризонтальноеПоложение.Центр;
			ОформлениеСтроки.Ячейки("ИнформацияВспомогательная").Текст = FrontOffice.ПредставлениеДаты(ДанныеСтроки.ИнформацияВспомогательная);
		КонецЕсли;

	КонецЕсли;
	
	// КонтрагентПредставление.
	ОформлениеСтроки.Ячейки("КонтрагентПредставление").Текст = ДанныеСтроки.КонтрагентПредставление + Символы.ПС + ДанныеСтроки.АдресДоставкиПредставление;
	
	// ТелефонПредставление.
	ОформлениеСтроки.Ячейки("ТелефонПредставление").Текст = ДанныеСтроки.ТелефонПредставление + УправлениеКонтактнойИнформацией.ПроверкаПустойСтроки(ДанныеСтроки.ТелефонДополнительныйПредставление, Символы.ПС) + ДанныеСтроки.ТелефонДополнительныйПредставление;
	
КонецПроцедуры // ТаблицаОткрытыхДокументовВывестиСтроку()

// Процедура осуществляет поиск данных табличного поля открытых документов.
//
// Описания:
//	См. процедуру "ТаблицаОткрытыхДокументовПрочитать".
//
Функция ТаблицаОткрытыхДокументовНайти(ТабличноеПоле) Экспорт
	
	Перем Значение;
	
	// Открываем форму.
	ФормаВыбора = ЭтотОбъект.ПолучитьФорму("ФормаВыбораПоиска");
	
	// Выбор.
	ПараметрЗакрытия = ФормаВыбора.ОткрытьМодально();
	Если (Не ТипЗнч(ПараметрЗакрытия) = Тип("Строка")) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Режим и данные поиска.
	мРежимПоиска = ПараметрЗакрытия; мДанныеПоиска = ТабличноеПоле.Данные(); 
	
	// Данные.
	Данные = Новый ТаблицаЗначений;
	Для Каждого Колонка Из мДанныеПоиска.Колонки Цикл
		Данные.Колонки.Добавить(Колонка.Имя, Колонка.ТипЗначения, Колонка.Заголовок, Колонка.Ширина);
	КонецЦикла;
	
	// Поиск.
	Если (мРежимПоиска = "Телефон") Тогда
		Результат = FrontOffice.ПоискЧисла(Значение, НСтр("ru='Введите телефон';uk='Введіть телефон'") , 12, ,,, "ЧЦ=12; ЧДЦ=0; ЧГ=", Данные, "Номер,ТелефонПредставление", , ЭтотОбъект, "ПоискДокумента");
	ИначеЕсли (мРежимПоиска = "Адрес") Тогда
		Результат = FrontOffice.ПоискСтроки(Значение,НСтр("ru='Введите адрес';uk='Введіть адресу")  , ,,, Данные, "Номер,КонтрагентПредставление", , ЭтотОбъект, "ПоискДокумента");
	ИначеЕсли (мРежимПоиска = "Сумма") Тогда
		Результат = FrontOffice.ПоискЧисла(Значение, НСтр("ru='Введите сумму';uk='Введіть суму'") , Метаданные.Документы.РеализацияТоваровУслуг.Реквизиты.СуммаДокумента.Тип.КвалификаторыЧисла.Разрядность, Метаданные.Документы.РеализацияТоваровУслуг.Реквизиты.СуммаДокумента.Тип.КвалификаторыЧисла.РазрядностьДробнойЧасти, ,,, Данные, "Номер,СуммаДокумента", , ЭтотОбъект, "ПоискДокумента");
	Иначе
		Результат = FrontOffice.ПоискЧисла(Значение, НСтр("ru='Введите номер документа';uk='Введіть номер документу'"), Метаданные.Документы.РеализацияТоваровУслуг.ДлинаНомера, ,,, "ЧЦ=" + Метаданные.Документы.РеализацияТоваровУслуг.ДлинаНомера + "; ЧДЦ=0; ЧГ=", Данные, "Номер", , ЭтотОбъект, "ПоискДокумента");
	КонецЕсли;
	
	// Позиционирование.
	Если Результат Тогда
		ТабличноеПоле.ТекущаяСтрока(ТабличноеПоле.Данные().Найти(Значение.Ссылка, "Ссылка"));
	КонецЕсли;
	
	// Результат.
	Возврат Результат;
	
КонецФункции // ТаблицаОткрытыхДокументовНайти()


// Процедура заполнения табличного поля закрытых документов.
//
// Описания:
//	См. процедуру "ТаблицаОткрытыхДокументовПрочитать".
//
Процедура ТаблицаЗакрытыхДокументовПрочитать(ТабличноеПоле, ТребуемыеПолномочия = "ПросмотрСпискаЗакрытых", СписокИсключаемых = Неопределено, Реализация = Истина, Списание = Истина) Экспорт
	
	ТаблицаОткрытыхДокументовПрочитать(ТабличноеПоле, ТребуемыеПолномочия, СписокИсключаемых, Реализация, Списание, Ложь);
	
КонецПроцедуры // ТаблицаЗакрытыхДокументовПрочитать()

// Процедура обработчик события ПриВыводеСтроки табличного поля закрырых документов.
//
Процедура ТаблицаЗакрытыхДокументовВывестиСтроку(Элемент, ОформлениеСтроки, ДанныеСтроки) Экспорт

	ТаблицаОткрытыхДокументовВывестиСтроку(Элемент, ОформлениеСтроки, ДанныеСтроки, Ложь);

КонецПроцедуры // ТаблицаЗакрытыхДокументовВывестиСтроку()

// Процедура осуществляет поиск данных табличного поля закрытых документов.
//
// Описания:
//	См. процедуру "ТаблицаОткрытыхДокументовПрочитать".
//
Функция ТаблицаЗакрытыхДокументовНайти(ТабличноеПоле) Экспорт
	
	Возврат ТаблицаОткрытыхДокументовНайти(ТабличноеПоле);
	
КонецФункции // ТаблицаЗакрытыхДокументовНайти()


// Обработчик события ПоискДокумента.ПриИзмененииДанных элемента.
//
Процедура ПоискДокументаПриИзмененииДанных(Элемент) Экспорт
	
	// Табличное поле.
	ТабличноеПоле = Элемент; 
	
	ТабличноеПоле.Колонки.Получить("Номер").Ширина = 400 * 0.20;
	ТабличноеПоле.Колонки.Получить("Номер").ГоризонтальноеПоложениеВКолонке = ГоризонтальноеПоложение.Центр;
	Если (мРежимПоиска = "Телефон") Тогда
		ТабличноеПоле.Колонки.Получить("ТелефонПредставление").Ширина = 400 * 0.30;
		ТабличноеПоле.Колонки.Получить("ТелефонПредставление").ГоризонтальноеПоложениеВКолонке = ГоризонтальноеПоложение.Центр;
	ИначеЕсли (мРежимПоиска = "Адрес") Тогда
		ТабличноеПоле.Колонки.Получить("КонтрагентПредставление").Ширина = 400 * 0.70;
	ИначеЕсли (мРежимПоиска = "Сумма") Тогда
		ТабличноеПоле.Колонки.Получить("СуммаДокумента").Ширина = 400 * 0.30;
		ТабличноеПоле.Колонки.Получить("СуммаДокумента").Формат = "ЧЦ=" + Метаданные.Документы.РеализацияТоваровУслуг.Реквизиты.СуммаДокумента.Тип.КвалификаторыЧисла.Разрядность + "; ЧДЦ=" + Метаданные.Документы.РеализацияТоваровУслуг.Реквизиты.СуммаДокумента.Тип.КвалификаторыЧисла.РазрядностьДробнойЧасти + "; ЧН=";
	КонецЕсли;
	
	ПолучитьСерверFrontOffice().ТабличноеПолеПоместить(ТабличноеПоле);
	
КонецПроцедуры // ПоискДокументаПриИзмененииДанных()

// Обработчик события ПоискДокумента.ПриПоискеЗначения элемента.
//
Процедура ПоискДокументаПриПоискеЗначения(Элемент, Значение, СтандартнаяОбработка) Экспорт
	
	// Даныне.
	Данные = Элемент.Данные(); Данные.Очистить();
	
	// Значение для поиска.
	Если (мРежимПоиска = "Телефон") Тогда
		ЗначениеДляПоиска = Формат(Значение, "ЧГ=");
	ИначеЕсли (мРежимПоиска = "Адрес") Тогда
		ЗначениеДляПоиска = Нрег(СокрЛ(Значение));
	ИначеЕсли (мРежимПоиска = "Сумма") Тогда
		ЗначениеДляПоиска = Формат(Значение, "ЧРД=,; ЧГ=");
	Иначе
		ЗначениеДляПоиска = Формат(Значение, "ЧГ=");
	КонецЕсли;
	Если ПустаяСтрока(ЗначениеДляПоиска) Тогда
		Возврат;
	КонецЕсли;
	
	// Поиск.
	Для Каждого СтрокаТаблицыДанных Из мДанныеПоиска Цикл
		
		Если (мРежимПоиска = "Телефон") Тогда
			Валидная = Булево(Найти(СтрокаТаблицыДанных.ТелефонПоиск, ЗначениеДляПоиска)) Или Булево(Найти(СтрокаТаблицыДанных.ТелефонДополнительныйПоиск, ЗначениеДляПоиска));
		ИначеЕсли (мРежимПоиска = "Адрес") Тогда
			Валидная = Булево(Найти(НРег(СтрокаТаблицыДанных.АдресДоставкиПоиск), ЗначениеДляПоиска));
		ИначеЕсли (мРежимПоиска = "Сумма") Тогда
			Валидная = Булево(Найти(Формат(СтрокаТаблицыДанных.СуммаДокумента), ЗначениеДляПоиска));
		Иначе
			Валидная = Булево(Найти(FrontOffice.ПредставлениеНомера(СтрокаТаблицыДанных.Номер), ЗначениеДляПоиска));
		КонецЕсли;
		Если Не Валидная Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаТаблицы = Данные.Добавить();
		Для Каждого Колонка Из мДанныеПоиска.Колонки Цикл
			СтрокаТаблицы[Колонка.Имя] = СтрокаТаблицыДанных[Колонка.Имя];
		КонецЦикла;
		
		// TODO: Поиск значения.
	
	КонецЦикла;
	
КонецПроцедуры // ПоискКлиентаПриПоискеЗначения()

// Обработчик события ПоискДокумента.ПриВыводеСтроки элемента.
//
Процедура ПоискДокументаПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки) Экспорт
	
	// Оформление строки.
	СтруктураСтиля = FrontOffice.ПараметрыСтиляСостоянияДокумента(ДанныеСтроки.Состояние, ,,, Ложь); СтруктураСтиля.Шрифт = Новый Шрифт(ОформлениеСтроки.Шрифт, ,, СтруктураСтиля.Шрифт.Жирный, СтруктураСтиля.Шрифт.Наклонный, СтруктураСтиля.Шрифт.Подчеркивание, СтруктураСтиля.Шрифт.Зачеркивание);
	
	ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("Номер"), СтруктураСтиля);
	Если (мРежимПоиска = "Телефон") Тогда
		ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("ТелефонПредставление"), СтруктураСтиля);
	ИначеЕсли (мРежимПоиска = "Адрес") Тогда
		ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("КонтрагентПредставление"), СтруктураСтиля);
	ИначеЕсли (мРежимПоиска = "Сумма") Тогда
		ЗаполнитьЗначенияСвойств(ОформлениеСтроки.Ячейки("СуммаДокумента"), СтруктураСтиля);
	КонецЕсли;
	
	// Номер.
	ОформлениеСтроки.Ячейки("Номер").Текст = FrontOffice.ПредставлениеНомера(ДанныеСтроки.Номер) + Символы.ПС + FrontOffice.ПредставлениеДаты(ДанныеСтроки.Дата);
	
	// ТелефонПредставление.
	Если (мРежимПоиска = "Телефон") Тогда
		ОформлениеСтроки.Ячейки("ТелефонПредставление").Текст = ДанныеСтроки.ТелефонПредставление + УправлениеКонтактнойИнформацией.ПроверкаПустойСтроки(ДанныеСтроки.ТелефонДополнительныйПредставление, Символы.ПС) + ДанныеСтроки.ТелефонДополнительныйПредставление;
	КонецЕсли;
	
	// КонтрагентПредставление.
	Если (мРежимПоиска = "Адрес") Тогда
		ОформлениеСтроки.Ячейки("КонтрагентПредставление").Текст = ДанныеСтроки.КонтрагентПредставление + Символы.ПС + ДанныеСтроки.АдресДоставкиПредставление;
	КонецЕсли;
	
КонецПроцедуры // ПоискКлиентаПриВыводеСтроки()


// Инициализация переменных.
мТипДокументаРеализацияТоваровУслуг = Тип("ДокументСсылка.РеализацияТоваровУслуг");

#КонецЕсли
