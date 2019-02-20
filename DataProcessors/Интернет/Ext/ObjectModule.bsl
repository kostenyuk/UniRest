﻿
Функция ПолучитьЗначениеЭлемента(УзелDOM, Имя)
	
	Если (ТипЗнч(УзелDOM) = Тип("ЭлементDOM")) Тогда
	
		Элементы = УзелDOM.ПолучитьЭлементыПоИмени(Имя);
		Если Не Булево(Элементы.Количество()) Тогда
			Возврат Неопределено;
		КонецЕсли;
		
		Возврат Элементы[0].ТекстовоеСодержимое;
		
	Иначе
		
		Для Каждого ЭлементDOM Из УзелDOM Цикл
			Если (НРег(ЭлементDOM.ИмяУзла) = НРег(Имя)) Тогда
				Возврат ЭлементDOM.ТекстовоеСодержимое;
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции // ПолучитьЗначениеЭлемента()

Функция ПолучитьДочерниеУзлыЭлемента(УзелDOM, Имя)
	
	Элементы = УзелDOM.ПолучитьЭлементыПоИмени(Имя);
	Если Не Булево(Элементы.Количество()) Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	Возврат Элементы[0].ДочерниеУзлы;
	
КонецФункции // ПолучитьДочерниеУзлыЭлемента()


Функция ПолучитьДату(Представление, Альтернативная = '0001.01.01 00:00:00')
	
	Если ПустаяСтрока(Представление) Тогда
		Возврат Альтернативная;
	КонецЕсли;
	
	Попытка
		Возврат Дата(Сред(Представление, 9, 2) + "." + Сред(Представление, 6, 2) + "." + Сред(Представление, 1, 4) + " " + Сред(Представление, 12, 8));
	Исключение
		Возврат Альтернативная;
	КонецПопытки;
	
КонецФункции // ПолучитьДату()

Функция ПолучитьЧисло(Представление, Альтернативное = 0)
	
	Если ПустаяСтрока(Представление) Тогда
		Возврат Альтернативное;
	КонецЕсли;
	
	Попытка
		Возврат Число(Представление);
	Исключение
		Возврат Альтернативное;
	КонецПопытки;
	
КонецФункции // ПолучитьЧисло()


Функция НайтиРеализациюТоваровУслуг(ИнформационнаяСистема, Идентификатор)
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	СинонимыОбъектов.Объект
	                      |ИЗ
	                      |	РегистрСведений.СинонимыОбъектов КАК СинонимыОбъектов
	                      |ГДЕ
	                      |	СинонимыОбъектов.ИнформационнаяСистема = &ИнформационнаяСистема
	                      |	И СинонимыОбъектов.Идентификатор = &Идентификатор");
	Запрос.УстановитьПараметр("ИнформационнаяСистема", ИнформационнаяСистема);
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции // НайтиРеализациюТоваровУслуг()

Функция НайтиРесторан(Код)
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	Рестораны.Ссылка
	                      |ИЗ
	                      |	Справочник.Рестораны КАК Рестораны
	                      |ГДЕ
	                      |	Рестораны.Код = &Код");
	Запрос.УстановитьПараметр("Код", Код);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Справочники.Пользователи.ПустаяСсылка();
	
КонецФункции // НайтиРесторан()

Функция НайтиОтветственного(Код)
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	Пользователи.Ссылка
	                      |ИЗ
	                      |	Справочник.Пользователи КАК Пользователи
	                      |ГДЕ
	                      |	Пользователи.Код = &Код
	                      |	И (НЕ Пользователи.ЭтоГруппа)");
	Запрос.УстановитьПараметр("Код", Код);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Справочники.Пользователи.ПустаяСсылка();
	
КонецФункции // НайтиОтветственного()

Функция НайтиУлицу(Код)
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	КлассификаторУлиц.Ссылка
	                      |ИЗ
	                      |	Справочник.КлассификаторУлиц КАК КлассификаторУлиц
	                      |ГДЕ
	                      |	КлассификаторУлиц.Код = &Код
	                      |	И (НЕ КлассификаторУлиц.ЭтоГруппа)");
	Запрос.УстановитьПараметр("Код", Код);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Справочники.КлассификаторУлиц.ПустаяСсылка();
	
КонецФункции // НайтиУлицу()

Функция НайтиКонтрагента(Наименование, Телефон, ТелефонДополнительный)
	
	// Телефон.
	Если ПустаяСтрока(Телефон) Тогда
		РезультатТелефон = Новый Массив;
	Иначе
		ЗапросТелефон = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
		                             |	ВложенныйЗапрос.Ссылка,
		                             |	ВЫБОР
		                             |		КОГДА (ВЫРАЗИТЬ(ВложенныйЗапрос.Ссылка.НаименованиеПолное КАК СТРОКА(100))) = &Наименование
		                             |			ТОГДА ИСТИНА
		                             |		ИНАЧЕ ЛОЖЬ
		                             |	КОНЕЦ КАК Сравнение
		                             |ИЗ
		                             |	(ВЫБРАТЬ РАЗЛИЧНЫЕ
		                             |		КонтактнаяИнформацияРеализацииТоваровУслуг.Объект КАК Ссылка
		                             |	ИЗ
		                             |		РегистрСведений.КонтактнаяИнформацияРеализацииТоваровУслуг КАК КонтактнаяИнформацияРеализацииТоваровУслуг
		                             |	ГДЕ
		                             |		КонтактнаяИнформацияРеализацииТоваровУслуг.Поиск = &Поиск
		                             |		И КонтактнаяИнформацияРеализацииТоваровУслуг.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон)
		                             |	
		                             |	ОБЪЕДИНИТЬ ВСЕ
		                             |	
		                             |	ВЫБРАТЬ
		                             |		КонтактнаяИнформация.Объект
		                             |	ИЗ
		                             |		РегистрСведений.КонтактнаяИнформация КАК КонтактнаяИнформация
		                             |	ГДЕ
		                             |		КонтактнаяИнформация.Поиск = &Поиск
		                             |		И КонтактнаяИнформация.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон)) КАК ВложенныйЗапрос
		                             |
		                             |УПОРЯДОЧИТЬ ПО
		                             |	Сравнение УБЫВ");
		ЗапросТелефон.УстановитьПараметр("Поиск", Телефон);
		ЗапросТелефон.УстановитьПараметр("Наименование", Наименование);
		РезультатТелефон = ЗапросТелефон.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	КонецЕсли;		
		
	// Телефон дополнительный.
	Если ПустаяСтрока(ТелефонДополнительный) Тогда
		РезультатТелефонДополнительный = Новый Массив;
	Иначе
		ЗапросТелефонДополнительный = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
		                                           |	ВложенныйЗапрос.Ссылка,
		                                           |	ВЫБОР
		                                           |		КОГДА (ВЫРАЗИТЬ(ВложенныйЗапрос.Ссылка.НаименованиеПолное КАК СТРОКА(100))) = &Наименование
		                                           |			ТОГДА ИСТИНА
		                                           |		ИНАЧЕ ЛОЖЬ
		                                           |	КОНЕЦ КАК Сравнение
		                                           |ИЗ
		                                           |	(ВЫБРАТЬ РАЗЛИЧНЫЕ
		                                           |		КонтактнаяИнформацияРеализацииТоваровУслуг.Объект КАК Ссылка
		                                           |	ИЗ
		                                           |		РегистрСведений.КонтактнаяИнформацияРеализацииТоваровУслуг КАК КонтактнаяИнформацияРеализацииТоваровУслуг
		                                           |	ГДЕ
		                                           |		КонтактнаяИнформацияРеализацииТоваровУслуг.Поиск = &Поиск
		                                           |		И КонтактнаяИнформацияРеализацииТоваровУслуг.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон)
		                                           |	
		                                           |	ОБЪЕДИНИТЬ ВСЕ
		                                           |	
		                                           |	ВЫБРАТЬ
		                                           |		КонтактнаяИнформация.Объект
		                                           |	ИЗ
		                                           |		РегистрСведений.КонтактнаяИнформация КАК КонтактнаяИнформация
		                                           |	ГДЕ
		                                           |		КонтактнаяИнформация.Поиск = &Поиск
		                                           |		И КонтактнаяИнформация.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон)) КАК ВложенныйЗапрос
		                                           |
		                                           |УПОРЯДОЧИТЬ ПО
		                                           |	Сравнение УБЫВ");
		ЗапросТелефонДополнительный.УстановитьПараметр("Поиск", ТелефонДополнительный);
		ЗапросТелефонДополнительный.УстановитьПараметр("Наименование", Наименование);
		РезультатТелефонДополнительный = ЗапросТелефонДополнительный.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	КонецЕсли;
	
	// Пересечение.
	Для Каждого Контрагент Из РезультатТелефон Цикл
		Если (Не РезультатТелефонДополнительный.Найти(Контрагент) = Неопределено) Тогда
			Возврат Контрагент;
		КонецЕсли;
	КонецЦикла;
	
	// Варианты.
	Если Булево(РезультатТелефон.Количество()) Тогда
		Возврат РезультатТелефон[0];
	КонецЕсли;
	Если Булево(РезультатТелефонДополнительный.Количество()) Тогда
		Возврат РезультатТелефонДополнительный[0];
	КонецЕсли;
	
	Возврат Справочники.Контрагенты.ПустаяСсылка();
	
КонецФункции // НайтиКонтрагента()

Функция НайтиНоменклатуру(Код)
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	Номенклатура.Ссылка
	                      |ИЗ
	                      |	Справочник.Номенклатура КАК Номенклатура
	                      |ГДЕ
	                      |	Номенклатура.Код = &Код
	                      |	И (НЕ Номенклатура.ЭтоГруппа)");
	Запрос.УстановитьПараметр("Код", Код);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Справочники.Номенклатура.ПустаяСсылка();
	
КонецФункции // НайтиНоменклатуру()

Функция ПолучитьПроизводственныеГруппы(Данные)
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	                      |	НоменклатурныеГруппы.ПроизводственнаяГруппа КАК ПроизводственнаяГруппа
	                      |ИЗ
	                      |	Справочник.НоменклатурныеГруппы КАК НоменклатурныеГруппы
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПроизводственныеГруппы КАК ПроизводственныеГруппы
	                      |		ПО НоменклатурныеГруппы.ПроизводственнаяГруппа = ПроизводственныеГруппы.Ссылка
	                      |ГДЕ
	                      |	НоменклатурныеГруппы.Ссылка В(&НоменклатурныеГруппы)
	                      |	И ПроизводственныеГруппы.Актуальность");
	Запрос.УстановитьПараметр("НоменклатурныеГруппы", Данные.ВыгрузитьКолонку("НоменклатурнаяГруппа"));

	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ПроизводственнаяГруппа");
	
КонецФункции // ПолучитьПроизводственныеГруппы()


Процедура ЗагрузитьФайл(Файл, ИнтернетИнформационнаяСитема, ИнтернетКаталогВыполненных)
	
	// Флайги.
	Пустой = Истина; УспешноеВыполнение = Истина;
	
	// Чтение.
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(Файл.ПолноеИмя);

	// Преобразование.
	ПостроительDOM = Новый ПостроительDOM(); 
	ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
	ЧтениеXML.Закрыть();
	
	// Выборка.
	XPath = ДокументDOM.СоздатьВыражениеXPath("//orders/order", Новый РазыменовательПространствИменDOM(ДокументDOM)).Вычислить(ДокументDOM); 
    УзелDOM = XPath.ПолучитьСледующий();
	Пока (Не УзелDOM = Неопределено) Цикл
		
		Пустой = Ложь;
		
		// -- Документ
		Если Не НайтиРеализациюТоваровУслуг(ИнтернетИнформационнаяСитема, ПолучитьЗначениеЭлемента(УзелDOM, "id")) Тогда
			
			РеализацияТоваровУслуг = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
			
			// ---- Шапка.
			РеализацияТоваровУслуг.Дата = ПолучитьДату(ПолучитьЗначениеЭлемента(УзелDOM, "date"), ТекущаяДата());
			РеализацияТоваровУслуг.Модуль = Перечисления.МодулиИПодсистемы.Доставка;
			РеализацияТоваровУслуг.ДатаНачалаПериода = РеализацияТоваровУслуг.Дата; 
			РеализацияТоваровУслуг.Ресторан = НайтиРесторан(ПолучитьЗначениеЭлемента(УзелDOM, "restaurant")); 
			РеализацияТоваровУслуг.Ответственный = НайтиОтветственного(ПолучитьЗначениеЭлемента(УзелDOM, "employee"));
			РеализацияТоваровУслуг.Сотрудник = РеализацияТоваровУслуг.Ответственный.Сотрудник;
			РеализацияТоваровУслуг.ТребуемаяДатаОкончанияПериода = ПолучитьДату(ПолучитьЗначениеЭлемента(УзелDOM, "requireddate"));
			РеализацияТоваровУслуг.ФиксированнаяТребуемаяДатаОкончанияПериода = Не ОбщегоНазначения.ЗначениеНЕЗаполнено(РеализацияТоваровУслуг.ТребуемаяДатаОкончанияПериода); 
			РеализацияТоваровУслуг.Интернет = Истина;
			РеализацияТоваровУслуг.УстановитьНовыйНомер();
			ОбщегоНазначения.ЗаполнитьШапкуДокумента(РеализацияТоваровУслуг, РеализацияТоваровУслуг.Ответственный);
			
			// ------ Шапка контактная информация.
			УправлениеКонтактнойИнформацией.РазложитьТелефонПоПолям(ПолучитьЗначениеЭлемента(УзелDOM, "phone"), РеализацияТоваровУслуг.КонтактнаяИнформация().Телефон);
			УправлениеКонтактнойИнформацией.РазложитьТелефонПоПолям(ПолучитьЗначениеЭлемента(УзелDOM, "extphone"), РеализацияТоваровУслуг.КонтактнаяИнформация().ТелефонДополнительный);
			УправлениеКонтактнойИнформацией.СформироватьПредставлениеТелефона(РеализацияТоваровУслуг.КонтактнаяИнформация().Телефон);
			УправлениеКонтактнойИнформацией.СформироватьПредставлениеТелефона(РеализацияТоваровУслуг.КонтактнаяИнформация().ТелефонДополнительный);
			АдресDOM = ПолучитьДочерниеУзлыЭлемента(УзелDOM, "address"); Если Булево(АдресDOM.Количество()) Тогда
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле6 = НайтиУлицу(ПолучитьЗначениеЭлемента(АдресDOM, "street"));	
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле4 = РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле6.Владелец;
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле7 = УправлениеКонтактнойИнформацией.ПривестиДомАдресаКШаблону(ПолучитьЗначениеЭлемента(АдресDOM, "home"));	
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле8 = УправлениеКонтактнойИнформацией.ПривестиКорпусАдресаКШаблону(ПолучитьЗначениеЭлемента(АдресDOM, "housing"));	
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле11 = УправлениеКонтактнойИнформацией.ПривестиПодъездАдресаКШаблону(ПолучитьЗначениеЭлемента(АдресDOM, "staircase"));	
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле10 = УправлениеКонтактнойИнформацией.ПривестиЭтажАдресаКШаблону(ПолучитьЗначениеЭлемента(АдресDOM, "floor"));	
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Поле9 = УправлениеКонтактнойИнформацией.ПривестиКвартируАдресаКШаблону(ПолучитьЗначениеЭлемента(АдресDOM, "apartment"));	
				РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки.Комментарий = ПолучитьЗначениеЭлемента(АдресDOM, "comment");	
				УправлениеКонтактнойИнформацией.СформироватьПредставлениеАдреса(РеализацияТоваровУслуг.КонтактнаяИнформация().АдресДоставки);
			КонецЕсли;
			
			// ------ Шапка контрагент.
			РеализацияТоваровУслуг.Контрагент = НайтиКонтрагента(ПолучитьЗначениеЭлемента(УзелDOM, "customer"), РеализацияТоваровУслуг.КонтактнаяИнформация().Телефон.Поиск, РеализацияТоваровУслуг.КонтактнаяИнформация().ТелефонДополнительный.Поиск); 
			РеализацияТоваровУслуг.Контрагент().Наименование(ПолучитьЗначениеЭлемента(УзелDOM, "customer"));
			
			// ---- МнЧ.
			Для Каждого НоменклатураDOM Из ПолучитьДочерниеУзлыЭлемента(УзелDOM, "goods") Цикл
				НоменклатураDOM = НоменклатураDOM.ДочерниеУзлы;
				
				СтрокаТабличнойЧасти = РеализацияТоваровУслуг.Товары.Добавить();
				СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар;
				СтрокаТабличнойЧасти.Номенклатура = НайтиНоменклатуру(ПолучитьЗначениеЭлемента(НоменклатураDOM, "id"));
				СтрокаТабличнойЧасти.ЕдиницаИзмерения = СтрокаТабличнойЧасти.Номенклатура.БазоваяЕдиницаИзмерения;
				СтрокаТабличнойЧасти.Количество = ПолучитьЧисло(ПолучитьЗначениеЭлемента(НоменклатураDOM, "quantity"), 1);
				СтрокаТабличнойЧасти.ПлановаяСебестоимость = РегистрыСведений.ЦеныНоменклатуры.ПолучитьПоследнее(РеализацияТоваровУслуг.Дата, Новый Структура("Номенклатура", СтрокаТабличнойЧасти.Номенклатура)).Себестоимость;
				СтрокаТабличнойЧасти.Цена = ПолучитьЧисло(ПолучитьЗначениеЭлемента(НоменклатураDOM, "price"), 1);
				СтрокаТабличнойЧасти.Сумма = ПолучитьЧисло(ПолучитьЗначениеЭлемента(НоменклатураDOM, "cost"), СтрокаТабличнойЧасти.Количество * СтрокаТабличнойЧасти.Цена);
				СтрокаТабличнойЧасти.СуммаБезСкидок = СтрокаТабличнойЧасти.Количество * СтрокаТабличнойЧасти.Цена;
				СтрокаТабличнойЧасти.СуммаСкидки = СтрокаТабличнойЧасти.СуммаБезСкидок - СтрокаТабличнойЧасти.Сумма;
				СтрокаТабличнойЧасти.СтавкаНДС = СтрокаТабличнойЧасти.Номенклатура.СтавкаНДС;
				СтрокаТабличнойЧасти.ПенсионныйФонд = СтрокаТабличнойЧасти.Номенклатура.ПенсионныйФонд;
				СтрокаТабличнойЧасти.НоменклатурнаяГруппа = СтрокаТабличнойЧасти.Номенклатура.НоменклатурнаяГруппа;
				СтрокаТабличнойЧасти.Организация = СтрокаТабличнойЧасти.НоменклатурнаяГруппа.Организация;
				СтрокаТабличнойЧасти.ЕдиницаИзмерения = СтрокаТабличнойЧасти.Номенклатура.БазоваяЕдиницаИзмерения;
				СтрокаТабличнойЧасти.Комментарий = ПолучитьЗначениеЭлемента(НоменклатураDOM, "comment");
			КонецЦикла;
			
			// ------ Шапка продолжительность производства.
			ОсновныеНастройки = РеализацияТоваровУслуг.НастройкиПроизводства().ОсновныеНастройки(ПолучитьПроизводственныеГруппы(РеализацияТоваровУслуг.Товары));
			
			РеализацияТоваровУслуг.ПродолжительностьПроизводства = ОсновныеНастройки.ПродолжительностьПроизводства;
			РеализацияТоваровУслуг.ПродолжительностьДоставки = ОсновныеНастройки.ПродолжительностьДоставки;
	
			Если Не РеализацияТоваровУслуг.ФиксированнаяТребуемаяДатаОкончанияПериода Тогда
				РеализацияТоваровУслуг.ТребуемаяДатаОкончанияПериода = ОбщегоНазначения.ПолучитьНеПустуюДату(РеализацияТоваровУслуг.ДатаНачалаПериода) + ОбщегоНазначения.ПолучитьЧисло(ОсновныеНастройки.ПродолжительностьВыполнения);
			КонецЕсли;			
			
			// ---- Запись.
			РеализацияТоваровУслуг.ДополнительныеСвойства.Вставить("ИнтернетРежим", Истина);
			РеализацияТоваровУслуг.ДополнительныеСвойства.Вставить("СинонимОбъекта", Новый Структура("ИнформационнаяСистема,Идентификатор", ИнтернетИнформационнаяСитема, ПолучитьЗначениеЭлемента(УзелDOM, "id")));
			
			Попытка
				РеализацияТоваровУслуг.Записать();
			Исключение
				ЗаписьЖурналаРегистрации("Интернет",УровеньЖурналаРегистрации.Ошибка,,,"Файл " + Файл.Имя + " заказ " + ПолучитьЗначениеЭлемента(УзелDOM, "id") + ": " + ОбщегоНазначения.СформироватьТекстСообщения(ОписаниеОшибки()));
				УспешноеВыполнение = Ложь;
			КонецПопытки;			
			
		КонецЕсли;
		
		УзелDOM = XPath.ПолучитьСледующий();
	КонецЦикла;
	
	// Перенос файла.
	Попытка
		Если УспешноеВыполнение Тогда
			Если Пустой Тогда
				УдалитьФайлы(Файл.ПолноеИмя);
			Иначе
				ПереместитьФайл(Файл.ПолноеИмя, ИнтернетКаталогВыполненных + "\" + Файл.Имя);
			КонецЕсли;
		КонецЕсли;
	Исключение КонецПопытки;
	
КонецПроцедуры // ЗагрузитьФайл()

Процедура ЗагрузитьФайлы() Экспорт

	// Настройки.
	ИнтернетСервер = Константы.ИнтернетСервер.Получить();
	ИнтернетАдрес = Константы.ИнтернетАдрес.Получить();
	ИнтернетКаталог = Константы.ИнтернетКаталог.Получить();
	ИнтернетКаталогВыполненных = ИнтернетКаталог + "\processed";
	ИнтернетИмяФайла = "orders_";
	ИнтернетРасширениеФайла = "xml";
	ИнтернетИнформационнаяСитема = Константы.ИнтернетИнформационнаяСитема.Получить();
	
	// Проверка.
	Если ПустаяСтрока(ИнтернетСервер) Или ПустаяСтрока(ИнтернетАдрес) Или ПустаяСтрока(ИнтернетКаталог) Или (Не ЗначениеЗаполнено(ИнтернетИнформационнаяСитема)) Тогда
		Возврат;
	КонецЕсли;

	// Создание.
	Если Не РаботаСФайлами.ФайлСуществует(ИнтернетКаталог) Тогда
		СоздатьКаталог(ИнтернетКаталог);
	КонецЕсли;
	Если Не РаботаСФайлами.ФайлСуществует(ИнтернетКаталогВыполненных) Тогда
		СоздатьКаталог(ИнтернетКаталогВыполненных);
	КонецЕсли;
	
	// Загрузка.
	#Если Клиент Тогда
		Состояние("Соединение с сервером " + ИнтернетСервер);
	#КонецЕсли
	
	HTTPСоединение = Новый HTTPСоединение(ИнтернетСервер); 
	Попытка
		HTTPСоединение.Получить(ИнтернетАдрес, ИнтернетКаталог + "\" + ИнтернетИмяФайла + Формат(ТекущаяДата(), "ДФ=yyyyMMdd_HHmmss") + "." + ИнтернетРасширениеФайла); 
	Исключение 
		ЗаписьЖурналаРегистрации("Интернет",УровеньЖурналаРегистрации.Ошибка,,,"HTTP: " + ОбщегоНазначения.СформироватьТекстСообщения(ОписаниеОшибки()));
	КонецПопытки;
	
	// Обработка.
	МассивФайлов = НайтиФайлы(ИнтернетКаталог, ИнтернетИмяФайла + "*." + ИнтернетРасширениеФайла);
	Для Каждого Файл Из МассивФайлов Цикл

		Если Файл.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;
		
		#Если Клиент Тогда
			Состояние("Загрузка файла " + Файл.Имя);
		#КонецЕсли
		
		ЗагрузитьФайл(Файл, ИнтернетИнформационнаяСитема, ИнтернетКаталогВыполненных);
		
	КонецЦикла;

КонецПроцедуры // ЗагрузитьФайлы()
