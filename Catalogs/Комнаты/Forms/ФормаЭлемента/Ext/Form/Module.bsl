﻿
&НаКлиенте
Функция ПолучитьНаименование()

	Если ЗначениеЗаполнено(Объект.ТипКомнаты) Тогда
		Возврат Шаблон("[ТипКомнаты] № [Номер]", 
			Новый Структура("ТипКомнаты,Номер", Объект.ТипКомнаты, Объект.Номер));
	КонецЕсли; 
	
	Возврат "№ " + Объект.Номер; 
		
КонецФункции // ПолучитьНаименование()

&НаСервере
Функция ПолучитьНаименованиеСервер()
	
	Возврат Справочники.Комнаты.ПолучитьНаименование(Объект);
		
КонецФункции // ПолучитьНаименованиеСервер()


&НаКлиенте
Процедура РодительПриИзменении(Элемент)
	
	// Наследуемые реквизиты.
	РодительПриИзмененииСервер();
	
	// Автоматическое формирование наименования.
	ТипКомнатыПриИзменении(Неопределено);

КонецПроцедуры // РодительПриИзменении()

&НаСервере
Процедура РодительПриИзмененииСервер()
	
	__РаботаСДаннымиКлиентСервер.ПолучитьНаследуемыеРеквизиты(Объект);

	Объект.ТипКомнаты = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеЗначение(
							Объект.Родитель.ТипКомнаты,
							Объект.ТипКомнаты);

КонецПроцедуры // РодительПриИзмененииСервер()

&НаКлиенте
Процедура НомерПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименование(), Элементы.Наименование);
	
КонецПроцедуры // НомерПриИзменении()

&НаКлиенте
Процедура ТипКомнатыПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименование(), Элементы.Наименование);
	
КонецПроцедуры // ТипКомнатыПриИзменении()

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименование(), Элементы.Наименование);
	
КонецПроцедуры // НаименованиеПриИзменении()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Данные.
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииНаСервере(Объект);	
	КонецЕсли;
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименованиеСервер(), Элементы.Наименование);

КонецПроцедуры // ПриЧтенииНаСервере()
