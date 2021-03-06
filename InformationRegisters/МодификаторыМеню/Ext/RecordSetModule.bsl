﻿
// Обработчик события ПередЗаписью объекта.
//
Процедура ПередЗаписью(Отказ, Замещение)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Проверка заполнения реквизитов.
	Для Каждого Запись Из ЭтотОбъект Цикл
		Если Запись.Актуальность И (Не ЗначениеЗаполнено(Запись.ТипМодификатора)) Тогда
			ОбщегоНазначения.СообщитьОбНезаполненомРеквизитеРегистра(ЭтотОбъект, "ТипМодификатора", Отказ);
		КонецЕсли;
		
		Если Отказ Тогда
			 Возврат;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры // ПередЗаписью()
