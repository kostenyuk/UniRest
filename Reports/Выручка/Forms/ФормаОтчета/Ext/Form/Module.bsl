﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Локальные переменные
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	ОтчетМетаданные = ОтчетОбъект.Метаданные();
	
	РежимРасшифровки = (Параметры.Свойство("Расшифровка") И Параметры.Расшифровка <> Неопределено);
	РежимВариантаОтчета = (Параметры.Свойство("КлючВарианта") И Параметры.КлючВарианта <> Неопределено);
	КлючОбъекта = ОтчетМетаданные.ПолноеИмя();
	НаименованиеОтчета = СокрЛП(ОтчетМетаданные.Представление());
	ПравоВывода = ПравоДоступа("Вывод", Метаданные);
	
	НастройкиОтчета = ОтчетОбъект.ПолучитьНастройкиОтчета();
	
	// Параметры печати печати и сохранения положения окна.
	УстановитьКлючиФормы();
	
	// Параметры формы
	ЭтаФормаПараметры = Новый Структура(
		"КлючНазначенияИспользования, КлючПользовательскихНастроек,
		|Расшифровка, СформироватьПриОткрытии, ТолькоПросмотр,
		|ФиксированныеНастройки, ОтчетСсылка");
	ЗаполнитьЗначенияСвойств(ЭтаФормаПараметры, Параметры);
	Если НЕ ЗначениеЗаполнено(ЭтаФормаПараметры.ОтчетСсылка) Тогда
		ОтчетИнформация = ВариантыОтчетов.СформироватьИнформациюОбОтчетеПоПолномуИмени(КлючОбъекта);
		Если НЕ ЗначениеЗаполнено(ОтчетИнформация.ТекстОшибки) Тогда
			ЭтаФормаПараметры.ОтчетСсылка = ОтчетИнформация.Отчет;
		Иначе
			ЭтаФормаПараметры.ОтчетСсылка = КлючОбъекта;
		КонецЕсли;
	КонецЕсли;
	
	ЭтаФормаПараметры = Новый ФиксированнаяСтруктура(ЭтаФормаПараметры);
	
	ВариантСсылка = ВариантыОтчетов.ПолучитьСсылку(ЭтаФормаПараметры.ОтчетСсылка, КлючТекущегоВарианта);
	
	// Регистрация элементов, команд и реквизитов формы, которые не удаляются при перезаполнении быстрых настроек
	НаборРеквизитов = ПолучитьРеквизиты();
	Для Каждого Реквизит Из НаборРеквизитов Цикл
		ПостоянныеРеквизиты.Добавить(Реквизит.Имя);
	КонецЦикла;
	
	Для Каждого Команда Из Команды Цикл
		ПостоянныеКоманды.Добавить(Команда.Имя);
	КонецЦикла;
	
	// Заполнение списка выбора интервала
	ЗаполнитьИнтервалНаСервере();
	
	// Заполнение периода	
	ЗаполнитьНачальноеЗначениеПериодов();
	
	// Заполнение начальных значений полей отборов
	ЗаполнитьНачальныеЗначенияПолейОтборов();
	
	// Установка видимости элементов
	УставновитьВидимостьНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеВариантаНаСервере(Настройки)
	
	// Загрузка фиксированных настроек для режима расшифровки.
	Если РежимРасшифровки Тогда
		Если Параметры <> Неопределено И Параметры.Свойство("Расшифровка") Тогда
			Отчет.КомпоновщикНастроек.ЗагрузитьФиксированныеНастройки(Параметры.Расшифровка.ПрименяемыеНастройки);
			Отчет.КомпоновщикНастроек.ФиксированныеНастройки.ДополнительныеСвойства.Вставить("РежимРасшифровки", Истина);
		КонецЕсли;
	КонецЕсли;

	// Параметры печати печати и сохранения положения окна.
	УстановитьКлючиФормы();
	
	// Заполнение панели настроек
	РежимВариантаОтчета = Истина;
	ВариантСсылка = ВариантыОтчетов.ПолучитьСсылку(ЭтаФормаПараметры.ОтчетСсылка, КлючТекущегоВарианта);
	
	НастройкиЗагрузитьСхему(Настройки, Неопределено);
	
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииВариантаНаСервере(Настройки)
	// Заголовок
	УставновитьВидимостьНаСервере("ВариантОтчета");
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если Параметр = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметр.Имя = "Рестораны" Тогда
		Отчет.ОтборРесторан = Параметр.Значение;
	ИначеЕсли Параметр.Имя = "ВидыОплатЧекаККМ" Тогда
		Отчет.ОтборОплата = Параметр.Значение;
	КонецЕсли;
	
	НастройкиЗагрузитьСхему("СброситьНастройки", Неопределено);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ОтборРесторанНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОткрытьФормуВыбора(Элемент, "Рестораны");
КонецПроцедуры

&НаКлиенте
Процедура ОтборОплатаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОткрытьФормуВыбора(Элемент, "ВидыОплатЧекаККМ");
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура Сформировать(Команда)
	СформироватьОтчет();
КонецПроцедуры

&НаКлиенте
Процедура ПериодРегулированиеЛево(Команда)
	ПериодРегулирование(-1);
	ОбновитьПредставлениеПериода();
КонецПроцедуры

&НаКлиенте
Процедура ПериодРегулированиеПраво(Команда)
	ПериодРегулирование(1);
	ОбновитьПредставлениеПериода();
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьФильтры(Команда)
	ПоказатьСкрытьНастройки("Фильтры");
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура ПериодРегулирование(Направление = 1)
	
	Если Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Месяц") Тогда
		
		МесяцДатаНачала 	= НачалоМесяца(ДобавитьМесяц(МесяцДатаНачала,	 1*Направление));
		МесяцДатаОкончания  = КонецМесяца (ДобавитьМесяц(МесяцДатаОкончания, 1*Направление));
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСкрытьНастройки(Элемент = "Фильтры")
	
	СостояниеДоИзменения = Новый Структура("Видимость, ДополнительныйРежимОтображения, Картинка, Текст");
	ЗаполнитьЗначенияСвойств(СостояниеДоИзменения, Элементы.ОтчетТабличныйДокумент.ОтображениеСостояния);
	
	Отчет.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(Элемент, НЕ Элементы["Группа"+Элемент+"Низ"].Видимость);
	УставновитьВидимостьНаСервере(Элемент);
	
	ЗаполнитьЗначенияСвойств(Элементы.ОтчетТабличныйДокумент.ОтображениеСостояния, СостояниеДоИзменения);
	
КонецПроцедуры  

&НаКлиенте
Процедура ОткрытьФормуВыбора(Элемент, ИмяСправочника)
	
	// Получим ключ уникальности открываемой формы
	КлючУникальности = Строка(Новый УникальныйИдентификатор);
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ИмяСправочника"		, ИмяСправочника);
	ПараметрыОткрытия.Вставить("ИмяПараметра"		, "СписокОтмеченных");
	ПараметрыОткрытия.Вставить("ЗначениеПараметра"	, Отчет[Элемент.Имя]);
	
	ОткрытьФорму("Отчет.Выручка.Форма.ФормаВыбора", ПараметрыОткрытия, ЭтаФорма, КлючУникальности);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// Клиент или сервер

&НаКлиентеНаСервереБезКонтекста
Функция ПривестиИдентификаторКИмени(Идентификатор)
	Возврат СтрЗаменить(Строка(Идентификатор), "-", "");
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Процедура УстановитьКлючиФормы()
	Если ПравоВывода Тогда
		//ЗаполнитьЗначенияСвойств(ОтчетТабличныйДокумент, НастройкиОтчета.ПараметрыПечатиПоУмолчанию);
		
		Уникальность = КлючОбъекта;
		Если ЗначениеЗаполнено(КлючТекущегоВарианта) Тогда
			Уникальность = Уникальность + "/КлючВарианта." + КлючТекущегоВарианта;
		КонецЕсли;
		
		ОтчетТабличныйДокумент.КлючПараметровПечати = Уникальность;
		КлючСохраненияПоложенияОкна = Уникальность;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПоказатьОшибкиФормирования(ИнформацияОбОшибке)
	
	ОписаниеОшибки = ФункцииОтчетовКлиентСервер.КраткоеПредставлениеОшибкиФормированияОтчета(ИнформацияОбОшибке);
	
	ОтображениеСостояния = Элементы.ОтчетТабличныйДокумент.ОтображениеСостояния;
	ОтображениеСостояния.Видимость                      = Истина;
	ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.Неактуальность;
	ОтображениеСостояния.Картинка                       = Новый Картинка;
	ОтображениеСостояния.Текст                          = ?(ПустаяСтрока(ОписаниеОшибки), ПодробноеПредставлениеОшибки(ИнформацияОбОшибке), ОписаниеОшибки);
	
КонецПроцедуры

&НаСервере
Процедура НастройкиЗагрузитьСхему(НовыеНастройки, ИзмененияИзФормыВариантаОтчета)
	
	Если НовыеНастройки <> Неопределено Тогда
		ОтображениеСостояния = Элементы.ОтчетТабличныйДокумент.ОтображениеСостояния;
		ОтображениеСостояния.Видимость = Истина;
		ОтображениеСостояния.Текст     = НСтр("ru = 'Отчет не сформирован. Нажмите ""Сформировать"" для получения отчета.'");
		ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.Неактуальность;
	КонецЕсли;
	
	Если ТипЗнч(НовыеНастройки) = Тип("КомпоновщикНастроекКомпоновкиДанных") Тогда
		
		ПользовательскиеНастройкиМодифицированы = Истина;
		
		// Включение флажка "ВариантМодифицирован"...
		Если ИзмененияИзФормыВариантаОтчета = Истина Тогда
			// ... если редактировался вариант отчета.
			ВариантМодифицирован = Истина;
		ИначеЕсли ИзмененияИзФормыВариантаОтчета = Ложь И ВариантМодифицирован = Ложь Тогда
			// ... если в результате изменения пользовательских настроек так же изменился их состав.
			ПользовательскиеНастройкиКД = НовыеНастройки.ПользовательскиеНастройки;
			КоличествоНовыхНастроек = 0;
			Режимы = РежимОтображенияЭлементаНастройкиКомпоновкиДанных;
			Для Каждого ПользовательскаяНастройка Из ПользовательскиеНастройкиКД.Элементы Цикл
				Если ПользовательскаяНастройка.РежимОтображения = Режимы.Недоступный ИЛИ ПользовательскаяНастройка.РежимОтображения = Режимы.Обычный Тогда
					Продолжить;
				КонецЕсли;
				ИдентификаторСКД = ПользовательскаяНастройка.ИдентификаторПользовательскойНастройки;
				ИдентификаторЭлемента = ПривестиИдентификаторКИмени(ИдентификаторСКД);
				Если БыстрыйПоискПользовательскихНастроек.Получить(ИдентификаторЭлемента) = Неопределено Тогда
					ВариантМодифицирован = Истина;
					Прервать;
				КонецЕсли;
				КоличествоНовыхНастроек = КоличествоНовыхНастроек + 1;
			КонецЦикла;
			Если БыстрыйПоискПользовательскихНастроек.Количество() <> КоличествоНовыхНастроек Тогда
				ВариантМодифицирован = Истина;
			КонецЕсли;
		КонецЕсли;
		
		Отчет.КомпоновщикНастроек.ЗагрузитьНастройки(НовыеНастройки.Настройки);
		Отчет.КомпоновщикНастроек.ЗагрузитьПользовательскиеНастройки(НовыеНастройки.ПользовательскиеНастройки);
		
	ИначеЕсли ТипЗнч(НовыеНастройки) = Тип("НастройкиКомпоновкиДанных") Тогда
		Отчет.КомпоновщикНастроек.ЗагрузитьНастройки(НовыеНастройки);
	ИначеЕсли ТипЗнч(НовыеНастройки) = Тип("ПользовательскиеНастройкиКомпоновкиДанных") Тогда
		Отчет.КомпоновщикНастроек.ЗагрузитьПользовательскиеНастройки(НовыеНастройки);
	ИначеЕсли НовыеНастройки = "СброситьНастройки" Тогда
		ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
		ОтчетМетаданные = ОтчетОбъект.Метаданные();
		
		// Чтение настроек варианта
		КомпоновщикНастроекКД = Отчет.КомпоновщикНастроек;
		ВариантНастройкиКД = ОтчетОбъект.СхемаКомпоновкиДанных.ВариантыНастроек.Найти(КлючТекущегоВарианта);
		Если ВариантНастройкиКД = Неопределено Тогда
			// Из хранилища
			Если ОтчетМетаданные.ХранилищеВариантов = Неопределено Тогда
				МенеджерХранилища = ХранилищеВариантовОтчетов;
			Иначе
				МенеджерХранилища = ХранилищаНастроек[ОтчетМетаданные.ХранилищеВариантов.Имя];
			КонецЕсли;
			НастройкиКД = МенеджерХранилища.Загрузить(КлючОбъекта, КлючТекущегоВарианта);
		Иначе
			// Из метаданных СКД
			НастройкиКД = ВариантНастройкиКД.Настройки;
		КонецЕсли;
		Если НастройкиКД = Неопределено Тогда
			// По умолчанию
			НастройкиКД = ОтчетОбъект.СхемаКомпоновкиДанных.НастройкиПоУмолчанию;
		КонецЕсли;
		
		АдресСхемыКД = ПоместитьВоВременноеХранилище(ОтчетОбъект.СхемаКомпоновкиДанных, УникальныйИдентификатор);
		КомпоновщикНастроекКД.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемыКД));
		КомпоновщикНастроекКД.ЗагрузитьНастройки(НастройкиКД);
		
		ПользовательскиеНастройкиМодифицированы = Истина;
	КонецЕсли;
	
	// Удаление реквизитов
	УдаляемыеРеквизиты = Новый Массив;
	НаборРеквизитов = ПолучитьРеквизиты();
	Для Каждого Реквизит Из НаборРеквизитов Цикл
		Если ПостоянныеРеквизиты.НайтиПоЗначению(Реквизит.Имя) = Неопределено Тогда
			УдаляемыеРеквизиты.Добавить(Реквизит.Имя);
		КонецЕсли;
	КонецЦикла;
	ИзменитьРеквизиты(Новый Массив, УдаляемыеРеквизиты);
	
	// Удаление команд
	УдаляемыеКоманды = Новый Массив;
	Для Каждого Команда Из Команды Цикл
		Если ПостоянныеКоманды.НайтиПоЗначению(Команда.Имя) = Неопределено Тогда
			УдаляемыеКоманды.Добавить(Команда);
		КонецЕсли;
	КонецЦикла;
	Для Каждого Команда Из УдаляемыеКоманды Цикл
		Команды.Удалить(Команда);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНачальноеЗначениеПериодов()
	
	Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Месяц");
	
	Если ИнтервалДатаНачало = Дата("00010101") Тогда
		ИнтервалДатаНачало = НачалоМесяца(ТекущаяДата());
	КонецЕсли;
	Если ИнтервалДатаЗавершение = Дата("00010101") Тогда
		ИнтервалДатаЗавершение = КонецДня(ТекущаяДата());
	КонецЕсли;
	
	ГодДатаНачала		 = НачалоГода(ИнтервалДатаНачало);
	ГодДатаОкончания 	 = КонецГода(ИнтервалДатаНачало);
	
	КварталДатаНачала    = НачалоКвартала(ИнтервалДатаНачало);
	КварталДатаОкончания = КонецКвартала(ИнтервалДатаНачало);
	
	МесяцДатаНачала		 = НачалоМесяца(ИнтервалДатаНачало);
	МесяцДатаОкончания 	 = КонецМесяца(ИнтервалДатаНачало);
	
	ДеньДатаНачала		 = ИнтервалДатаЗавершение;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИнтервалНаСервере()
	
	Интервал = "День";
	ИнтервалПредставление = "ПериодДень";
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНачальныеЗначенияПолейОтборов()
	
	Отчет.ВидСравнения = ПредопределенноеЗначение("Перечисление.ВидыСравнения.Больше");
	Отчет.ЗначениеСравнения = -1;
	
КонецПроцедуры
	
&НаКлиенте
Процедура ОбновитьПредставлениеПериода()
	ОбновитьЗначениеИнтервала();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗначениеИнтервала()
	
	Если Периодичность = ПредопределенноеЗначение("Перечисление.Периодичность.Месяц") Тогда
		
		ИнтервалДатаНачало = МесяцДатаНачала;
		
		Если Месяц(МесяцДатаНачала) = Месяц(ТекущаяДата()) Тогда
			ИнтервалДатаЗавершение = КонецДня(ТекущаяДата());
		Иначе
			ИнтервалДатаЗавершение = МесяцДатаОкончания;
		КонецЕсли;
		
		МесяцПериод = ПериодПрописью(ИнтервалДатаНачало, ИнтервалДатаЗавершение);
		
	КонецЕсли;
	
	Если Периодичность <> ПредопределенноеЗначение("Перечисление.Периодичность.ПустаяСсылка") Тогда //все кроме произвольного
		
		ПериодНачало      = ИнтервалДатаНачало;
		ПериодЗавершение  = ИнтервалДатаЗавершение;
		
	КонецЕсли;
	
КонецПроцедуры //ОбновитьЗначениеИнтервала()

&НаСервере
Функция ПериодПрописью(ДатаНачала, ДатаОкончания)
	
	Если ДатаНачала > ДатаОкончания Тогда
		Возврат "---";
	КонецЕсли;
	
	Если ДатаОкончания = Дата("00010101") тогда
		Возврат ПредставлениеПериода(НачалоДня(ДатаНачала), ДатаОкончания, "ФП=Истина");
	Иначе
		Возврат ПредставлениеПериода(НачалоДня(ДатаНачала), КонецДня(ДатаОкончания), "ФП=Истина");
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура УставновитьВидимостьНаСервере(Изменения = "")
	
	// Фильтры
	Если Изменения = "" ИЛИ Изменения = "Фильтры" Тогда
		ПользовательскиеНастройкиКД = Отчет.КомпоновщикНастроек.ПользовательскиеНастройки;
		ВидимостьФильтров = Неопределено;
		ПользовательскиеНастройкиКД.ДополнительныеСвойства.Свойство("Фильтры", ВидимостьФильтров);
		Если ВидимостьФильтров = Неопределено Тогда
			ВидимостьФильтров = Ложь;
		КонецЕсли;
		Элементы.ГруппаФильтрыНиз.Видимость = ВидимостьФильтров;
		Элементы.ПоказатьСкрытьФильтры.Пометка = ВидимостьФильтров;
		Если ВидимостьФильтров Тогда
			Команды.ПоказатьСкрытьФильтры.Картинка = БиблиотекаКартинок.TouchВверх;
			Команды.ПоказатьСкрытьФильтры.Подсказка = НСтр("ru = 'Скрыть фильтры';uk = 'Приховати фільтри'");
		Иначе
			Команды.ПоказатьСкрытьФильтры.Картинка = БиблиотекаКартинок.TouchВниз;
			Команды.ПоказатьСкрытьФильтры.Подсказка = НСтр("ru = 'Показать фильтры';uk = 'Показати фільтри'");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СформироватьОтчет()
	
	КомпоновщикНастроек = Отчет.КомпоновщикНастроек;
	ПользовательскиеНастройкиКД = КомпоновщикНастроек.ПользовательскиеНастройки;
	ПользовательскиеНастройкиКД.ДополнительныеСвойства.Вставить("Фильтры", Ложь);

	УставновитьВидимостьНаСервере();
	
	// Формирование отчета
	ДопСвойства = Отчет.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
	
	// Формирование отчета.
	ДопСвойства.Вставить("КлючВарианта", КлючТекущегоВарианта);
	КлючПараметровПечатиДоКомпоновки = ОтчетТабличныйДокумент.КлючПараметровПечати;
	Попытка
		СкомпоноватьРезультат(РежимКомпоновкиРезультата.Авто);
		РеквизитФормыВЗначение("Отчет").СформироватьОтчет(ОтчетТабличныйДокумент, ИнтервалДатаНачало, ИнтервалДатаЗавершение);
		ДопСвойства.Удалить("КлючВарианта");
	Исключение
		ДопСвойства.Удалить("КлючВарианта");
		ПоказатьОшибкиФормирования(ИнформацияОбОшибке());
		ВызватьИсключение;
	КонецПопытки;
	ОтчетТабличныйДокумент.КлючПараметровПечати = КлючПараметровПечатиДоКомпоновки;
	
	ОтчетТабличныйДокумент.ФиксацияСверху = 2;
	ОтчетТабличныйДокумент.ФиксацияСлева = 6;
	
КонецПроцедуры
