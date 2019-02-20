﻿
Функция ЗначенияЗаполненныПересечение(КоллекцияЗначений, ПроверяемыеЗначения) Экспорт
	
	Структура = Новый Структура(ПроверяемыеЗначения); ЗаполнитьЗначенияСвойств(Структура, КоллекцияЗначений);
	
	Для Каждого Элемент Из Структура Цикл Если Не ЗначениеЗаполнено(Элемент.Значение) Тогда Возврат Ложь; КонецЕсли; КонецЦикла; 

	Возврат Истина;

КонецФункции // ЗначенияЗаполненныПересечение()

Функция ЗначенияЗаполненныОбъединение(КоллекцияЗначений, ПроверяемыеЗначения) Экспорт
	
	Структура = Новый Структура(ПроверяемыеЗначения); ЗаполнитьЗначенияСвойств(Структура, КоллекцияЗначений);
	
	Для Каждого Элемент Из Структура Цикл Если ЗначениеЗаполнено(Элемент.Значение) Тогда Возврат Истина; КонецЕсли; КонецЦикла; 

	Возврат Ложь;

КонецФункции // ЗначенияЗаполненныОбъединение()


Функция ОкрВремя(Время, Разрядность) Экспорт

	Числом = Время - '00010101';
	
	Остаток = Числом % Разрядность;
	Целое = Числом - Остаток; 
	
	Числом = Целое + Число(Остаток >= Разрядность / 2) * Разрядность; 
	
	Возврат '00010101' + Числом;

КонецФункции // ОкрВремя()


Функция МаксДата() Экспорт

	Возврат '39991231235959';

КонецФункции // МаксДата()


Функция ПолучитьНеПустоеЗначение(Значение, ТекущееЗначение) Экспорт

	Если ЗначениеЗаполнено(Значение) Тогда
		Возврат Значение;
	КонецЕсли; 
	
	Возврат ТекущееЗначение;
	
КонецФункции // ПолучитьНеПустоеЗначение()

Функция ПолучитьНеПустуюДату(Дата, ТекущаяДата = Неопределено) Экспорт

	Если ЗначениеЗаполнено(Дата) Тогда
		Возврат Дата;
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(ТекущаяДата) Тогда
		Возврат ТекущаяДата;
	КонецЕсли; 
	
	Возврат ТекущаяДата();
	
КонецФункции // ПолучитьНеПустуюДату()

Функция ПолучитьНеПустоеНаименование(Наименование, ТекущееНаименование = Неопределено) Экспорт

	Если Не ПустаяСтрока(Наименование) Тогда
		Возврат Строка(Наименование);
	КонецЕсли; 
	
	Если Не ПустаяСтрока(ТекущееНаименование) Тогда
		Возврат Строка(ТекущееНаименование);
	КонецЕсли; 
	
	Возврат "<>";
	
КонецФункции // ПолучитьНеПустоеНаименование()



Функция ПроверитьПараметрЗаполнения(Параметры, Свойство, Значение = Неопределено, ПоУмолчанию = Неопределено) Экспорт
	
	Если (Параметры = Неопределено) Тогда
		Значение = ПоУмолчанию; Возврат Ложь;
	КонецЕсли;
	
	ПроверяемоеЗначение = Новый УникальныйИдентификатор; СтруктураПриемник = Новый Структура(Свойство, ПроверяемоеЗначение); 
	ЗаполнитьЗначенияСвойств(СтруктураПриемник, Параметры); Если (Не СтруктураПриемник[Свойство] = ПроверяемоеЗначение) Тогда
		Значение = СтруктураПриемник[Свойство]; Возврат Истина;
	КонецЕсли;
	
	Значение = ПоУмолчанию; Возврат Ложь;
	
КонецФункции // ПроверитьПараметрЗаполнения()

Функция ПолучитьПараметрЗаполнения(Параметры, Свойство, ПоУмолчанию = Неопределено) Экспорт
	
	Если (Параметры = Неопределено) Тогда
		Возврат ПоУмолчанию;
	КонецЕсли;
	
	ПроверяемоеЗначение = Новый УникальныйИдентификатор; СтруктураПриемник = Новый Структура(Свойство, ПроверяемоеЗначение); 
	ЗаполнитьЗначенияСвойств(СтруктураПриемник, Параметры); Если (Не СтруктураПриемник[Свойство] = ПроверяемоеЗначение) Тогда
		Возврат СтруктураПриемник[Свойство];
	КонецЕсли;
	
	Возврат ПоУмолчанию;
	
КонецФункции // ПолучитьПараметрЗаполнения()



Функция УдалитьСтроки(КоллекцияСтрок, МассивУдаляемыхСтрок) Экспорт

	Для Каждого УдаляемаяСтрока Из МассивУдаляемыхСтрок Цикл КоллекцияСтрок.Удалить(УдаляемаяСтрока); КонецЦикла; 

КонецФункции // УдалитьСтроки()


Функция Парсинг(Значение, Разделитель = ",") Экспорт
	
	Если (ТипЗнч(Значение) = Тип("Массив")) Тогда
		
		Результат = Строка(Неопределено);
		
		// Формирование.
		Первый = Истина;
		Для Каждого Строка Из Значение Цикл
			Если Первый Тогда
				Результат = Строка(Строка); Первый = Ложь;
			Иначе
				Результат = Результат + Разделитель + Строка(Строка);
			КонецЕсли; 
		КонецЦикла;
		
	Иначе
	
		Результат = Новый Массив;
		
		// Парсинг.
		Строка = Строка(Значение); ДлиннаРазделителя = СтрДлина(Разделитель);
		Пока Не ПустаяСтрока(Строка) Цикл
			Индекс = Найти(Строка, Разделитель); Если Не Индекс Тогда Индекс = СтрДлина(Строка) + 1; КонецЕсли;
			Результат.Добавить(Лев(Строка, Индекс - 1));
			Строка = Сред(Строка, Индекс + ДлиннаРазделителя);
		КонецЦикла;
		
	КонецЕсли;          
		
	// Результат.
	Возврат Результат;
	
КонецФункции // Парсинг()


Функция ПеревестиИзДесятичной(Значение, Нотация = 16, Разрядность = 8) Экспорт
	
	Результат = Строка(Неопределено);
	
	Нотация = Мин(36, Макс(2, Цел(Нотация))); Приведенное = Макс(0, Цел(Значение));

	Пока (Приведенное > 0) Цикл
		Результат = Сред("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", Приведенное % Нотация + 1, 1) + Результат;
		Приведенное = Цел(Приведенное / Нотация);
	КонецЦикла;
	Для Индекс = СтрДлина(Результат) + 1 По Разрядность Цикл
		Результат = "0" + Результат;
	КонецЦикла;

	Возврат Результат;
	
КонецФункции // ПеревестиИзДесятичной()

Функция ПеревестиВДесятичную(Значение, Нотация = 36) Экспорт
	
	Результат = Число(Ложь);
	
	Нотация = Мин(36, Макс(2, Цел(Нотация))); Приведенное = СокрЛП(Значение);
	
	Индекс = СтрДлина(Приведенное); Степень = 1; Пока (Индекс > 0) Цикл
		Результат = Результат + Макс(0, (Найти("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", Сред(Приведенное, Индекс, 1)) - 1)) * Степень;
		Степень = Степень * Нотация; Индекс = Индекс - 1;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции // ПеревестиВДесятичную()


Функция СкопироватьРекурсивно(Источник) Экспорт
	
	Перем Приемник;
	
	ТипИсточника = ТипЗнч(Источник);
	Если ТипИсточника = Тип("Структура") Тогда
		Приемник = СкопироватьСтруктуру(Источник);
	ИначеЕсли ТипИсточника = Тип("Соответствие") Тогда
		Приемник = СкопироватьСоответствие(Источник);
	ИначеЕсли ТипИсточника = Тип("Массив") Тогда
		Приемник = СкопироватьМассив(Источник);
	ИначеЕсли ТипИсточника = Тип("СписокЗначений") Тогда
		Приемник = СкопироватьСписокЗначений(Источник);
	#Если Сервер Или ТолстыйКлиент Или ВнешнееСоединение Тогда
	ИначеЕсли ТипИсточника = Тип("ТаблицаЗначений") Тогда
		Приемник = Источник.Скопировать();
	#КонецЕсли
	Иначе
		Приемник = Источник;
	КонецЕсли;
	
	Возврат Приемник;
	
КонецФункции

Функция СкопироватьСтруктуру(СтруктураИсточник) Экспорт
	
	СтруктураРезультат = Новый Структура;
	
	Для Каждого КлючИЗначение ИЗ СтруктураИсточник Цикл
		СтруктураРезультат.Вставить(КлючИЗначение.Ключ, СкопироватьРекурсивно(КлючИЗначение.Значение));
	КонецЦикла;
	
	Возврат СтруктураРезультат;
	
КонецФункции

Функция СкопироватьСоответствие(СоответствиеИсточник) Экспорт
	
	СоответствиеРезультат = Новый Соответствие;
	
	Для Каждого КлючИЗначение ИЗ СоответствиеИсточник Цикл
		СоответствиеРезультат.Вставить(КлючИЗначение.Ключ, СкопироватьРекурсивно(КлючИЗначение.Значение));
	КонецЦикла;
	
	Возврат СоответствиеРезультат;

КонецФункции

Функция СкопироватьМассив(МассивИсточник) Экспорт
	
	МассивРезультат = Новый Массив;
	
	Для Каждого Элемент ИЗ МассивИсточник Цикл
		МассивРезультат.Добавить(СкопироватьРекурсивно(Элемент));
	КонецЦикла;
	
	Возврат МассивРезультат;
	
КонецФункции

Функция СкопироватьСписокЗначений(СписокИсточник) Экспорт
	
	СписокРезультат = Новый СписокЗначений;
	
	Для Каждого ЭлементСписка ИЗ СписокИсточник Цикл
		СписокРезультат.Добавить(
			СкопироватьРекурсивно(ЭлементСписка.Значение), 
			ЭлементСписка.Представление, 
			ЭлементСписка.Пометка, 
			ЭлементСписка.Картинка);
	КонецЦикла;
	
	Возврат СписокРезультат;
	
КонецФункции


Функция ПолучитьСообщениеОшибки(ТекстСообщения) Экспорт
	
	Если (ТипЗнч(ТекстСообщения) = Тип("ИнформацияОбОшибке")) Тогда
		
		ИнформацияОбОшибке = ТекстСообщения.Причина.Описание;
		Если ПустаяСтрока(ИнформацияОбОшибке) Тогда
			ИнформацияОбОшибке = ТекстСообщения.Описание;
		КонецЕсли; 
		
	Иначе
		ИнформацияОбОшибке = Строка(ТекстСообщения);
	КонецЕсли; 

	НачалоСлужебногоСообщения    = Найти(ИнформацияОбОшибке, "{");
	ОкончаниеСлужебногоСообщения = Найти(ИнформацияОбОшибке, "}:");
	
	Если ОкончаниеСлужебногоСообщения И НачалоСлужебногоСообщения И (НачалоСлужебногоСообщения < ОкончаниеСлужебногоСообщения) Тогда
		
		ИнформацияОбОшибке = Лев(ТекстСообщения, (НачалоСлужебногоСообщения - 1)) +
							 Сред(ТекстСообщения, (ОкончаниеСлужебногоСообщения + 2));
						 
	КонецЕсли;
					 
	Возврат СокрЛП(ИнформацияОбОшибке);

КонецФункции // ПолучитьСообщениеОшибки()


// Формирует и выводит сообщение, которое может быть связано с элементом 
// управления формы.
//
//	Параметры
//	ТекстСообщенияПользователю	- Строка - текст сообщения.
//	ОбъектИлиСсылка				- Ссылка на объект ИБ или объект
//	Поле						- Строка - наименование реквизита формы
//	ПутьКДанным					- Строка - путь к данным (путь к реквизиту формы)
//	Отказ						- Булево - Выходной параметр. 
//                                Устанавливается в этой процедуре в значение Истина.
//
//	Примеры использования:
//	1. Для вывода сообщения у поля управляемой формы, связанного с реквизитом объекта:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ,
//		"ПолеВРеквизитеФормыОбъект",
//		"Объект");
//
//	Альтернативный вариант использования в форме объекта:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ,
//		"Объект.ПолеВРеквизитеФормыОбъект");
//
//	2. Для вывода сообщения рядом с полем управляемой формы, связанным с реквизитом формы:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ,
//		"ИмяРеквизитаФормы");
//
//	3. Для вывода сообщения из кода на сервере:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"),СсылкаНаОбъект,,,Отказ);
//
Процедура СообщитьПользователю(	Знач ТекстСообщенияПользователю,
								Знач ОбъектИлиСсылка = Неопределено,
								Знач Поле = "",
								Знач ПутьКДанным = "",
								Отказ = Ложь) Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = Строка(ТекстСообщенияПользователю);
	Сообщение.Поле = Строка(Поле);
	Сообщение.ПутьКДанным = Строка(ПутьКДанным);
	
	Если ОбъектИлиСсылка <> Неопределено Тогда
		Сообщение.УстановитьДанные(ОбъектИлиСсылка);
	КонецЕсли;
	
	Сообщение.Сообщить();
	Отказ = Истина;
	
КонецПроцедуры

Функция СообщитьОбОшибке(ТекстСообщения, ОбъектИлиСсылка = Неопределено, Поле = Неопределено, ПутьКДанным = Неопределено, Отказ = Ложь) Экспорт

	СообщитьПользователю(ТекстСообщения, ОбъектИлиСсылка, Поле, ПутьКДанным, Отказ);
	Возврат Ложь;
	
КонецФункции // СообщитьОбОшибке()

//Костенюк Александр-Старт 31.08.2012
#Если Клиент Тогда
	
// Открывает форму редактирования произвольного многострочного текста модально.
//
// Параметры:
//  МногострочныйТекст      - Строка - произвольный текст, который необходимо отредактировать;
//  РезультатРедактирования - Строка - в этот параметр будет помещен результат редактирования;
//  Модифицированность      - Строка - флаг модифицированности формы;
//  Заголовок               - Строка - текст, который необходимо отобразить в заголовке формы.
//
Процедура ОткрытьФормуРедактированияМногострочногоТекста(Знач МногострочныйТекст, РезультатРедактирования, Модифицированность = Ложь, 
		Знач Заголовок = Неопределено) Экспорт
	
	Если Заголовок = Неопределено Тогда
		ТекстВведен = ВвестиСтроку(МногострочныйТекст,,, Истина);
	Иначе
		ТекстВведен = ВвестиСтроку(МногострочныйТекст, Заголовок,, Истина);
	КонецЕсли;
	
	Если Не ТекстВведен Тогда
		Возврат;
	КонецЕсли;
		
	РезультатРедактирования = МногострочныйТекст;
	Если Не Модифицированность Тогда
		Модифицированность = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Возвращает текущую дату, приведенную к часовому поясу сеанса.
//
// Функция возвращает время, близкое к результату функции ТекущаяДатаСеанса() в серверном контексте.
// Погрешность обусловлена временем выполнения серверного вызова.
// Предназначена для использования вместо функции ТекущаяДата().
//
Функция ДатаСеанса() Экспорт
	//Возврат ТекущаяДата() + СтандартныеПодсистемыКлиентПовтИсп.ПараметрыРаботыКлиента().ПоправкаКВремениСеанса;
	Возврат ТекущаяДата() + РассылкаОтчетовПовтИсп.ПараметрыРаботыКлиента().ПоправкаКВремениСеанса;
КонецФункции

#КонецЕсли
//Костенюк Александр-Финиш 31.08.2012

// Добавляет к переданному пути каталога конечный символ-разделитель, если он отсутствует.
// В случае, когда параметр "Платформа" не указан, разделитель выбирается, исходя из уже имеющихся
// разделителей в параметре "ПутьКаталога".
//
// Параметры:
//  ПутьКаталога - Строка - путь к каталогу;
//  Платформа - ТипПлатформы - тип платформы, в рамках которой осуществляется работа (влияет на выбор разделителя).
//
// Возвращаемое значение:
//  Строка   - путь к каталогу с конечным символом-разделителем.
//
// Примеры использования:
//  Результат = ДобавитьКонечныйРазделительПути("C:\Мой каталог"); // возвращает "C:\Мой каталог\"
//  Результат = ДобавитьКонечныйРазделительПути("C:\Мой каталог\"); // возвращает "C:\Мой каталог\"
//  Результат = ДобавитьКонечныйРазделительПути("ftp://Мой каталог"); // возвращает "ftp://Мой каталог/"
//	Результат = ДобавитьКонечныйРазделительПути("%APPDATA%", ТипПлатформы.Windows_x86_64); // возвращает "%APPDATA%\"
//
Функция ДобавитьКонечныйРазделительПути(Знач ПутьКаталога, Знач Платформа = Неопределено) Экспорт
	
	Если ПустаяСтрока(ПутьКаталога) Тогда
		Возврат ПутьКаталога;
	КонецЕсли;
	
	ДобавляемыйСимвол = "\";
	Если Платформа = Неопределено Тогда
		Если Найти(ПутьКаталога, "/") > 0 Тогда
			ДобавляемыйСимвол = "/";
		КонецЕсли;
	Иначе
		Если Платформа = ТипПлатформы.Linux_x86 Или Платформа = ТипПлатформы.Linux_x86_64 Тогда
			ДобавляемыйСимвол = "/";
		КонецЕсли;
	КонецЕсли;
	
	Если Прав(ПутьКаталога, 1) <> ДобавляемыйСимвол Тогда
		Возврат ПутьКаталога + ДобавляемыйСимвол;
	Иначе 
		Возврат ПутьКаталога;
	КонецЕсли;
	
КонецФункции

// Возвращает строку недопустимых символов
// Согласно http://en.wikipedia.org/wiki/Filename - в разделе "Reserved characters and words"
// Возвращаемое значение:
//   Строка - строка недопустимых символов
Функция ПолучитьНедопустимыеСимволыВИмениФайла() Экспорт

	НедопустимыеСимволы = """/\[]:;|=?*<>";
	Возврат НедопустимыеСимволы;

КонецФункции

// Проверяет наличение недопустимых символов в имени файла
//
// Параметры
//  ИмяФайла  - Строка 
// Возвращаемое значение:
//   Массив   - массив обнаруженных в имени файла недопустимых символов.
//              Если недопустимых символов не обнаружено возвращается пустой массив.
Функция НайтиНедопустимыеСимволыВИмениФайла(ИмяФайла) Экспорт

	НедопустимыеСимволы = ПолучитьНедопустимыеСимволыВИмениФайла();
	
	МассивНайденныхНедопустимыхСимволов = Новый Массив;
	
	Для ПозицияСимвола = 1 По СтрДлина(НедопустимыеСимволы) Цикл
		ПроверяемыйСимвол = Сред(НедопустимыеСимволы,ПозицияСимвола,1);
		Если Найти(ИмяФайла,ПроверяемыйСимвол) <> 0 Тогда
			МассивНайденныхНедопустимыхСимволов.Добавить(ПроверяемыйСимвол);
		КонецЕсли;
	КонецЦикла;
	
	Возврат МассивНайденныхНедопустимыхСимволов;

КонецФункции

// Сравнивает элементы списков значений или массивов по значениям
//
Функция СпискиЗначенийИдентичны(Список1, Список2) Экспорт
	
	СпискиИдентичны = Истина;
	
	Для Каждого ЭлементСписка1 Из Список1 Цикл
		Если НайтиВСписке(Список2, ЭлементСписка1) = Неопределено Тогда
			СпискиИдентичны = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если СпискиИдентичны Тогда
		Для Каждого ЭлементСписка2 Из Список2 Цикл
			Если НайтиВСписке(Список1, ЭлементСписка2) = Неопределено Тогда
				СпискиИдентичны = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат СпискиИдентичны;
	
КонецФункции // СпискиЗначенийИдентичны

// Функция выполняет поиск элемента в коллекции: списке значений или массиве
//
Функция НайтиВСписке(Список, Элемент)
	
	Перем ЭлементВСписке;
	
	Если ТипЗнч(Список) = Тип("СписокЗначений") Тогда
		Если ТипЗнч(Элемент) = Тип("ЭлементСпискаЗначений") Тогда
			ЭлементВСписке = Список.НайтиПоЗначению(Элемент.Значение);
		Иначе
			ЭлементВСписке = Список.НайтиПоЗначению(Элемент);
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗнч(Список) = Тип("Массив") Тогда
		ЭлементВСписке = Список.Найти(Элемент);
	КонецЕсли;
	
	Возврат ЭлементВСписке;
	
КонецФункции // ЭлементПрисутствуетВСписке

// Процедура управляет состояние поля табличного документа
//
//Параметры:
//  ПолеТабличногоДокумента – ПолеФормы – поле формы с видом ПолеТабличногоДокумента,
//                            для которого необходимо установить состояние.
//  Состояние               – Строка – задает вид состояния.
//
Процедура УстановитьСостояниеПоляТабличногоДокумента(ПолеТабличногоДокумента, Состояние = "НеИспользовать") Экспорт
	
	Если ТипЗнч(ПолеТабличногоДокумента) = Тип("ПолеФормы") 
		И ПолеТабличногоДокумента.Вид = ВидПоляФормы.ПолеТабличногоДокумента Тогда
		ОтображениеСостояния = ПолеТабличногоДокумента.ОтображениеСостояния;
		Если ВРег(Состояние) = "НЕИСПОЛЬЗОВАТЬ" Тогда
			ОтображениеСостояния.Видимость                      = Ложь;
			ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.НеИспользовать;
			ОтображениеСостояния.Картинка                       = Новый Картинка;
			ОтображениеСостояния.Текст                          = "";
		ИначеЕсли ВРег(Состояние) = "НЕАКТУАЛЬНОСТЬ" Тогда
			ОтображениеСостояния.Видимость                      = Истина;
			ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.Неактуальность;
			ОтображениеСостояния.Картинка                       = Новый Картинка;
			ОтображениеСостояния.Текст                          = НСтр("ru = 'Отчет не сформирован. Нажмите ""Сформировать"" для получения отчета.'");;
		ИначеЕсли ВРег(Состояние) = "ФОРМИРОВАНИЕОТЧЕТА" Тогда  
			ОтображениеСостояния.Видимость                      = Истина;
			ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.Неактуальность;
			ОтображениеСостояния.Картинка                       = БиблиотекаКартинок.ДлительнаяОперация48;
			ОтображениеСостояния.Текст                          = НСтр("ru = 'Отчет формируется...'");
		Иначе
			ВызватьИсключение(НСтр("ru = 'Недопустимое значение параметра (параметр номер ''2'')'"));
		КонецЕсли;
	Иначе
		ВызватьИсключение(НСтр("ru = 'Недопустимое значение параметра (параметр номер ''1'')'"));
	КонецЕсли;
	
КонецПроцедуры
