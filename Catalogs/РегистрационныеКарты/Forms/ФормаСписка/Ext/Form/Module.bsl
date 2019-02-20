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


&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
		
КонецПроцедуры // СписокПередНачаломДобавления()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Режим выбора.
	РежимВыбора = __РаботаСДиалогамиКлиентСервер.ФормаРежимВыбора(ЭтаФорма, Элементы.Список,
						"ПодробныйРежим, ГруппаПользователей");
		
	// Настройка формы.
	Элементы.ПроцентУточняемый.Видимость = Ложь;
	Элементы.ГруппаПользователей.Видимость = Ложь;
	
	Если Параметры.Свойство("Отбор") Тогда
		АвтоЗаголовок = Ложь;
		Заголовок = НСтр("ru = 'Регистрационные карты'; uk = 'Реєстраційні картки'");
		Элементы.ГруппаПользователей.Видимость = Не РежимВыбора;
		Элементы.ВладелецКарты.Заголовок = НСтр("ru = 'Пользователь'; uk = 'Користувач'");
		Элементы.ВладелецКарты.КартинкаШапки = БиблиотекаКартинок.Пользователь;
	КонецЕсли; 
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Настройка формы.
	УстановитьВидимость();
	
КонецПроцедуры // ПриОткрытии()
