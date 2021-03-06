﻿
Процедура ПолучитьНаследуемыеРеквизиты(Объект) Экспорт
	
	__УправлениеДаннымиСервер.ПолучитьНаследуемыеРеквизиты(Объект);

КонецПроцедуры // ПолучитьНаследуемыеРеквизиты()


Процедура УстановитьАктуальность(Ссылка, Актуальность = Неопределено, Отказ = Неопределено) Экспорт
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		Попытка
			__УправлениеДаннымиСервер.УстановитьАктуальность(Ссылка, Актуальность);
		Исключение
			Отказ = Истина;
			// ERR
		КонецПопытки;
	КонецЕсли; 

КонецПроцедуры // УстановитьАктуальность()

Процедура УстановитьСвязанныеДанные(Ссылка, Данные, Отказ = Неопределено) Экспорт
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		Попытка
			__УправлениеДаннымиСервер.УстановитьСвязанныеДанные(Ссылка, Данные);
		Исключение
			Отказ = Истина;
			// ERR
		КонецПопытки;
	КонецЕсли; 

КонецПроцедуры // УстановитьСвязанныеДанные()





Процедура ПолучитьПравилаПринадлежности(Ссылка, Справочник, Реквизит, Объект) Экспорт

	__УправлениеДаннымиСервер.ПолучитьПравилаПринадлежности(Ссылка, Справочник, Реквизит, Объект);
	
КонецПроцедуры // ПолучитьПравилаПринадлежности()

Процедура ИзменитьПравилаПринадлежностиПодчиненных(Элемент, Объект) Экспорт

	ИзменитьПравилаАктуальностиПодчиненных(Элемент, Объект, "Принадлежность", Ложь);
	
КонецПроцедуры // ИзменитьПравилаПринадлежностиПодчиненных()

Процедура УстановитьПравилаПринадлежности(Ссылка, Справочник, Реквизит, Объект, Отказ) Экспорт

	__УправлениеДаннымиСервер.УстановитьПравилаПринадлежности(Ссылка, Справочник, Реквизит, Объект, Отказ);
	
КонецПроцедуры // УстановитьПравилаПринадлежности()


Процедура ИзменитьПравилаМодификаторовУсловийПодчиненных(Элемент, Объект) Экспорт

	ИзменитьПравилаАктуальностиПодчиненных(Элемент, Объект, "Актуальность", Истина);

КонецПроцедуры // ИзменитьПравилаМодификаторовУсловийПодчиненных()



Процедура ИзменитьПравилаАктуальностиПодчиненных(Элемент, Объект, Реквизит = "Актуальность", Связанность = Истина) Экспорт

	ТекущиеДанные = __РаботаСДиалогамиКлиентСервер.ПолучитьРодителя(Элемент, "ТаблицаФормы").ТекущиеДанные;
	
	// Изменение родителей.
	РодительДанные = ТекущиеДанные.ПолучитьРодителя();
	Пока (Не РодительДанные = Неопределено) Цикл
		ПодчиненныеЭлементы = РодительДанные.ПолучитьЭлементы(); 
		
		Итог = 0; Для Каждого ПодчиненныеДанные Из ПодчиненныеЭлементы Цикл Итог = Итог + ПодчиненныеДанные[Реквизит]; КонецЦикла; 
		РодительДанные[Реквизит] = (РодительДанные[Реквизит] Или (ПодчиненныеЭлементы.Количество() = Итог) Или Связанность) И Итог;
		
		РодительДанные = РодительДанные.ПолучитьРодителя();
	КонецЦикла;
	
	// Изменение подчиненных.
	МассивПодчиненных = Новый Массив; МассивПодчиненных.Добавить(ТекущиеДанные.ПолучитьЭлементы());

	Для Каждого РодительЭлементы Из МассивПодчиненных Цикл
		Для Каждого ПодчиненныеДанные Из РодительЭлементы Цикл
			ПодчиненныеДанные[Реквизит] = ТекущиеДанные[Реквизит];
					
			РодительЭлементы = ПодчиненныеДанные.ПолучитьЭлементы(); 
			Если РодительЭлементы.Количество() Тогда
				МассивПодчиненных.Добавить(РодительЭлементы);
			КонецЕсли; 
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры // ИзменитьПравилаАктуальностиПодчиненных()
