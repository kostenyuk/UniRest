﻿
// Функция формирует текст в формате, необходимом для выдачи сообщений по табличной части.
//
// Параметры:
//  ИмяТЧ - Строка. Имя табличной части.
//  НомерСтроки - Число. Номер строки табличной части.
//  ИмяРеквизита - Строка. Имя реквизита.
//
// Возвращаемое значение:
//  Строка.
//
Функция ПолучитьТекстДляВыдачиСообщенийПоСтрокеТЧ(ИмяТЧ, НомерСтроки, ИмяРеквизита) Экспорт

	Возврат ИмяТЧ + "[" + Формат(НомерСтроки - 1, "ЧН=0; ЧГ=0") + "]." + ИмяРеквизита;

КонецФункции // ПолучитьТекстДляВыдачиСообщенийПоСтрокеТЧ()

// Служебная функция, предназначенная для получения описания типов числа, заданной разрядности.
// 
// Параметры:
//  Разрядность 			- число, разряд числа.
//  РазрядностьДробнойЧасти - число, разряд дробной части.
//
// Возвращаемое значение:
//  Объект "ОписаниеТипов" для числа указанной разрядности.
//
Функция ПолучитьОписаниеТиповЧисла(Разрядность, РазрядностьДробнойЧасти) Экспорт

	Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(Разрядность, РазрядностьДробнойЧасти));

КонецФункции // ПолучитьОписаниеТиповЧисла()

// Служебная функция, предназначенная для получения описания типов даты
// 
// Параметры:
//  ЧастиДаты - системное перечисление ЧастиДаты.
// 
Функция ПолучитьОписаниеТиповДаты(ЧастиДаты) Экспорт

	Возврат Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты));

КонецФункции // ПолучитьОписаниеТиповДаты()

Процедура ДобавитьСтрокиВТаблицу(Приемник, Источник) Экспорт

	Для каждого СтрокаИсточника Из Источник Цикл
		ЗаполнитьЗначенияСвойств(Приемник.Добавить(), СтрокаИсточника);
	КонецЦикла;

КонецПроцедуры

Процедура ПронумероватьТаблицуЗначений(ТЗ, ИмяКолонкиНомераСтроки) Экспорт

	ТЗ.Колонки.Добавить(ИмяКолонкиНомераСтроки, ПолучитьОписаниеТиповЧисла(15, 0));

	КоличествоСтрок = ТЗ.Количество() - 1;
	Для НомерСтроки = 0 По КоличествоСтрок Цикл
		ТЗ[НомерСтроки][ИмяКолонкиНомераСтроки] = НомерСтроки;
	КонецЦикла;

КонецПроцедуры

Процедура УстановитьНовоеЗначениеРеквизита(Знач Объект, НовоеЗначение, ИмяРеквизита) Экспорт

	Если Объект[ИмяРеквизита] <> НовоеЗначение Тогда

		Объект[ИмяРеквизита] = НовоеЗначение;

	КонецЕсли;

КонецПроцедуры

Функция ПолучитьМассивПустыхТипов(Реквизит) Экспорт

	МассивПустыхТипов = Новый Массив;
	Для Каждого ТипЗначения Из Реквизит.Тип.Типы() Цикл

		МассивПустыхТипов.Добавить(Новый (ТипЗначения));

	КонецЦикла;

	Возврат МассивПустыхТипов;

КонецФункции

Функция РаспределитьПропорционально(Знач ИсхСумма, МассивКоэф, Знач Точность = 2) Экспорт
	
	Если МассивКоэф.Количество() = 0 Или ИсхСумма = 0 Или ИсхСумма = Null Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ИндексМакс = 0;
	МаксЗнач   = 0;
	РаспрСумма = 0;
	СуммаКоэф  = 0;
	
	Для К = 0 По МассивКоэф.Количество() - 1 Цикл
		
		МодульЧисла = ?(МассивКоэф[К] > 0, МассивКоэф[К], - МассивКоэф[К]);
		
		Если МаксЗнач < МодульЧисла Тогда
			МаксЗнач = МодульЧисла;
			ИндексМакс = К;
		КонецЕсли;
		
		СуммаКоэф = СуммаКоэф + МассивКоэф[К];
		
	КонецЦикла;
	
	Если СуммаКоэф = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	МассивСумм = Новый Массив(МассивКоэф.Количество());
	
	Для К = 0 По МассивКоэф.Количество() - 1 Цикл
		МассивСумм[К] = Окр(ИсхСумма * МассивКоэф[К] / СуммаКоэф, Точность, 1);
		РаспрСумма = РаспрСумма + МассивСумм[К];
	КонецЦикла;
	
	// Погрешности округления отнесем на коэффицент с максимальным весом
	Если Не РаспрСумма = ИсхСумма Тогда
		МассивСумм[ИндексМакс] = МассивСумм[ИндексМакс] + ИсхСумма - РаспрСумма;
	КонецЕсли;
	
	Возврат МассивСумм;

КонецФункции

Функция ПолучитьПредставлениеНоменклатуры(НоменклатураПредставление, ХарактеристикаПредставление) Экспорт

	СтрПредставление = СокрЛП(НоменклатураПредставление);

	Если ЗначениеЗаполнено(ХарактеристикаПредставление)Тогда
		СтрПредставление = СтрПредставление + " / " + СокрЛП(ХарактеристикаПредставление);
	КонецЕсли;

	Возврат СтрПредставление;

КонецФункции

Функция ПолучитьЗначенияРеквизитовОбъекта(Ссылка, СтруктураПолей) Экспорт

	Результат = Новый Структура;
	Для Каждого КлючИЗначение ИЗ СтруктураПолей Цикл
		Результат.Вставить(КлючИЗначение.Ключ);
	КонецЦикла;

	ТекстЗапроса = "";
	
	ОбъектМетаданных = Ссылка.Метаданные();

	Для Каждого Элемент Из СтруктураПолей Цикл
		
		ИмяПоля = Элемент.Значение;
		
		Если НЕ ЗначениеЗаполнено(ИмяПоля) Тогда
			ИмяПоля = СокрЛП(Элемент.Ключ);
		КонецЕсли;
		
		ТекстЗапроса  = ТекстЗапроса + ?(ПустаяСтрока(ТекстЗапроса), "", ",") + "
		|	" + ИмяПоля + " КАК " + СокрЛП(Элемент.Ключ);
	КонецЦикла;

	Запрос = Новый Запрос();

	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ" + ТекстЗапроса + "
	|ИЗ
	|	" + ОбъектМетаданных.ПолноеИмя() + " КАК ТаблицаОбъекта
	|ГДЕ
	|	Ссылка = &Ссылка";

	Запрос.УстановитьПараметр("Ссылка" , Ссылка);

	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Для Каждого КлючИЗначение ИЗ СтруктураПолей Цикл
			Результат[КлючИЗначение.Ключ] = Выборка[КлючИЗначение.Ключ];
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

// Получает и возвращает запрос из переданного макета компоновки данных
//
// Параметры:
//  Макет - макет компоновки данных, из которого требуется получить запрос.
//  ИмяНабораДанных - имя набора данных из макета, для которого получается запрос.
//
// Возвращаемое значение:
//  Запрос, сформированный на основании макета компоновки
//
Функция ПолучитьЗапросИзМакетаКомпоновки(Макет, ИмяНабораДанных) Экспорт

	Запрос = Новый Запрос(Макет.НаборыДанных[ИмяНабораДанных].Запрос);

	Для Каждого Параметр Из Макет.ЗначенияПараметров Цикл
		Запрос.УстановитьПараметр(Параметр.Имя, Параметр.Значение);
	КонецЦикла;

	Возврат Запрос;

КонецФункции

// Получает и возвращает макет компоновки данных для схемы компоновки
//
// Параметры:
//  СхемаКомпоновки - схема компоновки данных, для которой получается макет компоновки
//  Настройки - настройки компоновки, применяемые к схеме
//
// Возвращаемое значение:
//  Макет компоновки данных
//
Функция ПолучитьМакетКомпоновки(СхемаКомпоновки, Настройки) Экспорт

	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;

	Возврат КомпоновщикМакета.Выполнить(СхемаКомпоновки, Настройки, , , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ДЛЯ ПОЛУЧЕНИЯ ПРЕДСТАВЛЕНИЯ ДАННЫХ
//

Функция ПолучитьПредставлениеДокумента(Ссылка, Номер, Дата) Экспорт
	
	Возврат Ссылка.Метаданные().Синоним + " " + Номер + " от " + Формат(Дата,"ДЛФ=D");
	
КонецФункции // ПолучитьПредставлениеДокумента()

Функция ПолучитьПредставлениеПериода(ДатаНачалаПериода, ДатаОкончанияПериода) Экспорт
	
	Возврат ПредставлениеПериода(ДатаНачалаПериода, ДатаОкончанияПериода);
	
КонецФункции // ПолучитьПредставлениеПериода()

// Возвращает сокращенное строковое представление коллекции значений
// 
// Параметры:
//  Коллекция 						- массив или список значений.
//  МаксимальноеКоличествоЭлементов - число, максимальное количество элементов включаемое в представление.
//
// Возвращаемое значение:
//  Строка.
//
Функция ПолучитьСокращенноеПредставлениеКоллекцииЗначений(Коллекция, МаксимальноеКоличествоЭлементов = 2) Экспорт
	
	СтрокаПредставления = "";
	
	КоличествоЗначений			 = Коллекция.Количество();
	КоличествоВыводимыхЭлементов = Мин(КоличествоЗначений, МаксимальноеКоличествоЭлементов);
	
	Если КоличествоВыводимыхЭлементов = 0 Тогда
		
		Возврат "";
		
	Иначе
		
		Для НомерЗначения = 1 По КоличествоВыводимыхЭлементов Цикл
			
			СтрокаПредставления = СтрокаПредставления + Коллекция.Получить(НомерЗначения - 1) + ", ";	
			
		КонецЦикла;
		
		СтрокаПредставления = Лев(СтрокаПредставления, СтрДлина(СтрокаПредставления) - 2);
		Если КоличествоЗначений > КоличествоВыводимыхЭлементов Тогда
			СтрокаПредставления = СтрокаПредставления + ", ... ";
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат СтрокаПредставления;
	
КонецФункции


 
//// Получает структуру для индикации прогресса цикла.
////
//// Параметры:
////  КоличествоПроходов – Число - максимальное значение счетчика;
////  ПредставлениеПроцесса – Строка, "Выполнено" – отображаемое название процесса;
////  ВнутреннийСчетчик - Булево, *Истина - использовать внутренний счетчик с начальным значением 1,
////                    иначе нужно будет передавать значение счетчика при каждом вызове обновления индикатора;
////  КоличествоОбновлений - Число, *100 - всего количество обновлений индикатора;
////  ЛиВыводитьВремя - Булево, *Истина - выводить приблизительное время до окончания процесса;
////  РазрешитьПрерывание - Булево, *Истина - разрешает пользователю прерывать процесс.
////  МинимальныйПериодОбновления - Число, *1 - с, обновлять не чаще чем этот период, 0 - по количеству обновлений,
////                    эта реализация не поддерживает дробные значения;
////
//// Возвращаемое значение:
////  Структура - которую потом нужно будет передавать в метод ЛксОбработатьИндикатор.
//// 
////Ключевым моментом в ЛксОбработатьИндикатор() для обновления состояния является требование выполнения
////в общем случае двух (любое можно отключить) условий:
////- прошло минимальное время с момента последнего обновления
////- не превысить заданное общее число обновлений
////
////
////Вот пример их использования.
////
////КоличествоДанных = 100000;
////Индикатор = ЛксПолучитьИндикаторПроцесса(КоличествоДанных, "Проверка данных");
////Для Счетчик = 1 По КоличествоДанных Цикл              
//// ЛксОбработатьИндикатор(Индикатор, Счетчик);
////КонецЦикла;
////
////КоличествоДанных = 100000;
////Индикатор = ЛксПолучитьИндикаторПроцесса(КоличествоДанных, "Проверка данных", Истина);
////Для Счетчик = 1 По КоличествоДанных Цикл              
//// ЛксОбработатьИндикатор(Индикатор);
////КонецЦикла;
//Функция ЛксПолучитьИндикаторПроцесса(Знач КоличествоПроходов = 0, ПредставлениеПроцесса = "Выполнение", ВнутреннийСчетчик = Истина,
//	Знач КоличествоОбновлений = 100, ЛиВыводитьВремя = Истина, РазрешитьПрерывание = Истина, МинимальныйПериодОбновления = 1) Экспорт

//	Индикатор = Новый Структура;
//	Если КоличествоПроходов = 0 Тогда
//		Состояние(ПредставлениеПроцесса + "...");
//		КоличествоПроходов = 1;
//	КонецЕсли;
//	Индикатор.Вставить("КоличествоПроходов", КоличествоПроходов);
//	Индикатор.Вставить("ПредставлениеПроцесса", ПредставлениеПроцесса);
//	Индикатор.Вставить("ЛиВыводитьВремя", ЛиВыводитьВремя);
//	Индикатор.Вставить("РазрешитьПрерывание", РазрешитьПрерывание);

//	Индикатор.Вставить("ДатаНачалаПроцесса", ТекущаяДата());

//	Индикатор.Вставить("МинимальныйПериодОбновления", МинимальныйПериодОбновления);
//	Индикатор.Вставить("ДатаСледующегоОбновления", Дата('00010101'));

//	Индикатор.Вставить("ВнутреннийСчетчик", ВнутреннийСчетчик);
//	Если КоличествоОбновлений > 0 Тогда
//		Шаг = КоличествоПроходов / КоличествоОбновлений;
//	Иначе
//		Шаг = 0;
//	КонецЕсли;
//	Индикатор.Вставить("Шаг", Шаг);
//	Индикатор.Вставить("СледующийСчетчик", 0);
//	Индикатор.Вставить("Счетчик", 0);
//	Возврат Индикатор;

//КонецФункции // ЛксПолучитьИндикаторПроцесса()

//// Проверяет и обновляет индикатор. Нужно вызывать на каждом проходе индицируемого цикла.
////
//// Параметры:
////  Индикатор    – Структура – индикатора, полученная методом ЛксПолучитьИндикаторПроцесса;
////  Счетчик      – Число – внешний счетчик цикла, используется при ВнутреннийСчетчик = Ложь.
////
//Процедура ЛксОбработатьИндикатор(Индикатор, Счетчик = 0) Экспорт

//	Если Индикатор.ВнутреннийСчетчик Тогда
//		Счетчик = Индикатор.Счетчик + 1;
//		Индикатор.Счетчик = Счетчик;
//	КонецЕсли;
//	Если Индикатор.РазрешитьПрерывание Тогда
//		ОбработкаПрерыванияПользователя();
//	КонецЕсли;
//	ОбновитьИндикатор = Истина;
//	ТекущаяДата = ТекущаяДата();
//	Если Индикатор.МинимальныйПериодОбновления > 0 Тогда
//		Если ТекущаяДата >= Индикатор.ДатаСледующегоОбновления Тогда
//			Индикатор.ДатаСледующегоОбновления = ТекущаяДата + Индикатор.МинимальныйПериодОбновления;
//		Иначе
//			ОбновитьИндикатор = Ложь;
//		КонецЕсли;
//	КонецЕсли;
//	Если ОбновитьИндикатор Тогда
//		Если Индикатор.Шаг > 0 Тогда
//			Если Счетчик >= Индикатор.СледующийСчетчик Тогда
//				Индикатор.СледующийСчетчик = Цел(Счетчик + Индикатор.Шаг);
//			Иначе
//				ОбновитьИндикатор = Ложь;
//			КонецЕсли;
//		КонецЕсли;
//	КонецЕсли;
//	Если ОбновитьИндикатор Тогда
//		Индикатор.СледующийСчетчик = Цел(Счетчик + Индикатор.Шаг);
//		Если Индикатор.ЛиВыводитьВремя Тогда
//			ТекущаяДата = ТекущаяДата();
//			ПрошлоВремени = ТекущаяДата - Индикатор.ДатаНачалаПроцесса;
//			Осталось = ПрошлоВремени * (Индикатор.КоличествоПроходов / Счетчик - 1);
//			Часов = Цел(Осталось / 3600);
//			Осталось = Осталось - (Часов * 3600);
//			Минут = Цел(Осталось / 60);
//			Секунд = Цел(Цел(Осталось - (Минут * 60)));
//			ОсталосьВремени = Формат(Часов, "ЧЦ=2; ЧН=00; ЧВН=") + ":"
//				+ Формат(Минут, "ЧЦ=2; ЧН=00; ЧВН=") + ":"
//				+ Формат(Секунд, "ЧЦ=2; ЧН=00; ЧВН=");
//			ТекстОсталось = "Осталось: ~" + ОсталосьВремени;
//		Иначе
//			ТекстОсталось = "";
//		КонецЕсли;
//		ТекстСостояния = Индикатор.ПредставлениеПроцесса + " "
//			+ Формат(Счетчик / Индикатор.КоличествоПроходов * 100, "ЧЦ=3; ЧДЦ=0") + "%  " + ТекстОсталось;
//		Если ТипЗнч(Индикатор) = Тип("СтрокаТаблицыЗначений") Тогда
//			ТаблицаИндикаторов = Индикатор.Владелец();
//			ИндексИндикатора = ТаблицаИндикаторов.Индекс(Индикатор);
//			Если ИндексИндикатора > 0 Тогда
//				ТекстСостояния = ТаблицаИндикаторов[ИндексИндикатора - 1].ТекстСостояния + " >> " + ТекстСостояния;
//			КонецЕсли;
//			Индикатор.ТекстСостояния = ТекстСостояния;
//		КонецЕсли;
//		Состояние(ТекстСостояния);
//	КонецЕсли;
//	Если Счетчик = Индикатор.КоличествоПроходов Тогда
//		Состояние("");
//	КонецЕсли;

//КонецПроцедуры // ЛксОбработатьИндикатор()



////////////////////////////////////////////////////////////////////////////////
// ПРОЧИЕ ПРОЦЕДУРЫ И ФУНКЦИИ
//
 	
Процедура ПолучитьСсылкуИзОбъектаСправочника(ИмяОбъектаИлиСсылки, ЧтоПолучить = "Объект", Знач ЗначениеОбъекта, ЗначениеРезультата = Неопределено) Экспорт 	
		Если ЗначениеРезультата <> Неопределено Тогда
			ЗначениеРезультата = Неопределено;
		КонецЕсли;
		Если ТипЗнч(ЗначениеОбъекта) =  Вычислить("Тип(""СправочникОбъект."+ ИмяОбъектаИлиСсылки+""")") Тогда
			Если ЧтоПолучить = "Ссылка" Тогда
				ЗначениеРезультата = ЗначениеОбъекта.Ссылка;
			ИначеЕсли ЧтоПолучить = "Объект" Тогда
				ЗначениеРезультата = ЗначениеОбъекта;	
			КонецЕсли;
		ИначеЕсли  ТипЗнч(ЗначениеОбъекта) = Вычислить("Тип(""СправочникСсылка."+ ИмяОбъектаИлиСсылки+""")") Тогда 
			Если ЧтоПолучить = "Ссылка" Тогда
				  ЗначениеРезультата = ЗначениеОбъекта;
			ИначеЕсли ЧтоПолучить = "Объект" Тогда		
				ЗначениеРезультата = ЗначениеОбъекта.ПолучитьОбъект();
			КонецЕсли;
		КонецЕсли;		
	КонецПроцедуры

// Осуществляет проверку заполненности проверяемых реквизитов.
//
// Параметры:
// Объект               - ДокументОбъект, СправочникОбъект - Проверяемый объект.
// ПроверяемыеРеквизиты - Массив - массив проверяемых реквизитов.
//
// Возвращаемое значение:
// Булево - Истина, если значение хотя бы одного реквизита не заполнено, иначе Ложь
//
Функция ПроверитьЗаполнениеРеквизитовОбъекта(Объект, ПроверяемыеРеквизиты) Экспорт
	
	Для Каждого Реквизит Из ПроверяемыеРеквизиты Цикл
		
		ПозицияТочки = Найти(Реквизит,".");
		
		Если ПозицияТочки > 0 Тогда
			
			ДлинаСтроки       = СтрДлина(Реквизит);
			ИмяТабличнойЧасти = Лев(Реквизит, ПозицияТочки-1);
			ИмяРеквизита      = Прав(Реквизит, ДлинаСтроки - ПозицияТочки);
			
			Для Каждого ТекСтрока Из Объект[ИмяТабличнойЧасти] Цикл
				
				Если Не ЗначениеЗаполнено(ТекСтрока[ИмяРеквизита]) Тогда
					
					Возврат Истина;
					
				КонецЕсли;
				
			КонецЦикла;
			
		Иначе
			
			Если Не ЗначениеЗаполнено(Объект[Реквизит]) Тогда
				
				Возврат Истина;
				
			КонецЕсли;
			
		КонецЕсли;
			
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

// Осуществляет проверку заполненности проверяемых реквизитов.
//
// Параметры:
// Документ           - ДокументСсылка - Документ, на основании которого осуществляется ввод
// Статус             - Статус документ, на основании которого осуществляется ввод
// ЕстьОшибкиПроведен - Булево - Если Истина - документ, на основании которого осуществляется ввод, не проведен
// ЕстьОшибкиСтатус   - Булево - Если Истина - документ, на основании которого осуществляется ввод, имеет некорректный статус
//
Процедура ПроверитьВозможностьВводаНаОсновании(Документ, Статус = Неопределено, ЕстьОшибкиПроведен = Ложь, ЕстьОшибкиСтатус = Ложь, МассивДопустимыхСтатусов = Неопределено) Экспорт
	
	Если ЕстьОшибкиПроведен Тогда
		
		ТекстОшибки = НСтр("ru='Документ %Документ% не проведен. Ввод на основании непроведенного документа невозможен.'");
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Документ%", Документ);
	
		ВызватьИсключение ТекстОшибки;
		
	ИначеЕсли ЕстьОшибкиСтатус Тогда
		
		Если МассивДопустимыхСтатусов = Неопределено Тогда
			ТекстОшибки = НСтр("ru='Документ %Документ% находится в статусе ""%Статус%"". Ввод на основании невозможен.'");
		ИначеЕсли ТипЗнч(МассивДопустимыхСтатусов) = Тип("Массив") Тогда
			
			ТекстОшибки = НСтр("ru='Документ %Документ% находится в статусе ""%Статус%"". Ввод на основании возможен в %СтрокаДопустимыхСтатусов%.'");
			СтрокаДопустимыхСтатусов = "";
			
			Для Каждого ДопустимыйСтатус Из МассивДопустимыхСтатусов Цикл
				СтрокаДопустимыхСтатусов = СтрокаДопустимыхСтатусов + """"+ ДопустимыйСтатус + """, ";
			КонецЦикла;
			
			СтрокаДопустимыхСтатусов = Лев(СтрокаДопустимыхСтатусов, СтрДлина(СтрокаДопустимыхСтатусов)-2);
			
			Если МассивДопустимыхСтатусов.Количество() = 0 Тогда
				ТекстОшибки = НСтр("ru='Документ %Документ% находится в статусе ""%Статус%"". Ввод на основании невозможен.'");
			ИначеЕсли МассивДопустимыхСтатусов.Количество() = 1 Тогда
				ТекстОшибки = НСтр("ru='Документ %Документ% находится в статусе ""%Статус%"". Ввод на основании возможен только в статусе %СтрокаДопустимыхСтатусов%.'");
				ТекстОшибки = СтрЗаменить(ТекстОшибки, "%СтрокаДопустимыхСтатусов%", СтрокаДопустимыхСтатусов);
			Иначе
				ТекстОшибки = НСтр("ru='Документ %Документ% находится в статусе ""%Статус%"". Ввод на основании возможен только в статусах %СтрокаДопустимыхСтатусов%.'");
				ТекстОшибки = СтрЗаменить(ТекстОшибки, "%СтрокаДопустимыхСтатусов%", СтрокаДопустимыхСтатусов);
			КонецЕсли;
			
		КонецЕсли;
		
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Документ%", Документ);
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Статус%",   Статус);
	
		ВызватьИсключение ТекстОшибки;
		
	КонецЕсли;
	
КонецПроцедуры // ПроверитьВозможностьВводаНаОсновании()

// Осуществляет проверку заполненности проверяемых реквизитов.
//
// Параметры:
// ЕстьОшибкиТиповое  - Булево - Если Истина - соглашение, на основании которого осуществляется ввод - типовое
//
Процедура ПроверитьВозможностьВводаНаОснованииСоглашения(ЕстьОшибкиТиповое) Экспорт
	
	Если ЕстьОшибкиТиповое Тогда
		
		ТекстОшибки = НСтр("ru='Ввод на основании типового соглашения с клиентом невозможен.'");
	
		ВызватьИсключение ТекстОшибки;
		
	КонецЕсли;
	
КонецПроцедуры // ПроверитьВозможностьВводаНаОснованииСоглашения()

// Устанавливает или сбрасывает флаг Согласован у справочника.
// Вызывается из процедуры ПередЗаписью документа.
//
// Параметры:
// ДокументОбъект     - СправочникОбъект - Справочник, в котором необходимо изменить флаг Согласован
// СтатусНеСогласован - Статус документа, в котором флаг Согласован должен быть сброшен
//
Процедура ИзменитьПризнакСогласованностиСправочника(СправочникОбъект, Знач СтатусНеСогласован = Неопределено) Экспорт
	
	// Справочник не имеет статуса
	Если СтатусНеСогласован = Неопределено Тогда
		
		Если Не СправочникОбъект.Согласован Тогда
			СправочникОбъект.Согласован = Истина;
		КонецЕсли;
		
	// Справочник имеет статус, в котором проведенный справочник не согласован
	Иначе
		
		Если СправочникОбъект.Статус = СтатусНеСогласован И СправочникОбъект.Согласован Тогда
			СправочникОбъект.Согласован = Ложь;
		ИначеЕсли СправочникОбъект.Статус <> СтатусНеСогласован И Не СправочникОбъект.Согласован Тогда
			СправочникОбъект.Согласован = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры // ИзменитьПризнакСогласованностиСправочника()

// Устанавливает или сбрасывает флаг Согласован у документа.
// Вызывается из процедуры ПередЗаписью документа.
//
// Параметры:
// ДокументОбъект     - ДокументОбъект - Документ, в котором необходимо изменить флаг Согласован
// РежимЗаписи        - Режим записи документа
// СтатусНеСогласован - Статус документа, в котором флаг Согласован должен быть сброшен
//
Процедура ИзменитьПризнакСогласованностиДокумента(ДокументОбъект, Знач РежимЗаписи, Знач СтатусНеСогласован = Неопределено) Экспорт
	
	Если РежимЗаписи = РежимЗаписиДокумента.Запись Или
		 РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		
		Если ДокументОбъект.Согласован Тогда
			ДокументОбъект.Согласован = Ложь;
		КонецЕсли;
		
	ИначеЕсли РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		// Документ не имеет статуса
		Если СтатусНеСогласован = Неопределено Тогда
		
			Если Не ДокументОбъект.Согласован Тогда
				ДокументОбъект.Согласован = Истина;
			КонецЕсли;
			
		// Документ имеет статус из массива, в которых проведенный документ не согласован
		ИначеЕсли ТипЗнч(СтатусНеСогласован) = Тип("Массив") Тогда
			
			Если ДокументОбъект.Согласован Тогда
				
				Для Каждого ТекСтатус Из СтатусНеСогласован Цикл
					
					Если ДокументОбъект.Статус = ТекСтатус Тогда
						
						ДокументОбъект.Согласован = Ложь;
						Прервать;
						
					КонецЕсли;
					
				КонецЦикла;
				
			Иначе
				
				ДокументСогласован = Истина;
				
				Для Каждого ТекСтатус Из СтатусНеСогласован Цикл
					
					Если ДокументОбъект.Статус = ТекСтатус Тогда
						ДокументСогласован = Ложь;
					КонецЕсли;
					
				КонецЦикла;
				
				Если ДокументСогласован Тогда
					ДокументОбъект.Согласован = Истина;
				КонецЕсли;
				
			КонецЕсли;
			
		// Документ имеет статус, в котором проведенный документ не согласован
		Иначе
			
			Если ДокументОбъект.Статус = СтатусНеСогласован И ДокументОбъект.Согласован Тогда
				ДокументОбъект.Согласован = Ложь;
			ИначеЕсли ДокументОбъект.Статус <> СтатусНеСогласован И Не ДокументОбъект.Согласован Тогда
				ДокументОбъект.Согласован = Истина;
			КонецЕсли;
			
		КонецЕсли;

	КонецЕсли;
	
КонецПроцедуры // ИзменитьПризнакСогласованностиДокумента()

// Функция заполняет структуру значениями перечисления
//
// Параметры
//  ИмяПеречисления  - строка - имя перечисления
//  Включать  пустую ссылку  - булево - добавлять ли в структуру значение пустой ссылки
//                 
// Возвращаемое значение:
//   СтруктураВозврата   - Структура содержащая значения перечисления,
//                         в том числе пустое значение.
Функция ПолучитьСтруктуруЗначенияПеречисления(ИмяПеречисления, ВключатьПустуюСсылку = ЛОЖЬ) Экспорт
	
	СтруктураВозврата   = Новый Структура;
	Для каждого ЭлементМетаданных Из Метаданные.Перечисления[ИмяПеречисления].ЗначенияПеречисления Цикл
		СтруктураВозврата.Вставить(ЭлементМетаданных.Имя,Перечисления[ИмяПеречисления][ЭлементМетаданных.Имя]);
	КонецЦикла;
	
	Если ВключатьПустуюСсылку Тогда
		СтруктураВозврата.Вставить("ПустаяСсылка",Перечисления[ИмяПеречисления].ПустаяСсылка());
	КонецЕсли;		
	
	Возврат СтруктураВозврата;	
	
КонецФункции // ПолучитьСтруктуруЗначенияПеречисления()

// Процедура устанавливает блокировку документа для редактирования.
//
// Параметры:
//	ДокументСсылка - документ, на который устанавливается блокировка
//	ОтменятьТранзакцию - Булево - Признак необходимости отмены транзакции
//
Процедура ЗаблокироватьДокументДляРедактирования(ДокументСсылка, ОтменятьТранзакцию = Ложь) Экспорт
	
	Попытка
		ЗаблокироватьДанныеДляРедактирования(ДокументСсылка);
	Исключение
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Не удалось заблокировать %1. %2'"),
			ДокументСсылка,
			КраткоеПредставлениеОшибки(ИнформацияОбОшибке())
		);
		Если ОтменятьТранзакцию Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение ТекстОшибки;
	КонецПопытки;
	
КонецПроцедуры // ЗаблокироватьДокументДляРедактирования()
