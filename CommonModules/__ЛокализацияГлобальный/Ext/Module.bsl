﻿
Функция Шаблон(Строка, Параметры) Экспорт
	
	Результат = Строка;
		
	Для Каждого Параметр Из Параметры Цикл
		Результат = СтрЗаменить(Результат, "[" + Параметр.Ключ + "]", Строка(Параметр.Значение));
		Результат = СтрЗаменить(Результат, "%" + Параметр.Ключ + "%", Строка(Параметр.Значение));
	КонецЦикла;

	Возврат Результат;
	
КонецФункции // Шаблон()

Функция Кавычки(Строка) Экспорт
	
	Возврат """" + Строка + """";
	
КонецФункции // Кавычки()
