﻿
&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьПолноеНаименованиеАвтоматически, Объект.НаименованиеПолное, Объект.Наименование, Элементы.НаименованиеПолное);
	
КонецПроцедуры // НаименованиеПриИзменении()

&НаКлиенте
Процедура НаименованиеПолноеПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьПолноеНаименованиеАвтоматически, Объект.НаименованиеПолное, Объект.Наименование, Элементы.НаименованиеПолное);
	
КонецПроцедуры // НаименованиеПолноеПриИзменении()


&НаКлиенте
Процедура ТелефонныеКодаКодПриИзменении(Элемент)
	
	__УправлениеКонтактнойИнформациейКлиент.ТелефонныеКодаКодПриИзменении(Объект, Элемент);
	
КонецПроцедуры // ТелефонныеКодаКодПриИзменении()

&НаКлиенте
Процедура ТелефонныеКодаПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	__УправлениеКонтактнойИнформациейКлиент.ТелефонныеКодаПриОкончанииРедактирования(Объект, Элемент, НоваяСтрока, ОтменаРедактирования);
	
КонецПроцедуры // ТелефонныеКодаПриОкончанииРедактирования()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Автоматическое формирование наименования.
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииНаСервере(Объект);	
	КонецЕсли;
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьПолноеНаименованиеАвтоматически, Объект.НаименованиеПолное, Объект.Наименование, Элементы.НаименованиеПолное);
	
КонецПроцедуры // ПриЧтенииНаСервере()
