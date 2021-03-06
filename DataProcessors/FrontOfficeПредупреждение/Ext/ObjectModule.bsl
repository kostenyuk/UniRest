﻿
#Если Клиент Тогда

// Функция вывода на экран диалогового окна.
//
// Параметры:
//	ТекстВопроса - Строка. Текст задаваемого вопроса;
//	Режим - РежимДиалогаВопрос. Задает состав кнопок диалога и возможные варианты ответов;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	КнопкаПоУмолчанию - КодВозвратаДиалога. Определяет кнопку, которая должна быть назначена кнопкой по умолчанию;
//	Заголовок - Строка. Заголовок окна;
//	Картинка - Картинка. Картинка диалогового окна.
//
// Возвращаемое значение:
//	КодВозвратаДиалога. В зависимости от реакции пользователя возвращается одно из значений системного перечисления.
//
Функция ВывестиДиалог(Текст, Режим, Таймаут = 0, КнопкаПоУмолчанию = Неопределено, Заголовок = "", Картинка = Неопределено)
	
	// Получаем форму.
	Форма = ЭтотОбъект.ПолучитьФорму("Форма");
	Если Не ПустаяСтрока(Заголовок) Тогда
		Форма.Заголовок = Заголовок;
	КонецЕсли;
	Форма.Текст = Текст;
	Форма.Режим = Режим;
	Форма.Картинка = Картинка;
	Форма.КнопкаПоУмолчанию = КнопкаПоУмолчанию;
	
	// Открываем форму.
	КодВозврата = Форма.ОткрытьМодально(Таймаут);
	
	// Результат.
	Если (КодВозврата = Неопределено) Тогда
		Возврат КодВозвратаДиалога.Таймаут;
	КонецЕсли;
		
	Возврат КодВозврата;
	
КонецФункции // ВывестиДиалог()
	
	
// Процедура вывода на экран окна предупреждения.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ВывестиПредупреждение(ТекстПредупреждения, Таймаут = 0, Заголовок = "") Экспорт
	
	// Проверка входных параметров.
	
// TODO: Проверка входных параметров.
	
	// Перенаправление.
	Попытка
		ВывестиДиалог(ТекстПредупреждения, РежимДиалогаВопрос.ОК, Таймаут, , Заголовок, БиблиотекаКартинок.TouchПредупреждение);
	Исключение
		ВывестиДиалог(ТекстПредупреждения, РежимДиалогаВопрос.ОК, Таймаут, , Заголовок);
	КонецПопытки;
	
КонецПроцедуры // ВывестиПредупреждение()
	
// Процедура вывода на экран окна восклицания.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ВывестиВосклицание(ТекстПредупреждения, Таймаут = 0, Заголовок = "") Экспорт
	
	// Проверка входных параметров.
	
// TODO: Проверка входных параметров.
	
	// Перенаправление.
	Попытка
		ВывестиДиалог(ТекстПредупреждения, РежимДиалогаВопрос.ОК, Таймаут, , Заголовок, БиблиотекаКартинок.TouchВосклицание);
	Исключение
		ВывестиДиалог(ТекстПредупреждения, РежимДиалогаВопрос.ОК, Таймаут, , Заголовок);
	КонецПопытки;
	
КонецПроцедуры // ВывестиВосклицание()

// Процедура вывода на экран окна ошибки.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ВывестиОшибку(ТекстПредупреждения, Таймаут = 0, Заголовок = "") Экспорт
	
	// Проверка входных параметров.
	
// TODO: Проверка входных параметров.
	
	// Перенаправление.
	Попытка
		ВывестиДиалог(ТекстПредупреждения, РежимДиалогаВопрос.ОК, Таймаут, , Заголовок, БиблиотекаКартинок.TouchОшибка);
	Исключение
		ВывестиДиалог(ТекстПредупреждения, РежимДиалогаВопрос.ОК, Таймаут, , Заголовок);
	КонецПопытки;
	
КонецПроцедуры // ВывестиОшибку()


// Функция вывода на экран окна вопроса.
//
// Параметры:
//	ТекстВопроса - Строка. Текст задаваемого вопроса;
//	Режим - РежимДиалогаВопрос. Задает состав кнопок диалога и возможные варианты ответов;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	КнопкаПоУмолчанию - КодВозвратаДиалога. Определяет кнопку, которая должна быть назначена кнопкой по умолчанию;
//	Заголовок - Строка. Заголовок окна.
//
// Возвращаемое значение:
//	КодВозвратаДиалога. В зависимости от реакции пользователя возвращается одно из значений системного перечисления.
//
Функция ВывестиВопрос(ТекстВопроса, Режим, Таймаут = 0, КнопкаПоУмолчанию = Неопределено, Заголовок = "") Экспорт
	
	// Проверка входных параметров.
	
// TODO: Проверка входных параметров.
	
	// Перенаправление.
	Попытка
		Возврат ВывестиДиалог(ТекстВопроса, Режим, Таймаут, КнопкаПоУмолчанию, Заголовок, БиблиотекаКартинок.TouchВопрос);
	Исключение
		Возврат ВывестиДиалог(ТекстВопроса, Режим, Таймаут, КнопкаПоУмолчанию, Заголовок);
	КонецПопытки;
	
КонецФункции // ВывестиВопрос()

#КонецЕсли

