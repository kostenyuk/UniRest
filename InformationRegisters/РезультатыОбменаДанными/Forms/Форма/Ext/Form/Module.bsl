﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Устанавливаем отборы динамических списков и сохраняем их в реквизите для управления ими
	НастроитьОтборыДинамическихСписков(НастройкиОтборовДинамическихСписков);
	
	ИспользуетсяГрупповоеИзменение = Ложь;
	ОбменДаннымиСервер.ПриОпределенииИспользованияГрупповогоИзмененияОбъектов(ИспользуетсяГрупповоеИзменение);
	
	Если Не ИспользуетсяГрупповоеИзменение Тогда
		
		Элементы.НепроведенныеДокументыКонтекстноеМеню.ПодчиненныеЭлементы.НепроведенныеДокументыКонтекстноеМенюИзменитьВыделенныеДокументы.Видимость = Ложь;
		Элементы.НепроведенныеДокументыИзменитьВыделенныеДокументы.Видимость = Ложь;
		Элементы.НезаполненныеРеквизитыКонтекстноеМеню.ПодчиненныеЭлементы.НезаполненныеРеквизитыКонтекстноеМенюИзменитьВыделенныеОбъекты.Видимость = Ложь;
		Элементы.НезаполненныеРеквизитыИзменитьВыделенныеОбъекты.Видимость = Ложь;
		
	КонецЕсли;
	
	ИспользуетсяДатыЗапретаИзменения = Ложь;
	ОбменДаннымиСервер.ПриОпределенииИспользованияДатЗапретаИзменения(ИспользуетсяДатыЗапретаИзменения);
	
	ИспользуетсяВерсионирование = ОбменДаннымиПовтИсп.ИспользуетсяВерсионирование(, Истина);
	
	Если Не ИспользуетсяВерсионирование Тогда
		
		Коллизии.ТекстЗапроса = "";
		НепринятыеПоДате.ТекстЗапроса = "";
		Элементы.СтраницаКоллизии.Видимость = Ложь;
		Элементы.СтраницаНепринятыеПоДатеЗапрета.Видимость = Ложь;
		
	ИначеЕсли Не ИспользуетсяДатыЗапретаИзменения Тогда
		
		НепринятыеПоДате.ТекстЗапроса = "";
		Элементы.СтраницаНепринятыеПоДатеЗапрета.Видимость = Ложь;
		
	КонецЕсли;
	
	Если ОбщегоНазначенияПовтИсп.РазделениеВключено() Тогда
		
		Элементы.КоллизииАвторДругойВерсии.Заголовок = Нстр("ru = 'Версия получена из приложения'");
		
	КонецЕсли;
	
	ЗаполнитьСписокУзлов();
	
	ОбновитьОтборыИПроигнорированные();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Оповестить("ЗакрытаФормаРезультатовОбменаДанными");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	ОбновитьНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	ОбновитьОтборыИПроигнорированные();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	
	ОбновитьОтборПоПричине();
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодПриИзменении(Элемент)
	
	ОбновитьОтборПоПериоду();
	
КонецПроцедуры

&НаКлиенте
Процедура УзелИнформационнойБазыОчистка(Элемент, СтандартнаяОбработка)
	
	УзелИнформационнойБазы = Неопределено;
	ОбновитьОтборПоУзлу();
	
КонецПроцедуры

&НаКлиенте
Процедура УзелИнформационнойБазыПриИзменении(Элемент)
	
	ОбновитьОтборПоУзлу();
	
КонецПроцедуры

&НаКлиенте
Процедура УзелИнформационнойБазыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не Элементы.УзелИнформационнойБазы.РежимВыбораИзСписка Тогда
		
		СтандартнаяОбработка = Ложь;
		
		УзелИнформационнойБазы = ОткрытьФормуМодально("ОбщаяФорма.ВыборУзловПлановОбмена");
		
		ОбновитьОтборПоУзлу();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УзелИнформационнойБазыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	УзелИнформационнойБазы = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатыОбменаДаннымиПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	Если Элемент.ПодчиненныеЭлементы.СтраницаКоллизии = ТекущаяСтраница Тогда
		Элементы.СтрокаПоиска.Доступность = Ложь;
	Иначе
		Элементы.СтрокаПоиска.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ НепроведенныеДокументы

&НаКлиенте
Процедура НепроведенныеДокументыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьОбъект(Элементы.НепроведенныеДокументы);
	
КонецПроцедуры

&НаКлиенте
Процедура НепроведенныеДокументыПередНачаломИзменения(Элемент, Отказ)
	
	ИзменениеОбъекта();
	Отказ = Истина;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ НезаполненныеРеквизиты

&НаКлиенте
Процедура НезаполненныеРеквизитыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьОбъект(Элементы.НезаполненныеРеквизиты);
	
КонецПроцедуры

&НаКлиенте
Процедура НезаполненныеРеквизитыПередНачаломИзменения(Элемент, Отказ)
	
	ИзменениеОбъекта();
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КоллизииПередНачаломИзменения(Элемент, Отказ)
	
	ИзменениеОбъекта();
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура КоллизииПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		
		Если Элемент.ТекущиеДанные.ДругаяВерсияПринята Тогда
			
			ПричинаКонфликта = "Конфликт был разрешен автоматически в пользу программы ""%1"".
				|Версия в этой программе была замененена на версию из другой программы.";
			ПричинаКонфликта = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ПричинаКонфликта, Элемент.ТекущиеДанные.АвторДругойВерсии);
			
			
		Иначе
			
			ПричинаКонфликта ="Конфликт был разрешен автоматически в пользу этой программы.
				|Версия в этой программе была сохранена, версия из другой программы была отклонена.";
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НепринятыеПоДатеПередНачаломИзменения(Элемент, Отказ)
	
	ИзменениеОбъекта();
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура НепринятыеПоДатеПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		
		Если Элемент.ТекущиеДанные.НовыйОбъект Тогда
			
			Элементы.НепринятыеПоДатеПринятьВерсию.Доступность = Ложь;
			
		Иначе
			
			Элементы.НепринятыеПоДатеПринятьВерсию.Доступность = Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура Изменить(Команда)
	
	ИзменениеОбъекта();
	
КонецПроцедуры

&НаКлиенте
Процедура ИгнорироватьДокумент(Команда)
	
	Игнорировать(Элементы.НепроведенныеДокументы.ВыделенныеСтроки, Истина, "НепроведенныеДокументы");
	
КонецПроцедуры

&НаКлиенте
Процедура НеИгнорироватьДокумент(Команда)
	
	Игнорировать(Элементы.НепроведенныеДокументы.ВыделенныеСтроки, Ложь, "НепроведенныеДокументы");
	
КонецПроцедуры

&НаКлиенте
Процедура НеИгнорироватьОбъект(Команда)
	
	Игнорировать(Элементы.НезаполненныеРеквизиты.ВыделенныеСтроки, Ложь, "НезаполненныеРеквизиты");
	
КонецПроцедуры

&НаКлиенте
Процедура ИгнорироватьОбъект(Команда)
	
	Игнорировать(Элементы.НезаполненныеРеквизиты.ВыделенныеСтроки, Истина, "НезаполненныеРеквизиты");
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВыделенныеДокументы(Команда)
	
	ОбменДаннымиКлиент.ПриИзмененииВыделенныхОбъектов(Элементы.НепроведенныеДокументы);
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	ОбновитьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПровестиДокумент(Команда)
	
	ОчиститьСообщения();
	ПровестиДокументы(Элементы.НепроведенныеДокументы.ВыделенныеСтроки);
	ОбновитьНаСервере("НепроведенныеДокументы");
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВыделенныеОбъекты(Команда)
	
	ОбменДаннымиКлиент.ПриИзмененииВыделенныхОбъектов(Элементы.НезаполненныеРеквизиты);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтличияНепринятые(Команда)
	
	ПоказатьОтличия(Элементы.НепринятыеПоДате);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВерсиюНепринятые(Команда)
	
	Если Элементы.НепринятыеПоДате.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	СравниваемыеВерсии.Добавить(Элементы.НепринятыеПоДате.ТекущиеДанные.НомерДругойВерсии);
	ОбменДаннымиКлиент.ПриОткрытииФормыОтчетаПоВерсии(Элементы.НепринятыеПоДате.ТекущиеДанные.Ссылка, СравниваемыеВерсии);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВерсиюНепринятыеВЭтойПрограмме(Команда)
	
	Если Элементы.НепринятыеПоДате.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	СравниваемыеВерсии.Добавить(Элементы.НепринятыеПоДате.ТекущиеДанные.НомерЭтойВерсии);
	ОбменДаннымиКлиент.ПриОткрытииФормыОтчетаПоВерсии(Элементы.НепринятыеПоДате.ТекущиеДанные.Ссылка, СравниваемыеВерсии);

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтличияКоллизии(Команда)
	
	ПоказатьОтличия(Элементы.Коллизии);
	
КонецПроцедуры

&НаКлиенте
Процедура ИгнорироватьКонфликт(Команда)
	
	ИгнорироватьВерсию(Элементы.Коллизии.ВыделенныеСтроки, Истина, "Коллизии");
	
КонецПроцедуры

&НаКлиенте
Процедура ИгнорироватьНепринятый(Команда)
	
	ИгнорироватьВерсию(Элементы.НепринятыеПоДате.ВыделенныеСтроки, Истина, "НепринятыеПоДате");
	
КонецПроцедуры

&НаКлиенте
Процедура НеИгнорироватьКонфликт(Команда)
	
	ИгнорироватьВерсию(Элементы.Коллизии.ВыделенныеСтроки, Ложь, "Коллизии");
	
КонецПроцедуры

&НаКлиенте
Процедура НеИгнорироватьНепринятый(Команда)
	
	ИгнорироватьВерсию(Элементы.НепринятыеПоДате.ВыделенныеСтроки, Ложь, "НепринятыеПоДате");
	
КонецПроцедуры

&НаКлиенте
Процедура ПринятьВерсиюНепринятые(Команда)
	
	Ответ = Вопрос(НСтр("ru = 'Принять версию, несмотря на запрет загрузки?'"), РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет); 
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	ПринятьОтклонитьВерсиюНаСервере(Элементы.НепринятыеПоДате.ВыделенныеСтроки, Истина, "НепринятыеПоДате");
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВерсиюДоКонфликта(Команда)
	
	ТекущиеДанные = Элементы.Коллизии.ТекущиеДанные;
	ОткрытьВерсиюНаКлиенте(Элементы.Коллизии.ТекущиеДанные, ТекущиеДанные.НомерЭтойВерсии);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВерсиюКонфликта(Команда)
	
	ТекущиеДанные = Элементы.Коллизии.ТекущиеДанные;
	ОткрытьВерсиюНаКлиенте(Элементы.Коллизии.ТекущиеДанные, ТекущиеДанные.НомерДругойВерсии);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьПроигнорированныеКонфликты(Команда)
	
	ПоказыватьПроигнорированныеКонфликты = Не ПоказыватьПроигнорированныеКонфликты;
	ПоказыватьПроигнорированныеКонфликтыНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьПроигнорированныеНезаполненные(Команда)
	
	ПоказыватьПроигнорированныеНезаполненные = Не ПоказыватьПроигнорированныеНезаполненные;
	ПоказыватьПроигнорированныеНезаполненныеНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьПроигнорированныеНепринятые(Команда)
	
	ПоказыватьПроигнорированныеНепринятые = Не ПоказыватьПроигнорированныеНепринятые;
	ПоказыватьПроигнорированныеНепринятыеНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьПроигнорированныеНепроведенные(Команда)
	
	ПоказыватьПроигнорированныеНепроведенные = Не ПоказыватьПроигнорированныеНепроведенные;
	ПоказыватьПроигнорированныеНепроведенныеНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьРезультатКонфликта(Команда)
	
	Если Элементы.Коллизии.ТекущиеДанные <> Неопределено Тогда
		
		Если Элементы.Коллизии.ТекущиеДанные.ДругаяВерсияПринята Тогда
			
			ТекстВопроса = Нстр("ru = 'Заменить версию, полученную из другой программы, на версию из этой программы?'");
			
		Иначе
			
			ТекстВопроса = Нстр("ru = 'Заменить версию этой программы на версию, полученную из другой программы?'");
			
		КонецЕсли;
		
		Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
		Если Ответ = КодВозвратаДиалога.Да Тогда
			
			ПринятьОтклонитьВерсиюНаСервере(Элементы.Коллизии.ВыделенныеСтроки, Элементы.Коллизии.ТекущиеДанные.ДругаяВерсияПринята, "Коллизии");
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура Игнорировать(Знач ВыделенныеСтроки, Пропустить, ИмяЭлемента)
	
	Для Каждого ВыделеннаяСтрока Из ВыделенныеСтроки Цикл
		
		Если ТипЗнч(ВыделеннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			Продолжить;
		КонецЕсли;
	
		РегистрыСведений.РезультатыОбменаДанными.Игнорировать(ВыделеннаяСтрока.ПроблемныйОбъект, ВыделеннаяСтрока.ТипПроблемы, Пропустить);
	
	КонецЦикла;
	
	ОбновитьНаСервере(ИмяЭлемента);
	
КонецПроцедуры

&НаСервере
Процедура ПоказыватьПроигнорированныеКонфликтыНаСервере(Обновлять= Истина)
	
	Элементы.КоллизииПоказыватьПроигнорированныеКонфликты.Пометка = ПоказыватьПроигнорированныеКонфликты;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Коллизии,
		"ВерсияПроигнорирована",
		,
		,
		,
		Не ПоказыватьПроигнорированныеКонфликты);
	
	Если Обновлять Тогда
		
		ОбновитьНаСервере("Коллизии");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПоказыватьПроигнорированныеНезаполненныеНаСервере(Обновлять= Истина)
	
	Элементы.НезаполненныеРеквизитыПоказыватьПроигнорированныеНезаполненные.Пометка = ПоказыватьПроигнорированныеНезаполненные;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НезаполненныеРеквизиты,
		"Пропущена",
		,
		,
		,
		Не ПоказыватьПроигнорированныеНезаполненные);
	
	Если Обновлять Тогда
		
		ОбновитьНаСервере("НезаполненныеРеквизиты");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПоказыватьПроигнорированныеНепринятыеНаСервере(Обновлять= Истина)
	
	Элементы.НепринятыеПоДатеПоказыватьПроигнорированныеНепринятые.Пометка = ПоказыватьПроигнорированныеНепринятые;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НепринятыеПоДате,
		"ВерсияПроигнорирована",
		,
		,
		,
		Не ПоказыватьПроигнорированныеНепринятые);
	
	Если Обновлять Тогда
		
		ОбновитьНаСервере("НепринятыеПоДате");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПоказыватьПроигнорированныеНепроведенныеНаСервере(Обновлять= Истина)
	
	Элементы.НепроведенныеДокументыПоказыватьПроигнорированныеНепроведенные.Пометка = ПоказыватьПроигнорированныеНепроведенные;
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НепроведенныеДокументы,
		"Пропущена",
		,
		,
		,
		Не ПоказыватьПроигнорированныеНепроведенные);
	
	Если Обновлять Тогда
		
		ОбновитьНаСервере("НепроведенныеДокументы");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПровестиДокументы(Знач ВыделенныеСтроки)
	
	Для Каждого ВыделеннаяСтрока Из ВыделенныеСтроки Цикл
		
		Если ТипЗнч(ВыделеннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			Продолжить;
		КонецЕсли;
		
		ДокументОбъект = ВыделеннаяСтрока.ПроблемныйОбъект.ПолучитьОбъект();
		
		Если ДокументОбъект.ПроверитьЗаполнение() Тогда
			
			ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
			
		КонецЕсли;
	
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокУзлов()
	
	ОтсутствуетОбменПоПравилам = Истина;
	КонтекстноеОткрытие = ЗначениеЗаполнено(Параметры.УзлыОбмена);
	
	УзлыОбмена = ?(КонтекстноеОткрытие, Параметры.УзлыОбмена, МассивУзловПриНеконтекстномОткрытии());
	Элементы.УзелИнформационнойБазы.СписокВыбора.ЗагрузитьЗначения(УзлыОбмена);
	
	Для Каждого УзелОбмена Из УзлыОбмена Цикл
		
		Если ОбменДаннымиПовтИсп.ЭтоУзелУниверсальногоОбменаДанными(УзелОбмена) Тогда
			
			ОтсутствуетОбменПоПравилам = Ложь;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если КонтекстноеОткрытие Тогда
		
		УстановитьОтборПоУзлам(УзлыОбмена);
		СписокУзлов = Новый СписокЗначений;
		СписокУзлов.ЗагрузитьЗначения(УзлыОбмена);
		
	КонецЕсли;
	
	Если КонтекстноеОткрытие И УзлыОбмена.Количество() = 1 Тогда
		
		УзелИнформационнойБазы = Неопределено;
		Элементы.УзелИнформационнойБазы.Видимость = Ложь;
		Элементы.НепроведенныеДокументыУзелИнформационнойБазы.Видимость = Ложь;
		Элементы.НезаполненныеРеквизитыУзелИнформационнойБазы.Видимость = Ложь;
		Элементы.КоллизииАвторДругойВерсии.Видимость = Ложь;
		Элементы.НепринятыеПоДатеАвторДругойВерсии.Видимость = Ложь;
		
	ИначеЕсли УзлыОбмена.Количество() >= 7 Тогда
		
		Элементы.УзелИнформационнойБазы.РежимВыбораИзСписка = Ложь;
		
	КонецЕсли;
	
	Если КонтекстноеОткрытие И ОтсутствуетОбменПоПравилам Тогда
		Заголовок = Нстр("ru = 'Конфликты при синхронизации данных'");
		Элементы.СтрокаПоиска.Видимость = Ложь;
		Элементы.РезультатыОбменаДанными.ТекущаяСтраница = Элементы.РезультатыОбменаДанными.ПодчиненныеЭлементы.СтраницаКоллизии;
		Элементы.РезультатыОбменаДанными.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоУзлам(УзлыОбмена)
	
	ОтборПоУзламДокумент = ЭлементОтбораДинамическогоСписка(НепроведенныеДокументы,
		НастройкиОтборовДинамическихСписков.НепроведенныеДокументы.УзелВСписке);
		
	ОтборПоУзламОбъект = ЭлементОтбораДинамическогоСписка(НезаполненныеРеквизиты,
		НастройкиОтборовДинамическихСписков.НезаполненныеРеквизиты.УзелВСписке);
		
	ОтборПоУзламКоллизии = ЭлементОтбораДинамическогоСписка(Коллизии,
		НастройкиОтборовДинамическихСписков.Коллизии.АвторВСписке);
		
	ОтборПоУзламНепринятые = ЭлементОтбораДинамическогоСписка(НепринятыеПоДате,
		НастройкиОтборовДинамическихСписков.НепринятыеПоДате.АвторВСписке);
		
	ОтборПоУзламДокумент.Использование = Истина;
	ОтборПоУзламДокумент.ПравоеЗначение = УзлыОбмена;
	
	ОтборПоУзламОбъект.Использование = Истина;
	ОтборПоУзламОбъект.ПравоеЗначение = УзлыОбмена;
	
	ОтборПоУзламКоллизии.Использование = Истина;
	ОтборПоУзламКоллизии.ПравоеЗначение = УзлыОбмена;
	
	ОтборПоУзламНепринятые.Использование = Истина;
	ОтборПоУзламНепринятые.ПравоеЗначение = УзлыОбмена;
	
КонецПроцедуры

&НаСервере
Функция МассивУзловПриНеконтекстномОткрытии()
	
	УзлыОбмена = Новый Массив;
	
	СписокПлановОбмена = ОбменДаннымиПовтИсп.ПланыОбменаБСП();
	
	Для Каждого ИмяПланаОбмена Из СписокПлановОбмена Цикл
		
		Если Не ПравоДоступа("Чтение", ПланыОбмена[ИмяПланаОбмена].ПустаяСсылка().Метаданные()) Тогда
			Продолжить;
		КонецЕсли;	
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("ЭтотУзел", ПланыОбмена[ИмяПланаОбмена].ЭтотУзел());
		Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ТаблицаПланаОбмена.Ссылка КАК УзелОбмена
		|ИЗ
		|	&ТаблицаПланаОбмена КАК ТаблицаПланаОбмена
		|ГДЕ
		|	ТаблицаПланаОбмена.Ссылка <> &ЭтотУзел
		|	И ТаблицаПланаОбмена.Ссылка.ПометкаУдаления = ЛОЖЬ
		|
		|УПОРЯДОЧИТЬ ПО
		|	Представление";
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ТаблицаПланаОбмена", "ПланОбмена." + ИмяПланаОбмена);
		
		Выборка = Запрос.Выполнить().Выбрать();
		
		Пока Выборка.Следующий() Цикл
			
			УзлыОбмена.Добавить(Выборка.УзелОбмена);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат УзлыОбмена;
	
КонецФункции

&НаСервере
Процедура ОбновитьОтборПоУзлу(Обновлять = Истина)
	
	ОтборПоУзлуДокумент = ЭлементОтбораДинамическогоСписка(НепроведенныеДокументы, 
		НастройкиОтборовДинамическихСписков.НепроведенныеДокументы.УзелРавно);
	
	ОтборПоУзлуОбъект = ЭлементОтбораДинамическогоСписка(НезаполненныеРеквизиты, 
		НастройкиОтборовДинамическихСписков.НезаполненныеРеквизиты.УзелРавно);
		
	ОтборПоУзлуКоллизии = ЭлементОтбораДинамическогоСписка(Коллизии, 
		НастройкиОтборовДинамическихСписков.Коллизии.АвторРавно);
		
	ОтборПоУзлуНепринятые = ЭлементОтбораДинамическогоСписка(НепринятыеПоДате, 
		НастройкиОтборовДинамическихСписков.НепринятыеПоДате.АвторРавно);
	
	Использование = ЗначениеЗаполнено(УзелИнформационнойБазы);
	
	// Использование
	ОтборПоУзлуДокумент.Использование   = Использование;
	ОтборПоУзлуОбъект.Использование     = Использование;
	ОтборПоУзлуКоллизии.Использование   = Использование;
	ОтборПоУзлуНепринятые.Использование = Использование;
	
	// И значение
	ОтборПоУзлуДокумент.ПравоеЗначение   = УзелИнформационнойБазы;
	ОтборПоУзлуОбъект.ПравоеЗначение     = УзелИнформационнойБазы;
	ОтборПоУзлуКоллизии.ПравоеЗначение   = УзелИнформационнойБазы;
	ОтборПоУзлуНепринятые.ПравоеЗначение = УзелИнформационнойБазы;
	
	Если Обновлять Тогда
		ОбновитьНаСервере();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция КоличествоНепринятых()
	
	УзлыОбмена = ?(ЗначениеЗаполнено(УзелИнформационнойБазы), УзелИнформационнойБазы, СписокУзлов);
	
	Возврат ОбменДаннымиСервер.КоличествоПроблемВерсионирования(УзлыОбмена, Ложь,
		ПоказыватьПроигнорированныеКонфликты, Период, СтрокаПоиска);
	
КонецФункции

&НаСервере
Функция КоличествоКоллизий()
	
	УзлыОбмена = ?(ЗначениеЗаполнено(УзелИнформационнойБазы), УзелИнформационнойБазы, СписокУзлов);
	
	Возврат ОбменДаннымиСервер.КоличествоПроблемВерсионирования(УзлыОбмена, Истина,
		ПоказыватьПроигнорированныеКонфликты, Период, СтрокаПоиска);
	
КонецФункции

&НаСервере
Функция КоличествоНезаполненныхРеквизитов()
	
	УзлыОбмена = ?(ЗначениеЗаполнено(УзелИнформационнойБазы), УзелИнформационнойБазы, СписокУзлов);
	
	Возврат РегистрыСведений.РезультатыОбменаДанными.КоличествоПроблем(УзлыОбмена, Перечисления.ТипыПроблемОбменаДанными.НезаполненныеРеквизиты,
		ПоказыватьПроигнорированныеНезаполненные, Период, СтрокаПоиска);
	
КонецФункции

&НаСервере
Функция КоличествоНепроведенныхДокументов()
	
	УзлыОбмена = ?(ЗначениеЗаполнено(УзелИнформационнойБазы), УзелИнформационнойБазы, СписокУзлов);
	
	Возврат РегистрыСведений.РезультатыОбменаДанными.КоличествоПроблем(УзлыОбмена, Перечисления.ТипыПроблемОбменаДанными.НепроведенныйДокумент,
		ПоказыватьПроигнорированныеНепроведенные, Период, СтрокаПоиска);
	
КонецФункции

&НаСервере
Процедура УстановитьЗаголовокСтраницы(Страница, Заголовок, Количество)
	
	ДобавочнаяСтрока = ?(Количество > 0, " (" + Количество + ")", "");
	Заголовок = Заголовок + ДобавочнаяСтрока;
	Страница.Заголовок = Заголовок;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОбъект(Элемент)
	
	Если Элемент.ТекущаяСтрока = Неопределено Или ТипЗнч(Элемент.ТекущаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
		Предупреждение(НСтр("ru = 'Команда не может быть выполнена для указанного объекта.'"));
		Возврат;
	КонецЕсли;
	
	ОткрытьЗначение(Элемент.ТекущиеДанные.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеОбъекта()
	
	СтраницыРезультатов = Элементы.РезультатыОбменаДанными;
	
	Если СтраницыРезультатов.ТекущаяСтраница = СтраницыРезультатов.ПодчиненныеЭлементы.СтраницаНепроведенныеДокументы Тогда
		
		ОткрытьОбъект(Элементы.НепроведенныеДокументы); 
		
	ИначеЕсли СтраницыРезультатов.ТекущаяСтраница = СтраницыРезультатов.ПодчиненныеЭлементы.СтраницаНезаполненныеРеквизиты Тогда
		
		ОткрытьОбъект(Элементы.НезаполненныеРеквизиты);
		
	ИначеЕсли СтраницыРезультатов.ТекущаяСтраница = СтраницыРезультатов.ПодчиненныеЭлементы.СтраницаКоллизии Тогда
		
		ОткрытьОбъект(Элементы.Коллизии);
		
	ИначеЕсли СтраницыРезультатов.ТекущаяСтраница = СтраницыРезультатов.ПодчиненныеЭлементы.СтраницаНепринятыеПоДатеЗапрета Тогда
		
		ОткрытьОбъект(Элементы.НепринятыеПоДате);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОтличия(Элемент)
	
	Если Элемент.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	
	Если Элемент.ТекущиеДанные.НомерЭтойВерсии <> 0 Тогда
		СравниваемыеВерсии.Добавить(Элемент.ТекущиеДанные.НомерЭтойВерсии);
	КонецЕсли;
	
	Если Элемент.ТекущиеДанные.НомерДругойВерсии <> 0 Тогда
		СравниваемыеВерсии.Добавить(Элемент.ТекущиеДанные.НомерДругойВерсии);
	КонецЕсли;
	
	Если СравниваемыеВерсии.Количество() <> 2 Тогда
		
		Сообщить(НСтр("ru = 'Нет версии для сравнения.'"));
		Возврат;
		
	КонецЕсли;
	
	ОбменДаннымиКлиент.ПриОткрытииФормыОтчетаПоВерсии(Элемент.ТекущиеДанные.Ссылка, СравниваемыеВерсии);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтборПоПричине(Обновлять = Истина)
	
	СтрокаПоискаЗадана = ЗначениеЗаполнено(СтрокаПоиска);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НепроведенныеДокументы,
		"Причина",
		СтрокаПоиска,
		,
		,
		СтрокаПоискаЗадана);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НезаполненныеРеквизиты,
		"Причина",
		СтрокаПоиска,
		,
		,
		СтрокаПоискаЗадана);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НепринятыеПоДате,
		"ПричинаЗапрета",
		СтрокаПоиска,
		,
		,
		СтрокаПоискаЗадана);
	
	Если Обновлять Тогда
		
		ОбновитьНаСервере();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтборПоПериоду(Обновлять = Истина)
	
	ОтборПоПериодуДокументС = ЭлементОтбораДинамическогоСписка(НепроведенныеДокументы, 
		НастройкиОтборовДинамическихСписков.НепроведенныеДокументы.ДатаНачала);
	ОтборПоПериодуДокументПо = ЭлементОтбораДинамическогоСписка(НепроведенныеДокументы, 
		НастройкиОтборовДинамическихСписков.НепроведенныеДокументы.ДатаОкончания);
	
	ОтборПоПериодуОбъектС = ЭлементОтбораДинамическогоСписка(НезаполненныеРеквизиты, 
		НастройкиОтборовДинамическихСписков.НезаполненныеРеквизиты.ДатаНачала);
	ОтборПоПериодуОбъектПо = ЭлементОтбораДинамическогоСписка(НезаполненныеРеквизиты, 
		НастройкиОтборовДинамическихСписков.НезаполненныеРеквизиты.ДатаОкончания);
	
	ОтборПоПериодуКоллизииС = ЭлементОтбораДинамическогоСписка(Коллизии, 
		НастройкиОтборовДинамическихСписков.Коллизии.ДатаНачала);
	ОтборПоПериодуКоллизииПо = ЭлементОтбораДинамическогоСписка(Коллизии, 
		НастройкиОтборовДинамическихСписков.Коллизии.ДатаОкончания);
	
	ОтборПоПериодуНепринятыеС = ЭлементОтбораДинамическогоСписка(НепринятыеПоДате, 
		НастройкиОтборовДинамическихСписков.НепринятыеПоДате.ДатаНачала);
	ОтборПоПериодуНепринятыеПо = ЭлементОтбораДинамическогоСписка(НепринятыеПоДате, 
		НастройкиОтборовДинамическихСписков.НепринятыеПоДате.ДатаОкончания);
	
	Использование = ЗначениеЗаполнено(Период);
	
	// Использование
	ОтборПоПериодуДокументС.Использование  = Использование;
	ОтборПоПериодуДокументПо.Использование = Использование;
	
	ОтборПоПериодуОбъектС.Использование  = Использование;
	ОтборПоПериодуОбъектПо.Использование = Использование;
	
	ОтборПоПериодуКоллизииС.Использование  = Использование;
	ОтборПоПериодуКоллизииПо.Использование = Использование;
	
	ОтборПоПериодуНепринятыеС.Использование  = Использование;
	ОтборПоПериодуНепринятыеПо.Использование = Использование;
	
	// И границы
	ОтборПоПериодуДокументС.ПравоеЗначение  = Период.ДатаНачала;
	ОтборПоПериодуДокументПо.ПравоеЗначение = Период.ДатаОкончания;
	
	ОтборПоПериодуОбъектС.ПравоеЗначение  = Период.ДатаНачала;
	ОтборПоПериодуОбъектПо.ПравоеЗначение = Период.ДатаОкончания;
	
	ОтборПоПериодуКоллизииС.ПравоеЗначение  = Период.ДатаНачала;
	ОтборПоПериодуКоллизииПо.ПравоеЗначение = Период.ДатаОкончания;
	
	ОтборПоПериодуНепринятыеС.ПравоеЗначение  = Период.ДатаНачала;
	ОтборПоПериодуНепринятыеПо.ПравоеЗначение = Период.ДатаОкончания;
	
	Если Обновлять Тогда
		ОбновитьНаСервере();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ИгнорироватьВерсию(Знач ВыделенныеСтроки, Игнорировать, ИмяЭлемента)
	
	Для Каждого ВыделеннаяСтрока Из ВыделенныеСтроки Цикл
		
		Если ТипЗнч(ВыделеннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			Продолжить;
		КонецЕсли;
		
		ОбменДаннымиСервер.ПриИгнорированииВерсииОбъекта(ВыделеннаяСтрока.Объект, ВыделеннаяСтрока.НомерВерсии, Игнорировать);
		
	КонецЦикла;
	
	ОбновитьНаСервере(ИмяЭлемента);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьНаСервере(ОбновляемыйЭлемент = "")
	
	ОбновитьСпискиФормы(ОбновляемыйЭлемент);
	ОбновитьЗаголовкиСтраниц();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСпискиФормы(ОбновляемыйЭлемент)
	
	Если ЗначениеЗаполнено(ОбновляемыйЭлемент) Тогда
		
		Элементы[ОбновляемыйЭлемент].Обновить();
		
	Иначе
		
		Элементы.НепроведенныеДокументы.Обновить();
		Элементы.НезаполненныеРеквизиты.Обновить();
		Если ИспользуетсяВерсионирование Тогда
			Элементы.Коллизии.Обновить();
			Элементы.НепринятыеПоДате.Обновить();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЗаголовкиСтраниц()
	
	УстановитьЗаголовокСтраницы(Элементы.СтраницаНепроведенныеДокументы, НСтр(" ru= 'Непроведенные документы'"), КоличествоНепроведенныхДокументов());
	УстановитьЗаголовокСтраницы(Элементы.СтраницаНезаполненныеРеквизиты, НСтр(" ru= 'Незаполненные реквизиты'"), КоличествоНезаполненныхРеквизитов());
	
	Если ИспользуетсяВерсионирование Тогда
		УстановитьЗаголовокСтраницы(Элементы.СтраницаКоллизии, НСтр(" ru= 'Конфликты'"), КоличествоКоллизий());
		УстановитьЗаголовокСтраницы(Элементы.СтраницаНепринятыеПоДатеЗапрета, НСтр(" ru= 'Непринятые по дате запрета'"), КоличествоНепринятых());
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВерсиюНаКлиенте(ТекущиеДанные, Версия)
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СравниваемыеВерсии = Новый Массив;
	СравниваемыеВерсии.Добавить(Версия);
	ОбменДаннымиКлиент.ПриОткрытииФормыОтчетаПоВерсии(ТекущиеДанные.Ссылка, СравниваемыеВерсии);
	
КонецПроцедуры

&НаСервере
Процедура ПринятьОтклонитьВерсиюНаСервере(Знач ВыделенныеСтроки, ПринятьВерсию, ИмяЭлемента, ПропуститьПроверкуЗапретаИзменения = Ложь)
	
	Для Каждого ВыделеннаяСтрока Из ВыделенныеСтроки Цикл
		
		Если ТипЗнч(ВыделеннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			Продолжить;
		КонецЕсли;
		
		ОбменДаннымиСервер.ПриПереходеНаВерсиюОбъекта(ВыделеннаяСтрока.Объект, ВыделеннаяСтрока.НомерВерсии, ПропуститьПроверкуЗапретаИзменения);
		
	КонецЦикла;
	
	ОбновитьНаСервере(ИмяЭлемента);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьОтборыДинамическихСписков(Результат)
	Результат = Новый Структура;
	
	// Непроведенные документы
	Отбор = ОтборДинамическогоСписка(НепроведенныеДокументы);
	Результат.Вставить("НепроведенныеДокументы", Новый Структура);
	Настройка = Результат.НепроведенныеДокументы;
	
	Настройка.Вставить("Пропущена", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Пропущена", ВидСравненияКомпоновкиДанных.Равно, Ложь, ,Истина)));
	Настройка.Вставить("ДатаНачала", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ДатаВозникновения", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("ДатаОкончания", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ДатаВозникновения", ВидСравненияКомпоновкиДанных.МеньшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("УзелРавно", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "УзелИнформационнойБазы", ВидСравненияКомпоновкиДанных.Равно, Неопределено, , Ложь)));
	Настройка.Вставить("Причина", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Причина", ВидСравненияКомпоновкиДанных.Содержит, Неопределено, , Ложь)));
	Настройка.Вставить("УзелВСписке", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "УзелИнформационнойБазы", ВидСравненияКомпоновкиДанных.ВСписке, Неопределено, , Ложь)));
		
	// Незаполненные реквизиты
	Отбор = ОтборДинамическогоСписка(НезаполненныеРеквизиты);
	Результат.Вставить("НезаполненныеРеквизиты", Новый Структура);
	Настройка = Результат.НезаполненныеРеквизиты;
	
	Настройка.Вставить("Пропущена", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Пропущена", ВидСравненияКомпоновкиДанных.Равно, Ложь, ,Истина)));
	Настройка.Вставить("ДатаНачала", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ДатаВозникновения", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("ДатаОкончания", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ДатаВозникновения", ВидСравненияКомпоновкиДанных.МеньшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("УзелРавно", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "УзелИнформационнойБазы", ВидСравненияКомпоновкиДанных.Равно, Неопределено, , Ложь)));
	Настройка.Вставить("Причина", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Причина", ВидСравненияКомпоновкиДанных.Содержит, Неопределено, , Ложь)));
	Настройка.Вставить("УзелВСписке", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "УзелИнформационнойБазы", ВидСравненияКомпоновкиДанных.ВСписке, Неопределено, , Ложь)));
		
	Возврат;
	// Конфликты
	Отбор = ОтборДинамическогоСписка(Коллизии);
	Результат.Вставить("Коллизии", Новый Структура);
	Настройка = Результат.Коллизии;
	
	Настройка.Вставить("АвторРавно", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "АвторДругойВерсии", ВидСравненияКомпоновкиДанных.Равно, Неопределено, ,Ложь)));
	Настройка.Вставить("ДатаНачала", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Дата", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("ДатаОкончания", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Дата", ВидСравненияКомпоновкиДанных.МеньшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("ВерсияПроигнорирована", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ВерсияПроигнорирована", ВидСравненияКомпоновкиДанных.Равно, Ложь, , Истина)));
	Настройка.Вставить("АвторВСписке", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "АвторДругойВерсии", ВидСравненияКомпоновкиДанных.ВСписке, Неопределено, ,Ложь)));
		
	// Непринятые по дате запрета
	Отбор = ОтборДинамическогоСписка(НепринятыеПоДате);
	Результат.Вставить("НепринятыеПоДате", Новый Структура);
	Настройка = Результат.НепринятыеПоДате;
	
	Настройка.Вставить("АвторРавно", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "АвторДругойВерсии", ВидСравненияКомпоновкиДанных.Равно, Неопределено, ,Ложь)));
	Настройка.Вставить("ДатаНачала", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Дата", ВидСравненияКомпоновкиДанных.БольшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("ДатаОкончания", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "Дата", ВидСравненияКомпоновкиДанных.МеньшеИлиРавно, '00010101', , Истина)));
	Настройка.Вставить("ПричинаЗапрета", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ПричинаЗапрета", ВидСравненияКомпоновкиДанных.Равно, Неопределено, , Ложь)));
	Настройка.Вставить("ВерсияПроигнорирована", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "ВерсияПроигнорирована", ВидСравненияКомпоновкиДанных.Равно, Ложь, , Истина)));
	Настройка.Вставить("АвторВСписке", Отбор.ПолучитьИдентификаторПоОбъекту(
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(Отбор, "АвторДругойВерсии", ВидСравненияКомпоновкиДанных.ВСписке, Неопределено, ,Ложь)));
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОтборДинамическогоСписка(Знач ДинамическийСписок)
	//Если Ложь Тогда
	//	Возврат ДинамическийСписок.КомпоновщикНастроек.Настройки.Отбор;
	//КонецЕсли;
	Возврат ДинамическийСписок.Отбор;
КонецФункции

&НаСервереБезКонтекста
Функция ЭлементОтбораДинамическогоСписка(Знач ДинамическийСписок, Знач Идентификатор)
	Отбор = ОтборДинамическогоСписка(ДинамическийСписок);
	Возврат Отбор.ПолучитьОбъектПоИдентификатору(Идентификатор);
КонецФункции

&НаСервере
Процедура ОбновитьОтборыИПроигнорированные()

	ОбновитьОтборПоПериоду(Ложь);
	ОбновитьОтборПоУзлу(Ложь);
	ОбновитьОтборПоПричине(Ложь);
	
	ПоказыватьПроигнорированныеКонфликтыНаСервере(Ложь);
	ПоказыватьПроигнорированныеНезаполненныеНаСервере(Ложь);
	ПоказыватьПроигнорированныеНепринятыеНаСервере(Ложь);
	ПоказыватьПроигнорированныеНепроведенныеНаСервере(Ложь);
	
	ОбновитьНаСервере();
	
	Если Не Элементы.РезультатыОбменаДанными.ТекущаяСтраница = Элементы.РезультатыОбменаДанными.ПодчиненныеЭлементы.СтраницаКоллизии Тогда
		
		Для Каждого Страница Из Элементы.РезультатыОбменаДанными.ПодчиненныеЭлементы Цикл
			
			Если Найти(Страница.Заголовок, "(") Тогда
				Элементы.РезультатыОбменаДанными.ТекущаяСтраница = Страница;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры
