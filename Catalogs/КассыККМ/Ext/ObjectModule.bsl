﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	// Владелец.
	Если (Не ЗначениеЗаполнено(Владелец)) И (Не ЗначениеЗаполнено(ПолучитьСвойство(ДанныеЗаполнения, "Владелец"))) Тогда
		Владелец = Справочники.Организации.ОсновнаяОрганизация();
	КонецЕсли;
	
КонецПроцедуры // ОбработкаЗаполнения()
