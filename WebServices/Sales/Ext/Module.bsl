﻿
Функция ПолучитьОткрытыеДокументыРесторана(Сеанс)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	СостояниеДокументов.Документ,
	                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СостояниеДокументов.Сотрудник) КАК Сотрудник,
	                      |	СостояниеДокументов.ПолныйНомерСтола,
	                      |	СостояниеДокументов.Комментарий
	                      |ИЗ
	                      |	РегистрСведений.СостояниеДокументов КАК СостояниеДокументов
	                      |ГДЕ
	                      |	СостояниеДокументов.Документ ССЫЛКА Документ.РеализацияТоваровУслуг
	                      |	И СостояниеДокументов.Модуль = ЗНАЧЕНИЕ(Перечисление.МодулиИПодсистемы.Ресторан)
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	СостояниеДокументов.Стол.Код,
	                      |	СостояниеДокументов.ПостфиксСтола");
	
	// Результат.
	Возврат __В(Запрос);

КонецФункции // ПолучитьОткрытыеДокументыРесторана()

Функция ДокументОткрыт(Сеанс)

	// Восстановление сеанса.
	__ВебСервисСервер.ПродлениеСеанса(__Из(Сеанс));
	
	Возврат __ВебСервисСервер.ПроверитьДанныеСеанса(__Из(Сеанс), "Документ");
	
КонецФункции // ДокументОткрыт()

Функция СоздатьДокумент(Сеанс, Параметры)
	
	// Параметры.
	__Входящие(Сеанс, Параметры); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Параметры);

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(Сеанс);
	
	// Получение данных.
	ЭтотОбъект = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
	Дополнение = Новый Структура("ТолькоПросмотр,ЭтоНовый", Ложь, Истина);
	
	// Заполнение.
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры);
	
	ЭтотОбъект.Модуль = Перечисления.МодулиИПодсистемы.Ресторан; // Совместимость.
			
	// Заполнение значений по умолчанию.
	ОбщегоНазначения.ЗаполнитьШапкуДокумента(ЭтотОбъект, ПараметрыСеанса.ТекущийПользователь);
	
	// Структура.
	Структура = ПолучитьДанныеДокументаСтруктурой(ЭтотОбъект, Дополнение);
	
	// Изменение.
	__ВебСервисСервер.НачалоСеансаДокумента(Сеанс, ЭтотОбъект);
	
	// Параметры.
	__Восстановалеие(Сеанс, Параметры);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);

КонецФункции // СоздатьДокумент()

Функция ОткрытьДокумент(Сеанс, Документ, ТолькоПросмотр = Истина)
	
	// Параметры.
	__Входящие(Сеанс, Документ);

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(Сеанс);
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	ЕСТЬNULL(ТолькоПросмотрЗапрос.ТолькоПросмотр, &ТолькоПросмотр) КАК ТолькоПросмотр,
	                      |	ЛОЖЬ КАК ЭтоНовый
	                      |ИЗ
	                      |	Документ.РеализацияТоваровУслуг КАК ПолучаемыйДокумент
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ ПЕРВЫЕ 1
	                      |			ИСТИНА КАК ТолькоПросмотр
	                      |		ИЗ
	                      |			РегистрСведений.__ЗначенияСеансовВебСервиса КАК __ЗначенияСеансовВебСервиса
	                      |		ГДЕ
	                      |			__ЗначенияСеансовВебСервиса.Документ = &Ссылка) КАК ТолькоПросмотрЗапрос
	                      |		ПО (ИСТИНА)
	                      |ГДЕ
	                      |	ПолучаемыйДокумент.Ссылка = &Ссылка");
	Запрос.УстановитьПараметр("Ссылка", Документ);
	Запрос.УстановитьПараметр("ТолькоПросмотр", ТолькоПросмотр);
	РезультатЗапроса = Запрос.Выполнить();

	// Проверка.
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение __ВебСервисСервер.ИсключениеНедостаточноПравДоступа();
	КонецЕсли;
	
	// Получение данных.
	ЭтотОбъект = Документ.ПолучитьОбъект();
	Дополнение = __ПередачаДанныхСервер.ЗапросСтруктурой(РезультатЗапроса);
	
	// Структура.
	Структура = ПолучитьДанныеДокументаСтруктурой(ЭтотОбъект, Дополнение);
	
	// Изменение.
	Если Дополнение.ТолькоПросмотр Тогда
		ТолькоПросмотр = Истина;
	Иначе
		__ВебСервисСервер.НачалоСеансаДокумента(Сеанс, ЭтотОбъект);
	КонецЕсли;
	
	// Параметры.
	__Восстановалеие(Сеанс, Документ);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);
	
КонецФункции // ОткрытьДокумент()

Функция ПрочитатьДокумент(Сеанс)
	
	// Продление сеанса.
	ЭтотОбъект = __ВебСервисСервер.ВосстановлениеСеансаДокумента(__Из(Сеанс), Неопределено);
	
	// Проверка.
	Если (ЭтотОбъект = Неопределено) Тогда
		ВызватьИсключение __ВебСервисСервер.ИсключениеНедостаточноПравДоступа();
	КонецЕсли;
	
	// Получение данных.
	Дополнение = Новый Структура("ТолькоПросмотр,ЭтоНовый",
		Ложь,
		ЭтотОбъект.ЭтоНовый());
	
	// Структура.
	Структура = ПолучитьДанныеДокументаСтруктурой(ЭтотОбъект, Дополнение);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);
	
КонецФункции // ПрочитатьДокумент()

Функция ЗакрытьДокумент(Сеанс, Записать = Ложь)
	// Транзакционная.
	
	Перем Блокировка;
	
	// Параметры.
	__Входящие(Сеанс);
	
	// Продление сеанса.
	Если Записать Тогда
		ЭтотОбъект = __ВебСервисСервер.ВосстановлениеСеансаДокумента(Сеанс, Блокировка);
	Иначе
		__ВебСервисСервер.ПродлениеСеанса(Сеанс);
	КонецЕсли;
	
	// Запись.
	Если Записать Тогда
		ЭтотОбъект.Записать();
	КонецЕсли;
	
	// Изменение.
	__ВебСервисСервер.ЗавершениеСеансаДокумента(Сеанс);
	
	// Параметры.
	__Восстановалеие(Сеанс);
	
	// Результат.
	Возврат Истина;

КонецФункции // ЗакрытьДокумент()

Функция ИзменитьРеквизит(Сеанс, Параметры)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Сеанс, Параметры, Блокировка); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Параметры);
	
	// Операция.
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры);
	ЗаполнитьЗначенияСвойств(Параметры, ЭтотОбъект);
	
	// Пересчет.
	РеквизитыУсловияПересчета = "ДисконтнаяКарта,КатегорияДокумента,КатегорияКонтрагента,КоличествоКлиентов"; Пересчет = Ложь;
	Для Каждого Элемент Из Параметры Цикл Если Булево(Найти(РеквизитыУсловияПересчета, Элемент.Ключ)) Тогда Пересчет = Истина; Прервать; КонецЕсли; КонецЦикла;
	Если Пересчет Тогда
		ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	КонецЕсли;
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Сеанс, Параметры, ЭтотОбъект,  
		Параметры);
	
КонецФункции // ИзменитьРеквизит()

Функция ДобавитьПозицию(Сеанс, Параметры)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Сеанс, Параметры, Блокировка); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Параметры);
	
	// Операция.
	СтрокаТабличнойЧасти = ЭтотОбъект.Товары.Добавить(); ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, Параметры);

	// Проверка.
	Если Не ЗначениеЗаполнено(СтрокаТабличнойЧасти.Номенклатура) Тогда
		ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(СтрокаТабличнойЧасти.ВидНоменклатуры) Тогда	// Совместимость.
		СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар;
		СтрокаТабличнойЧасти.Владелец = Неопределено;
	КонецЕсли;
	Если Не Булево(СтрокаТабличнойЧасти.ПорядокПодачи) Тогда				// Совместимость.
		Если Булево(ЭтотОбъект.Товары.Количество() - 1) Тогда
			СтрокаТабличнойЧасти.ПорядокПодачи = ЭтотОбъект.Товары[ЭтотОбъект.Товары.Количество() - 2].ПорядокПодачи;
		КонецЕсли;
		Если Не Булево(СтрокаТабличнойЧасти.ПорядокПодачи) Тогда
			СтрокаТабличнойЧасти.ПорядокПодачи = 1;
		КонецЕсли;
	КонецЕсли;
	
	// Проверка.
	Если (Не СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар) Тогда
		Если (ЭтотОбъект.Товары.Найти(СтрокаТабличнойЧасти.Владелец, "Идентификатор") = Неопределено) Тогда
			ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
		КонецЕсли;
	КонецЕсли;
	
	// Наслдование.
	Если (Не СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар) Тогда
		ВладелецСтрокиТабличнойЧасти = ЭтотОбъект.Товары.Найти(СтрокаТабличнойЧасти.Владелец, "Идентификатор");
		ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, ВладелецСтрокиТабличнойЧасти, "Количество,НаВынос,ПорядокПодачи,Распечатан");
	КонецЕсли;
	
	ОбработкаТабличныхЧастей.УстановитьИдентификаторТабЧасти(ЭтотОбъект, СтрокаТабличнойЧасти);
	
	ОбработкаТабличныхЧастей.ПриИзмененииНоменклатурыТабЧасти(СтрокаТабличнойЧасти, ЭтотОбъект, , "Товары");
	
	ОбработкаТабличныхЧастей.ЗаполнитьЕдиницуЦенуПродажиТабЧасти(СтрокаТабличнойЧасти, ЭтотОбъект, ЭтотОбъект.мВалютаРегламентированногоУчета, ЭтотОбъект.мВалютаРегламентированногоУчета, , Истина, "Товары");
	ОбработкаТабличныхЧастей.ЗаполнитьСтавкуНДСТабЧасти(СтрокаТабличнойЧасти, ЭтотОбъект, "Реализация", "Товары");
	
	// Наслдование.
	МассивИзмененных = Новый Массив; МассивУдаленных = Новый Массив;
	МассивИзмененных.Добавить(СтрокаТабличнойЧасти);
		
	// Рассчет.
	ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	
	// Колонки.
	Колонки = __ОбщегоНазначенияСервер.Реквизиты(ЭтотОбъект, "Товары");
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Сеанс, Параметры, ЭтотОбъект,  
		Новый Структура("Позиции", Новый Структура("Измененные,Удаленные",
			__ПередачаДанныхСервер.МассивНаборовМассивомСтруктур(МассивИзмененных, Колонки),
			МассивУдаленных)));
	
КонецФункции // ДобавитьПозицию()

Функция ИзменитьПозицию(Сеанс, Параметры)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Сеанс, Параметры, Блокировка); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Параметры);
	
	// Операция.
	Если Параметры.Свойство("Идентификатор") Тогда
		СтрокаТабличнойЧасти = ЭтотОбъект.Товары.Найти(Параметры.Идентификатор, "Идентификатор");
	КонецЕсли;
	
	// Проверка.
	Если (СтрокаТабличнойЧасти = Неопределено) Тогда
		ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, Параметры, , "Идентификатор");
	
	// Наслдование.
	МассивИзмененных = Новый Массив; МассивУдаленных = Новый Массив;
	МассивИзмененных.Добавить(СтрокаТабличнойЧасти); Для Каждого СтрокаТабличнойЧасти Из МассивИзмененных Цикл
	    Для Каждого ПодчиненнаяСтрокаТабличнойЧасти Из ЭтотОбъект.Товары.НайтиСтроки(Новый Структура("Владелец", СтрокаТабличнойЧасти.Идентификатор)) Цикл
			
			ЗаполнитьЗначенияСвойств(ПодчиненнаяСтрокаТабличнойЧасти, СтрокаТабличнойЧасти, "Количество,НаВынос,НомерКлиента,ПорядокПодачи,Распечатан");
			
			МассивИзмененных.Добавить(ПодчиненнаяСтрокаТабличнойЧасти);
		КонецЦикла; 
	КонецЦикла; 
		
	// Рассчет.
	ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	
	// Колонки.
	Колонки = __ОбщегоНазначенияСервер.Реквизиты(ЭтотОбъект, "Товары");
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Сеанс, Параметры, ЭтотОбъект,  
		Новый Структура("Позиции", Новый Структура("Измененные,Удаленные",
			__ПередачаДанныхСервер.МассивНаборовМассивомСтруктур(МассивИзмененных, Колонки),
			МассивУдаленных)));
	
КонецФункции // ИзменитьПозицию()

Функция УдалитьПозицию(Сеанс, Идентификатор)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Сеанс, Идентификатор, Блокировка);
	
	// Операция.
	СтрокаТабличнойЧасти = ЭтотОбъект.Товары.Найти(Идентификатор, "Идентификатор");
	
	// Проверка.
	Если (СтрокаТабличнойЧасти = Неопределено) Тогда
		ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
	КонецЕсли;
	
	// Наслдование.
	МассивИзмененных = Новый Массив; МассивУдаленных = Новый Массив;
	МассивУдаленных.Добавить(СтрокаТабличнойЧасти); Индекс = 0; Для Каждого СтрокаТабличнойЧасти Из МассивУдаленных Цикл
	    Для Каждого ПодчиненнаяСтрокаТабличнойЧасти Из ЭтотОбъект.Товары.НайтиСтроки(Новый Структура("Владелец", СтрокаТабличнойЧасти.Идентификатор)) Цикл
			МассивУдаленных.Добавить(ПодчиненнаяСтрокаТабличнойЧасти);
		КонецЦикла;
		
		МассивУдаленных[Индекс] = СтрокаТабличнойЧасти.Идентификатор; Индекс = Индекс + 1;
		ЭтотОбъект.Товары.Удалить(СтрокаТабличнойЧасти);
	КонецЦикла; 
		
	// Рассчет.
	ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Сеанс, Идентификатор, ЭтотОбъект,  
		Новый Структура("Позиции", Новый Структура("Измененные,Удаленные", 
			МассивИзмененных,
			МассивУдаленных)));
	
КонецФункции // УдалитьПозицию()

Функция НачалоОперацииНадДокументом(Сеанс, Параметры, Блокировка)
	
	// Параметры.
	__Входящие(Сеанс, Параметры);
	
	// Продление сеанса.
	Возврат __ВебСервисСервер.ПродлениеСеансаДокумента(Сеанс, Блокировка);
	
КонецФункции // НачалоОперацииНадДокументом()

Функция ОкончаниеОперацииНадДокументом(Сеанс, Параметры, Документ, Дополнение = Неопределено)
	
	// Структура.
	Структура = ПолучитьДанныеДокументаМинимальнойСтруктурой(Документ, Дополнение);
	
	// Изменение.
	__ВебСервисСервер.ИзменениеСеансаДокумента(Сеанс, Документ);
	
	// Параметры.
	__Восстановалеие(Сеанс, Параметры);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);
	
КонецФункции // НачалоОперацииНадДокументом()

Функция ПолучитьДанныеДокументаСтруктурой(Документ, Дополнение = Неопределено)
	
	// Структура.
	Результат = Новый Структура("Ссылка,Номер,Дата,ПометкаУдаления,Проведен");
	
	// Исключения.
	ИсключаяСвойства = "АдресДоставкиДом,
					   |АдресДоставкиКомментарий,
					   |АдресДоставкиПредставление,
					   |АдресДоставкиУлица,
					   |АналитическаяГруппа,
					   |Выполненн,
					   |Выполняется,
					   |Закреплен,
					   |Контрагент,
					   |КраткийСоставДокумента,
					   |КраткийСоставПроизводства,
					   |Модуль,
					   |Ожидает,
					   |Ответственный,
					   |ОтражатьВБухгалтерскомУчете,
					   |ОтражатьВНалоговомУчете,
					   |ОтражатьВУправленческомУчете,
					   |ПостфиксСтола,
					   |ПродолжительностьДоставки,
					   |ПродолжительностьПроизводства,
					   |Сделка,
					   |Состояние,
					   |ТелефонДополнительныйПредставление,
					   |ТелефонПредставление,
					   |ТребуемаяДатаНачалаПериода,
					   |ТребуемаяДатаОкончанияПериода,
					   |ТребуемаяДатаРазделенияПериода,
					   |ФактическаяДатаНачалаПериода,
					   |ФактическаяДатаОкончанияПериода,
					   |ФиксированнаяТребуемаяДатаОкончанияПериода,
					   |Услуги";
	Исключения = Новый Структура(ИсключаяСвойства);				   
	
	// Метаданные.
	МетаданныеДокумента = __ОбщегоНазначенияСервер.Метаданные(Документ);
	Для Каждого Реквизит Из МетаданныеДокумента.Реквизиты Цикл Имя = Реквизит.Имя; Если Не Исключения.Свойство(Имя) Тогда Результат.Вставить(Имя); КонецЕсли КонецЦикла;	
	Для Каждого ТабличнаяЧасть Из МетаданныеДокумента.ТабличныеЧасти Цикл Имя = ТабличнаяЧасть.Имя; Если Не Исключения.Свойство(Имя) Тогда Результат.Вставить(Имя); КонецЕсли КонецЦикла;	
	
	// Перенос данных.
	ЗаполнитьЗначенияСвойств(Результат, Документ);
	
	// Дополнение.
	Если (Не Дополнение = Неопределено) Тогда
		Для Каждого Элемент Из Дополнение Цикл Результат.Вставить(Элемент.Ключ, Элемент.Значение); КонецЦикла;	
	КонецЕсли;
	
	// Результат.
	Возврат ПолучитьДанныеДокументаДополненнойСтруктурой(Документ, Результат);

КонецФункции // ПолучитьДанныеДокументаСтруктурой()

Функция ПолучитьДанныеДокументаМинимальнойСтруктурой(Документ, Дополнение = Неопределено)
	
	// Минимальные данные.
	Результат = Новый Структура("СуммаДокумента,СуммаДокументаБезСкидок,СуммаНаценкиДокумента,СуммаСкидкиДокумента,Скидки");
	
	// Выборка данных.
	ЗаполнитьЗначенияСвойств(Результат, Документ);
	
	// Совместимость - нужен рефакторинг ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже.
	Результат.Вставить("СуммаДокумента", Документ.Товары.Итог("Сумма"));	
	Результат.Вставить("СуммаДокументаБезСкидок", Документ.Товары.Итог("СуммаБезСкидок"));	
	Результат.Вставить("СуммаНаценкиДокумента", Документ.Товары.Итог("СуммаНаценки"));	
	Результат.Вставить("СуммаСкидкиДокумента", Документ.Товары.Итог("СуммаСкидки"));	
	
	// Значения.
	Если (Не Дополнение = Неопределено) Тогда
		Для Каждого Элемент Из Дополнение Цикл Результат.Вставить(Элемент.Ключ, Элемент.Значение); КонецЦикла;	
	КонецЕсли;
	
	// Результат.
	Возврат ПолучитьДанныеДокументаДополненнойСтруктурой(Документ, Результат);

КонецФункции // ПолучитьДанныеДокументаМинимальнойСтруктурой()

Функция ПолучитьДанныеДокументаДополненнойСтруктурой(Документ, Структура)
	
	Перем Значение;
	
	// ДисконтнаяКарта.
	Если (Структура.Свойство("ДисконтнаяКарта", Значение)) Тогда
		Структура.Вставить("ДисконтнаяКартаКодКарты", Значение.КодКарты);
		Структура.Вставить("ДисконтнаяКартаВидДисконтнойКарты", Строка(Значение.ВидДисконтнойКарты));
		Структура.Вставить("ДисконтнаяКартаВладелецКарты", Строка(Значение.ВладелецКарты));
	КонецЕсли;
	
	// Товары.
	Если (Структура.Свойство("Товары", Значение)) Тогда
		Значение = Значение.Выгрузить(); Значение.Сортировать("Распечатан УБЫВ, ПорядокПодачи, ДатаНачалаПериода");
		Структура.Вставить("Товары", Значение);
	КонецЕсли;
	
	// Скидки.
	Если (Структура.Свойство("Скидки", Значение)) Тогда
		Значение = Значение.Выгрузить(); Значение.Колонки.Добавить("ЭтоСкидка", Новый ОписаниеТипов("Булево"));
		РазделениеСкидок = __ПолучитьСвойство(Документ.ДополнительныеСвойства, "РазделениеСкидок", Новый Соответствие);
		
		Для Каждого СтрокаТабличнойЧасти Из Значение Цикл
			ЭтоСкидка = РазделениеСкидок[СтрокаТабличнойЧасти.СкидкаНаценка];
			Если (ЭтоСкидка = Неопределено) Тогда
				ЭтоСкидка = (СтрокаТабличнойЧасти.СкидкаНаценка.ПроцентСкидкиНаценки >= 0);
				РазделениеСкидок[СтрокаТабличнойЧасти.СкидкаНаценка] = ЭтоСкидка; 
			КонецЕсли;
			СтрокаТабличнойЧасти.ЭтоСкидка = ЭтоСкидка;
		КонецЦикла;
		
		Документ.ДополнительныеСвойства.Вставить("РазделениеСкидок", РазделениеСкидок);
		Структура.Вставить("Скидки", Значение);
	КонецЕсли;
	
	// Результат.
	Возврат Структура;

КонецФункции // ПолучитьДанныеДокументаДополненнойСтруктурой()

Функция GetDocumentsOpenRestaurant(Session)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	СостояниеДокументов.Документ,
	                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СостояниеДокументов.Сотрудник) КАК Сотрудник,
	                      |	СостояниеДокументов.ПолныйНомерСтола,
	                      |	СостояниеДокументов.Комментарий
	                      |ИЗ
	                      |	РегистрСведений.СостояниеДокументов КАК СостояниеДокументов
	                      |ГДЕ
	                      |	СостояниеДокументов.Документ ССЫЛКА Документ.РеализацияТоваровУслуг
	                      |	И СостояниеДокументов.Модуль = ЗНАЧЕНИЕ(Перечисление.МодулиИПодсистемы.Ресторан)
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	СостояниеДокументов.Стол.Код,
	                      |	СостояниеДокументов.ПостфиксСтола");
	// Результат.
	Возврат __В(Запрос);

КонецФункции

Функция DocumentOpen(Session)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ПродлениеСеанса(__Из(Session));
	
	Возврат __ВебСервисСервер.ПроверитьДанныеСеанса(__Из(Session), "Документ");
	
КонецФункции

Функция CreateDocument(Session, Options)
	
	// Параметры.
	__Входящие(Session, Options); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Options);
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(Session);
	
	// Получение данных.
	ЭтотОбъект = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
	Дополнение = Новый Структура("ТолькоПросмотр,ЭтоНовый", Ложь, Истина);
	
	// Заполнение.
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры);
	
	ЭтотОбъект.Модуль = Перечисления.МодулиИПодсистемы.Ресторан; // Совместимость.
	
	// Заполнение значений по умолчанию.
	ОбщегоНазначения.ЗаполнитьШапкуДокумента(ЭтотОбъект, ПараметрыСеанса.ТекущийПользователь);
	
	// Структура.
	Структура = ПолучитьДанныеДокументаСтруктурой(ЭтотОбъект, Дополнение);
	
	// Изменение.
	__ВебСервисСервер.НачалоСеансаДокумента(Session, ЭтотОбъект);
	
	// Параметры.
	__Восстановалеие(Session, Параметры);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);
	
КонецФункции

Функция OpenDocument(Session, Document, ViewOnly)
	
	// Параметры.
	__Входящие(Session, Document);
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(Session);
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	ЕСТЬNULL(ТолькоПросмотрЗапрос.ТолькоПросмотр, &ТолькоПросмотр) КАК ТолькоПросмотр,
	                      |	ЛОЖЬ КАК ЭтоНовый
	                      |ИЗ
	                      |	Документ.РеализацияТоваровУслуг КАК ПолучаемыйДокумент
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ ПЕРВЫЕ 1
	                      |			ИСТИНА КАК ТолькоПросмотр
	                      |		ИЗ
	                      |			РегистрСведений.__ЗначенияСеансовВебСервиса КАК __ЗначенияСеансовВебСервиса
	                      |		ГДЕ
	                      |			__ЗначенияСеансовВебСервиса.Документ = &Ссылка) КАК ТолькоПросмотрЗапрос
	                      |		ПО (ИСТИНА)
	                      |ГДЕ
	                      |	ПолучаемыйДокумент.Ссылка = &Ссылка");
	Запрос.УстановитьПараметр("Ссылка", Document);
	Запрос.УстановитьПараметр("ТолькоПросмотр", ViewOnly);
	РезультатЗапроса = Запрос.Выполнить();

	// Проверка.
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение __ВебСервисСервер.ИсключениеНедостаточноПравДоступа();
	КонецЕсли;
	
	// Получение данных.
	ЭтотОбъект = Document.ПолучитьОбъект();
	Дополнение = __ПередачаДанныхСервер.ЗапросСтруктурой(РезультатЗапроса);
	
	// Структура.
	Структура = ПолучитьДанныеДокументаСтруктурой(ЭтотОбъект, Дополнение);
	
	// Изменение.
	Если Дополнение.ТолькоПросмотр Тогда
		ViewOnly = Истина;
	Иначе
		__ВебСервисСервер.НачалоСеансаДокумента(Session, ЭтотОбъект);
	КонецЕсли;
	
	// Параметры.
	__Восстановалеие(Session, Document);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);

КонецФункции

Функция ReadDocument(Session)
	
	// Продление сеанса.
	ЭтотОбъект = __ВебСервисСервер.ВосстановлениеСеансаДокумента(__Из(Session), Неопределено);
	
	// Проверка.
	Если (ЭтотОбъект = Неопределено) Тогда
		ВызватьИсключение __ВебСервисСервер.ИсключениеНедостаточноПравДоступа();
	КонецЕсли;
	
	// Получение данных.
	Дополнение = Новый Структура("ТолькоПросмотр,ЭтоНовый",	Ложь, ЭтотОбъект.ЭтоНовый());
	
	// Структура.
	Структура = ПолучитьДанныеДокументаСтруктурой(ЭтотОбъект, Дополнение);
	
	// Результат.
	Возврат JSON.ЗаписатьJSON_(Структура, Ложь, Истина);

КонецФункции

Функция CloseDocument(Session, Write)
	
	// Транзакционная.
	Перем Блокировка;
	
	// Параметры.
	__Входящие(Session);
	
	// Продление сеанса.
	Если Write Тогда
		ЭтотОбъект = __ВебСервисСервер.ВосстановлениеСеансаДокумента(Session, Блокировка);
	Иначе
		__ВебСервисСервер.ПродлениеСеанса(Session);
	КонецЕсли;
	
	// Запись.
	Если Write Тогда
		ЭтотОбъект.Записать();
	КонецЕсли;
	
	// Изменение.
	__ВебСервисСервер.ЗавершениеСеансаДокумента(Session);
	
	// Параметры.
	__Восстановалеие(Session);
	
	// Результат.
	Возврат Истина;

КонецФункции

Функция ChangeProps(Session, Options)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Session, Options, Блокировка); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Options);
	
	// Операция.
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры);
	ЗаполнитьЗначенияСвойств(Параметры, ЭтотОбъект);
	
	// Пересчет.
	РеквизитыУсловияПересчета = "ДисконтнаяКарта,КатегорияДокумента,КатегорияКонтрагента,КоличествоКлиентов"; Пересчет = Ложь;
	Для Каждого Элемент Из Параметры Цикл Если Булево(Найти(РеквизитыУсловияПересчета, Элемент.Ключ)) Тогда Пересчет = Истина; Прервать; КонецЕсли; КонецЦикла;
	Если Пересчет Тогда
		ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	КонецЕсли;
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Session, Параметры, ЭтотОбъект, Параметры);

КонецФункции

Функция AddItem(Session, Options)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Session, Options, Блокировка); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Options);
	
	// Операция.
	СтрокаТабличнойЧасти = ЭтотОбъект.Товары.Добавить(); ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, Параметры);

	// Проверка.
	Если Не ЗначениеЗаполнено(СтрокаТабличнойЧасти.Номенклатура) Тогда
		ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(СтрокаТабличнойЧасти.ВидНоменклатуры) Тогда	// Совместимость.
		СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар;
		СтрокаТабличнойЧасти.Владелец = Неопределено;
	КонецЕсли;
	Если Не Булево(СтрокаТабличнойЧасти.ПорядокПодачи) Тогда				// Совместимость.
		Если Булево(ЭтотОбъект.Товары.Количество() - 1) Тогда
			СтрокаТабличнойЧасти.ПорядокПодачи = ЭтотОбъект.Товары[ЭтотОбъект.Товары.Количество() - 2].ПорядокПодачи;
		КонецЕсли;
		Если Не Булево(СтрокаТабличнойЧасти.ПорядокПодачи) Тогда
			СтрокаТабличнойЧасти.ПорядокПодачи = 1;
		КонецЕсли;
	КонецЕсли;
	
	// Проверка.
	Если (Не СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар) Тогда
		Если (ЭтотОбъект.Товары.Найти(СтрокаТабличнойЧасти.Владелец, "Идентификатор") = Неопределено) Тогда
			ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
		КонецЕсли;
	КонецЕсли;
	
	// Наслдование.
	Если (Не СтрокаТабличнойЧасти.ВидНоменклатуры = Перечисления.ТипыСтрокЗаказов.Товар) Тогда
		ВладелецСтрокиТабличнойЧасти = ЭтотОбъект.Товары.Найти(СтрокаТабличнойЧасти.Владелец, "Идентификатор");
		ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, ВладелецСтрокиТабличнойЧасти, "Количество,НаВынос,ПорядокПодачи,Распечатан");
	КонецЕсли;
	
	ОбработкаТабличныхЧастей.УстановитьИдентификаторТабЧасти(ЭтотОбъект, СтрокаТабличнойЧасти);
	
	ОбработкаТабличныхЧастей.ПриИзмененииНоменклатурыТабЧасти(СтрокаТабличнойЧасти, ЭтотОбъект, , "Товары");
	
	ОбработкаТабличныхЧастей.ЗаполнитьЕдиницуЦенуПродажиТабЧасти(СтрокаТабличнойЧасти, ЭтотОбъект, ЭтотОбъект.мВалютаРегламентированногоУчета, ЭтотОбъект.мВалютаРегламентированногоУчета, , Истина, "Товары");
	ОбработкаТабличныхЧастей.ЗаполнитьСтавкуНДСТабЧасти(СтрокаТабличнойЧасти, ЭтотОбъект, "Реализация", "Товары");
	
	// Наслдование.
	МассивИзмененных = Новый Массив; МассивУдаленных = Новый Массив;
	МассивИзмененных.Добавить(СтрокаТабличнойЧасти);
		
	// Рассчет.
	ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	
	// Колонки.
	Колонки = __ОбщегоНазначенияСервер.Реквизиты(ЭтотОбъект, "Товары");
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Session, Параметры, ЭтотОбъект,  
		Новый Структура("Позиции", Новый Структура("Измененные,Удаленные",
			__ПередачаДанныхСервер.МассивНаборовМассивомСтруктур(МассивИзмененных, Колонки),
			МассивУдаленных)));

КонецФункции

Функция ChangeItem(Session, Options)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Session, Options, Блокировка); Параметры = __ПередачаДанныхСервер.СоответствиеСтруктурой(Options);
	
	// Операция.
	Если Параметры.Свойство("Идентификатор") Тогда
		СтрокаТабличнойЧасти = ЭтотОбъект.Товары.Найти(Параметры.Идентификатор, "Идентификатор");
	КонецЕсли;
	
	// Проверка.
	Если (СтрокаТабличнойЧасти = Неопределено) Тогда
		ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, Параметры, , "Идентификатор");
	
	// Наслдование.
	МассивИзмененных = Новый Массив; МассивУдаленных = Новый Массив;
	МассивИзмененных.Добавить(СтрокаТабличнойЧасти); Для Каждого СтрокаТабличнойЧасти Из МассивИзмененных Цикл
	    Для Каждого ПодчиненнаяСтрокаТабличнойЧасти Из ЭтотОбъект.Товары.НайтиСтроки(Новый Структура("Владелец", СтрокаТабличнойЧасти.Идентификатор)) Цикл
			
			ЗаполнитьЗначенияСвойств(ПодчиненнаяСтрокаТабличнойЧасти, СтрокаТабличнойЧасти, "Количество,НаВынос,НомерКлиента,ПорядокПодачи,Распечатан");
			
			МассивИзмененных.Добавить(ПодчиненнаяСтрокаТабличнойЧасти);
		КонецЦикла; 
	КонецЦикла; 
		
	// Рассчет.
	ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	
	// Колонки.
	Колонки = __ОбщегоНазначенияСервер.Реквизиты(ЭтотОбъект, "Товары");
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Session, Параметры, ЭтотОбъект,  
		Новый Структура("Позиции", Новый Структура("Измененные,Удаленные",
			__ПередачаДанныхСервер.МассивНаборовМассивомСтруктур(МассивИзмененных, Колонки),
			МассивУдаленных)));
	
КонецФункции

Функция RemoveItem(Session, Identifier)
	
	Перем Блокировка;
	
	// Продление сеанса.
	ЭтотОбъект = НачалоОперацииНадДокументом(Session, Identifier, Блокировка);
	
	// Операция.
	СтрокаТабличнойЧасти = ЭтотОбъект.Товары.Найти(Identifier, "Идентификатор");
	
	// Проверка.
	Если (СтрокаТабличнойЧасти = Неопределено) Тогда
		ВызватьИсключение __ЛокализацияКлиентСервер.ИсключениеНедопустимыеВходящиеПараметры();
	КонецЕсли;
	
	// Наслдование.
	МассивИзмененных = Новый Массив; МассивУдаленных = Новый Массив;
	МассивУдаленных.Добавить(СтрокаТабличнойЧасти); Индекс = 0; Для Каждого СтрокаТабличнойЧасти Из МассивУдаленных Цикл
	    Для Каждого ПодчиненнаяСтрокаТабличнойЧасти Из ЭтотОбъект.Товары.НайтиСтроки(Новый Структура("Владелец", СтрокаТабличнойЧасти.Идентификатор)) Цикл
			МассивУдаленных.Добавить(ПодчиненнаяСтрокаТабличнойЧасти);
		КонецЦикла;
		
		МассивУдаленных[Индекс] = СтрокаТабличнойЧасти.Идентификатор; Индекс = Индекс + 1;
		ЭтотОбъект.Товары.Удалить(СтрокаТабличнойЧасти);
	КонецЦикла; 
		
	// Рассчет.
	ОбработкаТабличныхЧастей.РассчитатьСуммыПриПродаже(ЭтотОбъект);
	
	// Результат.
	Возврат ОкончаниеОперацииНадДокументом(Session, Identifier, ЭтотОбъект,  
		Новый Структура("Позиции", Новый Структура("Измененные,Удаленные", 
			МассивИзмененных,
			МассивУдаленных)));

КонецФункции
