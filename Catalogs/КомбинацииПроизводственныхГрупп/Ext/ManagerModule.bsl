﻿
Процедура СформироватьКомбинацииГрупп(Отказ, Источник) Экспорт
	
	// Запись комбинаций.
	Если Не Отказ Тогда
		
		УстановитьПривилегированныйРежим(Истина);
	
		Запрос = Новый Запрос("ВЫБРАТЬ
		                      |	ПроизводственныеГруппы.Ссылка,
		                      |	ПроизводственныеГруппы.Поиск КАК Поиск
		                      |ИЗ
		                      |	Справочник.ПроизводственныеГруппы КАК ПроизводственныеГруппы
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	Поиск");
		КомбинацииГруппЗаписать(Отказ, Запрос.Выполнить().Выгрузить(), Новый Массив, 0, Источник);					  
		
		УстановитьПривилегированныйРежим(Ложь);
	
	КонецЕсли; 
	
КонецПроцедуры // СформироватьКомбинацииГрупп()


Процедура КомбинацииГруппЗаписать(Отказ, ТаблицаСостава, МассивИспользованногоСостава, Начало, Источник)
	
	УстановитьПривилегированныйРежим(Истина);

	ПрефиксПоиска = Строка(Неопределено); Для Каждого СтрокаТаблицыСостава Из МассивИспользованногоСостава Цикл ПрефиксПоиска = ПрефиксПоиска + СтрокаТаблицыСостава.Поиск; КонецЦикла;
	
	Для Индекс = Начало По ТаблицаСостава.Количество() - 1 Цикл
		ОсновнаяСтрокаТаблицыСостава = ТаблицаСостава[Индекс];
		
		// Запись комбинации.
		КомбинацияПроизводственныхГрупп = Справочники.КомбинацииПроизводственныхГрупп.НайтиПоРеквизиту("Поиск", ПрефиксПоиска + ОсновнаяСтрокаТаблицыСостава.Поиск);
		Если КомбинацияПроизводственныхГрупп.Пустая() Тогда
			КомбинацияПроизводственныхГруппОбъект = Справочники.КомбинацииПроизводственныхГрупп.СоздатьЭлемент();
		Иначе
			КомбинацияПроизводственныхГруппОбъект = КомбинацияПроизводственныхГрупп.ПолучитьОбъект();
		КонецЕсли;
		КомбинацияПроизводственныхГруппОбъект.Состав.Очистить();
		Для Каждого СтрокаТаблицыСостава Из МассивИспользованногоСостава Цикл КомбинацияПроизводственныхГруппОбъект.Состав.Добавить().Основание = СтрокаТаблицыСостава.Ссылка; КонецЦикла;
		КомбинацияПроизводственныхГруппОбъект.Состав.Добавить().Основание = ОсновнаяСтрокаТаблицыСостава.Ссылка;
		Попытка
			КомбинацияПроизводственныхГруппОбъект.Записать();
		Исключение
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось обновить комбинации производственных групп'; uk = 'Не вдалося оновити комбінації виробничих груп'"), Источник, ,, Отказ); Прервать;
		КонецПопытки;
			
			
		Если (Не Индекс = ТаблицаСостава.Количество() - 1) Тогда
			
			МассивИспользованногоСостава.Добавить(ОсновнаяСтрокаТаблицыСостава);
			КомбинацииГруппЗаписать(Отказ, ТаблицаСостава, МассивИспользованногоСостава, Индекс + 1, Источник);
			МассивИспользованногоСостава.Удалить(МассивИспользованногоСостава.ВГраница());
			
			Если Отказ Тогда
				Прервать;
			КонецЕсли;
		КонецЕсли;
			
	КонецЦикла;
	
	УстановитьПривилегированныйРежим(Ложь);

КонецПроцедуры // КомбинацииГруппЗаписать()
