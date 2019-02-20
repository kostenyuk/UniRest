﻿Перем мПериод          Экспорт; // Период движений.
Перем мТаблицаДвижений Экспорт; // Таблица движений.

// Выполняет движения по регистру.
//
Процедура ВыполнитьДвижения() Экспорт

	ОбщегоНазначения.ВыполнитьДвижениеПоРегистру(ЭтотОбъект);

КонецПроцедуры // ВыполнитьДвижения()


// Обработчик события ПередЗаписью объекта.
//
Процедура ПередЗаписью(Отказ, Замещение)
	
	// При обмене данными ничего не проверяем.
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Проверка заполнения реквизитов.
	Для Каждого Запись Из ЭтотОбъект Цикл
		Если ОбщегоНазначения.ЗначениеНЕЗаполнено(Запись.Количество) Тогда
			ОбщегоНазначения.СообщитьОбНезаполненомРесурсеРегистра(ЭтотОбъект, "Количество", Отказ);
		КонецЕсли;
		
		Если Отказ Тогда
			 Возврат;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры // ПередЗаписью()