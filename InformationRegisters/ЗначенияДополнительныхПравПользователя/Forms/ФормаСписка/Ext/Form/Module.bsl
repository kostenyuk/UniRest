﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Список.Параметры.УстановитьЗначениеПараметра("РежимыРаботы", Метаданные.Справочники.РежимыРаботы.Синоним);
	Список.Параметры.УстановитьЗначениеПараметра("Пользователи", Метаданные.Справочники.Пользователи.Синоним);
	Список.Параметры.УстановитьЗначениеПараметра("ГруппыПользователей", Метаданные.Справочники.ГруппыПользователей.Синоним);
	Список.Параметры.УстановитьЗначениеПараметра("Неопределено", НСтр("ru = 'Неопределено'; uk = 'Невизначено'"));
	
КонецПроцедуры // ПриСозданииНаСервере()
