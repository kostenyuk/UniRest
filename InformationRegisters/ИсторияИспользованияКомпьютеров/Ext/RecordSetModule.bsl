﻿
Процедура ПередЗаписью(Отказ, Замещение)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяДата = ТекущаяДата();
	
	// Заполнение реквизитов.
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		Если Не ЗначениеЗаполнено(Запись.ДатаНачалаПериода) Тогда
			Запись.ДатаНачалаПериода = ТекущаяДата;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Запись.ДатаОкончанияПериода) Тогда
			Запись.ДатаНачалаПериода = Мин(Запись.ДатаНачалаПериода, Запись.ДатаОкончанияПериода);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры // ПередЗаписью()
