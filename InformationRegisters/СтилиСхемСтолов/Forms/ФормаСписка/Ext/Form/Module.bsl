﻿
&НаСервере
Процедура УстановитьУсловноеОформлениеНаСервере()
	
	ТаблицаСтиля = РегистрыСведений.СтилиСхемСтолов.ПолучитьТаблицуСтиля();
	
	МассивУдаляемых = Новый Массив; Для Каждого ЭлементУсловногоОформления Из СписокСостояниеЗаказовПокупателей.УсловноеОформление.Элементы Цикл 
		Если (ЭлементУсловногоОформления.Представление = "ПрограммноеОформление") Тогда
			МассивУдаляемых.Добавить(ЭлементУсловногоОформления);
		КонецЕсли;
	КонецЦикла;
	Для Каждого ЭлементУсловногоОформления Из МассивУдаляемых Цикл 
		СписокСостояниеЗаказовПокупателей.УсловноеОформление.Элементы.Удалить(ЭлементУсловногоОформления);
	КонецЦикла;
			
	МассивУдаляемых = Новый Массив; Для Каждого ЭлементУсловногоОформления Из СписокСостояниеСтолов.УсловноеОформление.Элементы Цикл 
		Если (ЭлементУсловногоОформления.Представление = "ПрограммноеОформление") Тогда
			МассивУдаляемых.Добавить(ЭлементУсловногоОформления);
		КонецЕсли;
	КонецЦикла;
	Для Каждого ЭлементУсловногоОформления Из МассивУдаляемых Цикл 
		СписокСостояниеСтолов.УсловноеОформление.Элементы.Удалить(ЭлементУсловногоОформления);
	КонецЦикла;
	
	Для Каждого СтрокаТаблицыСтиля Из ТаблицаСтиля Цикл
		СостояниеЗаказовПокупателей = (ТипЗнч(СтрокаТаблицыСтиля.Состояние) = Тип("ПеречислениеСсылка.СостояниеЗаказовПокупателей"));	
		СостояниеСтолов = (ТипЗнч(СтрокаТаблицыСтиля.Состояние) = Тип("ПеречислениеСсылка.СостояниеСтолов"));	
		
		Если Истина Тогда
			
			Если СостояниеЗаказовПокупателей Тогда
				ЭлементУсловногоОформления = СписокСостояниеЗаказовПокупателей.УсловноеОформление.Элементы.Добавить();
			КонецЕсли;
			Если СостояниеСтолов Тогда
				ЭлементУсловногоОформления = СписокСостояниеСтолов.УсловноеОформление.Элементы.Добавить();
			КонецЕсли;
				
			ЭлементУсловногоОформления.Представление = "ПрограммноеОформление";
			ЭлементУсловногоОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			Если (Не СтрокаТаблицыСтиля.СхемаЦветТекста = Неопределено) Тогда
				ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", СтрокаТаблицыСтиля.СхемаЦветТекста);
			КонецЕсли;
			Если (Не СтрокаТаблицыСтиля.СхемаЦветФона = Неопределено) Тогда
				ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", СтрокаТаблицыСтиля.СхемаЦветФона);
			КонецЕсли;
			Если СостояниеЗаказовПокупателей Тогда
				ЗаполнитьЗначенияСвойств(ЭлементУсловногоОформления.Поля.Элементы.Добавить(), 
					Новый Структура("Поле,Использование", 
						Новый ПолеКомпоновкиДанных("ПримерСхема"), 
						Истина));
			КонецЕсли;
			Если СостояниеСтолов Тогда
				ЗаполнитьЗначенияСвойств(ЭлементУсловногоОформления.Поля.Элементы.Добавить(), 
					Новый Структура("Поле,Использование", 
						Новый ПолеКомпоновкиДанных("ПримерСхема"), 
						Истина));
			КонецЕсли;
			ЗаполнитьЗначенияСвойств(ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных")), 
				Новый Структура("ВидСравнения,Использование,ЛевоеЗначение,ПравоеЗначение", 
					ВидСравненияКомпоновкиДанных.Равно,
					Истина,
					Новый ПолеКомпоновкиДанных("Состояние"),
					СтрокаТаблицыСтиля.Состояние));
				
		КонецЕсли;
		Если СостояниеЗаказовПокупателей Тогда
			
			Если СостояниеЗаказовПокупателей Тогда
				ЭлементУсловногоОформления = СписокСостояниеЗаказовПокупателей.УсловноеОформление.Элементы.Добавить();
			КонецЕсли;
				
			ЭлементУсловногоОформления.Представление = "ПрограммноеОформление";
			ЭлементУсловногоОформления.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			Если (Не СтрокаТаблицыСтиля.СписокЦветТекста = Неопределено) Тогда
				ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", СтрокаТаблицыСтиля.СписокЦветТекста);
			КонецЕсли;
			Если (Не СтрокаТаблицыСтиля.СписокЦветФона = Неопределено) Тогда
				ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", СтрокаТаблицыСтиля.СписокЦветФона);
			КонецЕсли;
			Если СостояниеЗаказовПокупателей Тогда
				ЗаполнитьЗначенияСвойств(ЭлементУсловногоОформления.Поля.Элементы.Добавить(), 
					Новый Структура("Поле,Использование", 
						Новый ПолеКомпоновкиДанных("ПримерСписок"), 
						Истина));
			КонецЕсли;
			ЗаполнитьЗначенияСвойств(ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных")), 
				Новый Структура("ВидСравнения,Использование,ЛевоеЗначение,ПравоеЗначение", 
					ВидСравненияКомпоновкиДанных.Равно,
					Истина,
					Новый ПолеКомпоновкиДанных("Состояние"),
					СтрокаТаблицыСтиля.Состояние));
				
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры // УстановитьУсловноеОформлениеНаСервере()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЕСТЬNULL(СостояниеЗаказовПокупателей.Ссылка, СостояниеСтолов.Ссылка) КАК Состояние
	|ИЗ
	|	Перечисление.СостояниеЗаказовПокупателей КАК СостояниеЗаказовПокупателей
	|		ПОЛНОЕ СОЕДИНЕНИЕ Перечисление.СостояниеСтолов КАК СостояниеСтолов
	|		ПО (ЛОЖЬ)
	|ГДЕ
	|	НЕ ЕСТЬNULL(СостояниеЗаказовПокупателей.Ссылка, СостояниеСтолов.Ссылка) В
	|				(ВЫБРАТЬ
	|					СтилиСхемСтолов.Состояние
	|				ИЗ
	|					РегистрСведений.СтилиСхемСтолов КАК СтилиСхемСтолов)";
    Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Запись = РегистрыСведений.СтилиСхемСтолов.СоздатьМенеджерЗаписи();
		
		Запись.Состояние = Выборка.Состояние;
		
		Попытка
			Запись.Записать(Истина);
		Исключение
			// Карамба :(
		КонецПопытки;
		
	КонецЦикла;
	
	
	// Настройка формы.
	УстановитьУсловноеОформлениеНаСервере();
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если __УправлениеДаннымиКлиентСервер.ОповещениеИзмененияСтиля(ИмяСобытия) Тогда
		ОбработкаОповещенияНаСервере();
	КонецЕсли; 
	
КонецПроцедуры // ОбработкаОповещения()

&НаСервере
Процедура ОбработкаОповещенияНаСервере()
	
	// Настройка формы.
	УстановитьУсловноеОформлениеНаСервере();
	
КонецПроцедуры // ОбработкаОповещенияНаСервере()
