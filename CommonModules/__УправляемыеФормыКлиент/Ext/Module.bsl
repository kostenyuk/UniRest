﻿

Функция ПолучитьОкно(Окно) Экспорт
	
	Если (Окно = Неопределено) Тогда
		Возврат ПолучитьОсновноеОкно();
	КонецЕсли; 
	
	Возврат Окно;
	
КонецФункции // ПолучитьОкно()
	
Функция ПолучитьОсновноеОкно() Экспорт
	
	Окна = ПолучитьОкна();
	Если (Окна = Неопределено) Тогда
		Возврат Неопределено;
	КонецЕсли; 
	
	Возврат Окна[0];
	
КонецФункции // ПолучитьОсновноеОкно()
