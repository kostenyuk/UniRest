﻿
Функция ПолучитьПозициюМеню(Сеанс, Позиция)

	// Результат.
	Возврат ПолучитьСправочник(__Из(Сеанс), "Меню", Новый Структура, Истина, Ложь, "Полный", __Из(Позиция, Истина, Справочники.Меню.ПустаяСсылка()));

КонецФункции // ПолучитьПозициюМеню()

Функция НайтиПозицииМеню(Сеанс, Наименование)

	// Поиск.
	Поиск = СтрЗаменить(СокрЛП(Наименование), " ", "%");
	
	// Проверка.
	Если ПустаяСтрока(Поиск) Тогда
		Возврат __В(Новый Массив);
	Иначе
		Поиск = "%" + Поиск + "%";
	КонецЕсли; 
	
	Соответствие = Новый Соответствие;
	Соответствие["СОДЕРЖИТ Наименование"] = Поиск;
	Соответствие["СОДЕРЖИТ Номенклатура.Артикул"] = Поиск;
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Сеанс), "Меню", Новый Структура("ИЛИ, ЭтоГруппа", Соответствие, Ложь), Ложь, Истина, "Полный", Неопределено);

КонецФункции // НайтиПозицииМеню()

Функция ПолучитьМеню(Сеанс, Отбор, Иерархия)
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Сеанс), "Меню", __Из(Отбор, Истина, Новый Структура), Иерархия, Ложь, "Краткий", Неопределено);

КонецФункции // ПолучитьМеню()

Функция ПолучитьМодификаторы(Сеанс, Отбор, Иерархия)

	// Результат.
	Возврат ПолучитьСправочник(__Из(Сеанс), "МодификаторыНоменклатуры", __Из(Отбор, Истина, Новый Структура), Иерархия, Ложь, "Краткий", Неопределено);

КонецФункции // ПолучитьМодификаторы()

Функция ПолучитьУсловия(Сеанс, Отбор, Иерархия)

	// Результат.
	Возврат ПолучитьСправочник(__Из(Сеанс), "УсловияНоменклатуры", __Из(Отбор, Истина, Новый Структура), Иерархия, Ложь, "Краткий", Неопределено);

КонецФункции // ПолучитьУсловия()

Функция ПолучитьПрайсЛист(Сеанс, Отбор, Иерархия)

	// Результат.
	Возврат ПолучитьСправочник(__Из(Сеанс), "Меню", __Из(Отбор, Истина, Новый Структура), Иерархия, Ложь, "Краткий", Неопределено);

КонецФункции // ПолучитьПрайсЛист()

Функция ПолучитьНоменклатуру(Сеанс, Отбор)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	СправочникНоменклатура.Ссылка КАК Ссылка,
	                      |	СправочникНоменклатура.Код КАК Код,
	                      |	СправочникНоменклатура.Артикул КАК Артикул,
	                      |	СправочникНоменклатура.Наименование КАК Наименование,
	                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СправочникНоменклатура.БазоваяЕдиницаИзмерения) КАК БазоваяЕдиницаИзмерения,
	                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СправочникНоменклатура.КатегорияНоменклатуры) КАК КатегорияНоменклатуры,
	                      |	СправочникНоменклатура.Модифицируемый,
	                      |	СправочникНоменклатура.МножественныйВыборМодификаторов КАК МодифицируемыйМножественно,
	                      |	СправочникНоменклатура.МаксимальноеКоличествоМодификаторов,
	                      |	СправочникНоменклатура.ПовторениеМодификаторов,
	                      |	ВЫРАЗИТЬ(СправочникНоменклатура.Состав КАК СТРОКА(1000)) КАК Состав,
	                      |	СправочникНоменклатура.Выход,
	                      |	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
	                      |	ВЫБОР
	                      |		КОГДА МодификаторыНоменклатуры.Номенклатура ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК ЕстьМодификаторы,
	                      |	ВЫБОР
	                      |		КОГДА УсловияНоменклатуры.Номенклатура ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК ЕстьУсловия,
	                      |	ВЫБОР
	                      |		КОГДА СопутствующаяНоменклатура.Номенклатура ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК ЕстьСопутствующие,
	                      |	СправочникНоменклатура.Изображение КАК Изображение,
	                      |	СправочникНоменклатура.Миниатюра КАК Миниатюра,
	                      |	СправочникНоменклатура.Иконка КАК Иконка
	                      |ИЗ
	                      |	Справочник.Номенклатура КАК СправочникНоменклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Дата, ) КАК ЦеныНоменклатурыСрезПоследних
	                      |		ПО СправочникНоменклатура.Ссылка = ЦеныНоменклатурыСрезПоследних.Номенклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |			МодификаторыНоменклатуры.Номенклатура КАК Номенклатура
	                      |		ИЗ
	                      |			РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
	                      |		ГДЕ
	                      |			МодификаторыНоменклатуры.Актуальность) КАК МодификаторыНоменклатуры
	                      |		ПО СправочникНоменклатура.Ссылка = МодификаторыНоменклатуры.Номенклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |			УсловияНоменклатуры.Номенклатура КАК Номенклатура
	                      |		ИЗ
	                      |			РегистрСведений.УсловияНоменклатуры КАК УсловияНоменклатуры
	                      |		ГДЕ
	                      |			УсловияНоменклатуры.Актуальность) КАК УсловияНоменклатуры
	                      |		ПО СправочникНоменклатура.Ссылка = УсловияНоменклатуры.Номенклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |			СопутствующаяНоменклатура.Номенклатура КАК Номенклатура
	                      |		ИЗ
	                      |			РегистрСведений.СопутствующаяНоменклатура КАК СопутствующаяНоменклатура
	                      |		ГДЕ
	                      |			СопутствующаяНоменклатура.Актуальность) КАК СопутствующаяНоменклатура
	                      |		ПО СправочникНоменклатура.Ссылка = СопутствующаяНоменклатура.Номенклатура
	                      |ГДЕ
	                      |	&Отбор");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "СправочникНоменклатура.Изображение");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "СправочникНоменклатура.Миниатюра");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "СправочникНоменклатура.Иконка");
	Запрос.УстановитьПараметр("Дата", ТекущаяДата());						  
	
	// Отбор.
	__ЗапросыСервер.НаложитьОтборСтруктурой(Запрос, __Из(Отбор, Истина, Новый Структура), "&Отбор", "СправочникНоменклатура");
	
	// Результат.
	Возврат __В(Запрос);

КонецФункции // ПолучитьНоменклатуру()

Функция ПолучитьМодификаторыНоменклатуры(Сеанс, Номенклатура)

	// Результат.
	Возврат ПолучитьМодификаторыУсловия(Сеанс, "МодификаторыНоменклатуры", Номенклатура);

КонецФункции // ПолучитьМодификаторыНоменклатуры()

Функция ПолучитьУсловияНоменклатуры(Сеанс, Номенклатура)

	// Результат.
	Возврат ПолучитьМодификаторыУсловия(Сеанс, "УсловияНоменклатуры", Номенклатура);

КонецФункции // ПолучитьУсловияНоменклатуры()

Функция ПолучитьСопутствующиеНоменклатуры(Сеанс, Номенклатура)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	Меню.Ссылка КАК Ссылка
	                      |ИЗ
	                      |	Справочник.Меню КАК Меню
	                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.__НастройкиВебСервиса КАК __НастройкиВебСервиса
	                      |		ПО Меню.Владелец = __НастройкиВебСервиса.ВебСервисВидМеню
	                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СопутствующаяНоменклатура КАК СопутствующаяНоменклатура
	                      |		ПО (СопутствующаяНоменклатура.Номенклатура = &Номенклатура)
	                      |			И Меню.Номенклатура = СопутствующаяНоменклатура.Сопутствующая
	                      |ГДЕ
	                      |	&ПериодыДействия
	                      |	И Меню.Актуальность
	                      |ИТОГИ ПО
	                      |	Ссылка ТОЛЬКО ИЕРАРХИЯ");	
	РегистрыСведений.ПериодыДействия.ПериодДействияСгенерироватьУсловиеЗапроса(Запрос, "&ПериодыДействия", "Меню");
	Запрос.УстановитьПараметр("Номенклатура", __Из(Номенклатура));						  
	
	// Выборка данных.
	ПромежуточныйРезультат = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	// Результат.
	Результат = Новый ДеревоЗначений; Для Каждого Колонка Из ПромежуточныйРезультат.Колонки Цикл Результат.Колонки.Добавить(Колонка.Имя, Колонка.ТипЗначения); КонецЦикла; 
	
	// Перенос данных.
	СоответствиеРодителей = Новый Соответствие; МассивПодчиненных = Новый Массив; МассивПодчиненных.Добавить(ПромежуточныйРезультат.Строки);

	Для Каждого РодительЭлементы Из МассивПодчиненных Цикл
		Для Каждого ПодчиненныеДанные Из РодительЭлементы Цикл
			ПодчиненныеЭлементы = ПодчиненныеДанные.Строки; Перенос = Ложь;
			
			Если Не ПодчиненныеЭлементы.Количество() Тогда
				Перенос = Истина;
			Иначе
				Если ПодчиненныеЭлементы.Количество() - 1 Тогда
					Перенос = ЗначениеЗаполнено(ПодчиненныеДанные.Ссылка);
				КонецЕсли; 
				
				МассивПодчиненных.Добавить(ПодчиненныеЭлементы);
			КонецЕсли; 
			
			Если Перенос Тогда
				ЭлементыРодителяРезультата = СоответствиеРодителей[ПодчиненныеДанные.Родитель];
				Если (ЭлементыРодителяРезультата = Неопределено) Тогда
					ЭлементыРодителяРезультата = Результат.Строки; 
				КонецЕсли;
				
				СтрокаРезультата = ЭлементыРодителяРезультата.Добавить(); ЗаполнитьЗначенияСвойств(СтрокаРезультата, ПодчиненныеДанные);
				
				СоответствиеРодителей[ПодчиненныеДанные] = СтрокаРезультата.Строки;
			КонецЕсли; 
					
		КонецЦикла;
	КонецЦикла;
	
	// Результат.
	Возврат __В(Результат);

КонецФункции // ПолучитьСопутствующиеНоменклатуры()

Функция ПолучитьМодифицируемуюНоменклатуру(Сеанс)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));
	
	// Выборка данных.
	Возврат __В(Новый Структура("ИмеющаяМодификаторы,ИмеющаяУсловия",
		РегистрыСведений.МодификаторыНоменклатуры.ПолучитьСписокНоменклатуры(),
		РегистрыСведений.УсловияНоменклатуры.ПолучитьСписокНоменклатуры()));
	
КонецФункции // ПолучитьМодифицируемуюНоменклатуру()

Функция ПолучитьЧерныйБелыйСписок(Сеанс, Представления)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Сеанс));
	
	// Выборка данных.
	Возврат JSON.ЗаписатьJSON_(Новый Структура("ЧерныйСписок,БелыйСписок",
		РегистрыСведений.ЧерныйСписокНоменклатуры.ПолучитьКоличествоНоменклатуры(),
		РегистрыСведений.БелыйСписокНоменклатуры.ПолучитьКоличествоНоменклатуры()), Ложь, Представления);
	
КонецФункции // ПолучитьЧерныйБелыйСписок()

Функция ПолучитьСправочник(Сеанс, Вид, Отбор, Иерархия, Поиск, Режим, Позиция)

	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(Сеанс);

	// Выборка данных.
	Если (Режим = "Полный") Или (Режим = "Позиция") Тогда
		Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                      |	Меню.Ссылка КАК Ссылка,
		                      |	Меню.Родитель,
		                      |	Меню.ЭтоГруппа КАК ЭтоГруппа,
		                      |	Меню.Номенклатура.Код КАК Код,
		                      |	Меню.Номенклатура.Артикул КАК Артикул,
		                      |	Меню.Наименование КАК Наименование,
		                      |	Меню.Номенклатура КАК Номенклатура,
		                      |	ЗНАЧЕНИЕ(Перечисление.ТипыСтрокЗаказов.Товар) КАК ВидНоменклатуры,
		                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(Меню.Номенклатура.БазоваяЕдиницаИзмерения) КАК БазоваяЕдиницаИзмерения,
		                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(Меню.Номенклатура.КатегорияНоменклатуры) КАК КатегорияНоменклатуры,
		                      |	Меню.Номенклатура.Модифицируемый КАК Модифицируемый,
		                      |	Меню.Номенклатура.МножественныйВыборМодификаторов КАК МодифицируемыйМножественно,
		                      |	Меню.Номенклатура.МаксимальноеКоличествоМодификаторов КАК МаксимальноеКоличествоМодификаторов,
		                      |	Меню.Номенклатура.ПовторениеМодификаторов КАК ПовторениеМодификаторов,
		                      |	Меню.Номенклатура.Состав КАК Состав,
		                      |	Меню.Номенклатура.Выход КАК Выход,
		                      |	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
		                      |	ВЫБОР
		                      |		КОГДА МодификаторыНоменклатуры.Номенклатура ЕСТЬ NULL 
		                      |			ТОГДА ЛОЖЬ
		                      |		ИНАЧЕ ИСТИНА
		                      |	КОНЕЦ КАК ЕстьМодификаторы,
		                      |	ВЫБОР
		                      |		КОГДА УсловияНоменклатуры.Номенклатура ЕСТЬ NULL 
		                      |			ТОГДА ЛОЖЬ
		                      |		ИНАЧЕ ИСТИНА
		                      |	КОНЕЦ КАК ЕстьУсловия,
		                      |	ВЫБОР
		                      |		КОГДА СопутствующаяНоменклатура.Номенклатура ЕСТЬ NULL 
		                      |			ТОГДА ЛОЖЬ
		                      |		ИНАЧЕ ИСТИНА
		                      |	КОНЕЦ КАК ЕстьСопутствующие,
		                      |	ВЫБОР
		                      |		КОГДА Меню.ЭтоГруппа
		                      |			ТОГДА Меню.Изображение
		                      |		ИНАЧЕ Меню.Номенклатура.Изображение
		                      |	КОНЕЦ КАК Изображение,
		                      |	ВЫБОР
		                      |		КОГДА Меню.ЭтоГруппа
		                      |			ТОГДА Меню.Миниатюра
		                      |		ИНАЧЕ Меню.Номенклатура.Миниатюра
		                      |	КОНЕЦ КАК Миниатюра,
		                      |	ВЫБОР
		                      |		КОГДА Меню.ЭтоГруппа
		                      |			ТОГДА Меню.Иконка
		                      |		ИНАЧЕ Меню.Номенклатура.Иконка
		                      |	КОНЕЦ КАК Иконка
		                      |ИЗ
		                      |	Справочник.Меню КАК Меню
		                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.__НастройкиВебСервиса КАК __НастройкиВебСервиса
		                      |		ПО Меню.Владелец = __НастройкиВебСервиса.ВебСервисВидМеню
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Дата, ТипЦены = &ТипЦены) КАК ЦеныНоменклатурыСрезПоследних
		                      |		ПО Меню.Номенклатура = ЦеныНоменклатурыСрезПоследних.Номенклатура
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		                      |			МодификаторыНоменклатуры.Номенклатура КАК Номенклатура
		                      |		ИЗ
		                      |			РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
		                      |		ГДЕ
		                      |			МодификаторыНоменклатуры.Актуальность) КАК МодификаторыНоменклатуры
		                      |		ПО Меню.Номенклатура = МодификаторыНоменклатуры.Номенклатура
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		                      |			УсловияНоменклатуры.Номенклатура КАК Номенклатура
		                      |		ИЗ
		                      |			РегистрСведений.УсловияНоменклатуры КАК УсловияНоменклатуры
		                      |		ГДЕ
		                      |			УсловияНоменклатуры.Актуальность) КАК УсловияНоменклатуры
		                      |		ПО Меню.Номенклатура = УсловияНоменклатуры.Номенклатура
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		                      |			СопутствующаяНоменклатура.Номенклатура КАК Номенклатура
		                      |		ИЗ
		                      |			РегистрСведений.СопутствующаяНоменклатура КАК СопутствующаяНоменклатура
		                      |		ГДЕ
		                      |			СопутствующаяНоменклатура.Актуальность) КАК СопутствующаяНоменклатура
		                      |		ПО Меню.Номенклатура = СопутствующаяНоменклатура.Номенклатура
		                      |ГДЕ
		                      |	&Отбор
		                      |	И &Иерархия
		                      |	И &ПериодыДействия
		                      |	И Меню.Актуальность
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	ЭтоГруппа ИЕРАРХИЯ,
		                      |	Наименование");
	Иначе						  
		Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                      |	Меню.Ссылка КАК Ссылка,
		                      |	Меню.Родитель,
		                      |	Меню.ЭтоГруппа КАК ЭтоГруппа,
		                      |	Меню.Наименование КАК Наименование,
		                      |	Меню.Номенклатура КАК Номенклатура,
		                      |	ЗНАЧЕНИЕ(Перечисление.ТипыСтрокЗаказов.Товар) КАК ВидНоменклатуры,
		                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(Меню.Номенклатура.БазоваяЕдиницаИзмерения) КАК БазоваяЕдиницаИзмерения,
		                      |	Меню.Номенклатура.Модифицируемый КАК Модифицируемый,
		                      |	Меню.Номенклатура.МножественныйВыборМодификаторов КАК МодифицируемыйМножественно,
		                      |	Меню.Номенклатура.МаксимальноеКоличествоМодификаторов КАК МаксимальноеКоличествоМодификаторов,
		                      |	Меню.Номенклатура.ПовторениеМодификаторов КАК ПовторениеМодификаторов,
		                      |	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
		                      |	ВЫБОР
		                      |		КОГДА МодификаторыНоменклатуры.Номенклатура ЕСТЬ NULL 
		                      |			ТОГДА ЛОЖЬ
		                      |		ИНАЧЕ ИСТИНА
		                      |	КОНЕЦ КАК ЕстьМодификаторы,
		                      |	ВЫБОР
		                      |		КОГДА УсловияНоменклатуры.Номенклатура ЕСТЬ NULL 
		                      |			ТОГДА ЛОЖЬ
		                      |		ИНАЧЕ ИСТИНА
		                      |	КОНЕЦ КАК ЕстьУсловия,
		                      |	ВЫБОР
		                      |		КОГДА СопутствующаяНоменклатура.Номенклатура ЕСТЬ NULL 
		                      |			ТОГДА ЛОЖЬ
		                      |		ИНАЧЕ ИСТИНА
		                      |	КОНЕЦ КАК ЕстьСопутствующие,
		                      |	ВЫБОР
		                      |		КОГДА Меню.ЭтоГруппа
		                      |			ТОГДА Меню.Иконка
		                      |		ИНАЧЕ Меню.Номенклатура.Иконка
		                      |	КОНЕЦ КАК Иконка
		                      |ИЗ
		                      |	Справочник.Меню КАК Меню
		                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.__НастройкиВебСервиса КАК __НастройкиВебСервиса
		                      |		ПО Меню.Владелец = __НастройкиВебСервиса.ВебСервисВидМеню
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Дата, ТипЦены = &ТипЦены) КАК ЦеныНоменклатурыСрезПоследних
		                      |		ПО Меню.Номенклатура = ЦеныНоменклатурыСрезПоследних.Номенклатура
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		                      |			МодификаторыНоменклатуры.Номенклатура КАК Номенклатура
		                      |		ИЗ
		                      |			РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
		                      |		ГДЕ
		                      |			МодификаторыНоменклатуры.Актуальность) КАК МодификаторыНоменклатуры
		                      |		ПО Меню.Номенклатура = МодификаторыНоменклатуры.Номенклатура
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		                      |			УсловияНоменклатуры.Номенклатура КАК Номенклатура
		                      |		ИЗ
		                      |			РегистрСведений.УсловияНоменклатуры КАК УсловияНоменклатуры
		                      |		ГДЕ
		                      |			УсловияНоменклатуры.Актуальность) КАК УсловияНоменклатуры
		                      |		ПО Меню.Номенклатура = УсловияНоменклатуры.Номенклатура
		                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		                      |			СопутствующаяНоменклатура.Номенклатура КАК Номенклатура
		                      |		ИЗ
		                      |			РегистрСведений.СопутствующаяНоменклатура КАК СопутствующаяНоменклатура
		                      |		ГДЕ
		                      |			СопутствующаяНоменклатура.Актуальность) КАК СопутствующаяНоменклатура
		                      |		ПО Меню.Номенклатура = СопутствующаяНоменклатура.Номенклатура
		                      |ГДЕ
		                      |	&Отбор
		                      |	И &Иерархия
		                      |	И &ПериодыДействия
		                      |	И Меню.Актуальность
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	ЭтоГруппа ИЕРАРХИЯ,
		                      |	Наименование");
	КонецЕсли; 
	Запрос.УстановитьПараметр("Дата", ТекущаяДата());
	Запрос.УстановитьПараметр("ТипЦены", ПараметрыСеанса.ТекущийРесторан.ТипЦен); //Костенюк Александр 27.04.2015
	РегистрыСведений.ПериодыДействия.ПериодДействияСгенерироватьУсловиеЗапроса(Запрос, "&ПериодыДействия", "Меню");
	Если (Режим = "Полный") Тогда
		РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "Меню.Изображение");
		РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "Меню.Номенклатура.Изображение");
		РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "Меню.Миниатюра");
		РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "Меню.Номенклатура.Миниатюра");
	КонецЕсли; 
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "Меню.Иконка");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "Меню.Номенклатура.Иконка");
	Если (Вид = "МодификаторыНоменклатуры") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ЗНАЧЕНИЕ(Перечисление.ТипыСтрокЗаказов.Товар)", "ЗНАЧЕНИЕ(Перечисление.ТипыСтрокЗаказов.Модификатор)");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Меню.Владелец = __НастройкиВебСервиса.ВебСервисВидМеню", "ИСТИНА");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ТипЦены = &ТипЦены", ""); //Костенюк Александр 11.06.2015
	КонецЕсли; 
	Если (Вид = "УсловияНоменклатуры") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ЗНАЧЕНИЕ(Перечисление.ТипыСтрокЗаказов.Товар)", "ЗНАЧЕНИЕ(Перечисление.ТипыСтрокЗаказов.Условие)");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Меню.Владелец = __НастройкиВебСервиса.ВебСервисВидМеню", "ИСТИНА");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ТипЦены = &ТипЦены", ""); //Костенюк Александр 11.06.2015
	КонецЕсли; 

	// Справочник.
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.Меню", "Справочник." + Вид);
	
	// Отбор.
	__ЗапросыСервер.НаложитьОтборСтруктурой(Запрос, Отбор, "&Отбор", "Меню");
						  
	// Иерархия.
	Если Иерархия Тогда
		Обход = ОбходРезультатаЗапроса.ПоГруппировкамСИерархией;
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Иерархия", "ИСТИНА");
	Иначе
		Если Поиск Тогда
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Иерархия", "ИСТИНА");
		Иначе
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Иерархия", "НЕ Меню.ЭтоГруппа");
		КонецЕсли; 
		Обход = ОбходРезультатаЗапроса.Прямой;
	КонецЕсли;
	
	// Поиск.
	Если Поиск Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ВЫБРАТЬ РАЗРЕШЕННЫЕ", "ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 50");
	КонецЕсли; 
	
	// Результат.
	Если (Позиция = Неопределено) Тогда
		
		Результат = Запрос.Выполнить().Выгрузить(Обход);
		
	Иначе
		
		// Родители.
		Родители = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
		                        |	Меню.Ссылка КАК Ссылка
		                        |ИЗ
		                        |	Справочник.Меню КАК Меню
		                        |ГДЕ
		                        |	Меню.Ссылка = &Ссылка
		                        |ИТОГИ ПО
		                        |	Ссылка ТОЛЬКО ИЕРАРХИЯ");
		Родители.УстановитьПараметр("Ссылка", Позиция);
			
		// Доп.данные.
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Меню.ЭтоГруппа КАК ЭтоГруппа", 
							  "	Меню.ЭтоГруппа КАК ЭтоГруппа,
		                      |	ВЫБОР
		                      |		КОГДА Меню.Ссылка = &Ссылка
		                      |			ТОГДА &ТипПозиция
		                      |		ИНАЧЕ ВЫБОР
		                      |				КОГДА Меню.Родитель = &Ссылка
		                      |					ТОГДА &ТипЭлемент
		                      |				ИНАЧЕ &ТипПуть
		                      |			КОНЕЦ
		                      |	КОНЕЦ КАК Тип
							  |");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "УПОРЯДОЧИТЬ ПО", 
							  " И (Меню.Ссылка В (&Путь)
		                      |			ИЛИ Меню.Ссылка = &Ссылка
		                      |			ИЛИ Меню.Родитель = &Ссылка)
		                      |
							  |УПОРЯДОЧИТЬ ПО");
		
		Запрос.УстановитьПараметр("ТипПуть", "Путь");
		Запрос.УстановитьПараметр("ТипПозиция", "Позиция");
		Запрос.УстановитьПараметр("ТипЭлемент", "Элемент");
		Запрос.УстановитьПараметр("Путь", Родители.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
		Запрос.УстановитьПараметр("Ссылка", Позиция);
			
		Соответсвие = __ПередачаДанныхСервер.ЗапросСоответсвиемНаборов(Запрос, "Тип");
		
		Результат = Соответсвие["Позиция"];
		Если (Соответсвие["Позиция"] = Неопределено) Тогда
			Результат = Новый Структура("Путь,Элементы", Соответсвие["Путь"], Соответсвие["Элемент"]);
		Иначе
			Результат = Результат[0]; Результат.Вставить("Путь", Соответсвие["Путь"]); Результат.Вставить("Элементы", Соответсвие["Элемент"]); 
		КонецЕсли;
		Если (Результат.Путь = Неопределено) Тогда
			Результат.Путь = Новый Массив;
		КонецЕсли;
		Если (Результат.Элементы = Неопределено) Тогда
			Результат.Элементы = Новый Массив;
		КонецЕсли;
	
	КонецЕсли;
	
	// Результат.
	Возврат __В(Результат);

КонецФункции // ПолучитьСправочник()

Функция ПолучитьМодификаторыУсловия(Сеанс, Вид, Номенклатура)

	// Восстановление сеанса.
	__ВебСервисСервер.ПродлениеСеанса(__Из(Сеанс));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	МодификаторыНоменклатуры.Модификатор КАК Ссылка
	                      |ИЗ
	                      |	РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
	                      |ГДЕ
	                      |	МодификаторыНоменклатуры.Актуальность
	                      |	И МодификаторыНоменклатуры.Модификатор.Актуальность
	                      |	И МодификаторыНоменклатуры.Номенклатура = &Номенклатура");
	Запрос.УстановитьПараметр("Номенклатура", __Из(Номенклатура));						  

	// Регистр.
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрСведений.МодификаторыНоменклатуры", "РегистрСведений." + Вид);
	Если (Вид = "УсловияНоменклатуры") Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "Модификатор", "Условия");
	КонецЕсли; 
	
	// Выборка данных.
	Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	// Результат.
	Возврат __В(Результат);

КонецФункции // ПолучитьМодификаторыУсловия()

Функция FindMenuItems(Session, Name)
	
	// Поиск.
	Поиск = СтрЗаменить(СокрЛП(Name), " ", "%");
	
	// Проверка.
	Если ПустаяСтрока(Поиск) Тогда
		Возврат __В(Новый Массив);
	Иначе
		Поиск = "%" + Поиск + "%";
	КонецЕсли; 
	
	Соответствие = Новый Соответствие;
	Соответствие["СОДЕРЖИТ Наименование"] = Поиск;
	Соответствие["СОДЕРЖИТ Номенклатура.Артикул"] = Поиск;
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Session), "Меню", Новый Структура("ИЛИ, ЭтоГруппа", Соответствие, Ложь), Ложь, Истина, "Полный", Неопределено);
	
КонецФункции

Функция GetMenu(Session, Selection, Hierarchy)
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Session), "Меню", __Из(Selection, Истина, Новый Структура), Hierarchy, Ложь, "Краткий", Неопределено);
	
КонецФункции

Функция GetModifiers(Session, Selection, Hierarchy)
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Session), "МодификаторыНоменклатуры", __Из(Selection, Истина, Новый Структура), Hierarchy, Ложь, "Краткий", Неопределено);

КонецФункции

Функция GetModifiersNomenclature(Session, Nomenclature)
	
	// Результат.
	Возврат ПолучитьМодификаторыУсловия(Session, "МодификаторыНоменклатуры", Nomenclature);
	
КонецФункции

Функция GetModifiableNomenclature(Session)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));
	
	// Выборка данных.
	Возврат __В(Новый Структура("ИмеющаяМодификаторы, ИмеющаяУсловия", РегистрыСведений.МодификаторыНоменклатуры.ПолучитьСписокНоменклатуры(), РегистрыСведений.УсловияНоменклатуры.ПолучитьСписокНоменклатуры()));

КонецФункции

Функция GetNomenclature(Session, Selection)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	СправочникНоменклатура.Ссылка КАК Ссылка,
	                      |	СправочникНоменклатура.Код КАК Код,
	                      |	СправочникНоменклатура.Артикул КАК Артикул,
	                      |	СправочникНоменклатура.Наименование КАК Наименование,
	                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СправочникНоменклатура.БазоваяЕдиницаИзмерения) КАК БазоваяЕдиницаИзмерения,
	                      |	ПРЕДСТАВЛЕНИЕССЫЛКИ(СправочникНоменклатура.КатегорияНоменклатуры) КАК КатегорияНоменклатуры,
	                      |	СправочникНоменклатура.Модифицируемый,
	                      |	СправочникНоменклатура.МножественныйВыборМодификаторов КАК МодифицируемыйМножественно,
	                      |	СправочникНоменклатура.МаксимальноеКоличествоМодификаторов,
	                      |	СправочникНоменклатура.ПовторениеМодификаторов,
	                      |	ВЫРАЗИТЬ(СправочникНоменклатура.Состав КАК СТРОКА(1000)) КАК Состав,
	                      |	СправочникНоменклатура.Выход,
	                      |	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
	                      |	ВЫБОР
	                      |		КОГДА МодификаторыНоменклатуры.Номенклатура ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК ЕстьМодификаторы,
	                      |	ВЫБОР
	                      |		КОГДА УсловияНоменклатуры.Номенклатура ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК ЕстьУсловия,
	                      |	ВЫБОР
	                      |		КОГДА СопутствующаяНоменклатура.Номенклатура ЕСТЬ NULL 
	                      |			ТОГДА ЛОЖЬ
	                      |		ИНАЧЕ ИСТИНА
	                      |	КОНЕЦ КАК ЕстьСопутствующие,
	                      |	СправочникНоменклатура.Изображение КАК Изображение,
	                      |	СправочникНоменклатура.Миниатюра КАК Миниатюра,
	                      |	СправочникНоменклатура.Иконка КАК Иконка
	                      |ИЗ
	                      |	Справочник.Номенклатура КАК СправочникНоменклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Дата, ТипЦены = &ТипЦены) КАК ЦеныНоменклатурыСрезПоследних
	                      |		ПО СправочникНоменклатура.Ссылка = ЦеныНоменклатурыСрезПоследних.Номенклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |			МодификаторыНоменклатуры.Номенклатура КАК Номенклатура
	                      |		ИЗ
	                      |			РегистрСведений.МодификаторыНоменклатуры КАК МодификаторыНоменклатуры
	                      |		ГДЕ
	                      |			МодификаторыНоменклатуры.Актуальность) КАК МодификаторыНоменклатуры
	                      |		ПО СправочникНоменклатура.Ссылка = МодификаторыНоменклатуры.Номенклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |			УсловияНоменклатуры.Номенклатура КАК Номенклатура
	                      |		ИЗ
	                      |			РегистрСведений.УсловияНоменклатуры КАК УсловияНоменклатуры
	                      |		ГДЕ
	                      |			УсловияНоменклатуры.Актуальность) КАК УсловияНоменклатуры
	                      |		ПО СправочникНоменклатура.Ссылка = УсловияНоменклатуры.Номенклатура
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |			СопутствующаяНоменклатура.Номенклатура КАК Номенклатура
	                      |		ИЗ
	                      |			РегистрСведений.СопутствующаяНоменклатура КАК СопутствующаяНоменклатура
	                      |		ГДЕ
	                      |			СопутствующаяНоменклатура.Актуальность) КАК СопутствующаяНоменклатура
	                      |		ПО СправочникНоменклатура.Ссылка = СопутствующаяНоменклатура.Номенклатура
	                      |ГДЕ
	                      |	&Отбор");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "СправочникНоменклатура.Изображение");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "СправочникНоменклатура.Миниатюра");
	РегистрыСведений.__НастройкиВебСервиса.РесурсПублицкацииИзображениеСгенерироватьПолеURLЗапроса(Запрос, "СправочникНоменклатура.Иконка");
	Запрос.УстановитьПараметр("Дата", ТекущаяДата());
	Запрос.УстановитьПараметр("ТипЦены", ПараметрыСеанса.ТекущийРесторан.ТипЦен); //Костенюк Александр 27.04.2015
	
	// Отбор.
	__ЗапросыСервер.НаложитьОтборСтруктурой(Запрос, __Из(Selection, Истина, Новый Структура), "&Отбор", "СправочникНоменклатура");
	
	// Результат.
	Возврат __В(Запрос);

КонецФункции

Функция GetMenuItem(Session, Item)
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Session), "Меню", Новый Структура, Истина, Ложь, "Полный", __Из(Item, Истина, Справочники.Меню.ПустаяСсылка()));

КонецФункции

Функция GetPriceList(Session, Selection, Hierarchy)
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Session), "Меню", __Из(Selection, Истина, Новый Структура), Hierarchy, Ложь, "Краткий", Неопределено);
	
КонецФункции

Функция GetRelatedNomenclature(Session, Nomenclature)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));

	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	Меню.Ссылка КАК Ссылка
	                      |ИЗ
	                      |	Справочник.Меню КАК Меню
	                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.__НастройкиВебСервиса КАК __НастройкиВебСервиса
	                      |		ПО Меню.Владелец = __НастройкиВебСервиса.ВебСервисВидМеню
	                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СопутствующаяНоменклатура КАК СопутствующаяНоменклатура
	                      |		ПО (СопутствующаяНоменклатура.Номенклатура = &Номенклатура)
	                      |			И Меню.Номенклатура = СопутствующаяНоменклатура.Сопутствующая
	                      |ГДЕ
	                      |	&ПериодыДействия
	                      |	И Меню.Актуальность
	                      |ИТОГИ ПО
	                      |	Ссылка ТОЛЬКО ИЕРАРХИЯ");	
	РегистрыСведений.ПериодыДействия.ПериодДействияСгенерироватьУсловиеЗапроса(Запрос, "&ПериодыДействия", "Меню");
	Запрос.УстановитьПараметр("Номенклатура", __Из(Nomenclature));						  
	
	// Выборка данных.
	ПромежуточныйРезультат = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	// Результат.
	Результат = Новый ДеревоЗначений; Для Каждого Колонка Из ПромежуточныйРезультат.Колонки Цикл Результат.Колонки.Добавить(Колонка.Имя, Колонка.ТипЗначения); КонецЦикла; 
	
	// Перенос данных.
	СоответствиеРодителей = Новый Соответствие; МассивПодчиненных = Новый Массив; МассивПодчиненных.Добавить(ПромежуточныйРезультат.Строки);

	Для Каждого РодительЭлементы Из МассивПодчиненных Цикл
		Для Каждого ПодчиненныеДанные Из РодительЭлементы Цикл
			ПодчиненныеЭлементы = ПодчиненныеДанные.Строки; Перенос = Ложь;
			
			Если Не ПодчиненныеЭлементы.Количество() Тогда
				Перенос = Истина;
			Иначе
				Если ПодчиненныеЭлементы.Количество() - 1 Тогда
					Перенос = ЗначениеЗаполнено(ПодчиненныеДанные.Ссылка);
				КонецЕсли; 
				
				МассивПодчиненных.Добавить(ПодчиненныеЭлементы);
			КонецЕсли; 
			
			Если Перенос Тогда
				ЭлементыРодителяРезультата = СоответствиеРодителей[ПодчиненныеДанные.Родитель];
				Если (ЭлементыРодителяРезультата = Неопределено) Тогда
					ЭлементыРодителяРезультата = Результат.Строки; 
				КонецЕсли;
				
				СтрокаРезультата = ЭлементыРодителяРезультата.Добавить(); ЗаполнитьЗначенияСвойств(СтрокаРезультата, ПодчиненныеДанные);
				
				СоответствиеРодителей[ПодчиненныеДанные] = СтрокаРезультата.Строки;
			КонецЕсли; 
					
		КонецЦикла;
	КонецЦикла;
	
	// Результат.
	Возврат __В(Результат);

КонецФункции

Функция GetConditions(Session, Selection, Hierarchy)
	
	// Результат.
	Возврат ПолучитьСправочник(__Из(Session), "УсловияНоменклатуры", __Из(Selection, Истина, Новый Структура), Hierarchy, Ложь, "Краткий", Неопределено);

КонецФункции

Функция GetNomenclatureConditions(Session, Nomenclature)
	
	// Результат.
	Возврат ПолучитьМодификаторыУсловия(Session, "УсловияНоменклатуры", Nomenclature);
	
КонецФункции

Функция GetBlackWhiteList(Session, Representations)
	
	// Восстановление сеанса.
	__ВебСервисСервер.ВосстановлениеСеанса(__Из(Session));
	
	// Выборка данных.
	Возврат JSON.ЗаписатьJSON_(Новый Структура("ЧерныйСписок,БелыйСписок",
		РегистрыСведений.ЧерныйСписокНоменклатуры.ПолучитьКоличествоНоменклатуры(),
		РегистрыСведений.БелыйСписокНоменклатуры.ПолучитьКоличествоНоменклатуры()), Ложь, Representations);

КонецФункции
