﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура("Отбор", Новый Структура("Модуль", ПредопределенноеЗначение("Перечисление.МодулиИПодсистемы.Доставка")));
	ОткрытьФорму("Документ.РеализацияТоваровУслуг.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, Строка(ПараметрыВыполненияКоманды.Уникальность) + "-Доставка", ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры // ОбработкаКоманды()
