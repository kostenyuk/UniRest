﻿Процедура ПередЗаписью(Отказ, Замещение)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		Запись.Комментарий = СОКРЛ(Запись.Комментарий);
		
	КонецЦикла;
	
КонецПроцедуры
