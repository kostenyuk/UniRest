﻿
// Функция проверяет строку на наличие значимых символов и если таковые имеются возвращает переданную ей дополнительную строку.
//
// Параметры:
//  ВыбСтрока – Строка. Строка для проверки;
//  ПризнакЗапятой – Булево, Строка. Дополнительная строка, возаращаемая в случае если проверяемая строка не пустая.
//	  Если в качестве дополнительной строки передана значение типа Булево Истина, дополнительная строка принимается равной 
//	  запятой и одному пробелу, а если Ложь то только пробелу.
//
// Возвращаемое значение:
//  Строка. Дополнительная строка или пустое значение строки.
//
Функция ПроверкаПустойСтроки(ВыбСтрока, ПризнакЗапятой = Истина) Экспорт
	
	Если ПустаяСтрока(ВыбСтрока) Тогда
		Возврат "";
	Иначе
		Если (ТипЗнч(ПризнакЗапятой) = Тип("Булево")) тогда
			Если ПризнакЗапятой Тогда
				Возврат ", ";
			Иначе
				Возврат " ";
			КонецЕсли;
		Иначе
			Возврат Строка(ПризнакЗапятой);
		КонецЕсли;
	КонецЕсли; 
	
КонецФункции // ПроверкаПустойСтроки()

// Функция возвращает только цифры из произвольной строки.
//
// Параметры:
//  ПроизвольнаяСтрока – Строка. Произвольная строка.
//
// Возвращаемое значение:
//  Строка. Строка содержащая только цифры одержащиеся исходной произвольной строки;
//	КоличествоЦифр - Число. Длина возвращаемой строки.
//
Функция ПолучитьТолькоЦифры(ПроизвольнаяСтрока, КоличествоЦифр = Неопределено) Экспорт
	
	ТолькоЦифры = "";
	Для Индекс = 1 По СтрДлина(ПроизвольнаяСтрока) Цикл
		Если Булево(СтрЧислоВхождений("1234567890", Сред(ПроизвольнаяСтрока, Индекс, 1))) Тогда
			ТолькоЦифры = ТолькоЦифры + Сред(ПроизвольнаяСтрока, Индекс, 1);
		КонецЕсли;
	КонецЦикла;
	
	КоличествоЦифр = СтрДлина(ТолькоЦифры);
	Возврат ТолькоЦифры;
	
КонецФункции // ПолучитьТолькоЦифры()

Функция ПолучитьТолькоЦифрыБезЛидирующихНулей(ПроизвольнаяСтрока) Экспорт
	
	ТолькоЦифры = "";
	Для Индекс = 1 По СтрДлина(ПроизвольнаяСтрока) Цикл
		Если ПустаяСтрока(ТолькоЦифры) Тогда
			Если Найти("123456789", Сред(ПроизвольнаяСтрока, Индекс, 1)) Тогда
				ТолькоЦифры = ТолькоЦифры + Сред(ПроизвольнаяСтрока, Индекс, 1);
			КонецЕсли;
		Иначе
			Если Найти("1234567890", Сред(ПроизвольнаяСтрока, Индекс, 1)) Тогда
				ТолькоЦифры = ТолькоЦифры + Сред(ПроизвольнаяСтрока, Индекс, 1);
			КонецЕсли;
		КонецЕсли
	КонецЦикла;
	
	КоличествоЦифр = СтрДлина(ТолькоЦифры);
	Возврат ТолькоЦифры;
	
КонецФункции // ПолучитьТолькоЦифрыБезЛидирующихНулей()



// Функция приводит код страны телефонного номера к единому формату.
//
// Параметры:
//  КодСтраныНомерТЛФ – Строка. Код страны телефонного номера, который надо преобразовывать.
//
// Возвращаемое значение:
//   Строка. Приведенный код страны телефонного номера.
//
Функция ПривестиКодСтраныНомераТелефонаКШаблону(КодСтраныНомерТЛФ) Экспорт
	
	Результат = ПолучитьТолькоЦифры(КодСтраныНомерТЛФ);
	Пока (Лев(Результат, 1) = "0") Цикл
		Результат = Сред(Результат, 2);
	КонецЦикла;
	Результат = Лев(Результат, 3);

	Возврат ПроверкаПустойСтроки(Результат, "+") + Результат;
	
КонецФункции // ПривестиКодСтраныНомераТелефонаКШаблону()

// Функция приводит код города телефонного номера к единому формату.
//
// Параметры:
//  КодГородаНомерТЛФ – Строка. Код города телефонного номера, который надо преобразовывать.
//
// Возвращаемое значение:
//   Строка. Приведенный код города телефонного номера.
//
Функция ПривестиКодГородаНомераТелефонаКШаблону(КодГородаНомерТЛФ) Экспорт
	
	Результат = ПолучитьТолькоЦифры(КодГородаНомерТЛФ);
	Пока (Лев(Результат, 1) = "0") Цикл
		Результат = Сред(Результат, 2);
	КонецЦикла;
	Результат = Лев(Результат, 4);

	Возврат Результат;
	
КонецФункции // ПривестиКодГородаНомераТелефонаКШаблону()

