﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Источник 		= ПараметрыВыполненияКоманды.Источник;
	ИмяОбъекта 		= Источник.Список.ОсновнаяТаблица;
	ОсновнаяТаблица = СтрЗаменить(Источник.Список.ОсновнаяТаблица, "Справочник.", "");
	
	Если ОсновнаяТаблица = "Меню" Тогда
		Владелец = Источник.Владелец;
	Иначе
		Владелец = Неопределено;
	КонецЕсли;
	
	Параметры = Новый Структура;
	Параметры.Вставить("Владелец"	, Владелец);
	Параметры.Вставить("ИмяОбъекта"	, ИмяОбъекта);
	
	ОткрытьФорму("РегистрСведений.НастройкаАктуальности.Форма.ФормаСохраненияНастроек", Параметры, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры
