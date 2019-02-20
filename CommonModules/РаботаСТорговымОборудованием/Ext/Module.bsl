﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С ТОРГОВЫМ ОБОРУДОВАНИЕМ

// Функция проверяет корректность порядка назначения PLU для товаров,
// выгружаемых в ККМ в режиме Offline.
//
// Параметры
//  ПорядокНазначения - <ПеречислениеСсылка.ПорядокПрисвоенияPLU>
//                    - Проверяемое значение.
//
// Возвращаемое значение:
//   <Булево>         – Результат проверки.
//
Функция КорректныйПорядокНазначенияPLU(ПорядокНазначения) Экспорт


	Возврат ИСТИНА;

КонецФункции // КорректныйПорядокНазначенияPLU()

// Функция возвращает значение PLU для новой записи регистра сведений
// "ТоварыНаККМ" в соответствии с текущим порядком назначения PLU.
//
// Параметры
//  КассаККМ       - <СправочникСсылка.КассыККМ>
//                 - Касса, с которой будет связана запись.
//
//  Номенклатура   - <СправочникСсылка.Номенклатура>
//                 - Номенклатура, для которой необходимо задать новый PLU.
//
// Возвращаемое значение:
//  <Число>        – Значение PLU.
//
Функция ПолучитьНовыйPLU(КассаККМ, Номенклатура) Экспорт

	Код     = 0;
		Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|    ВЫБОР
		|        КОГДА ПзКоды.Код ЕСТЬ NULL ТОГДА
		|            1
		|        ИНАЧЕ
		|            ПзКоды.Код + 1
		|    КОНЕЦ КАК Код
		|ИЗ
		|    (
		|    ВЫБРАТЬ
		|        МАКСИМУМ(РегТовары.Код) КАК Код
		|    ИЗ
		|        РегистрСведений.ТоварыНаККМ КАК РегТовары
		|    ГДЕ
		|        РегТовары.КассаККМ = &КассаККМ) КАК ПзКоды");
		Запрос.УстановитьПараметр("КассаККМ", КассаККМ);
		Код = Запрос.Выполнить().Выгрузить()[0].Код;

	Возврат Код;

КонецФункции // ПолучитьНовыйPLU()

///////////////////////////////////////////////////////////////////////////////
//// ФУНКЦИИ РАБОТЫ С ОБРАБОТКАМИ ОБСЛУЖИВАНИЯ

// Функция возвращает обработку обслуживания торгового оборудования.
//
// Параметры:
//  Модель                             - <СправочникСсылка.ТорговоеОборудование>
//                                     - Модель торгового оборудования, для
//                                       которой необходимо получить обработку
//                                       обслуживания.
//
//  Обработка                          - <ВнешняяОбработкаОбъект.*>
//                                     - Выходной параметр; обработка обслуживания,
//                                       соответствующая указанной модели торгового
//                                       оборудования.
//
// Возвращаемое значение:
//  <ПеречислениеСсылка.ТООшибкиОбщие> - Результат выполнения операции.
//                                       В случае успешного завершения возвращается
//                                       пустая ссылка перечисления ТООшибкиОбщие.
//
Функция ПолучитьОбработкуОбслуживанияТО(Модель, Обработка) Экспорт

	Обработка = Неопределено;
	
	Попытка
		ИмяФайла = ХранилищеДополнительнойИнформации.ПолучитьИмяФайла(ХранилищеДополнительнойИнформации.ПолучитьИмяКаталога(глТекущийПользователь), Модель.ОбработкаОбслуживания.ИмяФайла);
		Данные   = Модель.ОбработкаОбслуживания.Обработка;
		
		Данные.Получить().Записать(ИмяФайла);
		
		Обработка = ВнешниеОбработки.Создать(ИмяФайла);
	Исключение
		
		// может внутреняя
		Попытка
			Обработка =  Обработки[Модель.ОбработкаОбслуживания.Описание].Создать();
		Исключение
			Результат = Перечисления.ТООшибкиОбщие.ОшибкаЗагрузкиОбработкиОбслуживания;
			Возврат Результат;
		КонецПопытки;
		
	КонецПопытки;
	
	Возврат Перечисления.ТООшибкиОбщие.ПустаяСсылка();
	
КонецФункции // ПолучитьОбработкуОбслуживанияТО()

///////////////////////////////////////////////////////////////////////////////
//// ФУНКЦИИ, ОБЛЕГЧАЮЩИЕ РАБОТУ С РЕГИСТРОМ СВЕДЕНИЙ "ТОВАРЫ НА ККМ"

// Функция осуществляет получение информации о товаре по заданному номеру PLU.
//
// Параметры:
//  КассаККМ       - <СправочникСсылка.КассыККМ>
//                 - КассаККМ, для которой определён данный PLU.
//
//  ПЛУ            - <Число>
//                 - PLU товара, информацию о котором необходимо получить.
//
// Возвращаемое значение:
//  <Структура>,
//  <Неопределено> - В случае, если товар не найден, возвращается значение
//                   Неопределено. Иначе - структура со следующими полями:
//                     Номенклатура               - <СправочникСсылка.Номенклатура>
//                                                - Номенклатура, которая соответствует
//                                                  переданному значению PLU.
//                     ЕдиницаИзмерения           - <СправочникСсылка.ЕдиницыИзмерения>
//                                                - Единица измерения номенклатуры.
//                     ХарактеристикаНоменклатуры - <СправочникСсылка.ХарактеристикиНоменклатуры>
//                                                - Характеристика номенклатуры.
//                     СерияНоменклатуры          - <СправочникСсылка.СерииНоменклатуры>
//                                                - Серия номенклатуры.
//                     Качество                   - <СправочникСсылка.Качество>
//                                                - Качество.
//
Функция ПолучитьОписаниеТовараККМ(КассаККМ, ПЛУ) Экспорт

	Результат = Неопределено;

	Запрос = Новый Запрос(
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|    РегТовары.Номенклатура                КАК Номенклатура,
	|    РегТовары.ЕдиницаИзмерения            КАК ЕдиницаИзмерения,
	|    РегТовары.ХарактеристикаНоменклатуры  КАК ХарактеристикаНоменклатуры,
	|    РегТовары.СерияНоменклатуры           КАК СерияНоменклатуры
	|ИЗ
	|    РегистрСведений.ТоварыНаККМ КАК РегТовары
	|ГДЕ
	|    РегТовары.КассаККМ = &КассаККМ
	|    И РегТовары.Код    = &ПЛУ");
	Запрос.УстановитьПараметр("КассаККМ", КассаККМ);
	Запрос.УстановитьПараметр("ПЛУ",      ПЛУ);
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
		Результат = Новый Структура("Качество, Номенклатура, ЕдиницаИзмерения, ХарактеристикаНоменклатуры, СерияНоменклатуры",
		                      Справочники.Качество.Новый);
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;

	Возврат Результат;

КонецФункции // ПолучитьОписаниеТовараККМ()

////////////////////////////////////////////////////////////////////////////////
// ФУНКЦИИ РАБОТЫ СО ШТРИХКОДАМИ

// Функция осуществляет ввод штрихкода пользователем.
//
// Возвращаемое значение:
//  Строка - введенный щтрихкод. Если пользователь отказался от ввода - возвращается пустая строка.
//
Функция ВвестиШтрихкод() Экспорт

	Результат = "";

	ВвестиСтроку(Результат, "Введите штрихкод");

	Возврат Результат;

КонецФункции // ВвестиШтрихкод()

// Функция возвращает результат проверки строки на предмет соответствия
// штрихкоду формата EAN8.
//
// Параметры:
//  Штрихкод - <Строка>
//           - Проверяемый штрихкод.
//
// Возвращаемое значение:
//  <Булево> - Результат проверки.
//
Функция ТипШтрихкодаEAN8ТО(Штрихкод) Экспорт

	Результат   = Ложь;
	Сумма       = 0;
	Коэффициент = 3;

	Если СтрДлина(Штрихкод) = 8 Тогда
		Индекс = Неопределено;
		Для Индекс = 1 По 7 Цикл
			КодСимв = КодСимвола(Штрихкод, Индекс);
			Если КодСимв < 48 Или КодСимв > 57 Тогда
				Возврат Результат;
			КонецЕсли;
			Сумма       = Сумма + Коэффициент * (КодСимв - 48);
			Коэффициент = 4 - Коэффициент;
		КонецЦикла;
		Сумма     = (10 - Сумма % 10) % 10;
		Результат = (КодСимвола(Штрихкод, 8) = Сумма + 48);
	КонецЕсли;

	Возврат Результат;

КонецФункции // ТипШтрихкодаEAN8ТО()

// Функция возвращает результат проверки строки на предмет соответствия
// штрихкоду формата EAN13.
//
// Параметры:
//  Штрихкод - <Строка>
//           - Проверяемый штрихкод.
//
// Возвращаемое значение:
//  <Булево> - Результат проверки.
//
Функция ТипШтрихкодаEAN13ТО(Штрихкод) Экспорт

	Результат = (СтрДлина(Штрихкод) = 13
	             И КонтрольныйСимволEAN(Штрихкод, 13) = Прав(Штрихкод, 1));

	Возврат Результат;

КонецФункции // ТипШтрихкодаEAN13ТО()

// Функция возвращает результат проверки строки на предмет соответствия
// штрихкоду формата ITF14.
//
// Параметры:
//  Штрихкод - <Строка>
//           - Проверяемый штрихкод.
//
// Возвращаемое значение:
//  <Булево> - Результат проверки.
//
Функция ТипШтрихкодаITF14ТО(Штрихкод) Экспорт

	Результат   = Ложь;
	Сумма       = 0;
	Коэффициент = 1;

	Если СтрДлина(Штрихкод) = 14 Тогда
		Индекс = Неопределено;
		Для Индекс = 1 По 13 Цикл
			КодСимв = КодСимвола(Штрихкод, Индекс);
			Если КодСимв < 48 Или КодСимв > 57 Тогда
				Возврат Результат;
			КонецЕсли;
			Сумма       = Сумма + Коэффициент * (КодСимв - 48);
			Коэффициент = 4 - Коэффициент;
		КонецЦикла;
		Сумма     = (10 - Сумма % 10) % 10;
		Результат = (КодСимвола(Штрихкод, 14) = Сумма + 48);
	КонецЕсли;

	Возврат Результат;

КонецФункции // ТипШтрихкодаITF14ТО()

// Функция возвращает результат проверки строки на предмет соответствия
// штрихкоду формата CODE39.
//
// Параметры:
//  Штрихкод - <Строка>
//           - Проверяемый штрихкод.
//
// Возвращаемое значение:
//  <Булево> - Результат проверки.
//
Функция ТипШтрихкодаCODE39ТО(Штрихкод) Экспорт

	Результат = Ложь;
	Длина     = СтрДлина(Штрихкод);
	Индекс    = Неопределено;

	Если Длина > 0 Тогда
		Результат = Истина;
		Для Индекс = 1 По Длина Цикл
			КодСимв = КодСимвола(Штрихкод, Индекс);
			Если (КодСимв <> 32)
			     И (КодСимв < 36 Или КодСимв > 37)
			     И (КодСимв <> 43)
			     И (КодСимв < 45 Или КодСимв > 57)
			     И (КодСимв < 65 Или КодСимв > 90) Тогда

				Результат = Ложь;
				Прервать;

			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	Возврат Результат;

КонецФункции // ТипШтрихкодаCODE39ТО()

// Функция вычисляет контрольный символ кода EAN
//
// Параметры:
//  ШтрихКод     - штрих-код (без контрольной цифры)
//  Тип          - тип штрих-кода: 13 - EAN13, 8 - EAN8
//
// Возвращаемое значение:
//  Контрольный символ штрих-кода
//
Функция КонтрольныйСимволEAN(ШтрихКод, Тип) Экспорт

	Четн   = 0;
	Нечетн = 0;

	КоличествоИтераций = ?(Тип = 13, 6, 4);

	Для Индекс = 1 По КоличествоИтераций Цикл
		Если (Тип = 8) и (Индекс = КоличествоИтераций) Тогда
		Иначе
			Четн   = Четн   + Сред(ШтрихКод, 2 * Индекс, 1);
		КонецЕсли;
		Нечетн = Нечетн + Сред(ШтрихКод, 2 * Индекс - 1, 1);
	КонецЦикла;

	Если Тип = 13 Тогда
		Четн = Четн * 3;
	Иначе
		Нечетн = Нечетн * 3;
	КонецЕсли;

	КонтЦифра = 10 - (Четн + Нечетн) % 10;

	Возврат ?(КонтЦифра = 10, "0", Строка(КонтЦифра));

КонецФункции // КонтрольныйСимволEAN()

// Функция осуществляет формирование нового произвольного штрихкода.
// штучного товара
//
// Параметры
//  Код  – <Число> 
//       – Измерение "Код" регистра сведений Штрихкоды
//
// Возвращаемое значение:
//  <Строка>
//       – сформированный штрихкод
//
Функция СформироватьПроизвольныйШтрихКодEAN(Префикс = Неопределено, ТипШтрихкода = Неопределено, Регистр = "ШтрихКоды", МассивШтрихКодовНеВРегистре = Неопределено) Экспорт

	ПрефиксШтрихкода = Строка(Префикс) + "________________________________________________________________________________________________________________________________";
	//                                    |.........:.........:.........:.........:.........|.........:.........:.........:.........:.........|.........:.........:.......

	Если (ТипШтрихкода = Неопределено) Тогда
		ТипШтрихкода = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN13;
	КонецЕсли;
	Если (ТипШтрихкода = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN8) Тогда
	    ДлинаШтрихКодаБезКонтрольногоСимвола = 7; ДлинаШтрихКодаДляЗапроса = 8;
	ИначеЕсли (ТипШтрихкода = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN13) Тогда
	    ДлинаШтрихКодаБезКонтрольногоСимвола = 12; ДлинаШтрихКодаДляЗапроса = 13;
	ИначеЕсли (ТипШтрихкода = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN128) Тогда
	    ДлинаШтрихКодаБезКонтрольногоСимвола = 128; ДлинаШтрихКодаДляЗапроса = 128;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	ПрефиксШтрихкода = Лев(ПрефиксШтрихкода, ДлинаШтрихКодаДляЗапроса);
	
	ТаблицаШтрихКодовНеВРегистре = Новый ТаблицаЗначений;
	ТаблицаШтрихКодовНеВРегистре.Колонки.Добавить("Штрихкод", Новый ОписаниеТипов("Строка"));
	Если (Не МассивШтрихКодовНеВРегистре = Неопределено) Тогда
		Для Каждого ШтрихКодовНеВРегистре Из МассивШтрихКодовНеВРегистре Цикл
			ТаблицаШтрихКодовНеВРегистре.Добавить().Штрихкод = ШтрихКодовНеВРегистре;
		КонецЦикла;
	КонецЕсли;
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	РегШтрихКоды.Штрихкод КАК Штрихкод
	                      |ПОМЕСТИТЬ ВременнаяТаблицаШтрихКодовНеВРегистре
	                      |ИЗ
	                      |	&ТаблицаШтрихКодовНеВРегистре КАК РегШтрихКоды
	                      |;
	                      |
	                      |////////////////////////////////////////////////////////////////////////////////
	                      |ВЫБРАТЬ
	                      |	МАКСИМУМ(ВложенныйЗапрос.Код) КАК Код
	                      |ИЗ
	                      |	(ВЫБРАТЬ
	                      |		МАКСИМУМ(ПОДСТРОКА(РегШтрихКоды.Штрихкод, 1, " + ДлинаШтрихКодаБезКонтрольногоСимвола + ")) КАК Код
	                      |	ИЗ
	                      |		РегистрСведений.Штрихкоды КАК РегШтрихКоды
	                      |	ГДЕ
	                      |		РегШтрихКоды.ТипШтрихкода = &ТипШтрихкода
	                      |		И РегШтрихКоды.Штрихкод ПОДОБНО """ + ПрефиксШтрихкода + """
	                      |	
	                      |	ОБЪЕДИНИТЬ ВСЕ
	                      |	
	                      |	ВЫБРАТЬ
	                      |		МАКСИМУМ(ПОДСТРОКА(ТаблицаШтрихКодовНеВРегистре.Штрихкод, 1, " + ДлинаШтрихКодаБезКонтрольногоСимвола + ")) КАК Код
	                      |	ИЗ
	                      |		ВременнаяТаблицаШтрихКодовНеВРегистре КАК ТаблицаШтрихКодовНеВРегистре
	                      |	ГДЕ
	                      |		ТаблицаШтрихКодовНеВРегистре.Штрихкод ПОДОБНО """ + ПрефиксШтрихкода + """) КАК ВложенныйЗапрос
						  //|");
						  //Костенюк Александр-Старт 23.10.2012
						  |;
						  |
						  |////////////////////////////////////////////////////////////////////////////////
						  |УНИЧТОЖИТЬ ВременнаяТаблицаШтрихКодовНеВРегистре");
						  //Костенюк Александр-Финиш 23.10.2012
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрСведений.Штрихкоды", "РегистрСведений." + Регистр);
	Запрос.УстановитьПараметр("ТаблицаШтрихКодовНеВРегистре", ТаблицаШтрихКодовНеВРегистре);
	Запрос.УстановитьПараметр("ТипШтрихкода", ТипШтрихкода);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() И (Не Выборка.Код = Null) Тогда
		ТекКод = Число(Выборка.Код);
	Иначе
		ТекКод = Число(СтрЗаменить(Лев(ПрефиксШтрихкода, ДлинаШтрихКодаБезКонтрольногоСимвола), "_", "0"));
	КонецЕсли;
	ТекКод = Мин(ТекКод + 1, Pow(10, ДлинаШтрихКодаБезКонтрольногоСимвола) - 1);

	Штрихкод = Формат(ТекКод, "ЧЦ=" + ДлинаШтрихКодаБезКонтрольногоСимвола + "; ЧВН=; ЧГ=");
	Если (ТипШтрихкода = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN8) Тогда
		Штрихкод = Штрихкод + КонтрольныйСимволEAN(ШтрихКод, 8);
	ИначеЕсли (ТипШтрихкода = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN13) Тогда
		Штрихкод = Штрихкод + КонтрольныйСимволEAN(ШтрихКод, 13);
	КонецЕсли;

	Возврат Штрихкод;

КонецФункции // СформироватьПроизвольныйШтрихКодEAN()

///////////////////////////////////////////////////////////////////////////////
//// ФУНКЦИИ, ОБЛЕГЧАЮЩИЕ ПОДБОР НОМЕНКЛАТУРЫ ПРИ ИСПОЛЬЗОВАНИИ СКАНЕРА

// Функция возвращает структуру, которая может в дальнейшем использоваться в
// обработке подбора.
//
// Параметры:
//  Номенклатура   - <СправочникСсылка.Номенклатура>, <Неопределено>
//                 - Номенклатура, подбор которой осуществляется. В случае,
//                   если задан параметр "СерийныйНомер", значение данного
//                   параметра игнорируется.
//
//  Характеристика - <СправочникСсылка.ХарактеристикиНоменклатуры>, <Неопределено>
//                 - Характеристика подбираемой номенклатуры.  В случае,
//                   если задан параметр "СерийныйНомер", значение данного
//                   параметра игнорируется.
//
//  Серия          - <СправочникСсылка.СерииНоменклатуры>, <Неопределено>
//                 - Серия подбираемой номенклатуры.  В случае,
//                   если задан параметр "СерийныйНомер", значение данного
//                   параметра игнорируется.
//
//  Качество       - <СправочникСсылка.Качество>, <Неопределено>
//                 - Качество подбираемой номенклатуры.  В случае,
//                   если задан параметр "СерийныйНомер", значение данного
//                   параметра игнорируется.
//
//  Единица        - <СправочникСсылка.ЕдиницыИзмерения>, <Неопределено>
//                 - Единица измерения подбираемой номенклатуры.  В случае,
//                   если задан параметр "СерийныйНомер", значение данного
//                   параметра игнорируется.
//
//  Количество     - <Число>
//                 - Количество подбираемой номенклатуры.
//
//  Валюта         - <СправочникСсылка.Валюты>
//                 - Используемая валюта.
//
//  СерийныйНомер  - <СправочникСсылка.СерийныеНомера>, <Неопределено>
//                 - Серийный номер. В случае, если данный параметр не задан,
//                   осуществляется обычный подбор номенклатуры. В противном
//                   случае - подбор по серийному номеру.
//
//  СкладыВТЧ      - <Булево>
//                 - Признак необходимости указания складов в табличной части документа.
//
//  ТипЦен         - <СправочникСсылка.ТипыЦенНоменклатуры>, <СправочникСсылка.ТипыЦенНоменклатурыКонтрагентов>
//                 - Тип цен номенклатуры.
//
//  Контрагент     - <СправочникСсылка.Контрагенты>
//                 - Необязательный параметр; контрагент, для которого осуществляется
//                   получение цены номенклатуры.
//
//  Договор        - <СправочникСсылка.ДоговорыКонтрагентов>
//                 - Необязательный параметр; договор контрагентов.
//
// Возвращаемое значение:
//  <Структура>    - Структура, которая может в дальнейшем использоваться в
//                   обработке подбора.
//
Функция СформироватьСтруктуруПодбора(Знач ДатаЦен, Знач Номенклатура, Знач Характеристика, Знач Серия,
                                     Знач Качество, Знач Единица, Знач Количество, Знач Валюта,
                                     Знач СерийныйНомер, Знач СкладыВТЧ, Знач ТипЦен,
                                     Знач Контрагент = Неопределено,
                                     Знач Договор = Неопределено) Экспорт

	Результат = Новый Структура();

	Если ЗначениеЗаполнено(СерийныйНомер) Тогда
		Номенклатура   = СерийныйНомер.Владелец;
		Единица        = Номенклатура.ЕдиницаХраненияОстатков;
		Характеристика = Справочники.ХарактеристикиНоменклатуры.ПустаяСсылка();
		Серия          = Справочники.СерииНоменклатуры.ПустаяСсылка();
		Качество       = Справочники.Качество.Новый;
		Количество     = 1;
		Результат.Вставить("СерийныйНомер", СерийныйНомер);
	КонецЕсли;

	Цена = 0;
	//Если ТипЦен <> Неопределено Тогда
	//	Если Контрагент = Неопределено Тогда
	//		Цена = Ценообразование.ПолучитьЦенуНоменклатуры(Номенклатура, Характеристика, ТипЦен, ДатаЦен, Единица, Валюта);
	//	Иначе
	//		Цена = Ценообразование.ПолучитьЦенуКонтрагента(Номенклатура, Характеристика, Контрагент, ТипЦен, ДатаЦен, Единица, Валюта, , , Договор);
	//	КонецЕсли;
	//КонецЕсли;

	Результат.Вставить("СпособЗаполненияЦен",      Перечисления.СпособыЗаполненияЦен.ПоЦенамНоменклатуры);
	Результат.Вставить("ВалютаЦены",               Валюта);
	Результат.Вставить("Номенклатура",             Номенклатура);
	Результат.Вставить("ЕдиницаИзмерения",         Единица);
	Результат.Вставить("Количество",               Количество);
	Результат.Вставить("Цена",                     Цена);
	Результат.Вставить("Характеристика",           Характеристика);
	Результат.Вставить("Серия",                    Серия);
	Результат.Вставить("Качество",                 Качество);
	Результат.Вставить("ЕстьСкладВТабличнойЧасти", СкладыВТЧ);
	Результат.Вставить("Команда",                  "ПодборВТабличнуюЧасть");

	Возврат Результат;

КонецФункции // СформироватьСтруктуруПодбора()

// Функция формирует список значений по переданному массиву устройств.
//
// Параметры:
//  МассивУстройств - Массив устройств ТО.
//
// Возвращаемое значение:
//  СписокЗначений - сформированный список значений.
//
Функция ПолучитьСписокУстройствТОДляВыбора(МассивУстройств) Экспорт

	Перем ВидУстройства;
	Перем ПредставлениеУстройства;

	СписокУстройств = Новый СписокЗначений;

	Для Каждого Устройство Из МассивУстройств Цикл
		ПолучитьСерверТО().ПолучитьПредставлениеУстройства(Устройство, ВидУстройства, ПредставлениеУстройства);
		СписокУстройств.Добавить(Устройство, ПредставлениеУстройства);
	КонецЦикла;

	Возврат СписокУстройств;

КонецФункции // ПолучитьСписокУстройствДляВыбора()

// Функция определяет и проверяет фискальный регистратор.
//
// Параметры:
//  ФР - В эту переменную будет возвращен выбранный фискальный регистратор.
//
// Возвращаемое значение:
//  Булево - Истина, если фискальный регистратор выбран.
//
Функция ПолучитьПроверитьПараметрыДляПробитияЧека(ФР) Экспорт

	ФР = ПолучитьЭлементТО(Перечисления.ВидыТорговогоОборудования.ФискальныйРегистратор,
	   "Необходимо выбрать фискальный регистратор", "Фискальный регистратор не подключен!");

	Возврат ЗначениеЗаполнено(ФР);

КонецФункции // ПолучитьПроверитьПараметрыДляПробитияЧека()

// Функция возвращает подключенный элемент ТО, вид которого передан параметром.
//
// Параметры:
//  ВидТО - вид торгового оборудования, подключенный элемент которого требуется получить.
//  ТекстЗаголовкаВыбора - текст заголовка для выбора.
//   Используется, когда подключено несколько элементов.
//  СообщениеНеПодключен - сообщение о том, что ни один элемент не подключен.
//
// Возвращаемое значение:
//  Нужный элемент торгового оборудования.
//
Функция ПолучитьЭлементТО(ВидТО, ТекстЗаголовкаВыбора, СообщениеНеПодключен)

	МассивТО = ПолучитьСерверТО().ПолучитьСписокУстройств(ВидТО);

	КоличествоТО = МассивТО.Количество();
	Если КоличествоТО = 0 Тогда
		ЭлементТО = Неопределено;
		Предупреждение(СообщениеНеПодключен);
	ИначеЕсли КоличествоТО = 1 Тогда
		ЭлементТО = МассивТО[0];
	Иначе
		ЭлементТО = ПолучитьСписокУстройствТОДляВыбора(МассивТО).ВыбратьЭлемент(ТекстЗаголовкаВыбора);
		Если ЭлементТО <> Неопределено Тогда
			ЭлементТО = ЭлементТО.Значение;
		КонецЕсли;
	КонецЕсли;

	Возврат ЭлементТО;

КонецФункции // ПолучитьТО()

// Функция выполняет проверку, что переданная информационная карта не совпадает с заданым типом.
// Если карта не соответствует типу, то выдается соответствующее предупреждение.
//
// Параметры:
//  ИнформационнаяКарта - ссылка справочника "Информационные карты".
//
// Возвращаемое значение:
//  Булево. Истина - если информационная карта совпадает с заданым типом.
//
Функция ПроверитьТипКарты(ИнформационнаяКарта, ТипКарты) Экспорт

	//.. Начало изменения Dim)on  16 октября 2013 г. 16:00:21
	//
	//Результат = (ИнформационнаяКарта.ТипКарты = ТипКарты);
	Результат = (ТипЗнч(ИнформационнаяКарта) = Тип("СправочникСсылка.РегистрационныеКарты") И Перечисления.ТипыИнформационныхКарт.Регистрационная = ТипКарты) Или
		(ТипЗнч(ИнформационнаяКарта) = Тип("СправочникСсылка.ИнформационныеКарты") И ИнформационнаяКарта.ТипКарты = ТипКарты);
	//
	//.. Конец изменения Dim)on  16 октября 2013 г. 16:00:21
	
	Если Не Результат Тогда
		Если (ТипКарты = Перечисления.ТипыИнформационныхКарт.Регистрационная) Тогда
			____Восклицание("Считанная карта не является регистрационной!");
		Иначе
			____Восклицание("Считанная карта не является дисконтной!");
		КонецЕсли;
	Иначе
		Результат = Истина;
	КонецЕсли;

	Возврат Результат;

КонецФункции // ПроверитьСообщитьЧтоКартаНеДисконтная()
  
Функция ВернутьМодельОборудованияПоИдентификатору(Идентификатор=Неопределено) Экспорт
	
	Модель = Неопределено;
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	
	Запрос.Текст = "
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	РегТО.Модель КАК Модель
	|ИЗ
	|	РегистрСведений.ТорговоеОборудование КАК РегТО
	|ГДЕ
	|	РегТО.Идентификатор = &Идентификатор
	|";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Модель = Выборка.Модель;
	КонецЕсли;
	
	Возврат Модель;
	
КонецФункции	                   

Процедура ОбойтиСтрокиДереваРегистраТО(Строки)
    Для Каждого СтрокаДерева Из Строки Цикл
		Если НЕ(ЗначениеЗаполнено(СтрокаДерева.Оборудование)) Тогда
			//Если СтрокаДерева.Компьютер=Справочники.Компьютеры.ПустаяСсылка() Тогда
			//	Строки.Удалить(СтрокаДерева);
			//Иначе	
				СтрокаДерева.Оборудование = СтрокаДерева.Компьютер;    
			//КонецЕсли;
        КонецЕсли;
        ОбойтиСтрокиДереваРегистраТО(СтрокаДерева.Строки);
    КонецЦикла;
КонецПроцедуры

Функция ПолучитьДеревоРегистраТО(Отбор=Неопределено) Экспорт
	// Вставить содержимое обработчика.	
	// Данные.
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|    ВЫБОР
	|        КОГДА (РегТО.Модель = NULL)
	|            ТОГДА РегТО.Компьютер
	|        ИНАЧЕ РегТО.Модель
	|    КОНЕЦ КАК Оборудование,
	|	 РегТО.Идентификатор КАК Идентификатор,
	|	 РегТО.Компьютер КАК Компьютер,
	|	 РегТО.Модель.ОбработкаОбслуживания.Вид КАК ВидТО,
	|    РегТО.КассаККМ КАК КассаККМ
	|ИЗ
	|    РегистрСведений.ТорговоеОборудование КАК РегТО	
	|ГДЕ
	|	 НЕ(РегТО.Компьютер = &ПустаяСсылка)";
	
	Если НЕ(Отбор=Неопределено) Тогда
		Если Отбор.Свойство("ВидТО") Тогда
			Запрос.Текст = Запрос.Текст + " И
			|	РегТО.Модель.ОбработкаОбслуживания.Вид = &ВидТО";
			Запрос.УстановитьПараметр("ВидТО", Отбор["ВидТО"]);
		КонецЕсли;
	КонецЕсли;
	
	Запрос.Текст = Запрос.Текст + "
	|СГРУППИРОВАТЬ ПО
	|    РегТО.Компьютер,
	|    РегТО.Модель,
	|	 РегТО.КассаККМ,
	|	 РегТО.Идентификатор	
	|ИТОГИ ПО
	|    РегТО.Компьютер ИЕРАРХИЯ";
	
	Запрос.УстановитьПараметр("ПустаяСсылка", Справочники.Компьютеры.ПустаяСсылка());	
	
	Дерево = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);    	
	
	ОбойтиСтрокиДереваРегистраТО(Дерево.Строки);
	
	Дерево.Строки.Сортировать("Оборудование Убыв");
	
	Возврат Дерево;
КонецФункции

Функция ПолучитьСписокДоступныхПринтеров() Экспорт
//    Принтеры установленные в системе 
    Список = Новый СписокЗначений;
    #Если Клиент Тогда 
        Попытка
            КОМОбъект =  Новый COMОбъект ("WScript.Network");
            Принтеры =  КОМОбъект.EnumPrinterConnections();
            шшш = 0;
            Пока шшш < Принтеры.Count()-1 Цикл
                Список.Добавить(Принтеры.Item(шшш+1), Принтеры.Item(шшш+1));
                шшш = шшш + 2;
            КонецЦикла;
        Исключение
            Сообщить(ОписаниеОшибки());
        КонецПопытки;
    #КонецЕсли 
    возврат Список;
КонецФункции
        
Функция ВернутьИмяПринтераТО(ТекущиеДанные) Экспорт
	// Вставить содержимое обработчика.
	ИмяПринтера = "";
	Обработка = Неопределено;
	Ошибка    = ПолучитьОбработкуОбслуживанияТО(ТекущиеДанные.Модель, Обработка);
	Если (НЕ ЗначениеЗаполнено(Ошибка))и(НЕ(ТекущиеДанные=Неопределено)) Тогда		
		Если ЗначениеЗаполнено(ТекущиеДанные.Идентификатор) Тогда
			Набор = РегистрыСведений.ТорговоеОборудование.СоздатьНаборЗаписей();
			Набор.Отбор.Идентификатор.Установить(ТекущиеДанные.Идентификатор);
			Набор.Прочитать();
			
			Параметры = ?(ПустаяСтрока(Набор[0].Параметры),
						Новый Структура(),
						ЗначениеИзСтрокиВнутр(Набор[0].Параметры));			
			Если Параметры.Количество()<>0 Тогда 
				ИмяПринтера =  Параметры.НазваниеПринтера;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	Возврат ИмяПринтера;
КонецФункции	

Процедура СоэдатьЭлементВСправочникеИнформационныеКарты(КодКарты ,ВидДК , ВидКарты , ТипКарты , ЗаписьСовершена = Ложь, ВыходИзПроцедуры = ложь, Владелец=Неопределено, ВладелецКарты=Неопределено, ГруппаПользователей=Неопределено, ТипШтрихКода=Неопределено) Экспорт 
	
	Если ЗначениеЗаполнено(КодКарты) Тогда		
		СпрСсылка = Справочники.ИнформационныеКарты.НайтиПоРеквизиту("КодКарты", КодКарты);                      
		//НачатьТранзакцию();
		Если не СпрСсылка.Пустая() Тогда					
			Если СпрСсылка.ПометкаУдаления Тогда 
				FrontOffice.ВывестиПредупреждение(НСтр("ru='Дисконтная карта " + СпрСсылка.Наименование + " помечена на удаление обратитесь к Администратору!';uk='Дисконтна карта "+ СпрСсылка.Наименование+" помічена на видалення зверніться до Адміністратора!'"));			
				ВыходИзПроцедуры =Истина;
				Возврат;	
			иначе
				ВыходИзПроцедуры =Истина;
				Возврат;
			КонецЕсли;			
		Иначе 				
			
			Спр = Справочники.ИнформационныеКарты.СоздатьЭлемент();
			
			Спр.ВидДисконтнойКарты = ?(ВидДК.Пустая(),Справочники.ВидыДисконтныхКарт.НовыеКарточки,ВидДК );
			Спр.УстановитьНовыйКод();
			Спр.КодКарты= КодКарты;
			Спр.ВидКарты  = ВидКарты;
			Спр.ТипКарты =ТипКарты;
			
			Если Владелец <> Неопределено Тогда 
				Спр.Владелец =  Владелец;
			КонецЕсли;		
			
			Если ВладелецКарты <> Неопределено Тогда
				Спр.ВладелецКарты = ВладелецКарты;
			КонецЕсли;
			
			Если ГруппаПользователей <> Неопределено Тогда
				Спр.ГруппаПользователей = ГруппаПользователей;
			КонецЕсли;
			
			Если ТипШтрихКода <> Неопределено Тогда
				Спр.ТипШтрихКода = ТипШтрихКода; 
			КонецЕсли; 
			Спр.Наименование = ПолучитьНаименование(КодКарты);
			Спр.Ресторан = ПараметрыСеанса.ТекущийРесторан; //Костенюк Александр 13.02.2015 
		КонецЕсли;
		
		Попытка
			//Спр.ОбменДанными.Загрузка =Истина;
			Спр.Записать();
			//ЗафиксироватьТранзакцию();				
		Исключение                                        
			//ОтменитьТранзакцию();
			FrontOffice.ВывестиОшибку(НСтр("ru = '"+ОписаниеОшибки()+"'"), , "Ошибка записи справочника!");
			ВыходИзПроцедуры =Истина;
			Возврат;
		КонецПопытки;
		ВыходИзПроцедуры =Истина;
		ЗаписьСовершена = Истина;
		FrontOffice.ВывестиПредупреждение(НСтр("ru='Создана новая дисконтная карта " + СпрСсылка.Наименование + " !';uk='Створена нова дисконтна карта "+ СпрСсылка.Наименование+" !'"),, "Внимание");
	КонецЕсли;	
	
КонецПроцедуры

Функция ПолучитьНаименование(КодКарты)
	Результат = "№" + СокрЛП(КодКарты);
	Возврат Результат;	
КонецФункции // ПолучитьНаименование()

Процедура ВыбратьТО(Элемент, СтандартнаяОбработка, ВидТО = Неопределено) Экспорт

	СтандартнаяОбработка = Ложь;
	
	Если (ВидТО = Неопределено) Тогда
		Обработки.ТОВыбор.Создать().ПолучитьДеревоТОдляВыбора(Элемент);
	Иначе
		Обработки.ТОВыбор.Создать().ПолучитьДеревоТОдляВыбора(Элемент, Новый Структура("ВидТО", ВидТО));
	КонецЕсли;
	
КонецПроцедуры // ВыбратьТО()

Функция ВернутьТЗсоСпискомКассОрганизации(Организация, Компьютер) Экспорт
	
	//Ковтун А. 06/07/2010 Получить список касс подключенных к даному компьютеру по организации
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|    РегТО.КассаККМ КАК КассаККМ
	|ИЗ
	|    РегистрСведений.ТорговоеОборудование КАК РегТО
	|ГДЕ
	|    (РегТО.КассаККМ.Владелец = &Организация И РегТО.Компьютер = &Компьютер)");
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Компьютер"          , Компьютер);
	
	Результат = Запрос.Выполнить().Выгрузить();				
	
	Возврат Результат;

КонецФункции	

  