﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Если ЗначениеЗаполнено(ПараметрКоманды) Тогда
		ПараметрыФормы = Новый Структура("ОбъектИспользования", ПараметрКоманды);
		ОткрытьФорму("Справочник.РабочиеЦентры.Форма.ФормаНастройкиПравил", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	КонецЕсли; 
	
КонецПроцедуры // ОбработкаКоманды()
