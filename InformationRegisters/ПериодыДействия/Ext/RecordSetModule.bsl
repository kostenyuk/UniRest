﻿
Процедура ПередЗаписью(Отказ, Замещение)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		// Нормализация.
		Если Не ЗначениеЗаполнено(Запись.ДатаОкончания) Тогда
			Запись.ДатаОкончания = __ОбщегоНазначенияКлиентСервер.МаксДата();
		КонецЕсли; 
		Если Не ЗначениеЗаполнено(Запись.ВремяОкончания) Тогда
			Запись.ВремяОкончания = __ОбщегоНазначенияКлиентСервер.МаксДата();
		КонецЕсли; 
		Запись.НомерМесяцаГода = Мин(Запись.НомерМесяцаГода, 12);
		Запись.НомерДняНедели = Мин(Запись.НомерДняНедели, 7);

	КонецЦикла;
	
КонецПроцедуры // ПередЗаписью()
