﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Параметры.
	Список.Параметры.УстановитьЗначениеПараметра("ТекущаяДата", ТекущаяДата());
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриПовторномОткрытии()

	// Параметры.
	Список.Параметры.УстановитьЗначениеПараметра("ТекущаяДата", ТекущаяДата());
	
КонецПроцедуры // ПриПовторномОткрытии()
