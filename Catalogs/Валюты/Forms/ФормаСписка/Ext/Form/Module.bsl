﻿
&НаКлиенте
Процедура Подбор(Команда)
	
	ОткрытьФорму("Справочник.Валюты.Форма.ФормаПодбора", , Элементы.Список);
	
КонецПроцедуры // Подбор()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Режим выбора.
	__РаботаСДиалогамиКлиентСервер.ФормаРежимВыбора(ЭтаФорма, Элементы.Список,
		"Подбор, НаименованиеПолное");
	
КонецПроцедуры // ПриСозданииНаСервере()
