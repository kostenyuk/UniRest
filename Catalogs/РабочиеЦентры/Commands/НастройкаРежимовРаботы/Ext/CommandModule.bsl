﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Если ЗначениеЗаполнено(ПараметрКоманды) Тогда
		ПараметрыФормы = Новый Структура("ВладелецПравДоступа", ПараметрКоманды);
		ОткрытьФорму("Справочник.РабочиеЦентры.Форма.ФормаНастройкиДоступа", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	КонецЕсли; 
	
КонецПроцедуры // ОбработкаКоманды()
