﻿
//Процедура НоменклатураНачалоВыбораКлиент(Объект, СписокОтбора = Неопределено , )
//	
//	Если СписокОтбора = Неопределено Тогда
//	 	
//	 КонецЕсли;
//	
//	Список = ЗаполнитьСписокОтбора();
//	НоваяФорма = ПолучитьФорму("Справочник.Номенклатура.Форма.ФормаВыбора");
//	ОтборыСписковКлиентСервер.УстановитьЭлементОтбораСписка(НоваяФорма.Список,"Ссылка", Список, ВидСравненияКомпоновкиДанных.ВСписке);
//	Объект.Номенклатура = НоваяФорма.ОткрытьМодально();
//	Объект.Наименование= ПолучитьНаименование(Объект.Номенклатура);	
//	
//КонецПроцедуры

//Функция ЗаполнитьСписокОтбора(СписокОтбора)
//	
//	Возврат  УправлениеНоменклатуройСервер.ПолучитьСписокОтборНоменклатурыДляМодификаторовИУсловий("УсловияНоменклатуры", СписокОтбора);
//	
//КонецФункции 
