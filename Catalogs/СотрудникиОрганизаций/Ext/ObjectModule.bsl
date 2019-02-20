﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	// Организация.
	Если (Не ЭтоГруппа) И (Не ЗначениеЗаполнено(Организация)) Тогда
		Организация = Справочники.Организации.ОсновнаяОрганизация();
	КонецЕсли;
	
КонецПроцедуры // ОбработкаЗаполнения()

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// Код.
	Если ЭтоГруппа Тогда
		__ОбщегоНазначенияСервер.ИзменитьПроверяемыеРеквизиты(ПроверяемыеРеквизиты, , "Код");
	КонецЕсли;
		
КонецПроцедуры // ОбработкаПроверкиЗаполнения()

Процедура ПриКопировании(ОбъектКопирования)
	
	// Код.
	Если ЭтоГруппа Тогда
		Код = Неопределено;
	Иначе
		Код = Справочники.СотрудникиОрганизаций.ПолучитьОчереднойКод(ЭтотОбъект);	
	КонецЕсли;
	
КонецПроцедуры // ПриКопировании()

Процедура ПередЗаписью(Отказ)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Код.
	Если ПустаяСтрока(Код) Тогда
		Код = Справочники.СотрудникиОрганизаций.ПолучитьОчереднойКод(ЭтотОбъект);	
	КонецЕсли;
	
КонецПроцедуры // ПередЗаписью()
