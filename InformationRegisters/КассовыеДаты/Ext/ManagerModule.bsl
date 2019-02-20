﻿
Функция ПолучитьДату(КассоваяДата) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запись = РегистрыСведений.КассовыеДаты.Получить(Новый Структура("КассоваяДата", КассоваяДата.Ссылка));
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустуюДату(Запись.Дата);
	
КонецФункции // ПолучитьДату()

Процедура УстановитьДату(КассоваяДата, Дата, Отказ) Экспорт
	
	Если Не Отказ Тогда
	
		УстановитьПривилегированныйРежим(Истина);

		Запись = РегистрыСведений.КассовыеДаты.СоздатьМенеджерЗаписи();
		Запись.КассоваяДата = КассоваяДата.Ссылка;
		Запись.Дата = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустуюДату(Дата);
			
		Попытка
			Запись.Записать(Истина);
		Исключение
			Отказ = Истина; // ERR.
			//ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), Отказ, ,, НаборЗаписей, Ссылка);
		КонецПопытки;
		
		УстановитьПривилегированныйРежим(Ложь);
	
	КонецЕсли;
	
КонецПроцедуры // УстановитьДату()


Функция ПолучитьПараметрыКассовойДаты(КассоваяДата) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запись = РегистрыСведений.КассовыеДаты.Получить(Новый Структура("КассоваяДата", КассоваяДата.Ссылка));
	Запись.Дата = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустуюДату(Запись.Дата);
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Запись;
	
КонецФункции // ПолучитьПараметрыКассовойДаты()
