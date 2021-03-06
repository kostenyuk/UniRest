﻿&НаКлиенте
Перем ОбновитьИнтерфейс;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Значения реквизитов формы
	СоставНабораКонстантФормы    = ОбщегоНазначенияУТ.ПолучитьСтруктуруНабораКонстант(НаборКонстант);
	ВнешниеРодительскиеКонстанты = ОбщегоНазначенияУТПовтИсп.ПолучитьСтруктуруРодительскихКонстант(СоставНабораКонстантФормы);
	РежимРаботы 				 = ОбщегоНазначенияПовтИсп.РежимРаботыПрограммы();
	
	ВнешниеРодительскиеКонстанты.Вставить("ИспользоватьРозничныеПродажи");
	
	РежимРаботы.Вставить("СоставНабораКонстантФормы",    Новый ФиксированнаяСтруктура(СоставНабораКонстантФормы));
	РежимРаботы.Вставить("ВнешниеРодительскиеКонстанты", Новый ФиксированнаяСтруктура(ВнешниеРодительскиеКонстанты));
	РежимРаботы.Вставить("БазоваяВерсия", 				 ПолучитьФункциональнуюОпцию("БазоваяВерсия"));
	
	РежимРаботы = Новый ФиксированнаяСтруктура(РежимРаботы);
	
	// Настройки видимости при запуске
	
	// Обновление состояния элементов
	УстановитьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

&НаКлиенте
// Обработчик оповещения формы.
//
// Параметры:
//	ИмяСобытия - Строка - обрабатывается только событие Запись_НаборКонстант, генерируемое панелями администрирования.
//	Параметр   - Структура - содержит имена констант, подчиненных измененной константе, "вызвавшей" оповещение.
//	Источник   - Строка - имя измененной константы, "вызвавшей" оповещение.
//
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия <> "Запись_НаборКонстант" Тогда
		Возврат; // такие событие не обрабатываются
	КонецЕсли;
	
	// Если это изменена константа, расположенная в другой форме и влияющая на значения констант этой формы,
	// то прочитаем значения констант и обновим элементы этой формы.
	Если РежимРаботы.ВнешниеРодительскиеКонстанты.Свойство(Источник)
	 ИЛИ (ТипЗнч(Параметр) = Тип("Структура")
	 		И ОбщегоНазначенияУТКлиентСервер.ПолучитьОбщиеКлючиСтруктур(
	 			Параметр, РежимРаботы.ВнешниеРодительскиеКонстанты).Количество() > 0) Тогда
		
		ЭтаФорма.Прочитать();
		УстановитьДоступность();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьПодключаемоеОборудованиеПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОбменСПодключаемымОборудованиемOfflineПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	Оповестить("ИзмененыДоступныеТипыПодключаемогоОборудования", , ЭтаФорма);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьПодключаемоеОборудование(Команда)
	
	МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента();
	
	ОткрытьФорму("Справочник.ПодключаемоеОборудование.ФормаСписка", , ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПравилаОбменаСПодключаемымОборудованием(Команда)
	ОткрытьФорму("Справочник.ПравилаОбменаСПодключаемымОборудованиемOffline.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьШаблоныМагнитныхКарт(Команда)
	ОткрытьФорму("Справочник.ШаблоныМагнитныхКарт.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНастройкиРМК(Команда)
	ОткрытьФорму("Справочник.НастройкиРМК.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьТекущиеНастройкиРМК(Команда)
	
	ТекущиеНастройкиРМК = ТекущиеНастройкиРМК();
	Если ЗначениеЗаполнено(ТекущиеНастройкиРМК) Тогда
		ОткрытьЗначение(ТекущиеНастройкиРМК);
	Иначе
		ОткрытьФорму("Справочник.НастройкиРМК.ФормаОбъекта",,ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	Результат = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	Если ОбновлятьИнтерфейс Тогда
		#Если НЕ ВебКлиент Тогда
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 1, Истина);
		ОбновитьИнтерфейс = Истина;
		#КонецЕсли
	КонецЕсли;
	
	СтандартныеПодсистемыКлиент.ПоказатьРезультатВыполнения(ЭтаФорма, Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	#Если НЕ ВебКлиент Тогда
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбновитьИнтерфейс();
	КонецЕсли;
	#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область ВызовСервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	Результат = Новый Структура;
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат);
	
	УстановитьДоступность(РеквизитПутьКДанным);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область Сервер

&НаСервере
Процедура СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат;
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
		
		Если ОбщегоНазначенияУТПовтИсп.ЕстьПодчиненныеКонстанты(КонстантаИмя, КонстантаЗначение) Тогда
			ЭтаФорма.Прочитать();
		КонецЕсли;
		
		СтандартныеПодсистемыКлиентСервер.РезультатВыполненияДобавитьОповещениеОткрытыхФорм(Результат,
			"Запись_НаборКонстант", ОбщегоНазначенияУТПовтИсп.ПолучитьСтруктуруПодчиненныхКонстант(КонстантаИмя), КонстантаИмя);
		// СтандартныеПодсистемы.ВариантыОтчетов
		ВариантыОтчетов.ДобавитьОповещениеПриИзмененииЗначенияКонстанты(Результат, КонстантаМенеджер);
		// Конец СтандартныеПодсистемы.ВариантыОтчетов
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьПодключаемоеОборудование" ИЛИ РеквизитПутьКДанным = "" Тогда
		ЗначениеКонстанты = НаборКонстант.ИспользоватьПодключаемоеОборудование;
		
		Элементы.ИспользоватьОбменСПодключаемымОборудованиемOffline.Доступность = ЗначениеКонстанты И Константы.ИспользоватьРозничныеПродажи.Получить();
		Элементы.ОткрытьПодключаемоеОборудование.Доступность 					= ЗначениеКонстанты;
		Элементы.ОткрытьШаблоныМагнитныхКарт.Доступность 						= ЗначениеКонстанты;
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьОбменСПодключаемымОборудованиемOffline" ИЛИ РеквизитПутьКДанным = "" Тогда
		Элементы.ОткрытьПравилаОбменаСПодключаемымОборудованием.Доступность = НаборКонстант.ИспользоватьОбменСПодключаемымОборудованиемOffline;
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьРозничныеПродажи" ИЛИ РеквизитПутьКДанным = "" Тогда
		ЗначениеКонстанты = НаборКонстант.ИспользоватьРозничныеПродажи;
		
		Элементы.ОткрытьНастройкиРМК.Доступность        = ЗначениеКонстанты;
		Элементы.ОткрытьТекущиеНастройкиРМК.Доступность = ЗначениеКонстанты;
		
		Элементы.ГруппаКомментарийНастройкиРМК.Видимость = Не ЗначениеКонстанты;
		
	КонецЕсли;
	
	ОбменДаннымиУТУП.УстановитьДоступностьНастроекУзлаИнформационнойБазы(ЭтаФорма);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ТекущиеНастройкиРМК()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	НастройкиРМК.Ссылка
	|ИЗ
	|	Справочник.НастройкиРМК КАК НастройкиРМК
	|ГДЕ
	|	НастройкиРМК.РабочееМесто = &РабочееМесто";

	Запрос.УстановитьПараметр("РабочееМесто", МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента());

	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();

	Если Выборка.Следующий() Тогда
	
		Возврат Выборка.Ссылка;
		
	Иначе
		
		Возврат Справочники.НастройкиРМК.ПустаяСсылка();
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецОбласти
