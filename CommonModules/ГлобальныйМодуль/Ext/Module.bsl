﻿
 
// Процедура вывода текста сообщения в окно сообщений.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ____Сообщение(ТекстСообщения, Статус = Неопределено, Заголовок = Ложь) Экспорт
	
	// Перенаправление.
    ОбщегоНазначения.ВывестиСообщение(ТекстСообщения, Статус, Заголовок);
	
КонецПроцедуры // ____Сообщение()


// Процедура вывода на экран окна предупреждения.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ____Предупреждение(ТекстПредупреждения, Таймаут = 0, Заголовок = "") Экспорт
	
	// Перенаправление.
    ОбщегоНазначения.ВывестиПредупреждение(ТекстПредупреждения, Таймаут, Заголовок);
	
КонецПроцедуры // ____Предупреждение()
	
// Процедура вывода на экран окна восклицания.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ____Восклицание(ТекстПредупреждения, Таймаут = 0, Заголовок = "") Экспорт
	
	// Перенаправление.
    ОбщегоНазначения.ВывестиВосклицание(ТекстПредупреждения, Таймаут, Заголовок);
	
КонецПроцедуры // ____Восклицание()

// Процедура вывода на экран окна ошибки.
//
// Параметры:
//	ТекстПредупреждения - Строка. Текст предупреждения.;
//	Таймаут - Число. Интервал времени в секундах, в течение которого система будет ожидать ответа пользователя;
//	Заголовок - Строка. Заголовок окна.
//
Процедура ____Ошибка(ТекстПредупреждения, Таймаут = 0, Заголовок = "") Экспорт
	
	// Перенаправление.
    ОбщегоНазначения.ВывестиОшибку(ТекстПредупреждения, Таймаут, Заголовок);
	
КонецПроцедуры // ____Ошибка()


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
Функция ____Вопрос(ТекстВопроса, Режим, Таймаут = 0, КнопкаПоУмолчанию = Неопределено, Заголовок = "") Экспорт
	
	// Перенаправление.
	Возврат ОбщегоНазначения.ВывестиВопрос(ТекстВопроса, Режим, Таймаут, КнопкаПоУмолчанию, Заголовок);
	
КонецФункции // ____Вопрос()



#Если Клиент Тогда
	
///////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ ОЖИДАНИЯ
   
// Процедура контроля завершения работы программы.
//
Процедура КонтрольРежимаЗавершенияРаботыПользователей1() Экспорт
	
	//ТекущийРежим = Константы.РежимЗавершенияРаботыПользователей.Получить();
	//
	//Если (ТекущийРежим = Перечисления.РежимыЗавершенияРаботыПользователей.ПредупредитьПользователейОЗавершенииРаботы) Тогда
	//	Предупреждение(	"Администратор просит Вас завершить работу системы самостоятельно."
	//					"Если через несколько минут работа системы не будет завершена, администратор завершит работу принудительно!", 30, "Завершение работы системы");
	//ИначеЕсли ТекущийРежим = Перечисления.РежимыЗавершенияРаботыПользователей.ЗавершитьССохранениемДанныхПользователей Тогда
	//	Предупреждение("Работа системы будет завершена!", 10, "Завершение работы системы");
	//	ЗавершитьРаботуСистемы(Истина);
	//ИначеЕсли ТекущийРежим = Перечисления.РежимыЗавершенияРаботыПользователей.ПрекратитьРаботуБезусловно Тогда
	//	ПрекратитьРаботуСистемы();
	//КонецЕсли; 
	
КонецПроцедуры


 


// Завершение работы только при условии удачной установки монопольного режима работы.
//
Процедура ЗавершитьРаботуПользователей1() Экспорт

	Соединения = ПолучитьСоединенияИнформационнойБазы();
	
	Если (Соединения.Количество() = 1) Тогда
		Сообщить("Установлен режим завершения работы пользователей «" + Перечисления.РежимыЗавершенияРаботыПользователей.ПрекратитьРаботуБезусловно + "».", СтатусСообщения.Внимание);
		ЗавершитьРаботуСистемы(Ложь);
		Константы.РежимЗавершенияРаботыПользователей.Установить(Перечисления.РежимыЗавершенияРаботыПользователей.ПрекратитьРаботуБезусловно);
		Возврат;
	КонецЕсли; 
	
	ТекущийРежимЗавершения = Константы.РежимЗавершенияРаботыПользователей.Получить();
	
	Если ТекущийРежимЗавершения = Перечисления.РежимыЗавершенияРаботыПользователей.РазрешитьРаботу Тогда
		Константы.РежимЗавершенияРаботыПользователей.Установить(Перечисления.РежимыЗавершенияРаботыПользователей.ПредупредитьПользователейОЗавершенииРаботы);
		
	ИначеЕсли ТекущийРежимЗавершения = Перечисления.РежимыЗавершенияРаботыПользователей.ПредупредитьПользователейОЗавершенииРаботы Тогда
		Константы.РежимЗавершенияРаботыПользователей.Установить(Перечисления.РежимыЗавершенияРаботыПользователей.ЗавершитьССохранениемДанныхПользователей);
		
	ИначеЕсли ТекущийРежимЗавершения = Перечисления.РежимыЗавершенияРаботыПользователей.ЗавершитьССохранениемДанныхПользователей Тогда
		Константы.РежимЗавершенияРаботыПользователей.Установить(Перечисления.РежимыЗавершенияРаботыПользователей.ПрекратитьРаботуБезусловно);
		
	ИначеЕсли ТекущийРежимЗавершения = Перечисления.РежимыЗавершенияРаботыПользователей.ПрекратитьРаботуБезусловно Тогда
		
		
		ОтключитьОбработчикОжидания("ЗавершитьРаботуПользователей");
		
		ПодстрокиСтрокиСоединения = ОбщегоНазначения.РазложитьСтрокуВМассивПодстрок(СтрокаСоединенияИнформационнойБазы(),";");
		
		Если (ПодстрокиСтрокиСоединения.Количество() > 1) И (Лев(ПодстрокиСтрокиСоединения[0], 5) = "Srvr=") И (Лев(ПодстрокиСтрокиСоединения[1], 4) = "Ref=") Тогда
			
			ИмяСервера = Сред(ПодстрокиСтрокиСоединения[0],7, СтрДлина(ПодстрокиСтрокиСоединения[0]) - 7);
			ИмяИБ      = Сред(ПодстрокиСтрокиСоединения[1],6, СтрДлина(ПодстрокиСтрокиСоединения[1]) - 6);
			
			Попытка
				connector = Новый COMОбъект("V8.ComConnector");
				server = connector.ConnectServer(ИмяСервера);
				
				ПодстрокиПараметровЗапуска = ОбщегоНазначения.РазложитьСтрокуВМассивПодстрок(ПараметрЗапуска,";");
				Если (ПодстрокиПараметровЗапуска.Количество() > 2) И (Врег(ПодстрокиПараметровЗапуска[0]) = Врег("ЗавершитьРаботуПользователей")) Тогда
					server.AddAuthentication(ПодстрокиПараметровЗапуска[1], ПодстрокиПараметровЗапуска[2]);
				КонецЕсли;
				
				ibDesc = server.CreateInfoBaseInfo();
				ibDesc.Name = ИмяИБ;
				connections = server.GetIBConnections(ibDesc);
				
				Для Каждого connection Из connections Цикл
					
					Если (Не ИмяПользователя() = connection.userName) Тогда
						server.Disconnect(connection);
					КонецЕсли; 
					
				КонецЦикла;
			Исключение
				ОбщегоНазначения.СообщитьОбОшибке(ОписаниеОшибки());
			КонецПопытки; 
			
		КонецЕсли;
		
		Соединения = ПолучитьСоединенияИнформационнойБазы();
		Если (Соединения.Количество() > 1) Тогда
			
			Сообщение = "Не удалось завершить работу пользователей:";
			
			Для Каждого Соединение Из Соединения Цикл
				Если (Не Соединение.НомерСоединения = НомерСоединенияИнформационнойБазы()) Тогда
					Сообщение = Сообщение + Символы.ПС + " - " + Соединение;
				КонецЕсли;
			КонецЦикла; 
			
			Сообщить(Сообщение, СтатусСообщения.Внимание);
			ЗаписьЖурналаРегистрации("Завершение работы пользователей", УровеньЖурналаРегистрации.Предупреждение, , , Сообщение);
		Иначе
			Сообщить("Завершение работы пользователей выполнено успешно.", СтатусСообщения.Информация);
		КонецЕсли;
		
		ЗавершитьРаботуСистемы(Ложь);
		Возврат;
		
	Иначе
		
		Константы.РежимЗавершенияРаботыПользователей.Установить(Перечисления.РежимыЗавершенияРаботыПользователей.ПредупредитьПользователейОЗавершенииРаботы);
		
	КонецЕсли;
	
	ТекущийРежимЗавершения = Константы.РежимЗавершенияРаботыПользователей.Получить();
	Сообщить("Установлен режим завершения работы пользователей «" + ТекущийРежимЗавершения + "».", СтатусСообщения.Внимание);
	
КонецПроцедуры

#КонецЕсли

Функция ОпределитьЭтаИнформационнаяБазаФайловая(СтрокаСоединенияСБД = "") Экспорт
	
	Если ПустаяСтрока(СтрокаСоединенияСБД) Тогда
		СтрокаСоединенияСБД = СтрокаСоединенияИнформационнойБазы();
	Иначе
		СтрокаСоединенияСБД = СтрокаСоединенияСБД;
	КонецЕсли;
		
	// В зависимости от того файловый это вариант БД или нет немного по-разному путь в БД формируется.
	ПозицияПоиска = Найти(Врег(СтрокаСоединенияСБД), "FILE=");
	
	Возврат (ПозицияПоиска = 1);	
	
КонецФункции


#Если Сервер И НЕ Клиент И НЕ ВнешнееСоединение Тогда

Функция глЗначениеПеременной(Имя) Экспорт	
	
	Кэш = ПараметрыСеанса.ОбщиеЗначения.Получить();
	КэшИзменен = Ложь;
	ПолученноеЗначение = ОбщегоНазначения.ПолучитьЗначениеПеременной(Имя, Кэш, КэшИзменен);
	
	//Если (КэшИзменен)и(Имя<>"глТекущийПользователь") Тогда
	Если КэшИзменен Тогда	
		ПараметрыСеанса.ОбщиеЗначения = Новый ХранилищеЗначения(Кэш);
	КонецЕсли;
	
	Возврат ПолученноеЗначение;          	
	
КонецФункции

// Процедура установки значения экспортных переменных модуля приложения
//
// Параметры
//  Имя - строка, содержит имя переменной целиком
// 	Значение - значение переменной
//
Процедура глЗначениеПеременнойУстановить(Имя, Значение, ОбновлятьВоВсехКэшах = Ложь) Экспорт
	
	Кэш = ПараметрыСеанса.ОбщиеЗначения.Получить();	
	ОбщегоНазначения.УстановитьЗначениеПеременной(Имя, Кэш, Значение);
	ПараметрыСеанса.ОбщиеЗначения = Новый ХранилищеЗначения(Кэш);	
	
КонецПроцедуры


#КонецЕсли
