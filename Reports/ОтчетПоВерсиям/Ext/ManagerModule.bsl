﻿
// Описание дополнитльеных настроек отчета
// В данной процедуре можно задать описания варинатов отчетов, опредлить дополнительные варианты,
// определить дополнительные разделы варианта отчета
//
Процедура НастройкиОтчета(Настройки) Экспорт

	//Описание вариантов отчетов
	ВариантыОтчетов.УстановитьОписаниеВариантаВДопНастройках(Настройки, "_СсылкаНаОтчет", "");

	//Дополнительные подсистемы
	//ВариантыОтчетов.ДобавитьПодсистемуВариантаВДопНастройках(Настройки, "Ключварианта", "Подсистема\ПодчиненнаяПодсистема");
	//ВариантыОтчетов.УдалитьПодсистемуВариантаВДопНастройках(Настройки, "Ключварианта", "Подсистема\ПодчиненнаяПодсистема");

КонецПроцедуры
