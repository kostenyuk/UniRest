﻿
Процедура Обновить() Экспорт
	
	ПолучитьФорму("Форма").Открыть();
	
КонецПроцедуры // Обновить()             

  
Функция ДобавитьОбновитьНоменклатуруМеню(Ном, ДатаРасчетов=Неопределено, Реквизиты = Неопределено, ОбновленноеКоличество = Неопределено, ОбщееКоличество = Неопределено) Экспорт
	
	//Запрос = Новый Запрос;	
	//Запрос.УстановитьПараметр("НоменклатураМеню", НоменклатураМеню.Ссылка);
	//
	//Запрос.Текст = "
	//|ВЫБРАТЬ 
	//|	ДанныеМеню.Номенклатура.Ссылка КАК Номенклатура
	//|ИЗ
	//|	РегистрСведений.НоменклатураМеню Как ДанныеМеню
	//|ГДЕ
	//|	Номенклатура.Ссылка  = &НоменклатураМеню
	//|";
	
	//РезультатЗапроса = Запрос.Выполнить();
	Номенклатура = Неопределено;
	Если ТипЗнч(Номенклатура) <> Тип("СправочникСсылка.Номенклатура") Тогда
		Номенклатура = Ном.Ссылка;
	Иначе
		Номенклатура = Ном ;
	КонецЕсли;
	
	НаборЗаписей = РегистрыСведений.НоменклатураМеню.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Номенклатура.Использование = Истина;
	НаборЗаписей.Отбор.Номенклатура.Значение = Номенклатура;
	
	НаборЗаписей.Прочитать();
	
	Если НаборЗаписей.Количество() = 0 Тогда
		Запись = НаборЗаписей.Добавить();
	Иначе
		Запись = НаборЗаписей[0];
	КонецЕсли;
	
	Запись.Код = Номенклатура.Код;
	Запись.Номенклатура = Номенклатура;
	Запись.Артикул = Номенклатура.Артикул;
	Запись.Наименование = Номенклатура.Наименование;
	Запись.НаименованиеПолное = Номенклатура.НаименованиеПолное;
	Запись.НаименованиеСокращенное = Номенклатура.НаименованиеСокращенное;
	Запись.БазоваяЕдиницаИзмерения = Номенклатура.БазоваяЕдиницаИзмерения;
	Запись.СтавкаНДС = Номенклатура.СтавкаНДС;
	Запись.ТипНоменклатуры = Номенклатура.ТипНоменклатуры;
	Запись.Безнадбавочный = Номенклатура.Безнадбавочный;
	Запись.Безскидочный = Номенклатура.Безскидочный;   		
	//Версия 
	//из номенклатуры - версию не пишу (объект)
	//из меню - версию не пишу (ссылка)        
	Если Номенклатура.Ссылка = Номенклатура.Ссылка.Ссылка Тогда
		Запись.Версия = Номенклатура.Версия;
	КонецЕсли;	
	Запись.Весовой 				= Номенклатура.Весовой;
	Запись.Заменяемый           = Номенклатура.Заменяемый;
	Запись.Модифицируемый       = Номенклатура.Модифицируемый;
	Запись.Набор                = Номенклатура.Набор;
	Запись.НоменклатурнаяГруппа = Номенклатура.НоменклатурнаяГруппа;
	Запись.Организация          = Номенклатура.НоменклатурнаяГруппа.Организация;
	Запись.ПенсионныйФонд       = Номенклатура.ПенсионныйФонд;
	Запись.Печатаемый           = Номенклатура.Печатаемый;
	Запись.СтавкаНДС            = Номенклатура.СтавкаНДС;
	Запись.ТипНоменклатуры      = Номенклатура.ТипНоменклатуры;
	Запись.Услуга               = Номенклатура.Услуга;
	Запись.Ценовой              = Номенклатура.Ценовой;
	Запись.Штучный              = Номенклатура.Штучный;
	Запись.ЭтоГруппа            = Номенклатура.ЭтоГруппа;
	
	//// -- Цены.  	
	//Если (ТипЗнч(НоменклатураМеню) = Тип("ВыборкаИзРезультатаЗапроса")) Тогда
	//	Запись.Цена = НоменклатураМеню.Цена;
	//	Запись.Себестоимость = НоменклатураМеню.Себестоимость;
	//Иначе
		СтруктураРесурсов = РегистрыСведений.ЦеныНоменклатуры.ПолучитьПоследнее(ДатаРасчетов, Новый Структура("Номенклатура", Номенклатура));
		Запись.Цена = СтруктураРесурсов.Цена;
		Запись.Себестоимость = СтруктураРесурсов.Себестоимость;
	//КонецЕсли;
	
	// Запись набора записей.
	Попытка
		НаборЗаписей.Записать();
	Исключение
		ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра("При записи элемента: "+Запись.Наименование+" произошла ошибка: "+ОписаниеОшибки(), , ,, НаборЗаписей, Номенклатура);
		Возврат Ложь;
	КонецПопытки;
	
	//НаборЗаписей = РегистрыСведений.НоменклатураМеню.СоздатьНаборЗаписей();
	//НаборЗаписей.Отбор.Номенклатура.Использование = Истина;
	//НаборЗаписей.Отбор.Номенклатура.Значение = Номенклатура;
	//Запись = НаборЗаписей.Добавить();
	//
	////запись данных по Модификаторам
	//Запрос = Новый Запрос;	
	//Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	//
	//Запрос.Текст = "ВЫБРАТЬ
	//			   |	МодификаторыНоменклатуры.Номенклатура,
	//			   |	МодификаторыНоменклатуры.Модификатор,
	//			   |	МодификаторыНоменклатуры.Актуальность
	//			   |ИЗ
	//			   |	РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
	//			   |ГДЕ
	//			   |	МодификаторыНоменклатуры.Номенклатура = &Номенклатура";
	//																										   
	//РезультатЗапроса = Запрос.Выполнить();
	//Если НЕ(РезультатЗапроса.Пустой()) Тогда
	//	Выборка = РезультатЗапроса.Выбрать();
	//	Пока Выборка.Следующий() Цикл                 						
	//		НаборЗаписей = РегистрыСведений.МодификаторыМеню.СоздатьНаборЗаписей();				
	//		НаборЗаписей.Отбор.Номенклатура.Установить(Номенклатура, Истина);
	//		НаборЗаписей.Отбор.Модификатор.Установить(Выборка.Модификатор, Истина);
	//		Запись = НаборЗаписей.Добавить();
	//		Запись.Номенклатура = Номенклатура.Ссылка;
	//		Запись.Модификатор = Выборка.Модификатор.Ссылка;
	//		Запись.Актуальность = Выборка.Актуальность;
	//		Запись.ТипМодификатора = Перечисления.ТипыСтрокЗаказов.ПустаяСсылка();//Выборка.ТипМодификатора;
	//		//Запись.Неотъемлемый = Выборка.Неотъемлемый;			
	//		// Запись набора записей.
	//		Попытка
	//			НаборЗаписей.Записать(Истина);
	//		Исключение
	//			ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), , ,, НаборЗаписей, Номенклатура);
	//			Возврат Ложь;
	//		КонецПопытки; 	
	//	КонецЦикла;					
	//КонецЕсли;	
	
	//запись данных по Комплектующим
	Запрос = Новый Запрос;	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	Номенклатура,
	|	Комплектующая,
	|	Количество
	|ИЗ
	|	РегистрСведений.КомплектующиеНоменклатуры КАК КомплектующиеНоменклатуры
	|ГДЕ
	|	КомплектующиеНоменклатуры.Номенклатура = &Номенклатура
	|";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ(РезультатЗапроса.Пустой()) Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл                 						
			НаборЗаписей = РегистрыСведений.КомплектующиеМеню.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Номенклатура.Использование = Истина;			
			НаборЗаписей.Отбор.Номенклатура.Значение = Номенклатура.Ссылка;						
			НаборЗаписей.Отбор.Комплектующая.Использование = Истина;
			НаборЗаписей.Отбор.Комплектующая.Значение = Выборка.Комплектующая.Ссылка;
			Запись = НаборЗаписей.Добавить();
			Запись.Номенклатура = Номенклатура.Ссылка;
			Запись.Комплектующая = Выборка.Комплектующая.Ссылка;
			Запись.Количество = Выборка.Количество;
			// Запись набора записей.
			Попытка
				НаборЗаписей.Записать(Истина);
			Исключение
				ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), , ,, НаборЗаписей, Номенклатура);
				Возврат Ложь;
			КонецПопытки; 	
		КонецЦикла;					
	КонецЕсли;
	Если НЕ(ОбновленноеКоличество=Неопределено) Тогда
		ОбновленноеКоличество = ОбновленноеКоличество+1;
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

//из номенклатуры - версию не пишу (объект)
//из меню - версию не пишу (ссылка)         Ссылка = Ссылка.Ссылка
Функция ДобавитьНоменклатуруМеню(Ссылка = Неопределено, ДатаРасчетов = Неопределено, Реквизиты = Неопределено, ОбновленноеКоличество = Неопределено, ОбщееКоличество = Неопределено) Экспорт
	//ДатаРасчетов = для периодики, если нет то текущая
	Возврат Истина;	
	
КонецФункции // ДобавитьНоменклатуруМеню()

// Процедура считывает и обновляет содержимое меню данного Вида меню. СОХРАНИМ!!! ВДРУГ ПОНАДОБИТСЯ!!!
//
//Функция ОбновитьМеню(ВидМеню, ДатаРасчетов = Неопределено, РеквизитыСписок = Неопределено, ОбновленноеКоличество = 0) Экспорт
//	
//	// Нормализация.
//	Если Не ЗначениеЗаполнено(ДатаРасчетов) Тогда
//		ДатаРасчетов = ТекущаяДата();
//	КонецЕсли;
//	
//	// Запись данных.
//	Попытка
//		НачатьТранзакцию();
//		
//		// -- Выборка номенклатуры меню.
//		Запрос = Новый Запрос(
//			"ВЫБРАТЬ
//			|	Меню.Ссылка КАК Ссылка,
//			|	ВЫРАЗИТЬ(Меню.Номенклатура КАК Справочник.Номенклатура) КАК Номенклатура
//			|ИЗ
//			|	Справочник.Меню КАК Меню
//			|ГДЕ
//			|	Меню.Владелец = &Владелец
//			|	И НЕ Меню.ЭтоГруппа
//			|");
//		Запрос.УстановитьПараметр("Владелец", ВидМеню.Ссылка);
//		РезультатЗапроса = Запрос.Выполнить();
//		
//		Если Не РезультатЗапроса.Пустой() Тогда
//			// -- Выборка измененной номенклатуры.
//			ТаблицаРезультатаЗапроса = РезультатЗапроса.Выгрузить();
//			МассивНоменклатуры = ТаблицаРезультатаЗапроса.ВыгрузитьКолонку("Номенклатура");
//			МассивМеню = ТаблицаРезультатаЗапроса.ВыгрузитьКолонку("Ссылка");
//	
//			Запрос = Новый Запрос(
//				"ВЫБРАТЬ
//				|	Меню.Ссылка,
//				|	НоменклатураМеню.НаименованиеПолное,
//				|	НоменклатураМеню.НаименованиеСокращенное,
//				|	НоменклатураМеню.БазоваяЕдиницаИзмерения,
//				|	НоменклатураМеню.СтавкаНДС,
//				|	НоменклатураМеню.ТипНоменклатуры,
//				|	НоменклатураМеню.Безскидочный,
//				|	НоменклатураМеню.Безнадбавочный,
//				|	НоменклатураМеню.Цена,
//				|	НоменклатураМеню.Себестоимость,
//				|	НоменклатураМеню.Артикул
//				|ИЗ
//				|	Справочник.Меню КАК Меню
//				|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
//				|			НоменклатураМеню.Ссылка КАК Ссылка,
//				|			НоменклатураМеню.НаименованиеПолное КАК НаименованиеПолное,
//				|			НоменклатураМеню.НаименованиеСокращенное КАК НаименованиеСокращенное,
//				|			НоменклатураМеню.БазоваяЕдиницаИзмерения КАК БазоваяЕдиницаИзмерения,
//				|			НоменклатураМеню.СтавкаНДС КАК СтавкаНДС,
//				|			НоменклатураМеню.ТипНоменклатуры КАК ТипНоменклатуры,
//				|			НоменклатураМеню.Безскидочный КАК Безскидочный,
//				|			НоменклатураМеню.Безнадбавочный КАК Безнадбавочный,
//				|			НоменклатураМеню.Артикул КАК Артикул,
//				|			ЦеныНоменклатуры.Цена КАК Цена,
//				|			ЦеныНоменклатуры.Себестоимость КАК Себестоимость
//				|		ИЗ
//				|			Справочник.Номенклатура КАК НоменклатураМеню
//				|				ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Период, Номенклатура В (&НоменклатураМеню)) КАК ЦеныНоменклатуры
//				|				ПО НоменклатураМеню.Ссылка = ЦеныНоменклатуры.Номенклатура
//				|		ГДЕ
//				|			НоменклатураМеню.Ссылка В(&НоменклатураМеню)) КАК НоменклатураМеню
//				|		ПО Меню.Номенклатура = НоменклатураМеню.Ссылка
//				|ГДЕ
//				|	Меню.Владелец = &Владелец
//				|	И (НЕ Меню.ЭтоГруппа)
//				|	И Меню.Ссылка В(&Меню)");
//			Запрос.УстановитьПараметр("Период", ДатаРасчетов);
//			Запрос.УстановитьПараметр("НоменклатураМеню", МассивНоменклатуры);
//			Запрос.УстановитьПараметр("Владелец", ВидМеню.Ссылка);
//			Запрос.УстановитьПараметр("Меню", МассивМеню);
//	
//			// -- Обновление данных.
//			Выборка = Запрос.Выполнить().Выбрать();
//			Пока Выборка.Следующий() Цикл
//				
//				МенюОбъект = Выборка.Ссылка.ПолучитьОбъект();
//				ОбновитьНоменклатуруМеню(МенюОбъект, Выборка);
//				МенюОбъект.Записать();
//				
//				ОбновленноеКоличество = ОбновленноеКоличество + 1;
//			КонецЦикла;
//			
//		КонецЕсли;
//		
//		// -- Актуализация последнего обновления.
//		//ЭтотОбъект.ПоследнееОбновление = РабочаяДата;
//		//ЭтотОбъект.СледующееОбновление = Неопределено;
//		//ЭтотОбъект.Записать();
//		
//		ЗафиксироватьТранзакцию();
//	Исключение
//		ОбщегоНазначения.СообщитьОбОшибке(":" + Символы.ПС + ОписаниеОшибки());
//		
//		Если ТранзакцияАктивна() Тогда
//			ОтменитьТранзакцию();
//		КонецЕсли;
//		
//		Возврат Ложь;
//	КонецПопытки;
//	
//	// Успешное изменение данных.
//	Возврат Истина;
//	
//КонецФункции // ОбновитьМеню()


//ДобавитьНоменклатуруМеню(Ссылка = Неопределено, ДатаРасчетов = Неопределено, Реквизиты = Неопределено, ОбновленноеКолличество = Неопределено, ОбщееКоличество = Неопределено) Экспорт
//Функция ОбновитьНоменклатуруМеню(Ссылка, ДатаРасчетов = Неопределено) Экспорт	
//	//ДатаРасчетов = для периодики, если нет то тЕкущая
//	Возврат Истина;	
//	
//КонецФункции // ОбновитьНоменклатуру()
