﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	РедактируемыйСписок = Параметры.РедактируемыйСписок;
	ОтбираемыеПараметры = Параметры.ОтбираемыеПараметры;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьПараметрыРедактора(РедактируемыйСписок, ОтбираемыеПараметры);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ПометкаПриИзменении(Элемент)
	ОтметитьЭлементДерева(Элементы.Список.ТекущиеДанные, Элементы.Список.ТекущиеДанные.Пометка);
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ВыбратьСоставОтбора(Команда)
	
	Оповестить("ВыборЗначенийЭлементовОтбораЖурналаРегистрации",
	           ПолучитьОтредактированныйСписок(),
	           ВладелецФормы);
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВсеФлажки()
	УстановкаПометок(Истина);
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсеФлажки()
	УстановкаПометок(Ложь);
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиенте
Процедура УстановитьПараметрыРедактора(РедактируемыйСписок, ОтбираемыеПараметры)
	СтруктураПараметровОтбора = ПолучитьЗначенияОтбораЖурналаРегистрацииПоКолонке(ОтбираемыеПараметры);
	ЗначенияОтбора = СтруктураПараметровОтбора[ОтбираемыеПараметры];
	// Получение списка представлений событий
	Если ОтбираемыеПараметры = "Событие" Или ОтбираемыеПараметры = "Event" Тогда
		
		Для Каждого ЭлементСоответствия Из ЗначенияОтбора Цикл
			СтрокаПредставленияСобытий = ПредставленияСобытий.Добавить();
			СтрокаПредставленияСобытий.Представление = ЭлементСоответствия.Значение;
		КонецЦикла;
		
	КонецЕсли;
	
	Если ТипЗнч(ЗначенияОтбора) = Тип("Массив") Тогда
		ЭлементыСписка = Список.ПолучитьЭлементы();
		Для Каждого ЭлементМассива Из ЗначенияОтбора Цикл
			НовыйЭлемент = ЭлементыСписка.Добавить();
			НовыйЭлемент.Пометка = Ложь;
			НовыйЭлемент.Значение = ЭлементМассива;
			НовыйЭлемент.Представление = ЭлементМассива;
		КонецЦикла;
	ИначеЕсли ТипЗнч(ЗначенияОтбора) = Тип("Соответствие") Тогда
		
		Если ОтбираемыеПараметры = "Событие" Или ОтбираемыеПараметры = "Event" Или
			 ОтбираемыеПараметры = "Метаданные" Или ОтбираемыеПараметры = "Metadata" Тогда 
			// Грузим как дерево
			Для Каждого ЭлементСоответствия Из ЗначенияОтбора Цикл
				ПараметрыОтбораСобытий = Новый Структура("Представление", ЭлементСоответствия.Значение);
				
				Если ЭлементСоответствия.Ключ = ЭлементСоответствия.Значение
					И ПредставленияСобытий.НайтиСтроки(ПараметрыОтбораСобытий).Количество() > 1 Тогда
					ПользовательскиеСобытия.Добавить(ЭлементСоответствия.Ключ, ЭлементСоответствия.Значение);
					Продолжить;
				КонецЕсли;
				
				НовыйЭлемент = ПолучитьВетвьДерева(ЭлементСоответствия.Значение);
				НовыйЭлемент.Пометка = Ложь;
				НовыйЭлемент.Значение = ЭлементСоответствия.Ключ;
				НовыйЭлемент.ПолноеПредставление = ЭлементСоответствия.Значение;
			КонецЦикла;
			
		Иначе 
			// Грузим плоским списком
			ЭлементыСписка = Список.ПолучитьЭлементы();
			Для Каждого ЭлементСоответствия Из ЗначенияОтбора Цикл
				НовыйЭлемент = ЭлементыСписка.Добавить();
				НовыйЭлемент.Пометка = Ложь;
				НовыйЭлемент.Значение = ЭлементСоответствия.Ключ;
				
				Если (ОтбираемыеПараметры = "Пользователь" Или ОтбираемыеПараметры = "User") Тогда
					// Для пользователей ключем служит имя
					НовыйЭлемент.Значение = ЭлементСоответствия.Значение;
					НовыйЭлемент.Представление = ЭлементСоответствия.Значение;
					НовыйЭлемент.ПолноеПредставление = ЭлементСоответствия.Значение;
					
					Если НовыйЭлемент.Значение = "" Тогда
						// Случай для пользователя по умолчанию
						НовыйЭлемент.Значение = "";
						НовыйЭлемент.ПолноеПредставление = ПолноеИмяНеУказанногоПользователя();
						НовыйЭлемент.Представление = ПолноеИмяНеУказанногоПользователя();
					КонецЕсли;
					
				Иначе
					НовыйЭлемент.Представление = ЭлементСоответствия.Значение;
					НовыйЭлемент.ПолноеПредставление = ЭлементСоответствия.Значение;
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
	// Помечаем элементы дерева, если им есть соотвествие в РедактируемыйСписок
	ОтметитьВстречающиесяЭлементы(Список.ПолучитьЭлементы(), РедактируемыйСписок);
	
	// проверяем список на наличие подчиненных элементов, если их нет,
	// переводим ЭУ в режим Списка
	ЭтоДерево = Ложь;
	Для Каждого ЭлементДерева Из Список.ПолучитьЭлементы() Цикл
		Если ЭлементДерева.ПолучитьЭлементы().Количество() > 0 Тогда 
			ЭтоДерево = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Если Не ЭтоДерево Тогда
		Элементы.Список.Отображение = ОтображениеТаблицы.Список;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ПолучитьОтредактированныйСписок()
	
	РедактируемыйСписок = Новый СписокЗначений;
	
	РедактируемыйСписок.Очистить();
	ЕстьНеотмеченные = Ложь;
	ПолучитьСписокПоддерева(РедактируемыйСписок, Список.ПолучитьЭлементы(), ЕстьНеотмеченные);
	ДобавитьПользовательскиеСобытия();
	
	Возврат РедактируемыйСписок;
	
КонецФункции

&НаКлиенте
Процедура ДобавитьПользовательскиеСобытия()
	
	Для Каждого Событие Из ПользовательскиеСобытия Цикл
		РедактируемыйСписок.Добавить(Событие.Значение, Событие.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьВетвьДерева(Представление)
	СтрокиПути = РазложитьСтрокуПоТочкам(Представление);
	Если СтрокиПути.Количество() = 1 Тогда
		ЭлементыДерева = Список.ПолучитьЭлементы();
		ИмяВетки = СтрокиПути[0];
	Иначе
		// Собираем путь к ветке родителя из фрагментов пути
		ПредставлениеПутиРодителя = "";
		Для Сч = 0 По СтрокиПути.Количество() - 2 Цикл
			Если Не ПустаяСтрока(ПредставлениеПутиРодителя) Тогда
				ПредставлениеПутиРодителя = ПредставлениеПутиРодителя + ".";
			КонецЕсли;
			ПредставлениеПутиРодителя = ПредставлениеПутиРодителя + СтрокиПути[Сч];
		КонецЦикла;
		ЭлементыДерева = ПолучитьВетвьДерева(ПредставлениеПутиРодителя).ПолучитьЭлементы();
		ИмяВетки = СтрокиПути[СтрокиПути.Количество() - 1];
	КонецЕсли;
	
	Для Каждого ЭлементДерева Из ЭлементыДерева Цикл
		Если ЭлементДерева.Представление = ИмяВетки Тогда
			Возврат ЭлементДерева;
		КонецЕсли;
	КонецЦикла;
	// Не нашли, придется создавать
	ЭлементДерева = ЭлементыДерева.Добавить();
	ЭлементДерева.Представление = ИмяВетки;
	ЭлементДерева.Пометка = Ложь;
	Возврат ЭлементДерева;
КонецФункции

// Функция раскладывает строку в массив строк, используя точку как разделитель
&НаКлиенте
Функция РазложитьСтрокуПоТочкам(Знач Представление)
	Фрагменты = Новый Массив;
	Пока Истина Цикл
		Представление = СокрЛП(Представление);
		ПозицияТочки = Найти(Представление, ".");
		Если ПозицияТочки > 0 Тогда
			Фрагмент = СокрЛП(Лев(Представление, ПозицияТочки - 1));
			Фрагменты.Добавить(Фрагмент);
			Представление = Сред(Представление, ПозицияТочки + 1);
		Иначе
			Фрагменты.Добавить(СокрЛП(Представление));
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Возврат Фрагменты;
КонецФункции

&НаСервере
Функция ПолучитьЗначенияОтбораЖурналаРегистрацииПоКолонке(ОтбираемыеПараметры)
	Возврат ПолучитьЗначенияОтбораЖурналаРегистрации(ОтбираемыеПараметры);
КонецФункции

&НаКлиенте
Процедура ПолучитьСписокПоддерева(РедактируемыйСписок, ЭлементыДерева, ЕстьНеотмеченные)
	Для Каждого ЭлементДерева Из ЭлементыДерева Цикл
		Если ЭлементДерева.ПолучитьЭлементы().Количество() <> 0 Тогда
			ПолучитьСписокПоддерева(РедактируемыйСписок, ЭлементДерева.ПолучитьЭлементы(), ЕстьНеотмеченные);
		Иначе
			Если ЭлементДерева.Пометка Тогда
				НовыйЭлементСписка = РедактируемыйСписок.Добавить();
				НовыйЭлементСписка.Значение      = ЭлементДерева.Значение;
				НовыйЭлементСписка.Представление = ЭлементДерева.ПолноеПредставление;
			Иначе
				ЕстьНеотмеченные = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВстречающиесяЭлементы(ЭлементыДерева, РедактируемыйСписок)
	
	Для Каждого ЭлементДерева Из ЭлементыДерева Цикл
		
		Если ЭлементДерева.ПолучитьЭлементы().Количество() <> 0 Тогда 
			ОтметитьВстречающиесяЭлементы(ЭлементДерева.ПолучитьЭлементы(), РедактируемыйСписок);
		Иначе
			
			Для Каждого ЭлементСписка Из РедактируемыйСписок Цикл
				
				Если ЭлементДерева.ПолноеПредставление = ЭлементСписка.Представление Тогда
					ОтметитьЭлементДерева(ЭлементДерева, Истина);
					Прервать;
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьЭлементДерева(ЭлементДерева, Пометка, ПроверятьСостояниеРодителя = Истина)
	ЭлементДерева.Пометка = Пометка;
	// Отметить все подчиненные элементы дерева
	Для Каждого ПодчиненныйЭлементДерева Из ЭлементДерева.ПолучитьЭлементы() Цикл
		ОтметитьЭлементДерева(ПодчиненныйЭлементДерева, Пометка, Ложь);
	КонецЦикла;
	// Проверить, не должно ли измениться состояние родителя
	Если ПроверятьСостояниеРодителя Тогда
		ПроверитьСостояниеПометкиВетви(ЭлементДерева.ПолучитьРодителя());
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСостояниеПометкиВетви(Ветвь)
	Если Ветвь = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	ПодчиненныеВетви = Ветвь.ПолучитьЭлементы();
	Если ПодчиненныеВетви.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ЕстьИстина = Ложь;
	ЕстьЛожь = Ложь;
	Для Каждого ПодчиненнаяВетвь Из ПодчиненныеВетви Цикл
		Если ПодчиненнаяВетвь.Пометка Тогда
			ЕстьИстина = Истина;
			Если ЕстьЛожь Тогда
				Прервать;
			КонецЕсли;
		Иначе
			ЕстьЛожь = Истина;
			Если ЕстьИстина Тогда
				Прервать;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если ЕстьИстина Тогда
		Если ЕстьЛожь Тогда
			// есть и помеченные и непомеченные, у себя при необходимости ставим непомечено и проверяем родителя
			Если Ветвь.Пометка Тогда
				Ветвь.Пометка = Ложь;
				ПроверитьСостояниеПометкиВетви(Ветвь.ПолучитьРодителя());
			КонецЕсли;
		Иначе
			// Все подчиненные помечены
			Если Не Ветвь.Пометка Тогда
				Ветвь.Пометка = Истина;
				ПроверитьСостояниеПометкиВетви(Ветвь.ПолучитьРодителя());
			КонецЕсли;
		КонецЕсли;
	Иначе
		// все подчиненные непомечены
		Если Ветвь.Пометка Тогда
			Ветвь.Пометка = Ложь;
			ПроверитьСостояниеПометкиВетви(Ветвь.ПолучитьРодителя());
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция СобратьПредставление(ЭлементДерева)
	Если ЭлементДерева = Неопределено Тогда 
		Возврат "";
	КонецЕсли;
	Если ЭлементДерева.ПолучитьРодителя() = Неопределено Тогда
		Возврат ЭлементДерева.Представление;
	КонецЕсли;
	Возврат СобратьПредставление(ЭлементДерева.ПолучитьРодителя()) + "." + ЭлементДерева.Представление;
КонецФункции

&НаКлиенте
Процедура УстановкаПометок(Значение)
	Для Каждого ЭлементДерева Из Список.ПолучитьЭлементы() Цикл
		ОтметитьЭлементДерева(ЭлементДерева, Значение, Ложь);
	КонецЦикла;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолноеИмяНеУказанногоПользователя()
	
	Возврат Пользователи.ПолноеИмяНеУказанногоПользователя();
	
КонецФункции
