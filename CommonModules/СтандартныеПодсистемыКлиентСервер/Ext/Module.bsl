﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Базовая функциональность".
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЙ ПРОГРАММНЫЙ ИНТЕРФЕЙС

////////////////////////////////////////////////////////////////////////////////
// Обработка результата выполнения

// Формирует шаблон результата выполнения.
//
// Возвращаемое значение: 
//   Результат (Структура) См. СтандартныеПодсистемыКлиент.ПоказатьРезультатВыполнения().
//
Функция НовыйРезультатВыполнения(Результат = Неопределено) Экспорт
	Если Результат = Неопределено Тогда
		Результат = Новый Структура;
	КонецЕсли;
	
	Результат.Вставить("ВыводОповещения",     Новый Структура("Использование, Заголовок, Ссылка, Текст, Картинка", Ложь));
	Результат.Вставить("ВыводСообщения",      Новый Структура("Использование, Текст, ПутьКРеквизитуФормы", Ложь));
	Результат.Вставить("ВыводПредупреждения", Новый Структура("Использование, Текст, ПутьКРеквизитуФормы, ТекстОшибок", Ложь));
	Результат.Вставить("ОповещениеФорм",                Новый Структура("Использование, ИмяСобытия, Параметр, Источник", Ложь));
	Результат.Вставить("ОповещениеДинамическихСписков", Новый Структура("Использование, СсылкаИлиТип", Ложь));
	
	Возврат Результат;
КонецФункции

// Добавляет в оповещение для динамических списков типы из массива измененных объектов.
//
// Параметры:
//   ИзмененныеОбъекты (Массив) из (*) Ссылки измененных объектов программы.
//   Результат (Структура) См. СтандартныеПодсистемыКлиент.ПоказатьРезультатВыполнения().
//
Процедура ПодготовитьОповещениеДинамическихСписков(Знач ИзмененныеОбъекты, Результат) Экспорт
	Если ТипЗнч(ИзмененныеОбъекты) <> Тип("Массив") ИЛИ ИзмененныеОбъекты.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Результат.ОповещениеДинамическихСписков;
	Оповещение.Использование = Истина;
	
	ЗначениеОповещения = Оповещение.СсылкаИлиТип;
	ЗначениеОповещенияЗаполнено = ЗначениеЗаполнено(ЗначениеОповещения);
	
	Если ИзмененныеОбъекты.Количество() = 1 И НЕ ЗначениеОповещенияЗаполнено Тогда
		Оповещение.СсылкаИлиТип = ИзмененныеОбъекты[0];
	Иначе
		// Преобразование оповещения в массив.
		ЗначениеОповещенияТип = ТипЗнч(ЗначениеОповещения);
		Если ЗначениеОповещенияТип <> Тип("Массив") Тогда
			Оповещение.СсылкаИлиТип = Новый Массив;
			Если ЗначениеОповещенияЗаполнено Тогда
				Оповещение.СсылкаИлиТип.Добавить(?(ЗначениеОповещенияТип = Тип("Тип"), ЗначениеОповещения, ЗначениеОповещенияТип));
			КонецЕсли;
		КонецЕсли;
		
		// Добавление типов измененных объектов.
		Для Каждого ИзмененныйОбъект Из ИзмененныеОбъекты Цикл
			ТипИзмененногоОбъекта = ТипЗнч(ИзмененныйОбъект);
			Если Оповещение.СсылкаИлиТип.Найти(ТипИзмененногоОбъекта) = Неопределено Тогда
				Оповещение.СсылкаИлиТип.Добавить(ТипИзмененногоОбъекта);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

// Добавляет в оповещение для динамических списков типы из массива измененных объектов.
//
// Параметры:
//   Результат  (Структура) См. СтандартныеПодсистемыКлиент.ПоказатьРезультатВыполнения().
//   ИмяСобытия (Строка) Имя события, которое используется для первичной идентификации сообщений принимающими формами.
//   Параметр   (*) Набор данных, которые используются принимающей формой для обновления состава.
//   Источник   (*) Источник оповещения, например форма-источником.
//
Процедура РезультатВыполненияДобавитьОповещениеОткрытыхФорм(Результат, ИмяСобытия, Параметр = Неопределено, Источник = Неопределено) Экспорт
	Если Не Результат.Свойство("ОповещениеФорм") Тогда
		Результат.Вставить("ОповещениеФорм", Новый Массив);
	ИначеЕсли ТипЗнч(Результат.ОповещениеФорм) = Тип("Структура") Тогда // Структуру в массив структур.
		ОповещениеФорм = Результат.ОповещениеФорм;
		Результат.ОповещениеФорм = Новый Массив;
		Результат.ОповещениеФорм.Добавить(ОповещениеФорм);
	КонецЕсли;
	ОповещениеФорм = Новый Структура("Использование, ИмяСобытия, Параметр, Источник", Истина, ИмяСобытия, Параметр, Источник);
	Результат.ОповещениеФорм.Добавить(ОповещениеФорм);
КонецПроцедуры
