﻿
&НаКлиенте
//Костенюк Александр-Старт 07.06.2012
Процедура УстановитьИнтервал(Команда)
	
	ПараметрыПериода = Новый Структура;
	ПараметрыПериода.Вставить("ДатаНачала", 		Объект.ДатаНач);
	ПараметрыПериода.Вставить("ДатаОкончания", 		Объект.ДатаКон);
	ПараметрыПериода.Вставить("ИнтервалПериод", Истина);	
	
	РедактированиеПериода = ПолучитьФорму("ОбщаяФорма.РедактированиеПериода", ПараметрыПериода, ЭтаФорма);
	
	Если РедактированиеПериода.Открыта() Тогда
		РедактированиеПериода.Активизировать();
	Иначе
		РедактированиеПериода.Открыть();
	КонецЕсли;
	
КонецПроцедуры
//Костенюк Александр-Финиш 07.06.2012

&НаКлиенте
//Костенюк Александр-Старт 08.06.2012
Процедура ВыполнитьОбработку(Команда)
	
	КодРесторана = ПолучитьКодРесторана();
	
	Если НЕ ЗначениеЗаполнено(КодРесторана) Тогда
		ТекстСообщения = НСтр("ru='Не заполнена константа ';uk='Не заповнена константа '"+""""+"Код ресторана"+""""+". "+"ru='Выгрузка невозможна!';uk='Вивантаження неможливо!'");
		Сообщить(ТекстСообщения, СтатусСообщения.Важное);
		Возврат;
	КонецЕсли;
	
	ВыполнитьОбработкуНаСервере();
	
КонецПроцедуры
//Костенюк Александр-Финиш 08.06.2012

&НаСервере
//Костенюк Александр-Старт 08.06.2012
Процедура ВыполнитьОбработкуНаСервере()
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ВыполнитьВыгрузку();
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");
КонецПроцедуры
//Костенюк Александр-Финиш 08.06.2012

&НаКлиенте
//Костенюк Александр-Старт 11.06.2012
Процедура ПриОткрытии(Отказ)
	Объект.ДатаНач 			= НачалоМесяца(ТекущаяДата());
	Объект.ДатаКон 			= ТекущаяДата();
	Объект.ВыгружатьЧеки 	= Истина;
	Объект.ВыгружатьСС 		= Истина;
	Элементы.ИнтернетАдресСтрока.Заголовок = СокрЛП(ПолучитьИнтернетАдресДляОбменаДанными());
	Элементы.КаталогОбменаСтрока.Заголовок = СокрЛП(ПолучитьКаталогОбмена());
КонецПроцедуры
//Костенюк Александр-Финиш 11.06.2012

&НаКлиенте
//Костенюк Александр-Старт 11.06.2012
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ПериодИзменен" Тогда
		Объект.ДатаНач = Параметр.ДатаНачала;
		Объект.ДатаКон = КонецДня(Параметр.ДатаОкончания);
	КонецЕсли;
КонецПроцедуры
//Костенюк Александр-Финиш 11.06.2012

&НаСервере
//Костенюк Александр-Старт 14.01.2013
Функция ПолучитьКодРесторана()
	Возврат Константы.КодРесторана.Получить();
КонецФункции
//Костенюк Александр-Финиш 14.01.2013

&НаСервере
//Костенюк Александр-Старт 14.01.2013
Функция ПолучитьИнтернетАдресДляОбменаДанными()
	Возврат Константы.ИнтернетАдресДляОбменаДаннымиПоПротоколуHTTP.Получить();
КонецФункции
//Костенюк Александр-Финиш 14.01.2013

&НаСервере
//Костенюк Александр-Старт 14.01.2013
Функция ПолучитьКаталогОбмена()
	Возврат Константы.КаталогОбмена.Получить();
КонецФункции
//Костенюк Александр-Финиш 14.01.2013

	