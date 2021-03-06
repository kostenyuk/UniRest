﻿Функция ПолучитьСписокРодителейПоИерархии(Номенклатура) Экспорт
	
	//Если НЕ ЗначениеЗаполнено(Номенклатура.Родитель) Тогда
	//	Возврат Номенклатура;
	//КонецЕсли;
	//
	//Массив = Новый Массив;
	//Массив.Добавить(Номенклатура);
	//ТекущаяНоменклатура = Номенклатура;
	//Пока ЗначениеЗаполнено(ТекущаяНоменклатура.Родитель) Цикл
	//	ТекущаяНоменклатура = ТекущаяНоменклатура.Родитель;
	//	Массив.Добавить(ТекущаяНоменклатура);
	//КонецЦикла;
	//Возврат Массив;
	Возврат ОбщегоНазначенияСервер.ПолучитьСписокИерархииССылки(Номенклатура) ;
	
КонецФункции

Процедура ЗаполнитьРекурсивноДерево(Строка)
	
	СтрокаРодитель = Строка.Родитель;
	
	Если НЕ Строка.АктуальностьВРегистре Тогда
		Строка.Актуальность = ?(СтрокаРодитель=Неопределено,Ложь,СтрокаРодитель.Актуальность);
	КонецЕсли;
	
	Если Строка.ЭтоГруппа Тогда
		Строка.Картинка = БиблиотекаКартинок.TouchИерархияРодитель;
	Иначе
		Строка.Картинка = БиблиотекаКартинок.TouchИерархияЭлеменит;
	КонецЕсли;
	
	Для Каждого ПодчиненнаяСтрока ИЗ Строка.Строки Цикл
		ЗаполнитьРекурсивноДерево(ПодчиненнаяСтрока);
	Конеццикла;
	
КонецПроцедуры

Процедура ОбновитьРекурсивноДерево(Строка)
	
	СтрокаРодитель		= Строка.Родитель;
	Строка.Актуальность = ?(СтрокаРодитель=Неопределено,Ложь,СтрокаРодитель.Актуальность);
	
	Для Каждого ПодчиненнаяСтрока ИЗ Строка.Строки Цикл
		ОбновитьРекурсивноДерево(ПодчиненнаяСтрока);
	Конеццикла;
	
КонецПроцедуры

Процедура ОбновитьДерево(Дерево, Номенклатура, ИмяРегистра, ИмяРеквизита)
	
	Текст =
	"ВЫБРАТЬ
	|	Регистр.Актуальность,
	|	Регистр.Модификатор КАК Поле
	|ИЗ
	|	РегистрСведений.МодификаторыНоменклатуры КАК Регистр
	|ГДЕ
	|	Регистр.Номенклатура = &Номенклатура";
	
	Текст = СтрЗаменить(Текст,"РегистрСведений.МодификаторыНоменклатуры","РегистрСведений."+ИмяРегистра);
	Текст = СтрЗаменить(Текст,"Регистр.Модификатор","Регистр."+ИмяРеквизита);
	
	Запрос = Новый Запрос(Текст);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
	
		Строка = Дерево.Строки.Найти(Выборка.Поле,"Модификатор",Истина);
		Если Строка<>Неопределено Тогда
			Строка.Актуальность			= Выборка.Актуальность;
			Для Каждого ПодчиненнаяСтрока ИЗ Строка.Строки Цикл
				ОбновитьРекурсивноДерево(ПодчиненнаяСтрока);
			Конеццикла;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция СоздатьДеревоПервогоЭлемента(Номенклатура, ИмяРегистра, ИмяРеквизита)
	
	Текст =
	"ВЫБРАТЬ
	|	Данные.Ссылка КАК Модификатор,
	|	Регистр.Актуальность,
	|	ВЫБОР
	|		КОГДА Регистр.Актуальность ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК АктуальностьВРегистре,
	|	Данные.ЭтоГруппа
	|ИЗ
	|	Справочник.МодификаторыНоменклатуры КАК Данные
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МодификаторыНоменклатуры КАК Регистр
	|		ПО Данные.Ссылка = Регистр.Модификатор
	|			И (Регистр.Номенклатура = &Номенклатура)
	|ГДЕ
	|	Данные.Актуальность
	|	И (НЕ Данные.ПометкаУдаления)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Модификатор ИЕРАРХИЯ
	|АВТОУПОРЯДОЧИВАНИЕ";
	
	Текст = СтрЗаменить(Текст,"РегистрСведений.МодификаторыНоменклатуры","РегистрСведений."+ИмяРегистра);
	Текст = СтрЗаменить(Текст,"Справочник.МодификаторыНоменклатуры","Справочник."+ИмяРегистра);
	Текст = СтрЗаменить(Текст,"Данные.Модификатор","Данные."+ИмяРеквизита);
	Текст = СтрЗаменить(Текст,"Регистр.Модификатор","Регистр."+ИмяРеквизита);
	
	Запрос = Новый Запрос(Текст);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	ДеревоЗначение = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	ДеревоЗначение.Колонки.Добавить("Картинка");
	
	Для Каждого ПодчиненнаяСтрока ИЗ ДеревоЗначение.Строки Цикл
		ЗаполнитьРекурсивноДерево(ПодчиненнаяСтрока);
	Конеццикла;
	
	Возврат ДеревоЗначение;
	
КонецФункции

Функция СоздатьДерево(Номенклатура, ИмяРегистра, ИмяРеквизита)
	
	Массив = ПолучитьСписокРодителейПоИерархии(Номенклатура);
	Если ТипЗнч(Массив)<>Тип("Массив") ИЛИ Массив.Количество()=0 Тогда
		Возврат СоздатьДеревоПервогоЭлемента(Номенклатура, ИмяРегистра, ИмяРеквизита);
	КонецЕсли;
	
	Индекс = Массив.ВГраница();
	Дерево = СоздатьДеревоПервогоЭлемента(Массив[Индекс], ИмяРегистра, ИмяРеквизита);
	Индекс = Индекс - 1;
	Пока Индекс>=0 Цикл
		ОбновитьДерево(Дерево,Массив[Индекс],ИмяРегистра,ИмяРеквизита);
		Индекс = Индекс -1;
	КонецЦикла;
	
	Возврат Дерево;
	
КонецФункции

Функция ПрочитатьЗаписиРегистра(ИмяРегистра,Ссылка) Экспорт
	
	Массив = ПолучитьСписокРодителейПоИерархии(Ссылка);
	
	Если ТипЗнч(Массив)=Тип("Массив") Тогда
		
		Массив.Удалить(0);
		
		Текст = 
		"ВЫБРАТЬ
		|	УсловияНоменклатуры.Номенклатура,
		|	УсловияНоменклатуры.Условия КАК Модификатор,
		|	УсловияНоменклатуры.Актуальность КАК Актуальность
		|ИЗ
		|	РегистрСведений.УсловияНоменклатуры КАК УсловияНоменклатуры
		|ГДЕ
		|	УсловияНоменклатуры.Номенклатура В(&Номенклатура)
		|
		|УПОРЯДОЧИТЬ ПО
		|	Актуальность УБЫВ";
		Текст = СтрЗаменить(Текст,"РегистрСведений.УсловияНоменклатуры","РегистрСведений."+ИмяРегистра);
		Текст = СтрЗаменить(Текст,"УсловияНоменклатуры.Условия","УсловияНоменклатуры."+?(ИмяРегистра="УсловияНоменклатуры","Условия","Модификатор"));
		
		Запрос = Новый Запрос(Текст);
		Запрос.УстановитьПараметр("Номенклатура",Массив);
		Возврат Запрос.Выполнить().Выгрузить();
		
	Иначе
		
		Результат = Новый ТаблицаЗначений;
		Результат.Колонки.Добавить("Номенклатура");
		Результат.Колонки.Добавить("Модификатор");
		Результат.Колонки.Добавить("Актуальность");
		
		Возврат Результат;

	КонецЕсли; 
	
КонецФункции

Функция СоздатьДеревоМодификаторов(Номенклатура) Экспорт
	
	Возврат СоздатьДерево(Номенклатура,"МодификаторыНоменклатуры","Модификатор");
	
КонецФункции

Функция СоздатьДеревоУсловийПриготовления(Номенклатура) Экспорт
	
	Возврат СоздатьДерево(Номенклатура,"УсловияНоменклатуры","Условия");
	
КонецФункции

Функция ИспользуетсяМодификатор(Номенклатура,Модификатор) Экспорт
	
	МассивМодификаторов = ОбщегоНазначенияСервер.ПолучитьСписокИерархииССылки(Модификатор, "МодификаторыНоменклатуры");
	МассивНоменклатуры = ПолучитьСписокРодителейПоИерархии(Номенклатура);
	
	Для Каждого РодительНоменклатуры Из МассивНоменклатуры Цикл
	
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	Данные.Актуальность
		|ИЗ
		|	РегистрСведений.МодификаторыНоменклатуры КАК Данные
		|ГДЕ
		|	Данные.Номенклатура = &Номенклатура
		|	И Данные.Модификатор = &Модификатор"
		);
		Запрос.УстановитьПараметр("Номенклатура",РодительНоменклатуры);
		
		Для Каждого Строка Из МассивМодификаторов Цикл
			Запрос.УстановитьПараметр("Модификатор",Строка);
			Результат = Запрос.Выполнить().Выбрать();
			Если Результат.Следующий() Тогда
				Возврат Результат.Актуальность;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ИспользуетсяУсловие(Номенклатура,Модификатор) Экспорт
	
	МассивМодификаторов = ПолучитьСписокРодителейПоИерархии(Модификатор);
	МассивНоменклатуры = ПолучитьСписокРодителейПоИерархии(Номенклатура);
	
	Для Каждого РодительНоменклатуры Из МассивНоменклатуры Цикл
	
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	Данные.Актуальность
		|ИЗ
		|	РегистрСведений.УсловияНоменклатуры КАК Данные
		|ГДЕ
		|	Данные.Номенклатура = &Номенклатура
		|	И Данные.Условия = &Модификатор"
		);
		Запрос.УстановитьПараметр("Номенклатура",РодительНоменклатуры);
		
		Для Каждого Строка Из МассивМодификаторов Цикл
			Запрос.УстановитьПараметр("Модификатор",Строка);
			Результат = Запрос.Выполнить().Выбрать();
			Если Результат.Следующий() Тогда
				Возврат Результат.Актуальность;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции


// Рефакторинг: 
//	1. Удалить "Версия", "Период", "ИмяФайла", "ФайлИзображения", "Версия";
//	2. Переименовать "МножественныйВыборМодификаторов" в "МодифицируемыйМножественно".