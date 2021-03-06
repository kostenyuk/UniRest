﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ЗаполнитьПредустановленныеОписания();
	
	ЗагрузитьНастройки();
	
	УстановитьВидимостьИДоступность();
	
	УстановитьВидимостьСтраниц(Элементы.СтраницаОсновныеНастройки.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьСтраницыИОписания();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	ТекстВопроса = НСтр("ru='Закрыть помощник?';uk='Закрити помічник?'");
	
	Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	СохранитьСтатусыНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_НаборКонстант" Тогда
			УстановитьВидимостьИДоступность();
			УстановитьСтраницыИОписания();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Страница основные настройки.

&НаКлиенте
Процедура ОтметкаОрганизацииИВалютыНажатие(Элемент)
	
	ОтметкаОрганизацииИВалюты = Не ОтметкаОрганизацииИВалюты;
	
	УстановитьСтраницуОрганизацииИВалюты();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаОрганизацииНажатие(Элемент)
	
	ОтметкаОрганизации = Не ОтметкаОрганизации;
	
	УстановитьСтраницуОрганизации();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаКассыНажатие(Элемент)
	
	ОтметкаКассы = Не ОтметкаКассы;
	
	УстановитьСтраницуКассы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаНастройкиПользователейИПравНажатие(Элемент)
	
	ОтметкаНастройкиПользователейИПрав = Не ОтметкаНастройкиПользователейИПрав;
	
	УстановитьСтраницуНастройкиПользователейИПрав();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаГруппаНоменклатураНажатие(Элемент)
	
	ОтметкаГруппаНоменклатура = Не ОтметкаГруппаНоменклатура;
	
	УстановитьСтраницуГруппаНоменклатура();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаГруппаМаркетингИПродажиНажатие(Элемент)
	
	ОтметкаГруппаМаркетингИПродажи = Не ОтметкаГруппаМаркетингИПродажи;
	
	УстановитьСтраницуГруппаМаркетингИПродажи();
	
КонецПроцедуры

// Страница основные настройки номенклатуры.

&НаКлиенте
Процедура ОтметкаНастройкиНоменклатурыНажатие(Элемент)
	
	ОтметкаНастройкиНоменклатуры = Не ОтметкаНастройкиНоменклатуры;
	
	УстановитьСтраницуНастройкиНоменклатуры();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаНоменклатураНажатие(Элемент)
	
	ОтметкаНоменклатураОсновные = Не ОтметкаНоменклатураОсновные;
	
	УстановитьСтраницуНоменклатураОсновные();
	
КонецПроцедуры

// Страница маркетинг и продажи.

&НаКлиенте
Процедура ОтметкаПодключаемоеОборудованиеНажатие(Элемент)
	
	ОтметкаПодключаемоеОборудование = Не ОтметкаПодключаемоеОборудование;
	
	УстановитьСтраницуПодключаемоеОборудование();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаСкидкиНаценкиНажатие(Элемент)
	
	ОтметкаСкидкиНаценки = Не ОтметкаСкидкиНаценки;
	
	УстановитьСтраницуСкидкиНаценки();
	
КонецПроцедуры

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиНаГлавнуюСтраницу(Команда)
	
	УстановитьВидимостьСтраниц(Элементы.СтраницаОсновныеНастройки.Имя);
	
	Заголовок = НСтр("ru='Помощник заполнения настроек и справочников';uk='Помічник заповнення настройок і довідників'");
	
	Элементы.КоманднаяПанель.ТекущаяСтраница = Элементы.КоманднаяПанель.ПодчиненныеЭлементы.СтраницаКоманднаяПанельОсновная;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсеОтметки(Команда)
	
	МассивРеквизитов = МассивРеквизитовФормы(Элементы.ОсновнаяПанель.ТекущаяСтраница.Имя);
	
	Для Каждого Реквизит из МассивРеквизитов Цикл
		ЭтаФорма[Реквизит] = Ложь;
	КонецЦикла;
	
	УстановитьСтраницыИОписания();
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиВПомощникНастройкиУчетаНоменклатуры(Команда)
	
	УстановитьВидимостьСтраниц(Элементы.СтраницаОсновныеНастройкиНоменклатуры.Имя);
	
	Заголовок = НСтр("ru='Помощник заполнения настроек и справочников / 2.1. Настройки номенклатуры';uk='Помічник заповнення настройок і довідників / 2.1. Настройки номенклатури'");
	
	Элементы.КоманднаяПанель.ТекущаяСтраница = Элементы.КоманднаяПанель.ПодчиненныеЭлементы.СтраницаКоманднаяПанельОстальные;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиВПомощникМаркетингИПродажи(Команда)
	
	УстановитьВидимостьСтраниц(Элементы.СтраницаМаркетингИПродажи.Имя);
	
	Заголовок = НСтр("ru='Помощник заполнения настроек и справочников / 2.3. Маркетинг и продажи';uk='Помічник заповнення настройок і довідників / 2.3. Маркетинг і продажі'");
	
	Элементы.КоманднаяПанель.ТекущаяСтраница = Элементы.КоманднаяПанель.ПодчиненныеЭлементы.СтраницаКоманднаяПанельОстальные;
	
КонецПроцедуры

// Страница основные настройки.

&НаКлиенте
Процедура ОткрытьОрганизацииИДенежныеСредства(Команда)
	
	ОткрытьФорму("Обработка.ПанельАдминистрированияРС.Форма.ОрганизацииИДенежныеСредства", , ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОрганизации(Команда)
	
	ОткрытьФорму("Справочник.Организации.ФормаСписка", , ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКассы(Команда)
	
	ОткрытьФорму("Справочник.КассыККМ.ФормаСписка", , ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНастройкиПользователейИПрав(Команда)
	
	ОткрытьФорму("Справочник.Пользователи.ФормаСписка", , ЭтаФорма);
	
КонецПроцедуры

// Страница основные настройки номенклатуры.

&НаКлиенте
Процедура ОткрытьНастройкиНоменклатуры(Команда)
	
	ОткрытьФорму("Обработка.ПанельАдминистрированияРС.Форма.НастройкиНоменклатуры", , ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНоменклатуру(Команда)
	
	ОткрытьФорму("Справочник.Номенклатура.ФормаСписка", , ЭтаФорма);
	
КонецПроцедуры

// Страница маркетинг и продажи.

&НаКлиенте
Процедура ОткрытьАдминистрированиеПодключаемоеОборудование(Команда)
	ОткрытьФорму("Обработка.ПанельАдминистрированияРС.Форма.НастройкиРМКИОборудования", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСкидкиНаценки(Команда)
	ОткрытьФорму("Справочник.ТипыСкидокНаценок.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьТипыЦен(Команда)
	ОткрытьФорму("Справочник.ТипыЦен.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Установка страниц.

&НаКлиенте 
Процедура УстановитьСтраницыИОписания()
	
	// Страница основные настройки.
	
	УстановитьСтраницуОрганизацииИВалюты();
	УстановитьСтраницуОрганизации();
	УстановитьСтраницуКассы();
	УстановитьСтраницуНастройкиПользователейИПрав();
	
	// Страница маркетинг и продажи.
	
	УстановитьСтраницуПодключаемоеОборудование();

КонецПроцедуры

// Страница основные настройки.

&НаКлиенте
Процедура УстановитьСтраницуОрганизацииИВалюты()
	
	Если ОтметкаОрганизацииИВалюты Тогда 
		Элементы.ОрганизацииИВалютыСтраницы.ТекущаяСтраница = Элементы.ОрганизацииИВалютыСтраницы.ПодчиненныеЭлементы.СтраницаОрганизацииИВалютыОтменить;
	Иначе
		Элементы.ОрганизацииИВалютыСтраницы.ТекущаяСтраница = Элементы.ОрганизацииИВалютыСтраницы.ПодчиненныеЭлементы.СтраницаОрганизацииИВалютыГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуОрганизации(Готовность = Истина, Описание = "")
	
	Если Не Готовность Тогда
		Элементы.ОрганизацииСтраницы.ТекущаяСтраница = Элементы.ОрганизацииСтраницы.ПодчиненныеЭлементы.СтраницаОрганизации;
	ИначеЕсли ОтметкаОрганизации Тогда 
		Элементы.ОрганизацииСтраницы.ТекущаяСтраница = Элементы.ОрганизацииСтраницы.ПодчиненныеЭлементы.СтраницаОрганизацииОтменить;
	Иначе
		Элементы.ОрганизацииСтраницы.ТекущаяСтраница = Элементы.ОрганизацииСтраницы.ПодчиненныеЭлементы.СтраницаОрганизацииГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуКассы(Готовность = Истина, Описание = "")
	
	Если Не Готовность Тогда
		Элементы.КассыСтраницы.ТекущаяСтраница = Элементы.КассыСтраницы.ПодчиненныеЭлементы.СтраницаКассы;
	ИначеЕсли ОтметкаКассы Тогда 
		Элементы.КассыСтраницы.ТекущаяСтраница = Элементы.КассыСтраницы.ПодчиненныеЭлементы.СтраницаКассыОтменить;
	Иначе
		Элементы.КассыСтраницы.ТекущаяСтраница = Элементы.КассыСтраницы.ПодчиненныеЭлементы.СтраницаКассыГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуНастройкиПользователейИПрав()
	
	Если ОтметкаНастройкиПользователейИПрав Тогда
		Элементы.НастройкиПользователейИПравСтраницы.ТекущаяСтраница = Элементы.НастройкиПользователейИПравСтраницы.ПодчиненныеЭлементы.СтраницаНастройкиПользователейИПравОтменить;
	Иначе
		Элементы.НастройкиПользователейИПравСтраницы.ТекущаяСтраница = Элементы.НастройкиПользователейИПравСтраницы.ПодчиненныеЭлементы.СтраницаНастройкиПользователейИПравГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуГруппаНоменклатура(Готовность = Истина, Описание = "")
	
	Элементы.ПерейтиВПомощникНастройкиУчетаНоменклатуры.Доступность = Готовность;
	
	СтатусГруппаНоменклатура = ПредустановленныеОписания.НайтиПоЗначению("ГруппаНоменклатура").Представление;
	
	Если Не Готовность Тогда
		Элементы.ГруппаНоменклатураСтраницы.ТекущаяСтраница = Элементы.ГруппаНоменклатураСтраницы.ПодчиненныеЭлементы.СтраницаГруппаНоменклатура;
		СтатусГруппаНоменклатура = СтатусГруппаНоменклатура + " " + Описание;
	ИначеЕсли ОтметкаГруппаНоменклатура Тогда 
		Элементы.ГруппаНоменклатураСтраницы.ТекущаяСтраница = Элементы.ГруппаНоменклатураСтраницы.ПодчиненныеЭлементы.СтраницаГруппаНоменклатураОтменить;
	Иначе
		Элементы.ГруппаНоменклатураСтраницы.ТекущаяСтраница = Элементы.ГруппаНоменклатураСтраницы.ПодчиненныеЭлементы.СтраницаГруппаНоменклатураГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуГруппаМаркетингИПродажи(Готовность = Истина, Описание = "")
	
	Элементы.ПерейтиВПомощникЗаполненияМаркетингИПродажи.Доступность = Готовность;
	
	СтатусГруппаМаркетингИПродажи = ПредустановленныеОписания.НайтиПоЗначению("ГруппаМаркетингИПродажи").Представление;
	
	Если Не Готовность Тогда
		Элементы.ГруппаМаркетингИПродажиСтраницы.ТекущаяСтраница = Элементы.ГруппаМаркетингИПродажиСтраницы.ПодчиненныеЭлементы.СтраницаГруппаМаркетингИПродажи;
		СтатусГруппаМаркетингИПродажи = СтатусГруппаМаркетингИПродажи + " " + Описание;
	ИначеЕсли ОтметкаГруппаМаркетингИПродажи Тогда 
		Элементы.ГруппаМаркетингИПродажиСтраницы.ТекущаяСтраница = Элементы.ГруппаМаркетингИПродажиСтраницы.ПодчиненныеЭлементы.СтраницаГруппаМаркетингИПродажиОтменить;
	Иначе
		Элементы.ГруппаМаркетингИПродажиСтраницы.ТекущаяСтраница = Элементы.ГруппаМаркетингИПродажиСтраницы.ПодчиненныеЭлементы.СтраницаГруппаМаркетингИПродажиГотово;
	КонецЕсли;
	
КонецПроцедуры

// Страница основные настройки номенклатуры.

&НаКлиенте
Процедура УстановитьСтраницуНастройкиНоменклатуры()
	
	Если ОтметкаНастройкиНоменклатуры Тогда 
		Элементы.НастройкиНоменклатурыСтраницы.ТекущаяСтраница = Элементы.НастройкиНоменклатурыСтраницы.ПодчиненныеЭлементы.СтраницаНастройкиНоменклатурыОтменить;
	Иначе
		Элементы.НастройкиНоменклатурыСтраницы.ТекущаяСтраница = Элементы.НастройкиНоменклатурыСтраницы.ПодчиненныеЭлементы.СтраницаНастройкиНоменклатурыГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуНоменклатураОсновные(Готовность = Истина, Описание = "")
	
	СтатусНоменклатураОсновные = ПредустановленныеОписания.НайтиПоЗначению("НоменклатураОсновные").Представление;
	
	Если Не Готовность Тогда
		Элементы.НоменклатураСтраницы.ТекущаяСтраница = Элементы.НоменклатураСтраницы.ПодчиненныеЭлементы.СтраницаНоменклатура;
		СтатусНоменклатураОсновные = СтатусНоменклатураОсновные + " " + Описание;
	ИначеЕсли ОтметкаНоменклатураОсновные Тогда 
		Элементы.НоменклатураСтраницы.ТекущаяСтраница = Элементы.НоменклатураСтраницы.ПодчиненныеЭлементы.СтраницаНоменклатураОтменить;
	Иначе
		Элементы.НоменклатураСтраницы.ТекущаяСтраница = Элементы.НоменклатураСтраницы.ПодчиненныеЭлементы.СтраницаНоменклатураГотово;
	КонецЕсли;
	
КонецПроцедуры

// Страница маркетинг и продажи.

&НаКлиенте
Процедура УстановитьСтраницуПодключаемоеОборудование()
	
	Если ОтметкаПодключаемоеОборудование Тогда 
		Элементы.ПодключаемоеОборудованиеСтраницы.ТекущаяСтраница = Элементы.ПодключаемоеОборудованиеСтраницы.ПодчиненныеЭлементы.СтраницаПодключаемоеОборудованиеОтменить;
	Иначе
		Элементы.ПодключаемоеОборудованиеСтраницы.ТекущаяСтраница = Элементы.ПодключаемоеОборудованиеСтраницы.ПодчиненныеЭлементы.СтраницаПодключаемоеОборудованиеГотово;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуСкидкиНаценки(Готовность = Истина, Описание = "")
	
	СтатусСкидкиНаценки = ПредустановленныеОписания.НайтиПоЗначению("СкидкиНаценки").Представление;
	
	Если Не Элементы.ЭлементСкидкиНаценки.Доступность Тогда
		Элементы.СкидкиНаценкиСтраницы.ТекущаяСтраница = Элементы.СкидкиНаценкиСтраницы.ПодчиненныеЭлементы.СтраницаСкидкиНаценки;
		Возврат;
	КонецЕсли;
	
	Если Не Готовность Тогда
		Элементы.СкидкиНаценкиСтраницы.ТекущаяСтраница = Элементы.СкидкиНаценкиСтраницы.ПодчиненныеЭлементы.СтраницаСкидкиНаценки;
		СтатусСкидкиНаценки = СтатусСкидкиНаценки + " " + Описание;
	ИначеЕсли ОтметкаСкидкиНаценки Тогда 
		Элементы.СкидкиНаценкиСтраницы.ТекущаяСтраница = Элементы.СкидкиНаценкиСтраницы.ПодчиненныеЭлементы.СтраницаСкидкиНаценкиОтменить;
	Иначе
		Элементы.СкидкиНаценкиСтраницы.ТекущаяСтраница = Элементы.СкидкиНаценкиСтраницы.ПодчиненныеЭлементы.СтраницаСкидкиНаценкиГотово;
	КонецЕсли;
	
КонецПроцедуры

// Прочие.

&НаСервере
Процедура ЗаполнитьПредустановленныеОписания()
	
	// Страница основные настройки.
	
	ОписаниеГруппаНоменклатура			= НСтр("ru='Настройки учета номенклатуры должны выполняться с учетом особенностей всех подсистем.';uk='Настройки обліку номенклатури повинні виконуватися з урахуванням особливостей всіх підсистем.'");
	ОписаниеГруппаМаркетингИПродажи		= НСтр("ru='Задание параметров позволит планировать маркетинговые мероприятия и анализировать рынок, управлять процессами продаж, включая ценообразование и взаиморасчеты с клиентами.';uk='Завдання параметрів дозволить планувати маркетингові заходи та аналізувати ринок, керувати процесами продажу, включаючи ціноутворення та взаєморозрахунки з клієнтами.'");
	
	ПредустановленныеОписания.Добавить("ГруппаНоменклатура", ОписаниеГруппаНоменклатура);
	ПредустановленныеОписания.Добавить("ГруппаМаркетингИПродажи", ОписаниеГруппаМаркетингИПродажи);
	
	// Страница основные настройки номенклатуры.
	
	ОписаниеНоменклатураОсновные		= НСтр("ru='Предназначен для хранения информации о номенклатурных позициях (товары и услуги).';uk='Призначений для зберігання інформації про номенклатурні позиції (товари і послуги).'");
	
	ПредустановленныеОписания.Добавить("НоменклатураОсновные", ОписаниеНоменклатураОсновные);
	
	// Страница маркетинг и продажи.
	
	ОписаниеВидыЦен					= НСтр("ru='Справочник может содержать вспомогательные цены, которые применяются для расчета отпускных цен и других целей.';uk='Довідник може містити допоміжні ціни, які застосовуються для розрахунку відпускних цін та інших цілей.'");
	ОписаниеСкидкиНаценки			= НСтр("ru='Информацию в программе можно зарегистрировать, если в разделе ""Администрирование / Маркетинг и планирование"" включена функция использования автоматических скидок.';uk='Інформацію в програмі можна зареєструвати, якщо в розділі ""Адміністрування / Маркетинг і планування"" включена функція використання автоматичних знижок.'");
	
	ПредустановленныеОписания.Добавить("ВидыЦен", ОписаниеВидыЦен);
	ПредустановленныеОписания.Добавить("СкидкиНаценки", ОписаниеСкидкиНаценки);
	
	Для Каждого Элемент Из ПредустановленныеОписания Цикл
		Элемент.Представление = СтрЗаменить(Элемент.Представление, символы.ПС, "");
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция МассивРеквизитовФормы(ИмяСтраницы = Неопределено)
	
	Массив = Новый Массив;
	
	// Страница основные настройки.
	
	Если ИмяСтраницы = Неопределено Или ИмяСтраницы = "СтраницаОсновныеНастройки" Тогда
		
		Массив.Добавить("ОтметкаОрганизацииИВалюты");
		Массив.Добавить("ОтметкаОрганизации");
		Массив.Добавить("ОтметкаКассы");
		Массив.Добавить("ОтметкаНастройкиПользователейИПрав");
		
		Массив.Добавить("ОтметкаГруппаНоменклатура");
		Массив.Добавить("ОтметкаГруппаМаркетингИПродажи");
	
	КонецЕсли;
	
	// Страница основные настройки номенклатуры.
	
	Если ИмяСтраницы = Неопределено Или ИмяСтраницы = "СтраницаОсновныеНастройкиНоменклатуры" Тогда
		
		Массив.Добавить("ОтметкаНастройкиНоменклатуры");
		Массив.Добавить("ОтметкаНоменклатураОсновные");
		
	КонецЕсли;
	
	// Страница маркетинг и продажи.
	
	Если ИмяСтраницы = Неопределено Или ИмяСтраницы = "СтраницаМаркетингИПродажи" Тогда
		
		Массив.Добавить("ОтметкаМаркетингИПланирование");
		Массив.Добавить("ОтметкаПродажи");
		Массив.Добавить("ОтметкаПодключаемоеОборудование");
	
		Массив.Добавить("ОтметкаВидыЦен");
		Массив.Добавить("ОтметкаСкидкиНаценки");
		Массив.Добавить("ОтметкаВидыКартЛояльности");
		Массив.Добавить("ОтметкаКартыЛояльности");
		
	КонецЕсли;
	
	Возврат Массив;
	
КонецФункции

&НаСервере
Процедура СохранитьСтатусыНаСервере()
	
	Настройки = Константы.СтатусыОбъектовПомощникаЗаполненияНастроекИСправочников.Получить().Получить();
	
	Если ТипЗнч(Настройки) <> Тип("Соответствие") Тогда
		Настройки = Новый Соответствие;
	КонецЕсли;
	
	Массив = МассивРеквизитовФормы();
	
	Для Каждого Элемент из Массив Цикл
		Настройки.Вставить(Элемент, ЭтаФорма[Элемент]);
	КонецЦикла;
	
	Константы.СтатусыОбъектовПомощникаЗаполненияНастроекИСправочников.Установить(Новый ХранИлищеЗначения(Настройки));
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьНастройки()
	
	СохраненныеНастройки = Константы.СтатусыОбъектовПомощникаЗаполненияНастроекИСправочников.Получить().Получить();
	
	Если ТипЗнч(СохраненныеНастройки) = Тип("Соответствие") Тогда
		
		Массив = МассивРеквизитовФормы();
		
		Для Каждого Элемент из Массив Цикл
			ЭтаФорма[Элемент] = ?(СохраненныеНастройки[Элемент] = Неопределено, Ложь, СохраненныеНастройки[Элемент]);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьИДоступность()
	
	Элементы.ОткрытьОрганизацию.Заголовок = НСтр("ru='Организации';uk='Організації'");
	Элементы.ОткрытьКассы.Заголовок = НСтр("ru='Кассы';uk='Каси'");
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОрганизацияПоУмолчанию()
	
	Возврат Справочники.Организации.ПолучитьОрганизациюПоУмолчанию();
	
КонецФункции

&НаСервереБезКонтекста
Функция КассаПоУмолчанию()
	
	Возврат Справочники.Кассы.ПолучитьКассуПоУмолчанию(Справочники.Организации.ПустаяСсылка());
	
КонецФункции

&НаСервере
Процедура УстановитьВидимостьСтраниц(ИмяСтраницы)
	
	НоваяСтраница = Элементы[ИмяСтраницы];
	
	НоваяСтраница.Видимость = Истина;
	Элементы.ОсновнаяПанель.ТекущаяСтраница = НоваяСтраница;
	
	Для Каждого Элемент Из Элементы.ОсновнаяПанель.ПодчиненныеЭлементы Цикл
		Если Элемент = НоваяСтраница Тогда
			Продолжить;
		КонецЕсли;
		
		Элемент.Видимость = Ложь;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
