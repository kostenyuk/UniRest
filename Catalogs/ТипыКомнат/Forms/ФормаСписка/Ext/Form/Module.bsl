﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Управленчиский учет.
	ИспользоватьУправленческийУчет = ПолучитьФункциональнуюОпцию("ИспользоватьУправленческийУчет");

	// Режим выбора.
	__РаботаСДиалогамиКлиентСервер.ФормаРежимВыбора(ЭтаФорма, Элементы.Список, 
		"ГруппаКоличествоКлиентов,МаксимальноеКоличествоКлиентов");
	
КонецПроцедуры // ПриСозданииНаСервере()
