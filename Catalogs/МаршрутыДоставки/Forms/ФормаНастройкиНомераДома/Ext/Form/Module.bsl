﻿
&НаКлиенте
Процедура ДиапазонПриИзменении(Элемент)
	
	Если Не Диапазон Тогда
		КонечныйНомерДома = Неопределено;
	КонецЕсли;
	
	// Настройка формы.
	Если Диапазон Тогда
		Элементы.ГруппаСтраници.ТекущаяСтраница = Элементы.ГруппаСтраницаДиапазон;
	Иначе
		Элементы.ГруппаСтраници.ТекущаяСтраница = Элементы.ГруппаСтраницаОтдельный;
	КонецЕсли; 
	
КонецПроцедуры // ПереключательОсновнойДиапазонПриИзменении()


&НаКлиенте
Процедура НачальныйНомерДомаПриИзменении(Элемент)
	
	НачальныйНомерДома = УправлениеКонтактнойИнформацией.ПривестиДомАдресаКШаблону(НачальныйНомерДома);
	
	НачальныйНомерДома = Макс(НачальныйНомерДома, "1");
	
	Если Не ПустаяСтрока(КонечныйНомерДома) Тогда
		УправлениеКонтактнойИнформацией.ПолучитьДомПоПредставлениюВнутреннему(Макс(УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДомаВнутреннее(НачальныйНомерДома), УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДомаВнутреннее(КонечныйНомерДома)), КонечныйНомерДома);
	КонецЕсли;
	
КонецПроцедуры // НачальныйНомерДомаПриИзменении()

&НаКлиенте
Процедура НачальныйНомерДомаОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	НачальныйНомерДома = "1";
	
	НачальныйНомерДомаПриИзменении(Элемент);
	
КонецПроцедуры // НачальныйНомерДомаОчистка()

&НаКлиенте
Процедура КонечныйНомерДомаПриИзменении(Элемент)

	КонечныйНомерДома = УправлениеКонтактнойИнформацией.ПривестиДомАдресаКШаблону(КонечныйНомерДома);

	Если Не ПустаяСтрока(КонечныйНомерДома) Тогда
		УправлениеКонтактнойИнформацией.ПолучитьДомПоПредставлениюВнутреннему(Мин(УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДомаВнутреннее(НачальныйНомерДома), УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДомаВнутреннее(КонечныйНомерДома)), НачальныйНомерДома);
	КонецЕсли;
	
КонецПроцедуры // КонечныйНомерДомаПриИзменении()


&НаКлиенте
Процедура OK(Кнопка)

	Параметры.НомераДомов.НачальныйДом = УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДомаВнутреннее(НачальныйНомерДома);
	Если Диапазон Тогда
		Параметры.НомераДомов.КонечныйДом = УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДомаВнутреннее(КонечныйНомерДома);
	Иначе
		Параметры.НомераДомов.КонечныйДом = Параметры.НомераДомов.НачальныйДом;
	КонецЕсли;
	Если Диапазон И (Не Параметры.НомераДомов.НачальныйДом = Параметры.НомераДомов.КонечныйДом) Тогда
		Параметры.НомераДомов.Представление = УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДома(НачальныйНомерДома) + " — " + УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДома(КонечныйНомерДома);
	Иначе	
		Параметры.НомераДомов.Представление = УправлениеКонтактнойИнформацией.ПолучитьПредставлениеДома(НачальныйНомерДома);
	КонецЕсли;
	
	Закрыть(Параметры.НомераДомов);
	
КонецПроцедуры // OK()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Диапазон = (Не Параметры.НомераДомов.НачальныйДом = Параметры.НомераДомов.КонечныйДом);
	УправлениеКонтактнойИнформацией.ПолучитьДомПоПредставлениюВнутреннему(Параметры.НомераДомов.НачальныйДом, НачальныйНомерДома);
	Если Диапазон Тогда
		УправлениеКонтактнойИнформацией.ПолучитьДомПоПредставлениюВнутреннему(Параметры.НомераДомов.КонечныйДом, КонечныйНомерДома);
	КонецЕсли;
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ДиапазонПриИзменении(Элементы.Диапазон);
	НачальныйНомерДомаПриИзменении(Элементы.НачальныйНомерДома);
	
КонецПроцедуры // ПриОткрытии()
