﻿
Процедура ПроверитьВозможностьРаботыПользователяВРежимеЗавершенияРаботыПользователей(Отказ) Экспорт
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	РежимЗавершения = Константы.РежимЗавершенияРаботыПользователей.Получить();
	
	// Если право на изменение константы РежимЗавершенияРаботыПользователей отсутствует и
	// константа не позволяет работать - то в программу входить нельзя.
	Если Не ПравоДоступа("Изменение", Метаданные.Константы.РежимЗавершенияРаботыПользователей)
		 И (РежимЗавершения = Перечисления.РежимыЗавершенияРаботыПользователей.ПрекратитьРаботуБезусловно
		 Или РежимЗавершения = Перечисления.РежимыЗавершенияРаботыПользователей.ЗавершитьССохранениемДанныхПользователей) Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьКонтрольРежимаЗавершенияРаботыПользователей() Экспорт
	
	ТекущийРежим = Константы.РежимЗавершенияРаботыПользователей.Получить();
	
	Если РольДоступна("ПравоЗавершенияРаботыПользователей") Или ПравоДоступа("Изменение", Метаданные.Константы.РежимЗавершенияРаботыПользователей) И (Не ТекущийРежим = Перечисления.РежимыЗавершенияРаботыПользователей.РазрешитьРаботу) Тогда
		
		Если (Не ТекущийРежим = Перечисления.РежимыЗавершенияРаботыПользователей.РазрешитьРаботу) Тогда
			Если Не ЗначениеЗаполнено(ТекущийРежим) Тогда
				ТекстЛокализованый = НСтр("ru='Режим завершения работы пользователей не установлен.';uk='Режим завершення роботи користувачів не встановлено'");
				Сообщить(ТекстЛокализованый, СтатусСообщения.Внимание);
			Иначе
				ТекстЛокализованый = НСтр("ru='Установлен режим завершения работы пользователей «';uk='Встновлено режим завершення роботи користувачів «'");
				Сообщить(ТекстЛокализованый + ТекущийРежим + "».", СтатусСообщения.Внимание);
			КонецЕсли; 
		КонецЕсли; 
		
	Иначе
		
		КонтрольРежимаЗавершенияРаботыПользователей();
		ПодключитьОбработчикОжидания("КонтрольРежимаЗавершенияРаботыПользователей", 60);
		
	КонецЕсли; 
	
КонецПроцедуры

// Обработка параметров запуска программы.
//
Функция ОбработатьПараметрЗапуска() Экспорт
	
	// Есть ли параметры запуска.
	Если ПустаяСтрока(ПараметрЗапуска) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Различия в больших и маленьких буквах в параметрах нет.
	ЗначениеПараметраЗапуска = Врег(ОбщегоНазначения.РазложитьСтрокуВМассивПодстрок(ПараметрЗапуска,";")[0]);
	
	Если (ЗначениеПараметраЗапуска = Врег("РазрешитьРаботуПользователей")) Тогда
		
		Если Не ПравоДоступа("Изменение", Метаданные.Константы.РежимЗавершенияРаботыПользователей) Тогда
			ТекстЛокализованый = НСтр("ru='Параметр запуска не отработан. Нет прав на изменение состояния завершения работы пользователей.';uk='Не оброблено параметр запуску. Відсутні права на зміну стану завершення роботи користувачів'");
			Сообщить(ТекстЛокализованый, СтатусСообщения.Внимание);
			Возврат Ложь;
		КонецЕсли; 
		
		РазрешитьРаботу = Перечисления.РежимыЗавершенияРаботыПользователей.РазрешитьРаботу;
		
		Если (Не Константы.РежимЗавершенияРаботыПользователей.Получить() = РазрешитьРаботу) Тогда
			Константы.РежимЗавершенияРаботыПользователей.Установить(РазрешитьРаботу);
		КонецЕсли;
		
		ЗаписьЖурналаРегистрации("ОбработкаПараметраЗапуска", УровеньЖурналаРегистрации.Информация, , , ПараметрЗапуска);
		
		ЗавершитьРаботуСистемы(Ложь);
		Возврат Истина;
		
	ИначеЕсли ЗначениеПараметраЗапуска = Врег("ЗавершитьРаботуПользователей") Тогда
		
		Если Не ПравоДоступа("Изменение", Метаданные.Константы.РежимЗавершенияРаботыПользователей) Тогда
			ТекстЛокализованый = НСтр("ru='Параметр запуска не отработан. Нет прав на изменение состояния завершения работы пользователей.';uk='Не оброблено параметр запуску. Відсутні права на зміну стану завершення роботи користувачів'");
			Сообщить(ТекстЛокализованый, СтатусСообщения.Внимание);
			Возврат Ложь;
		КонецЕсли; 
		
		ЗаписьЖурналаРегистрации("ОбработкаПараметраЗапуска", УровеньЖурналаРегистрации.Информация, , , ПараметрЗапуска);
		
		ЗавершитьРаботуПользователей();
		ПодключитьОбработчикОжидания("ЗавершитьРаботуПользователей", 180);
		Возврат Истина;
	Иначе
		Сообщить(НСтр("ru='Указан неверный параметр запуска: ';uk='Вказано помилковий параметр запуску: '") + ПараметрЗапуска, СтатусСообщения.Внимание);
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции
