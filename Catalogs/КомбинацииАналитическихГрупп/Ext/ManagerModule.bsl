﻿
Процедура СформироватьКомбинацииГрупп(Отказ, Источник) Экспорт
	
	// Запись комбинаций.
	Если Не Отказ Тогда
		
		УстановитьПривилегированныйРежим(Истина);
	
		Запрос = Новый Запрос("ВЫБРАТЬ
		                      |	АналитическиеГруппы.Ссылка,
		                      |	АналитическиеГруппы.Поиск КАК Поиск
		                      |ИЗ
		                      |	Справочник.АналитическиеГруппы КАК АналитическиеГруппы
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
		КомбинацияАналитическихГрупп = Справочники.КомбинацииАналитическихГрупп.НайтиПоРеквизиту("Поиск", ПрефиксПоиска + ОсновнаяСтрокаТаблицыСостава.Поиск);
		Если КомбинацияАналитическихГрупп.Пустая() Тогда
			КомбинацияАналитическихГруппОбъект = Справочники.КомбинацииАналитическихГрупп.СоздатьЭлемент();
		Иначе
			КомбинацияАналитическихГруппОбъект = КомбинацияАналитическихГрупп.ПолучитьОбъект();
		КонецЕсли;
		КомбинацияАналитическихГруппОбъект.Состав.Очистить();
		Для Каждого СтрокаТаблицыСостава Из МассивИспользованногоСостава Цикл КомбинацияАналитическихГруппОбъект.Состав.Добавить().Основание = СтрокаТаблицыСостава.Ссылка; КонецЦикла;
		КомбинацияАналитическихГруппОбъект.Состав.Добавить().Основание = ОсновнаяСтрокаТаблицыСостава.Ссылка;
		Попытка
			КомбинацияАналитическихГруппОбъект.Записать();
		Исключение
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось обновить комбинации аналитических групп'; uk = 'Не вдалося оновити комбінації аналітичних груп'"), Источник, ,, Отказ); Прервать;
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
