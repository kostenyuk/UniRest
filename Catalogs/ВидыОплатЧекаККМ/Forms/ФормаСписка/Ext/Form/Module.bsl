﻿
&НаКлиенте
Процедура УстановитьВидимость()
	
	// Командная панель.
	Элементы.ПодробныйРежим.Пометка = ПодробныйРежим;
	
	// Элементы.
	Элементы.ГруппаОтражатьВУправленческомУчете.Видимость = (Не РежимВыбора) И ИспользоватьУправленческийУчет И ПодробныйРежим;
	Элементы.ГруппаОтражатьВБухгалтерскомУчете.Видимость = Элементы.ГруппаОтражатьВУправленческомУчете.Видимость;
	
КонецПроцедуры // УстановитьВидимость()


&НаКлиенте
Процедура ПодробныйРежим(Команда)
	
	ПодробныйРежим = Не ПодробныйРежим;
	
	// Настройка формы.
	УстановитьВидимость();
	
КонецПроцедуры // ПодробныйРежим()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Управленчиский учет.
	ИспользоватьУправленческийУчет = ПолучитьФункциональнуюОпцию("ИспользоватьУправленческийУчет");

	// Режим выбора.
	РежимВыбора = __РаботаСДиалогамиКлиентСервер.ФормаРежимВыбора(ЭтаФорма, Элементы.Список, 
		"ПодробныйРежим, ГруппаОтражатьВУправленческомУчете,ОтражатьВУправленческомУчете, ТипОплаты");
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Настройка формы.
	УстановитьВидимость();
	
КонецПроцедуры // ПриОткрытии()
