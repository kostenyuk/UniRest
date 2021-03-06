﻿
&НаКлиенте
Процедура ПравилаПринадлежностиПринадлежностьПриИзменении(Элемент)

	// Принадлежность.
	__РаботаСДаннымиКлиентСервер.ИзменитьПравилаПринадлежностиПодчиненных(Элемент, ПравилаПринадлежности);
	
КонецПроцедуры // ПравилаПринадлежностиПринадлежностьПриИзменении()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Принадлежность и максимальное количество.
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ДостигнутоМаксимальноеКоличество = Не Справочники.ПроизводственныеГруппы.ПроверитьМаксимальноеКоличествоЭлементов();
		
		Если Не ДостигнутоМаксимальноеКоличество Тогда
			ПриЧтенииНаСервере(Объект);
		КонецЕсли;
	КонецЕсли;
	
	// Максимальное количество.
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	// Максимальное количество.
	Если ДостигнутоМаксимальноеКоличество Тогда
		Отказ = Истина; Предупреждение(НСтр("ru = 'Достигнут предел количества элементов справочника!'; uk = 'Досягнуто межа кількості елементів довідника!'"));
	КонецЕсли;
	
КонецПроцедуры // ПриОткрытии()

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// Принадлежность.
	__РаботаСДаннымиКлиентСервер.ПолучитьПравилаПринадлежности(ТекущийОбъект, "НоменклатурныеГруппы", "ПроизводственнаяГруппа", ПравилаПринадлежности);
	
КонецПроцедуры // ПриЧтенииНаСервере()

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	// Принадлежность.
	__РаботаСДаннымиКлиентСервер.УстановитьПравилаПринадлежности(ТекущийОбъект, "НоменклатурныеГруппы", "ПроизводственнаяГруппа", ПравилаПринадлежности, Отказ);
	
КонецПроцедуры // ПриЗаписиНаСервере()
