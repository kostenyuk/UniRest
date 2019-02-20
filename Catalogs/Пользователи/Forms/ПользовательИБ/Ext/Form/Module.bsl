﻿
&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьСвойств(Форма)
	
	Элементы = Форма.Элементы;
	
	Элементы.Пароль.Доступность                                     = Форма.ПользовательИнфБазыАутентификацияСтандартная;
	Элементы.ПодтверждениеПароля.Доступность                        = Форма.ПользовательИнфБазыАутентификацияСтандартная;
	Элементы.ПользовательИнфБазыЗапрещеноИзменятьПароль.Доступность = Форма.ПользовательИнфБазыАутентификацияСтандартная;
	Элементы.ПользовательИнфБазыПоказыватьВСпискеВыбора.Доступность = Форма.ПользовательИнфБазыАутентификацияСтандартная;
	
	Элементы.ПользовательИнфБазыПользовательОС.Доступность = Форма.ПользовательИнфБазыАутентификацияОС;
	
	Элементы.ГруппаПроверка.Доступность = Форма.ПользовательИнфБазыАутентификацияСтандартная;
	
КонецПроцедуры // УстановитьДоступностьСвойств()


&НаСервере
Функция КоллекцияРолей(ТаблицаЗначенийДляЧтения = Ложь)
	
	Если ТаблицаЗначенийДляЧтения Тогда
		Возврат РеквизитФормыВЗначение("ПользовательИнфБазыРоли");
	КонецЕсли;
	
	Возврат ПользовательИнфБазыРоли;
	
КонецФункции // КоллекцияРолей()

&НаСервере
Функция ДанныеФормыКоллекцияЭлементовДерева(ДанныеФормыДерево, СтрокаДереваЗначений)
	
	Если СтрокаДереваЗначений.Родитель = Неопределено Тогда
		ДанныеФормыКоллекцияЭлементовДерева = ДанныеФормыДерево.ПолучитьЭлементы();
	Иначе
		ИндексРодителя = ?(СтрокаДереваЗначений.Родитель.Родитель = Неопределено, СтрокаДереваЗначений.Владелец().Строки, СтрокаДереваЗначений.Родитель.Родитель.Строки).Индекс(СтрокаДереваЗначений.Родитель);
		ДанныеФормыКоллекцияЭлементовДерева = ДанныеФормыКоллекцияЭлементовДерева(ДанныеФормыДерево, СтрокаДереваЗначений.Родитель).Получить(ИндексРодителя).ПолучитьЭлементы();
	КонецЕсли;
	
	Возврат ДанныеФормыКоллекцияЭлементовДерева;
	
КонецФункции // ДанныеФормыКоллекцияЭлементовДерева()

&НаСервере
Процедура ЗаполнитьРоли(ПрочитанныеРоли)
	
	ПользовательИнфБазыРоли.Очистить();
	
	Для каждого Роль Из ПрочитанныеРоли Цикл
		ПользовательИнфБазыРоли.Добавить().Роль = Роль;
	КонецЦикла;
	
	ОбновитьДеревоРолей();
	
КонецПроцедуры // ЗаполнитьРоли()

&НаСервере
Процедура ОбновитьДеревоРолей()
	
	// Запоминание текущей строки.
	ТекущаяПодсистема = "";
	ТекущаяРоль       = "";
	
	Если Элементы.Роли.ТекущаяСтрока <> Неопределено Тогда
		ТекущиеДанные = Роли.НайтиПоИдентификатору(Элементы.Роли.ТекущаяСтрока);
		Если ТекущиеДанные.ЭтоРоль Тогда
			ТекущаяПодсистема = ?(ТекущиеДанные.ПолучитьРодителя() = Неопределено, "", ТекущиеДанные.ПолучитьРодителя().Имя);
			ТекущаяРоль       = ТекущиеДанные.Имя;
		Иначе
			ТекущаяПодсистема = ТекущиеДанные.Имя;
			ТекущаяРоль       = "";
		КонецЕсли;
	КонецЕсли;
	
	ТипПользователя = Неопределено;
	
	ДеревоРолей = ПользователиСерверПовторно.ДеревоРолей(ПоказатьПодсистемыРолей, ТипПользователя).Скопировать();
	ДеревоРолей.Колонки.Добавить("Пометка",       Новый ОписаниеТипов("Булево"));
	ДеревоРолей.Колонки.Добавить("НомерКартинки", Новый ОписаниеТипов("Число"));
	ПодготовитьДеревоРолей(ДеревоРолей.Строки, ПоказатьТолькоВыбранныеРоли);
	
	ЗначениеВРеквизитФормы(ДеревоРолей, "Роли");
	
	Элементы.Роли.Отображение = ?(ДеревоРолей.Строки.Найти(Ложь, "ЭтоРоль") = Неопределено, ОтображениеТаблицы.Список, ОтображениеТаблицы.Дерево);
	
	// Восстановление текущей строки.
	НайденныеСтроки = ДеревоРолей.Строки.НайтиСтроки(Новый Структура("ЭтоРоль, Имя", Ложь, ТекущаяПодсистема), Истина);
	Если НайденныеСтроки.Количество() <> 0 Тогда
		ОписаниеПодсистемы = НайденныеСтроки[0];
		ИндексПодсистемы = ?(ОписаниеПодсистемы.Родитель = Неопределено, ДеревоРолей.Строки, ОписаниеПодсистемы.Родитель.Строки).Индекс(ОписаниеПодсистемы);
		СтрокаПодсистемы = ДанныеФормыКоллекцияЭлементовДерева(Роли, ОписаниеПодсистемы).Получить(ИндексПодсистемы);
		Если ЗначениеЗаполнено(ТекущаяРоль) Тогда
			НайденныеСтроки = ОписаниеПодсистемы.Строки.НайтиСтроки(Новый Структура("ЭтоРоль, Имя", Истина, ТекущаяРоль));
			Если НайденныеСтроки.Количество() <> 0 Тогда
				ОписаниеРоли = НайденныеСтроки[0];
				Элементы.Роли.ТекущаяСтрока = СтрокаПодсистемы.ПолучитьЭлементы().Получить(ОписаниеПодсистемы.Строки.Индекс(ОписаниеРоли)).ПолучитьИдентификатор();
			Иначе
				Элементы.Роли.ТекущаяСтрока = СтрокаПодсистемы.ПолучитьИдентификатор();
			КонецЕсли;
		Иначе
			Элементы.Роли.ТекущаяСтрока = СтрокаПодсистемы.ПолучитьИдентификатор();
		КонецЕсли;
	Иначе
		НайденныеСтроки = ДеревоРолей.Строки.НайтиСтроки(Новый Структура("ЭтоРоль, Имя", Истина, ТекущаяРоль), Истина);
		Если НайденныеСтроки.Количество() <> 0 Тогда
			ОписаниеРоли = НайденныеСтроки[0];
			ИндексРоли = ?(ОписаниеРоли.Родитель = Неопределено, ДеревоРолей.Строки, ОписаниеРоли.Родитель.Строки).Индекс(ОписаниеРоли);
			СтрокаРоли = ДанныеФормыКоллекцияЭлементовДерева(Роли, ОписаниеРоли).Получить(ИндексРоли);
			Элементы.Роли.ТекущаяСтрока = СтрокаРоли.ПолучитьИдентификатор();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ОбновитьДеревоРолей()

&НаСервере
Процедура ОбновитьСоставРолей(ИдентификаторСтроки, Добавить);
	
	Если ИдентификаторСтроки = Неопределено Тогда
		КоллекцияРолей = КоллекцияРолей();
		КоллекцияРолей.Очистить();
		Если Добавить Тогда
			ВсеРоли = ПользователиСерверПовторно.ВсеРоли();
			Для каждого ОписаниеРоли Из ВсеРоли Цикл
				Если ОписаниеРоли.Имя <> "ПолныеПрава" И ОписаниеРоли.Имя <> "АдминистраторСистемы" Тогда
					КоллекцияРолей.Добавить().Роль = ОписаниеРоли.Имя;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		Если ПоказатьТолькоВыбранныеРоли Тогда
			Если КоллекцияРолей.Количество() > 0 Тогда
				ОбновитьДеревоРолей();
			Иначе
				Роли.ПолучитьЭлементы().Очистить();
			КонецЕсли;
			// Возврат
			Возврат;
			// Возврат
		КонецЕсли;
	Иначе
		ТекущиеДанные = Роли.НайтиПоИдентификатору(ИдентификаторСтроки);
		Если ТекущиеДанные.ЭтоРоль Тогда
			ДобавитьУдалитьРоль(ТекущиеДанные.Имя, Добавить);
		Иначе
			ДобавитьУдалитьРолиПодсистемы(ТекущиеДанные.ПолучитьЭлементы(), Добавить);
		КонецЕсли;
	КонецЕсли;
	
	ОбновитьПометкуВыбранныхРолей(Роли.ПолучитьЭлементы());
	
КонецПроцедуры // ОбновитьСоставРолей()

&НаСервере
Процедура ПодготовитьДеревоРолей(Коллекция, ПоказатьТолькоВыбранныеРоли)
	
	Индекс = Коллекция.Количество()-1;
	
	Пока Индекс >= 0 Цикл
		Строка = Коллекция[Индекс];
		
		ПодготовитьДеревоРолей(Строка.Строки, ПоказатьТолькоВыбранныеРоли);
		
		Если Строка.ЭтоРоль Тогда
			Строка.НомерКартинки = 6;
			Строка.Пометка = КоллекцияРолей().НайтиСтроки(Новый Структура("Роль", Строка.Имя)).Количество() > 0;
			Если ПоказатьТолькоВыбранныеРоли И НЕ Строка.Пометка Тогда
				Коллекция.Удалить(Индекс);
			КонецЕсли;
		Иначе
			Если Строка.Строки.Количество() = 0 Тогда
				Коллекция.Удалить(Индекс);
			Иначе
				Строка.НомерКартинки = 5;
				Строка.Пометка = Строка.Строки.НайтиСтроки(Новый Структура("Пометка", Ложь)).Количество() = 0;
			КонецЕсли;
		КонецЕсли;
		
		Индекс = Индекс-1;
	КонецЦикла;
	
КонецПроцедуры // ПодготовитьДеревоРолей()

&НаСервере
Процедура ДобавитьУдалитьРоль(Роль, Добавить)
	
	НайденныеРоли = КоллекцияРолей().НайтиСтроки(Новый Структура("Роль", Роль));
	
	Если Добавить Тогда
		Если НайденныеРоли.Количество() = 0 Тогда
			КоллекцияРолей().Добавить().Роль = Роль;
		КонецЕсли;
	Иначе
		Если НайденныеРоли.Количество() > 0 Тогда
			КоллекцияРолей().Удалить(НайденныеРоли[0]);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ДобавитьУдалитьРоль()

&НаСервере
Процедура ДобавитьУдалитьРолиПодсистемы(Коллекция, Добавить)
	
	Для каждого Строка Из Коллекция Цикл
		Если Строка.ЭтоРоль Тогда
			ДобавитьУдалитьРоль(Строка.Имя, Добавить);
		Иначе
			ДобавитьУдалитьРолиПодсистемы(Строка.ПолучитьЭлементы(), Добавить);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры // ДобавитьУдалитьРолиПодсистемы()

&НаСервере
Процедура ОбновитьПометкуВыбранныхРолей(Коллекция)
	
	Индекс = Коллекция.Количество()-1;
	
	Пока Индекс >= 0 Цикл
		Строка = Коллекция[Индекс];
		
		Если Строка.ЭтоРоль Тогда
			Строка.Пометка = КоллекцияРолей().НайтиСтроки(Новый Структура("Роль", Строка.Имя)).Количество() > 0;
			Если ПоказатьТолькоВыбранныеРоли И НЕ Строка.Пометка Тогда
				Коллекция.Удалить(Индекс);
			КонецЕсли;
		Иначе
			ОбновитьПометкуВыбранныхРолей(Строка.ПолучитьЭлементы());
			Если Строка.ПолучитьЭлементы().Количество() = 0 Тогда
				Коллекция.Удалить(Индекс);
			Иначе
				Строка.Пометка = Истина;
				Для каждого Элемент Из Строка.ПолучитьЭлементы() Цикл
					Если НЕ Элемент.Пометка Тогда
						Строка.Пометка = Ложь;
						Прервать;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
		
		Индекс = Индекс-1;
	КонецЦикла;
	
КонецПроцедуры // ОбновитьПометкуВыбранныхРолей()


&НаКлиенте
Процедура OK(Команда)
	
	OKНаСервере();
	
	ОчиститьСообщения();

	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли; 
	
	Результат = Новый Структура("ПользовательИБ,РолиПользователяИБ", Параметры.ПользовательИБ, Параметры.РолиПользователяИБ);
	Закрыть(Результат);
	
КонецПроцедуры // OK()

&НаСервере
Процедура OKНаСервере()

	Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(Параметры.ПользовательИБ);
	ЗаполнитьЗначенияСвойств(Структура, ЭтаФорма);

	Параметры.ПользовательИБ = Новый ФиксированнаяСтруктура(Структура);
	Параметры.РолиПользователяИБ = Новый ФиксированныйМассив(КоллекцияРолей(Истина).ВыгрузитьКолонку("Роль"));
	
КонецПроцедуры // OKНаСервере()


&НаКлиенте
Процедура ПоказатьТолькоВыбранныеРоли(Команда)
	
	ПоказатьТолькоВыбранныеРоли = Не ПоказатьТолькоВыбранныеРоли;
	Элементы.РолиПоказатьТолькоВыбранныеРоли.Пометка = ПоказатьТолькоВыбранныеРоли;
	
	ОбновитьДеревоРолей();
	РазвернутьПодсистемыРолей();
	
КонецПроцедуры // ПоказатьТолькоВыбранныеРоли()

&НаКлиенте
Процедура ГруппировкаПоПодсистемам(Команда)
	
	ПоказатьПодсистемыРолей = Не ПоказатьПодсистемыРолей;
	Элементы.РолиПоказатьПодсистемыРолей.Пометка = ПоказатьПодсистемыРолей;
	
	ОбновитьДеревоРолей();
	РазвернутьПодсистемыРолей();
	
КонецПроцедуры // ГруппировкаПоПодсистемам()

&НаКлиенте
Процедура ВключитьРоли(Команда)
	
	ОбновитьСоставРолей(Неопределено, Истина);
	Если ПоказатьТолькоВыбранныеРоли Тогда
		РазвернутьПодсистемыРолей();
	КонецЕсли;
	
КонецПроцедуры // ВключитьРоли()

&НаКлиенте
Процедура ИсключитьРоли(Команда)
	
	ОбновитьСоставРолей(Неопределено, Ложь);
	
КонецПроцедуры // ИсключитьРоли()

&НаКлиенте
Процедура РазвернутьПодсистемыРолей()
	
	Для каждого Строка Из Роли.ПолучитьЭлементы() Цикл
		Элементы.Роли.Развернуть(Строка.ПолучитьИдентификатор(), Истина);
	КонецЦикла;
	
КонецПроцедуры // РазвернутьПодсистемыРолей()


&НаКлиенте
Процедура ПользовательИнфБазыИмяПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьПолноеНаименованиеАвтоматически, ПользовательИнфБазыПолноеИмя, ПользовательИнфБазыИмя, Элементы.ПользовательИнфБазыПолноеИмя);
	
КонецПроцедуры // ПользовательИнфБазыИмяПриИзменении()

&НаКлиенте
Процедура ПользовательИнфБазыПолноеИмяПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьПолноеНаименованиеАвтоматически, ПользовательИнфБазыПолноеИмя, ПользовательИнфБазыИмя, Элементы.ПользовательИнфБазыПолноеИмя);
	
КонецПроцедуры // ПользовательИнфБазыПолноеИмяПриИзменении()

&НаКлиенте
Процедура ПользовательИнфБазыГруппаПользователяОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры // ПользовательИнфБазыГруппаПользователяОчистка()

&НаКлиенте
Процедура ПользовательИнфБазыАутентификацияСтандартнаяПриИзменении(Элемент)
	
	УстановитьДоступностьСвойств(ЭтаФорма);
	
КонецПроцедуры // ПользовательИнфБазыАутентификацияСтандартнаяПриИзменении()

&НаКлиенте
Процедура ПарольПриИзменении(Элемент)
	
	ПользовательИнфБазыПароль = Пароль;
	
	ПодтверждениеПароляПриИзменении(Элемент);
	
	ПарольПриИзмененииНаСервере();
	
КонецПроцедуры // ПарольПриИзменении()

&НаСервере
Процедура ПарольПриИзмененииНаСервере()
	
	ПарольНеУникальный = Ложь;
	
	Если ЗначениеЗаполнено(Пароль) Тогда
		
		// В пределах набора групп.
		Для Каждого СтрокаГруппыПользователей Из Параметры.ГруппыПользователей Цикл
			Если (Пароль = СтрокаГруппыПользователей.Пароль) И (Не ПользовательИнфБазыГруппаПользователя = СтрокаГруппыПользователей.ГруппаПользователей) Тогда
				ПарольНеУникальный = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	
		// В регистре.
		Если Не ПарольНеУникальный Тогда
			УстановитьПривилегированныйРежим(Истина);
			
			Запрос = Новый Запрос("ВЫБРАТЬ
								  |	ГруппыПользователей.Пользователь
								  |ИЗ
								  |	РегистрСведений.ГруппыПользователей КАК ГруппыПользователей
								  |ГДЕ
								  |	НЕ ГруппыПользователей.Пользователь = &Пользователь
								  |	И ГруппыПользователей.Пароль = &Пароль");
			Запрос.УстановитьПараметр("Пользователь", Параметры.Пользователь);
			Запрос.УстановитьПараметр("Пароль", Пароль);
			
			ПарольНеУникальный = Не Запрос.Выполнить().Пустой();
			
			УстановитьПривилегированныйРежим(Ложь);
		КонецЕсли;
		
	КонецЕсли; 
	
	Если ПарольНеУникальный Тогда
		Элементы.ДекорацияПарольНеУникальный.Заголовок = НСтр("ru = '(не уникальный)'; uk = '(не унікальний)'");
	Иначе
		Элементы.ДекорацияПарольНеУникальный.Заголовок = Неопределено;
	КонецЕсли; 
	
КонецПроцедуры // ПарольПриИзмененииНаСервере()

&НаКлиенте
Процедура ПодтверждениеПароляПриИзменении(Элемент)
	
	ПаролиНеСовпадают = (Не Пароль = ПодтверждениеПароля);
	
	Если ПаролиНеСовпадают Тогда
		Элементы.ДекорацияНадписьНеСовпадают.Заголовок = НСтр("ru = '(не совпадают)'; uk = '(не співпадають)'");
	Иначе
		Элементы.ДекорацияНадписьНеСовпадают.Заголовок = Неопределено;
	КонецЕсли; 
	
КонецПроцедуры // ПодтверждениеПароляПриИзменении()

&НаСервере
Процедура ПодтверждениеПароляПриИзмененииНаСервере()
	
	ПаролиНеСовпадают = (Не Пароль = ПодтверждениеПароля);
	
	Если ПаролиНеСовпадают Тогда
		Элементы.ДекорацияНадписьНеСовпадают.Заголовок = НСтр("ru = '(не совпадают)'; uk = '(не співпадають)'");
	Иначе
		Элементы.ДекорацияНадписьНеСовпадают.Заголовок = Неопределено;
	КонецЕсли; 
	
КонецПроцедуры // ПодтверждениеПароляПриИзмененииНаСервере()

&НаКлиенте
Процедура ПользовательИнфБазыАутентификацияОСПриИзменении(Элемент)
	
	УстановитьДоступностьСвойств(ЭтаФорма);
	
КонецПроцедуры // ПользовательИнфБазыАутентификацияОСПриИзменении()

&НаКлиенте
Процедура ПользовательИнфБазыПользовательОСНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	#Если Не ВебКлиент Тогда
	Результат = ОткрытьФормуМодально("Справочник.Пользователи.Форма.ПользователиОС");
	
	Если ТипЗнч(Результат) = Тип("Строка") Тогда
		ПользовательИнфБазыПользовательОС = Результат;
	КонецЕсли;
	#КонецЕсли
	
КонецПроцедуры // ПользовательИнфБазыПользовательОСНачалоВыбора()

&НаКлиенте
Процедура ПользовательИнфБазыРежимЗапускаОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры // ПользовательИнфБазыРежимЗапускаОчистка()


&НаКлиенте
Процедура РолиПометкаПриИзменении(Элемент)
	
	Если Элементы.Роли.ТекущиеДанные <> Неопределено Тогда
		ОбновитьСоставРолей(Элементы.Роли.ТекущаяСтрока, Элементы.Роли.ТекущиеДанные.Пометка);
	КонецЕсли;
	
КонецПроцедуры // РолиПометкаПриИзменении()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Настройка формы.
	ПарольПриИзмененииНаСервере();													 
	ПодтверждениеПароляПриИзмененииНаСервере();													 
	
	
	// ПользовательИБ.
	ЗаполнитьЗначенияСвойств(ЭтаФорма, Параметры.ПользовательИБ);
	ЗаполнитьРоли(Параметры.РолиПользователяИБ);
	
	// Пароль.
	Если (ПользовательИнфБазыПароль = Неопределено) Тогда
		Если Параметры.ПользовательИБ.ПользовательИнфБазыПарольУстановлен Тогда
			Пароль = Параметры.ПользовательИБ.ПользовательИнфБазыСохраняемоеЗначениеПароля; 
		КонецЕсли; 
	Иначе
		Пароль = Параметры.ПользовательИБ.ПользовательИнфБазыПароль; 
	КонецЕсли;
	ПодтверждениеПароля = Пароль;
	
	// Заполнение списка выбора языка.
	Для каждого МетаданныеЯзыка ИЗ Метаданные.Языки Цикл
		Элементы.ПользовательИнфБазыЯзык.СписокВыбора.Добавить(МетаданныеЯзыка.Имя, МетаданныеЯзыка.Синоним);
	КонецЦикла;
	
	// Заполнение списка выбора режимов запуска.
	Для каждого РежимЗапуска Из РежимЗапускаКлиентскогоПриложения Цикл
		ПолноеИмяЗначения = ПолучитьПолноеИмяПредопределенногоЗначения(РежимЗапуска);
		ИмяЗначения = Сред(ПолноеИмяЗначения, Найти(ПолноеИмяЗначения, ".") + 1);
		Элементы.ПользовательИнфБазыРежимЗапуска.СписокВыбора.Добавить(ИмяЗначения, Строка(РежимЗапуска));
	КонецЦикла;
	Элементы.ПользовательИнфБазыРежимЗапуска.СписокВыбора.СортироватьПоПредставлению();
	
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьПолноеНаименованиеАвтоматически, ПользовательИнфБазыПолноеИмя, ПользовательИнфБазыИмя, Элементы.ПользовательИнфБазыПолноеИмя);
	
	
	// Настройка формы.
	УстановитьДоступностьСвойств(ЭтаФорма);
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	#Если ВебКлиент Тогда
	Элементы.ПользовательИнфБазыПользовательОС.КнопкаВыбора = Ложь;
	#КонецЕсли
	
КонецПроцедуры // ПриОткрытии()

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если Настройки["ПоказатьПодсистемыРолей"] = Ложь Тогда
		ПоказатьПодсистемыРолей = Ложь;
		Элементы.РолиПоказатьПодсистемыРолей.Пометка = Ложь;
	Иначе
		ПоказатьПодсистемыРолей = Истина;
		Элементы.РолиПоказатьПодсистемыРолей.Пометка = Истина;
	КонецЕсли;
	
	ОбновитьДеревоРолей();
	
КонецПроцедуры // ПриЗагрузкеДанныхИзНастроекНаСервере()

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)

	Если ПользовательИнфБазыАутентификацияСтандартная Тогда
		Если ПаролиНеСовпадают Тогда
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Пароль и подтверждение пароля не совпадают'; uk = 'Пароль і підтвердження пароля не співпадають'"), ,, "ПодтверждениеПароля", Отказ);
		КонецЕсли; 
	КонецЕсли; 
	
	Если ПользовательИнфБазыАутентификацияОС Тогда
		Если Не ПустаяСтрока(ПользовательИнфБазыПользовательОС) Тогда
			
			УстановитьПривилегированныйРежим(Истина);
			Попытка
				ПользовательИБ = ПользователиИнформационнойБазы.СоздатьПользователя();
				ПользовательИБ.ПользовательОС = ПользовательИнфБазыПользовательОС;
			Исключение
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Пользователь ОС должен быть в формате ""\\ИмяДомена\ИмяПользователя""'; uk = 'Користувач ОС повинен бути в форматі ""\\Ім''яДомена\Ім''яКористувача""'"), ,, "ПользовательИнфБазыПользовательОС", Отказ);
			КонецПопытки;
			ПользовательИБ = Неопределено;
			УстановитьПривилегированныйРежим(Ложь);
			
		КонецЕсли;
	Иначе	
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ПользовательИнфБазыПользовательОС"));
	КонецЕсли; 

КонецПроцедуры // ОбработкаПроверкиЗаполненияНаСервере()
