﻿
Функция НомерМесяцаГода(МесяцГода) Экспорт
	
	// Метаданные не используются намеренно.
	Если (МесяцГода = Перечисления.МесяцаГода.Январь) Тогда
		Возврат 1;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Февраль) Тогда
		Возврат 2;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Март) Тогда
		Возврат 3;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Апрель) Тогда
		Возврат 4;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Май) Тогда
		Возврат 5;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Июнь) Тогда
		Возврат 6;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Июль) Тогда
		Возврат 7;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Август) Тогда
		Возврат 8;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Сентябрь) Тогда
		Возврат 9;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Октябрь) Тогда
		Возврат 10;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Ноябрь) Тогда
		Возврат 11;
	КонецЕсли; 
	Если (МесяцГода = Перечисления.МесяцаГода.Декабрь) Тогда
		Возврат 12;
	КонецЕсли; 

	Возврат 0;

КонецФункции // НомерДняНедели()
 