﻿
&НаКлиенте
Процедура УстановитьВидимость()
	
	// Командная панель.
	Элементы.ПодробныйРежим.Пометка = ПодробныйРежим;
	
КонецПроцедуры // УстановитьВидимость()


&НаКлиенте
Процедура ПодробныйРежим(Команда)
	
	ПодробныйРежим = Не ПодробныйРежим;
	
	// Настройка формы.
	УстановитьВидимость();
	
КонецПроцедуры // ПодробныйРежим()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Режим выбора.
	__РаботаСДиалогамиКлиентСервер.ФормаРежимВыбора(ЭтаФорма, Элементы.Список, 
		"НаименованиеПолное,КраткийСоставСпарвочника");
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Настройка формы.
	УстановитьВидимость();
	
КонецПроцедуры // ПриОткрытии()

