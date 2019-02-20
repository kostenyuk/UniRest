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
	РежимВыбора = __РаботаСДиалогамиКлиентСервер.ФормаРежимВыбора(ЭтаФорма, Элементы.Список,
		"ПодробныйРежим, ТелефонДополнительныйПредставление,Ответственный,Комментарий,ПричинаОтказа");
		
	// Настройка форфмы.
	Элементы.Ресторан.Видимость = Справочники.Рестораны.КоличествоАктуальныхРесторановБолееОдного();
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	// Настройка формы.
	УстановитьВидимость();
	
КонецПроцедуры // ПриОткрытии()
