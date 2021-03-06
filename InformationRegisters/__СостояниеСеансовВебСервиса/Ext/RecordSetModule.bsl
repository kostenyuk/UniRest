﻿
Процедура ПередЗаписью(Отказ, Замещение)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяДата = ТекущаяДата();
	
	// Заполнение реквизитов.
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		Если Не ЗначениеЗаполнено(Запись.ГруппаПользователей) Тогда
			Запись.ГруппаПользователей = ПараметрыСеанса.ТекущаяГруппаПользователей;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Запись.Компьютер) Тогда
			Запись.Компьютер = ПараметрыСеанса.ТекущийКомпьютер;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Запись.Пользователь) Тогда
			Запись.Пользователь = ПараметрыСеанса.ТекущийПользователь;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Запись.РежимРаботы) Тогда
			Запись.РежимРаботы = ПараметрыСеанса.ТекущийРежимРаботы;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Запись.Сотрудник) Тогда
			Запись.Сотрудник = ПараметрыСеанса.ТекущийСотрудник;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Запись.ДатаНачалаПериода) Тогда
			Запись.ДатаНачалаПериода = ТекущаяДата;
		КонецЕсли;
		Запись.ДатаОкончанияПериода = Макс(Запись.ДатаОкончанияПериода, ТекущаяДата);
		
	КонецЦикла;
	
КонецПроцедуры // ПередЗаписью()
