﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ СО СТРОКАМИ

// Функция "расщепляет" строку на подстроки, используя заданный
//      разделитель. Разделитель может иметь любую длину.
//      Если в качестве разделителя задан пробел, рядом стоящие пробелы
//      считаются одним разделителем, а ведущие и хвостовые пробелы параметра Стр
//      игнорируются.
//      Например,
//      РазложитьСтрокуВМассивПодстрок(",один,,,два", ",") возвратит массив значений из пяти элементов,
//      три из которых - пустые строки, а
//      РазложитьСтрокуВМассивПодстрок(" один   два", " ") возвратит массив значений из двух элементов
//
//  Параметры:
//      Стр -           строка, которую необходимо разложить на подстроки.
//                      Параметр передается по значению.
//      Разделитель -   строка-разделитель, по умолчанию - запятая.
//
//  Возвращаемое значение:
//      массив значений, элементы которого - подстроки
//
Функция РазложитьСтрокуВМассивПодстрок(Знач Стр, Разделитель = ",") Экспорт
	
	МассивСтрок = Новый Массив();
	Если Разделитель = " " Тогда
		Стр = СокрЛП(Стр);
		Пока 1 = 1 Цикл
			Поз = Найти(Стр, Разделитель);
			Если Поз = 0 Тогда
				МассивСтрок.Добавить(Стр);
				Возврат МассивСтрок;
			КонецЕсли;
			МассивСтрок.Добавить(Лев(Стр, Поз - 1));
			Стр = СокрЛ(Сред(Стр, Поз));
		КонецЦикла;
	Иначе
		ДлинаРазделителя = СтрДлина(Разделитель);
		Пока 1 = 1 Цикл
			Поз = Найти(Стр, Разделитель);
			Если Поз = 0 Тогда
				Если (СокрЛП(Стр) <> "") Тогда
					МассивСтрок.Добавить(Стр);
				КонецЕсли;
				Возврат МассивСтрок;
			КонецЕсли;
			МассивСтрок.Добавить(Лев(Стр,Поз - 1));
			Стр = Сред(Стр, Поз + ДлинаРазделителя);
		КонецЦикла;
	КонецЕсли;
	
КонецФункции 

// Возвращает строку, полученную из массива элементов, разделенных символом разделителя
//
// Параметры:
//  Массив - Массив - массив элементов из которых необходимо получить строку
//  Разделитель - Строка - любой набор символов, который будет использован как разделитель между элементами в строке
//
// Возвращаемое значение:
//  Результат - Строка - строка, полученная из массива элементов, разделенных символом разделителя
// 
Функция ПолучитьСтрокуИзМассиваПодстрок(Массив, Разделитель = ",") Экспорт
	
	// возвращаемое значение функции
	Результат = "";
	
	Для Каждого Элемент ИЗ Массив Цикл
		
		Подстрока = ?(ТипЗнч(Элемент) = Тип("Строка"), Элемент, Строка(Элемент));
		
		РазделительПодстрок = ?(ПустаяСтрока(Результат), "", Разделитель);
		
		Результат = Результат + РазделительПодстрок + Подстрока;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Сравнить две строки версий.
//
// Параметры
//  СтрокаВерсии1  – Строка – номер версии в формате РР.{П|ПП}.ЗЗ.СС
//  СтрокаВерсии2  – Строка – второй сравниваемый номер версии
//
// Возвращаемое значение:
//   Число   – больше 0, если СтрокаВерсии1 > СтрокаВерсии2; 0, если версии равны.
//
Функция СравнитьВерсии(Знач СтрокаВерсии1, Знач СтрокаВерсии2) Экспорт
	
	Строка1 = ?(ПустаяСтрока(СтрокаВерсии1), "0.0.0.0", СтрокаВерсии1);
	Строка2 = ?(ПустаяСтрока(СтрокаВерсии2), "0.0.0.0", СтрокаВерсии2);
	Версия1 = РазложитьСтрокуВМассивПодстрок(Строка1, ".");
	Если Версия1.Количество() <> 4 Тогда
		ВызватьИсключение ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Неправильный формат строки версии: %1'"), СтрокаВерсии1);
	КонецЕсли;
	Версия2 = РазложитьСтрокуВМассивПодстрок(Строка2, ".");
	Если Версия2.Количество() <> 4 Тогда
		ВызватьИсключение ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Неправильный формат строки версии: %1'"), СтрокаВерсии2);
	КонецЕсли;
	
	Результат = 0;
	Для Разряд = 0 По 3 Цикл
		Результат = Число(Версия1[Разряд]) - Число(Версия2[Разряд]);
		Если Результат <> 0 Тогда
			Возврат Результат;
		КонецЕсли;
	КонецЦикла;
	Возврат Результат;
	
КонецФункции

// Подставляет параметры в строку. Максимально возможное число параметров - 9.
// Параметры в строке задаются как %<номер параметра>. Нумерация параметров
// начинается с единицы.
//
// Параметры
//  СтрокаПодстановки  – Строка – шаблон строки с параметрами (вхождениями вида "%ИмяПараметра").
// Параметр<n>         - Строка - параметр
// Возвращаемое значение:
//   Строка   – текстовая строка с подставленными параметрами
//
// Пример:
// Строка = ПодставитьПараметрыВСтроку(НСтр("ru='%1 пошел в %2'"), "Вася", "Зоопарк");
//
Функция ПодставитьПараметрыВСтроку(Знач СтрокаПодстановки,
	Знач Параметр1,	Знач Параметр2 = Неопределено, Знач Параметр3 = Неопределено,
	Знач Параметр4 = Неопределено, Знач Параметр5 = Неопределено, Знач Параметр6 = Неопределено,
	Знач Параметр7 = Неопределено, Знач Параметр8 = Неопределено, Знач Параметр9 = Неопределено) Экспорт
	
	Если СтрокаПодстановки = Неопределено ИЛИ СтрДлина(СтрокаПодстановки) = 0 Тогда
		Возврат "";
	КонецЕсли;
	
	Результат = "";
	НачПозиция = 1;
	Позиция = 1;
	Пока Позиция <= СтрДлина(СтрокаПодстановки) Цикл
		СимволСтроки = Сред(СтрокаПодстановки, Позиция, 1);
		Если СимволСтроки <> "%" Тогда
			Позиция = Позиция + 1;
			Продолжить;
		КонецЕсли;
		Результат = Результат + Сред(СтрокаПодстановки, НачПозиция, Позиция - НачПозиция);
		Позиция = Позиция + 1;
		СимволСтроки = Сред(СтрокаПодстановки, Позиция, 1);
		
		Если СимволСтроки = "%" Тогда
			Позиция = Позиция + 1;
			НачПозиция = Позиция;
			Продолжить;
		КонецЕсли;
		
		Попытка
			НомерПараметра = Число(СимволСтроки);
		Исключение
			ВызватьИсключение НСтр("ru='Входная строка СтрокаПодстановки имеет неверный формат: %'" + СимволСтроки);
		КонецПопытки;
		
		Если СимволСтроки = "1" Тогда
			ЗначениеПараметра = Параметр1;
		ИначеЕсли СимволСтроки = "2" Тогда
			ЗначениеПараметра = Параметр2;
		ИначеЕсли СимволСтроки = "3" Тогда
			ЗначениеПараметра = Параметр3;
		ИначеЕсли СимволСтроки = "4" Тогда
			ЗначениеПараметра = Параметр4;
		ИначеЕсли СимволСтроки = "5" Тогда
			ЗначениеПараметра = Параметр5;
		ИначеЕсли СимволСтроки = "6" Тогда
			ЗначениеПараметра = Параметр6;
		ИначеЕсли СимволСтроки = "7" Тогда
			ЗначениеПараметра = Параметр7;
		ИначеЕсли СимволСтроки = "8" Тогда
			ЗначениеПараметра = Параметр8;
		ИначеЕсли СимволСтроки = "9" Тогда
			ЗначениеПараметра = Параметр9;
		Иначе
			ВызватьИсключение НСтр("ru='Входная строка СтрокаПодстановки имеет неверный формат: %'" + ЗначениеПараметра);
		КонецЕсли;
		Если ЗначениеПараметра = Неопределено Тогда
			ЗначениеПараметра = "";
		Иначе
			ЗначениеПараметра = Строка(ЗначениеПараметра);
		КонецЕсли;
		Результат = Результат + ЗначениеПараметра;
		Позиция = Позиция + 1;
		НачПозиция = Позиция;
		
	КонецЦикла;
	
	Если (НачПозиция <= СтрДлина(СтрокаПодстановки)) Тогда
		Результат = Результат + Сред(СтрокаПодстановки, НачПозиция, СтрДлина(СтрокаПодстановки) - НачПозиция + 1);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Подставляет параметры в строку. Неограниченное число параметров в строке.
// Параметры в строке задаются как %<номер параметра>. Нумерация параметров
// начинается с единицы.
//
// Параметры
//  СтрокаПодстановки  – Строка – шаблон строки с параметрами (вхождениями вида "%1").
//  МассивПараметров   - Массив - массив строк, которые соответствуют параметрам в строке подстановки
//
// Возвращаемое значение:
//   Строка   – текстовая строка с подставленными параметрами
//
// Пример:
// МассивПараметров = Новый Массив;
// МассивПараметров = МассивПараметров.Добавить("Вася");
// МассивПараметров = МассивПараметров.Добавить("Зоопарк");
//
// Строка = ПодставитьПараметрыВСтроку(НСтр("ru='%1 пошел в %2'"), МассивПараметров);
//
Функция ПодставитьПараметрыВСтрокуИзМассива(Знач СтрокаПодстановки, Знач МассивПараметров) Экспорт
	
	СтрокаРезультата = СтрокаПодстановки;
	
	Для Индекс = 1 По МассивПараметров.Количество() Цикл
		Если Не ПустаяСтрока(МассивПараметров[Индекс-1]) Тогда
			СтрокаРезультата = СтрЗаменить(СтрокаРезультата, "%"+Строка(Индекс), МассивПараметров[Индекс-1]);
		КонецЕсли;
	КонецЦикла;
	
	Возврат СтрокаРезультата;
	
КонецФункции

// Проверяет содержит ли строка только цифры.
//
// Параметры:
//  СтрокаПроверки - строка для проверки.
//  УчитыватьЛидирующиеНули - Булево - нужно ли учитывать лидирующие нули.
//  УчитыватьПробелы - Булево - нужно ли учитывать пробелы.
//
// Возвращаемое значение:
//  Истина       - строка содержит только цифры;
//  Ложь         - строка содержит не только цифры.
//
Функция ТолькоЦифрыВСтроке(Знач СтрокаПроверки, Знач УчитыватьЛидирующиеНули = Истина, Знач УчитыватьПробелы = Истина) Экспорт
	
	Если ТипЗнч(СтрокаПроверки) <> Тип("Строка") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СтрокаПроверки) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если НЕ УчитыватьПробелы Тогда
		СтрокаПроверки = СтрЗаменить(СтрокаПроверки, " ", "");
	КонецЕсли;
	
	Если НЕ УчитыватьЛидирующиеНули Тогда
		НомерПервойЦифры = 0;
		Для а = 1 По СтрДлина(СтрокаПроверки) Цикл
			НомерПервойЦифры = НомерПервойЦифры + 1;
			КодСимвола = КодСимвола(Сред(СтрокаПроверки, а, 1));
			Если КодСимвола <> 48 Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
		СтрокаПроверки = Сред(СтрокаПроверки, НомерПервойЦифры);
	КонецЕсли;
	
	Для а = 1 По СтрДлина(СтрокаПроверки) Цикл
		КодСимвола = КодСимвола(Сред(СтрокаПроверки, а, 1));
		Если НЕ (КодСимвола >= 48 И КодСимвола <= 57) Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции // ТолькоЦифрыВСтроке()

// Удаляет двойные кавычки с начала и конца строки, если они есть.
//
// Параметры:
//  Строка       - входная строка;
//
// Возвращаемое значение:
//  Строка - строка без двойных кавычек.
// 
Функция СократитьДвойныеКавычки(Знач Строка) Экспорт
	
	Результат = Строка;
	Пока Найти(Результат, """") = 1 Цикл
		Результат = Сред(Результат, 2); 
	КонецЦикла; 
	Пока Найти(Результат, """") = СтрДлина(Результат) Цикл
		Результат = Сред(Результат, 1, СтрДлина(Результат) - 1); 
	КонецЦикла; 
	Возврат Результат;
	
КонецФункции 

// Процедура удаляет из строки указанное количество символов справа
//
Процедура УдалитьПоследнийСимволВСтроке(Текст, ЧислоСимволов) Экспорт
	
	Текст = Лев(Текст, СтрДлина(Текст) - ЧислоСимволов);
	
КонецПроцедуры 

// Находит символ в строке с конца
//
Функция НайтиСимволСКонца(Знач СтрокаВся, Знач ОдинСимвол) Экспорт
	
	НачальнаяПозиция = 1; 
	ДлинаСтроки = СтрДлина(СтрокаВся);
	
	Для ТекущаяПозиция = 1 По СтрДлина(СтрокаВся) Цикл
		РеальнаяПозиция = ДлинаСтроки - ТекущаяПозиция + 1;
		ТекущийСимвол = Сред(СтрокаВся, РеальнаяПозиция, 1);
		Если ТекущийСимвол = ОдинСимвол Тогда
			Возврат РеальнаяПозиция;
		КонецЕсли;
	КонецЦикла;
	
	Возврат 0;
	
КонецФункции

// Функция проверяет, является ли переданная в неё строка уникальным идентификатором
//
Функция ЭтоУникальныйИдентификатор(ИдентификаторСтрока) Экспорт
	
	УИСтрока = ИдентификаторСтрока;
	Шаблон = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
	
	Если СтрДлина(Шаблон) <> СтрДлина(УИСтрока) Тогда
		Возврат Ложь;
	КонецЕсли;
	Для Сч = 1 По СтрДлина(УИСтрока) Цикл
		Если КодСимвола(Шаблон, сч) = 88 И 
			((КодСимвола(УИСтрока, сч) < 48 ИЛИ КодСимвола(УИСтрока, сч) > 57) И (КодСимвола(УИСтрока, сч) < 97 или КодСимвола(УИСтрока, сч) > 102)) Тогда
			Возврат ложь; 
		ИначеЕсли КодСимвола(Шаблон, сч) = 45 И КодСимвола(УИСтрока, сч) <> 45 Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

// Формирует строку повторяющихся символов заданной длины
//
Функция СформироватьСтрокуСимволов(Символ, КоличествоСимволов) Экспорт
	
	// возвращаемое значение функции
	Результат = "";
	
	Для Индекс = 1 ПО КоличествоСимволов Цикл
		
		Результат = Результат + Символ;
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

// Дополняет переданную в качестве первого параметра строку символами слева\справа до заданной длины и возвращает ее
// Незначащие символы слева и справа удаляются
// По умолчанию функция добавляет строку нулями слева
//
// Параметры:
//  Строка      - Строка - исходная строка, которую необходимо дополнить символами до заданной длины
//  ДлинаСтроки - Число - требуемая конечная длина строки
//  Символ      - Строка - (необязательный) значение символа, которым необходимо дополнить строку
//  Режим       - Строка - (необязательный) [Слева|Справа] режим добавления символов к исходной строке: слева или справа
// 
// Пример 1:
// Строка = "1234"; ДлинаСтроки = 10; Символ = "0"; Режим = "Слева"
// Возврат: "0000001234"
//
// Пример 2:
// Строка = " 1234  "; ДлинаСтроки = 10; Символ = "#"; Режим = "Справа"
// Возврат: "1234######"
//
// Возвращаемое значение:
//  Строка - строка, дополненная символами слева или справа
//
Функция ДополнитьСтроку(Знач Строка, Знач ДлинаСтроки, Знач Символ = "0", Знач Режим = "Слева") Экспорт
	
	Если ПустаяСтрока(Символ) Тогда
		Символ = "0";
	КонецЕсли;
	
	// длина символа не должна превышать единицы
	Символ = Лев(Символ, 1);
	
	// удаляем крайние пробелы слева и справа строки
	Строка = СокрЛП(Строка);
	
	КоличествоСимволовНадоДобавить = ДлинаСтроки - СтрДлина(Строка);
	
	Если КоличествоСимволовНадоДобавить > 0 Тогда
		
		СтрокаДляДобавления = СформироватьСтрокуСимволов(Символ, КоличествоСимволовНадоДобавить);
		
		Если ВРег(Режим) = "СЛЕВА" Тогда
			
			Строка = СтрокаДляДобавления + Строка;
			
		ИначеЕсли ВРег(Режим) = "СПРАВА" Тогда
			
			Строка = Строка + СтрокаДляДобавления;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Строка;
	
КонецФункции

// Удаляет повторяющиеся символы слева/справа в переданной строке
//
// Параметры:
//  Строка      - Строка - исходная строка, из которой необходимо удалить повторяющиеся символы
//  Символ      - Строка - значение символа, который необходимо удалить
//  Режим       - Строка - (необязательный) [Слева|Справа] режим добавления символов к исходной строке: слева или справа
//
Функция УдалитьПовторяющиесяСимволы(Знач Строка, Знач Символ, Знач Режим = "Слева") Экспорт
	
	Если ВРег(Режим) = "СЛЕВА" Тогда
		
		Пока Лев(Строка, 1)= Символ Цикл
			
			Строка = Сред(Строка, 2);
			
		КонецЦикла;
		
	ИначеЕсли ВРег(Режим) = "СПРАВА" Тогда
		
		Пока Прав(Строка, 1)= Символ Цикл
			
			Строка = Лев(Строка, СтрДлина(Строка) - 1);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат Строка;
КонецФункции

// Получает номер версии конфигурации без номера сборки
//
// Параметры:
//  Версия - Строка - версия конфигурации в формате РР.ПП.ЗЗ.СС,
//                    где СС – номер сборки, который будет удален
// 
//  Возвращаемое значение:
//  Строка - номер версии конфигурации без номера сборки в формате РР.ПП.ЗЗ
//
Функция ВерсияКонфигурацииБезНомераСборки(Знач Версия) Экспорт
	
	Массив = РазложитьСтрокуВМассивПодстрок(Версия, ".");
	
	Если Массив.Количество() < 3 Тогда
		Возврат Версия;
	КонецЕсли;
	
	Результат = "[Редакция].[Подредакция].[Релиз]";
	Результат = СтрЗаменить(Результат, "[Редакция]",    Массив[0]);
	Результат = СтрЗаменить(Результат, "[Подредакция]", Массив[1]);
	Результат = СтрЗаменить(Результат, "[Релиз]",       Массив[2]);
	
	Возврат Результат;
КонецФункции

// Разбивает строку по разделителям и возвращает полученные строки в списке
// Параметры:
// СтрокаИсточник - строка, которую необходимо разделить
// Разделители - строка с символами - разделителями
// РРегистр - флаг учета регистра символов - разделителей (1 - учитывать, иначе - нет)
Функция РазделитьСтроку(Знач СтрокаИсточник, Разделители, РРегистр = Ложь) Экспорт
	
	Перем СписокСлов; // Список, в который будут помещаться полученные при разборе слова
	
	Перем ТекСимвол; // Текущий символ адреса на запчасти
	
	Перем СледРазделитель; // Номер следующего разделителя в адресе на запчасти
	
	Перем НайденноеСлово; // Найденное новое слово в адресе на запчасти
	
	Перем ФлагРазделителя; // Является ли следующий найденный символ разделителем
	
	
	// Инициализация переменных
	
	СписокСлов = Новый СписокЗначений;
	СледРазделитель = 0;
	СтрокаИсточник = СокрЛП(Строка(СтрокаИсточник));
	
	Пока СтрДлина(СокрЛП(СтрокаИсточник)) > 0 Цикл            
		
		// Считываем первый символ
		
		ТекСимвол = Лев(СтрокаИсточник, 1);
		
		// Сначала удалить стоящие в начале разделители
		
		Если РРегистр <> 1 Тогда
			Если Найти(Разделители, ТекСимвол) > 0 Тогда
				СтрокаИсточник = Прав(СтрокаИсточник, СтрДлина(СтрокаИсточник) - 1);
				Продолжить;
			КонецЕсли;       
		Иначе
			Если ((Найти(Разделители, ТекСимвол) > 0) ИЛИ (Найти(Разделители, НРег(ТекСимвол)) > 0) ИЛИ (Найти(Разделители, ВРег(ТекСимвол)) > 0)) Тогда
				СтрокаИсточник = Прав(СтрокаИсточник, СтрДлина(СтрокаИсточник) - 1);
				Продолжить;
			КонецЕсли;       
		КонецЕсли;    
		
		// Теперь ищется окончание слова
		
		СледРазделитель = 1;                                              
		ФлагРазделителя = Ложь;
		Пока Не ФлагРазделителя Цикл
			ТекСимвол = Сред(СтрокаИсточник, СледРазделитель, 1);
			Если РРегистр <> 1 Тогда
				Если Найти(Разделители, ТекСимвол) > 0 Тогда
					ФлагРазделителя = Истина;
				КонецЕсли;       
			Иначе
				Если ((Найти(Разделители, ТекСимвол) > 0) ИЛИ (Найти(Разделители, НРег(ТекСимвол)) > 0) ИЛИ (Найти(Разделители, ВРег(ТекСимвол)) > 0)) Тогда
					ФлагРазделителя = Истина;
				КонецЕсли;       
			КонецЕсли;    
			// Строка закончилась
			
			Если СтрДлина(СтрокаИсточник) = СледРазделитель Тогда
				СледРазделитель = СледРазделитель + 1;
				ФлагРазделителя = Истина;
			КонецЕсли;    
			СледРазделитель = СледРазделитель + 1;
		КонецЦикла;
		
		// Вырежем новое слово из исходной строки
		
		НайденноеСлово = Лев(СтрокаИсточник, СледРазделитель - 2);
		
		// Поместим его в список               
		
		СписокСлов.Добавить(НайденноеСлово, НайденноеСлово);
		
		// Обрезаем строку-источник
		
		СтрокаИсточник = Прав(СтрокаИсточник, СтрДлина(СтрокаИсточник) - СледРазделитель + 1);
		
	КонецЦикла;    
	
	// Возвратить результат
	
	Возврат СписокСлов;
	
КонецФункции

Функция ЗаменитьПодстроку(С, Знач ПодстрокаПоиска, Знач ПодстрокаЗамены, УчитыватьРегистр = ложь) Экспорт
	
	Если УчитыватьРегистр Тогда
		Позиция = Найти(С, ПодстрокаПоиска); 
	Иначе
		Позиция = Найти(нрег(С),нрег(ПодстрокаПоиска)); 
	КонецЕсли;
	Если Позиция = 0 тогда
		Возврат С;
	КонецЕсли;	
	//Заменяем
	Возврат  Лев(С, Позиция-1) + ПодстрокаЗамены + Сред(С, Позиция + СтрДлина(ПодстрокаПоиска)); 
	
КонецФункции

Функция НайтиСтрокуМежду(ИсхСтр, МаркерНачала, МаркерКонца, УчитыватьРегистр = ложь) Экспорт
	//	Сообщить(бфстроки.НайтиСтрокуМежду("абв","а","в")); //б
	//	Сообщить(бфстроки.НайтиСтрокуМежду("абв","а",""));  //бв
	//	Сообщить(бфстроки.НайтиСтрокуМежду("абв","","б"));  //а
	
	Перем С;
	
	С=ИсхСтр;
	Если МаркерНачала = "" Тогда
		Поз1 = 1;
	Иначе
		Поз1 = СтроковыеФункцииКлиентСервер.НайтиПодстроку(С, МаркерНачала ,,, УчитыватьРегистр);
		Если Поз1=0 Тогда
			Возврат "";
		КонецЕсли;
	КонецЕсли;
	
	Начало=Лев(С, Поз1-1);
	Хвост=Сред(С, Поз1+СтрДлина(МаркерНачала));
	Если МаркерКонца = "" Тогда
		Поз2 = СтрДлина(Хвост) + 1;
	Иначе
		Поз2 = СтроковыеФункцииКлиентСервер.НайтиПодстроку(Хвост, МаркерКонца,,, УчитыватьРегистр);
		Если Поз2=0 Тогда
			Возврат "";
		КонецЕсли;
	КонецЕсли;
	Середина=Лев(Хвост, Поз2-1);
	Возврат Середина;
КонецФункции

Функция НайтиПодстроку(Знач Строка, Знач ПодстрокаПоиска, НачальнаяПозиция=1, НомерВхождения=1, УчитыватьРегистр = ложь) Экспорт
	//Назначение: Продвинутый поиск в строке 
	
	Если НЕ УчитыватьРегистр Тогда
		Строка=ВРег(Строка);
		ПодстрокаПоиска=ВРег(ПодстрокаПоиска);
	КонецЕсли;
	Строка=Сред(Строка, НачальнаяПозиция); //Обрезаем по позиции
	
	ДлинаСтрокиПоиска=СтрДлина(ПодстрокаПоиска);
	
	ТекНомерВхождения=1;
	ТекПозиция=0;
	БылиВхождения=0;
	Пока истина Цикл
		Иск=Найти(Строка, ПодстрокаПоиска);
		Если Иск=0 Тогда
			Если БылиВхождения=0 Тогда
				Возврат 0;
			Иначе
				Если НомерВхождения=0 Тогда
					Возврат БылиВхождения; //Последнее вхождение
				Иначе
					Возврат 0;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		БылиВхождения=ТекПозиция+Иск; //Запоминаем вхождение
		
		//Смотрим, какое по счету вхождение
		Если ТекНомерВхождения=НомерВхождения Тогда
			Возврат БылиВхождения;
		Иначе
			ТекНомерВхождения=ТекНомерВхождения+1;
			Если Строка="" Тогда
				Возврат 0;
			КонецЕсли;
			Строка=Сред(Строка, Иск+ДлинаСтрокиПоиска);
			ТекПозиция=ТекПозиция+ДлинаСтрокиПоиска;
		КонецЕсли;
	КонецЦикла;
	
	Возврат 0;
	
КонецФункции

