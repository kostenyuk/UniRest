﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Перем Параметры;
	
	Параметры = Новый Структура;
	Параметры.Вставить("Ключ", Запись.Документ);
	
	ОткрытьФорму("Документ.ЗаказПокупателя.ФормаОбъекта", Параметры, ВладелецФормы, Окно);
	
	Закрыть();
	
КонецПроцедуры // ПриОткрытии()
