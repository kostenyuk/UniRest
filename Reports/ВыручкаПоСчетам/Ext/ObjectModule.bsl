﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
// Для общей формы "Форма отчета выручка" подсистемы "Варианты отчетов".
Функция ПолучитьНастройкиОтчета() Экспорт
	НастройкиОтчета = ПолучитьНастройкиОтчетаПоУмолчанию();
	НастройкиОтчета.ПараметрыПечатиПоУмолчанию.ПолеСверху = 5;
	НастройкиОтчета.ПараметрыПечатиПоУмолчанию.ПолеСлева = 5;
	НастройкиОтчета.ПараметрыПечатиПоУмолчанию.ПолеСнизу = 5;
	НастройкиОтчета.ПараметрыПечатиПоУмолчанию.ПолеСправа = 5;
	Возврат НастройкиОтчета;
КонецФункции

// Формирует настройки отчета по умолчанию.
//
// Возвращаемое значение:
//   Настройки (Структура)
//       |- СоответствиеПериодичностиПараметров (Соответствие)
//           |- Ключ     (ПараметрКомпоновкиДанных)
//           |- Значение (ПеречислениеСсылка.ДоступныеПериодыОтчета)
//       |- ПараметрыПечатиПоУмолчанию (Структура)
//
Функция ПолучитьНастройкиОтчетаПоУмолчанию() Экспорт
	
	Настройки = Новый Структура;
	Настройки.Вставить("СоответствиеПериодичностиПараметров", Новый Соответствие);
	Настройки.Вставить("ПараметрыПечатиПоУмолчанию", Новый Структура);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("ПолеСверху", 10);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("ПолеСлева", 10);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("ПолеСнизу", 10);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("ПолеСправа", 10);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("ОриентацияСтраницы", ОриентацияСтраницы.Портрет);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("АвтоМасштаб", Истина);
	Настройки.ПараметрыПечатиПоУмолчанию.Вставить("МасштабПечати", Неопределено);
	
	Возврат Настройки;
	
КонецФункции

#КонецЕсли

