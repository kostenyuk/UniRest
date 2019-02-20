﻿
&НаКлиенте
Процедура РасширенныеНастройки(Команда)
	
	// Настройка формы.
	РасширенныеНастройкиНаСервере(Истина, Истина);
	
КонецПроцедуры // РасширенныеНастройки()

&НаСервере
Процедура РасширенныеНастройкиНаСервере(Режим, Полный = Ложь)
	
	// Настройка формы.
	Если Режим Тогда
	
		Элементы.ГруппаСтраницы.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСверху;
		
		Элементы.ГруппаРасширенныеНастройкиДополнительная.ОтображатьЗаголовок = Ложь;
		Элементы.ГруппаРасширенныеНастройкиДополнительная.Отображение = ОтображениеОбычнойГруппы.Нет;
		
		Если Полный Тогда
			Элементы.ГруппаНастройкиПользователей.Видимость = Истина;
			Элементы.ГруппаДополнительныеПраваПользователей.Видимость = Истина;
			Элементы.ГруппаПраваДоступаОбъектов.Видимость = Истина;
			Элементы.ГруппаПраваДоступаПользователей.Видимость = Истина;
		КонецЕсли;
		
		Элементы.ГруппаРасширенныеНастройки.Видимость = (Не Элементы.ГруппаНастройкиПользователей.Видимость) Или
														(Не Элементы.ГруппаДополнительныеПраваПользователей.Видимость) Или
														(Не Элементы.ГруппаПраваДоступаОбъектов.Видимость) Или
														(Не Элементы.ГруппаПраваДоступаПользователей.Видимость);

	Иначе
		
		////Костенюк Александр-Закомментировано 21.05.2014
		//// Одновременно должны отображаться закладки "Группы пользователей"  и "Рестораны"
		//Элементы.ГруппаСтраницы.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
		//
		//Элементы.ГруппаРасширенныеНастройкиДополнительная.ОтображатьЗаголовок = Истина;
		//Элементы.ГруппаРасширенныеНастройкиДополнительная.Отображение = ОтображениеОбычнойГруппы.Линия;
		
		Элементы.ГруппаНастройкиПользователей.Видимость = Ложь;
		Элементы.ГруппаДополнительныеПраваПользователей.Видимость = Ложь;
		Элементы.ГруппаПраваДоступаОбъектов.Видимость = Ложь;
		Элементы.ГруппаПраваДоступаПользователей.Видимость = Ложь;
		
	КонецЕсли; 
	
КонецПроцедуры // РасширенныеНастройкиНаСервере()

&НаКлиенте
Процедура ПользовательИБ(Команда)
	
	Для Каждого СтрокаГруппыПользователей Из ГруппыПользователей Цикл
		Если СтрокаГруппыПользователей.АутентификацияСтандартная Тогда
			СтрокаГруппыПользователейСтандартнаяАутентификация = СтрокаГруппыПользователей;
	    КонецЕсли;
	КонецЦикла;
	
	Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПользовательИБ);
	Структура.ПользовательИнфБазыИмя = СокрП(Объект.Код);
	Структура.ПользовательИнфБазыПолноеИмя = Объект.Наименование;
	Если (Не СтрокаГруппыПользователейСтандартнаяАутентификация = Неопределено) Тогда
		Если (Не Структура.ПользовательИнфБазыПароль = Неопределено) Тогда
			Структура.ПользовательИнфБазыПароль = СтрокаГруппыПользователейСтандартнаяАутентификация.Пароль;
		КонецЕсли; 
	КонецЕсли; 
	ПользовательИБ = Новый ФиксированнаяСтруктура(Структура);
	
	ПараметрыФормы = Новый Структура("Пользователь,ГруппыПользователей,ПользовательИБ,РолиПользователяИБ", Объект.Ссылка, ГруппыПользователей, ПользовательИБ, РолиПользователяИБ);
	Результат = ОткрытьФормуМодально("Справочник.Пользователи.Форма.ПользовательИБ", ПараметрыФормы, Элементы.ГруппыПользователей);
	
	Если (ТипЗнч(Результат) = Тип("Структура")) Тогда
		ПользовательИБ = Результат.ПользовательИБ;
		РолиПользователяИБ = Результат.РолиПользователяИБ;
		
		Объект.Код = ПользовательИБ.ПользовательИнфБазыИмя;
		Объект.Наименование = ПользовательИБ.ПользовательИнфБазыПолноеИмя;
		
		Если (СтрокаГруппыПользователейСтандартнаяАутентификация = Неопределено) Тогда
			СтрокаГруппыПользователейСтандартнаяАутентификация = ГруппыПользователей.Добавить();
			СтрокаГруппыПользователейСтандартнаяАутентификация.ТипРегистрации = "Стандартная";
			СтрокаГруппыПользователейСтандартнаяАутентификация.АутентификацияСтандартная = Истина;
			СтрокаГруппыПользователейСтандартнаяАутентификация.ИндексКартинки = 0;
		КонецЕсли; 
		Если (Не ПользовательИБ.ПользовательИнфБазыПароль = Неопределено) Тогда
			СтрокаГруппыПользователейСтандартнаяАутентификация.Пароль = ПользовательИБ.ПользовательИнфБазыПароль;
		КонецЕсли; 
		СтрокаГруппыПользователейСтандартнаяАутентификация.ГруппаПользователей = ПользовательИБ.ПользовательИнфБазыГруппаПользователя;
	КонецЕсли; 
	
КонецПроцедуры // ПользовательИБ()


&НаКлиенте
Процедура АвтоматическоеСозданиеСотрудникаПриИзменении(Элемент)
	
	// Настройка формы.
	Элементы.ГруппаСотрудникСтраницы.ТекущаяСтраница = Элементы.ГруппаСотрудник;

КонецПроцедуры // АвтоматическоеСозданиеСотрудникаПриИзменении()


&НаКлиенте
Процедура КодПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьПолноеНаименованиеАвтоматически, Объект.Наименование, СокрП(Объект.Код), Элементы.Наименование);
	
КонецПроцедуры // КодПриИзменении()

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьПолноеНаименованиеАвтоматически, Объект.Наименование, СокрП(Объект.Код), Элементы.Наименование);
	
КонецПроцедуры // НаименованиеПриИзменении()


&НаКлиенте
Процедура ГруппыПользователейПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Отказ = Истина;
	
	Если Копирование Тогда
		СтрокаГруппыПользователей = Новый Структура("ТипРегистрации,Пароль,КодКарты,ВидКарты,ГруппаПользователей,АутентификацияСтандартная", "Дополнительная", Неопределено, Неопределено, ПредопределенноеЗначение("Перечисление.ВидыИнформационныхКарт.Магнитная"), Неопределено, Ложь); ЗаполнитьЗначенияСвойств(СтрокаГруппыПользователей, Элементы.ГруппыПользователей.ТекущиеДанные, , "ТипРегистрации,Пароль,АутентификацияСтандартная,КодКарты");
	Иначе
		СтрокаГруппыПользователей = Новый Структура("ТипРегистрации,Пароль,КодКарты,ВидКарты,ГруппаПользователей,АутентификацияСтандартная", "Дополнительная", Неопределено, Неопределено, ПредопределенноеЗначение("Перечисление.ВидыИнформационныхКарт.Магнитная"), Неопределено, Ложь);
	КонецЕсли; 
	ПараметрыФормы = Новый Структура("Пользователь,ГруппыПользователей,СтрокаГруппыПользователей", Объект.Ссылка, ГруппыПользователей, СтрокаГруппыПользователей);
	Результат = ОткрытьФормуМодально("Справочник.Пользователи.Форма.ФормаНастройкиГруппыПользователя", ПараметрыФормы, Элемент);
	
	Если (ТипЗнч(Результат) = Тип("Структура")) Тогда
		ЗаполнитьЗначенияСвойств(ГруппыПользователей.Добавить(), Результат);
		
		Если Результат.АутентификацияСтандартная Тогда
			Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПользовательИБ);

			Структура.ПользовательИнфБазыГруппаПользователя = Результат.ГруппаПользователей;
			Структура.ПользовательИнфБазыПароль = Результат.Пароль;
			Структура.ПользовательИнфБазыПарольУстановлен = Не ПустаяСтрока(Структура.ПользовательИнфБазыПароль);
			
			ПользовательИБ = Новый ФиксированнаяСтруктура(Структура);
		КонецЕсли; 
	КонецЕсли;
	
КонецПроцедуры // ГруппыПользователейПередНачаломДобавления()

&НаКлиенте
Процедура ГруппыПользователейПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	
	СтрокаГруппыПользователей = Новый Структура("ТипРегистрации,Пароль,КодКарты,ВидКарты,ГруппаПользователей,АутентификацияСтандартная"); ЗаполнитьЗначенияСвойств(СтрокаГруппыПользователей, Элементы.ГруппыПользователей.ТекущиеДанные);
	ПараметрыФормы = Новый Структура("Пользователь,ГруппыПользователей,СтрокаГруппыПользователей", Объект.Ссылка, ГруппыПользователей, СтрокаГруппыПользователей);
	Результат = ОткрытьФормуМодально("Справочник.Пользователи.Форма.ФормаНастройкиГруппыПользователя", ПараметрыФормы, Элемент);
	
	Если (ТипЗнч(Результат) = Тип("Структура")) Тогда
		ЗаполнитьЗначенияСвойств(Элементы.ГруппыПользователей.ТекущиеДанные, Результат);
		
		Если Результат.АутентификацияСтандартная Тогда
			Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПользовательИБ);

			Структура.ПользовательИнфБазыГруппаПользователя = Результат.ГруппаПользователей;
			Структура.ПользовательИнфБазыПароль = Результат.Пароль;
			Структура.ПользовательИнфБазыПарольУстановлен = Не ПустаяСтрока(Структура.ПользовательИнфБазыПароль);
			
			ПользовательИБ = Новый ФиксированнаяСтруктура(Структура);
		КонецЕсли; 
	КонецЕсли;
	
КонецПроцедуры // ГруппыПользователейПередНачаломИзменения()

&НаКлиенте
Процедура ГруппыПользователейПередУдалением(Элемент, Отказ)

	Если Элементы.ГруппыПользователей.ТекущиеДанные.АутентификацияСтандартная Тогда
		Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПользовательИБ);

		Структура.ПользовательИнфБазыПароль = Строка(Неопределено);
		Структура.ПользовательИнфБазыПарольУстановлен = Не ПустаяСтрока(Структура.ПользовательИнфБазыПароль);
		
		ПользовательИБ = Новый ФиксированнаяСтруктура(Структура);
	КонецЕсли; 

КонецПроцедуры // ГруппыПользователейПередУдалением()


&НаКлиенте
Процедура ДополнительныеПраваПользователейФлажокПриИзменении(Элемент)
	
	Элементы.ДополнительныеПраваПользователей.ТекущиеДанные.Значение = Элементы.ДополнительныеПраваПользователей.ТекущиеДанные.Флажок;
	Элементы.ДополнительныеПраваПользователей.ТекущиеДанные.Актуальность = Элементы.ДополнительныеПраваПользователей.ТекущиеДанные.Значение;
	
КонецПроцедуры // ДополнительныеПраваПользователейФлажокПриИзменении()

&НаКлиенте
Процедура ДополнительныеПраваПользователейЗначениеПриИзменении(Элемент)
	
	Элементы.ДополнительныеПраваПользователей.ТекущиеДанные.Актуальность = ЗначениеЗаполнено(Элементы.ДополнительныеПраваПользователей.ТекущиеДанные.Значение);
	
КонецПроцедуры // ДополнительныеПраваПользователейЗначениеПриИзменении()

&НаКлиенте
Процедура НастройкиПользователейФлажокПриИзменении(Элемент)
	
	Элементы.НастройкиПользователей.ТекущиеДанные.Значение = Элементы.НастройкиПользователей.ТекущиеДанные.Флажок;
	Элементы.НастройкиПользователей.ТекущиеДанные.Актуальность = Элементы.НастройкиПользователей.ТекущиеДанные.Значение;
	
КонецПроцедуры // НастройкиПользователейФлажокПриИзменении()

&НаКлиенте
Процедура НастройкиПользователейЗначениеПриИзменении(Элемент)
	
	Элементы.НастройкиПользователей.ТекущиеДанные.Актуальность = ЗначениеЗаполнено(Элементы.НастройкиПользователей.ТекущиеДанные.Значение);
	
КонецПроцедуры // НастройкиПользователейЗначениеПриИзменении()

&НаКлиенте
Процедура ПраваДоступаПользователейАктуальностьПриИзменении(Элемент)

	// Актуальность.
	__РаботаСДаннымиКлиентСервер.ИзменитьПравилаАктуальностиПодчиненных(Элемент, ПраваДоступаПользователей);
	
КонецПроцедуры // ПраваДоступаПользователейАктуальностьПриИзменении()

&НаКлиенте
Процедура ПраваДоступаОбъектовАктуальностьПриИзменении(Элемент)

	ПользователиКлиент.ПриИзмененииАктуальностиПраваДоступаОбъектов(Элемент, ПраваДоступаОбъектов);

КонецПроцедуры // ПраваДоступаОбъектовАктуальностьПриИзменении()

&НаКлиенте
Процедура ПраваДоступаОбъектовРазделениеПриИзменении(Элемент)

	ПользователиКлиент.ПриИзмененииРазделенияПраваДоступаОбъектов(Элемент, ПраваДоступаОбъектов);
	
КонецПроцедуры // ПраваДоступаОбъектовАктуальностьПриИзменении()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Параметры.
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииНаСервере(Объект);
	КонецЕсли;
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьПолноеНаименованиеАвтоматически, Объект.Наименование, СокрП(Объект.Код), Элементы.Наименование);
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Перем ПрочитанныйПользователь, ПрочитанныеРоли;
	
	// ПользовательИБ.
	Пользователи.ПрочитатьПользователяИБ(__ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеЗначение(ТекущийОбъект.ИдентификаторПользователяИБ, Параметры.ИдентификаторПользователяИБ), ПрочитанныйПользователь, ПрочитанныеРоли);
	//Если Не ЗначениеЗаполнено(ПрочитанныйПользователь.ПользовательИнфБазыУникальныйИдентификатор) Тогда
	//	Пользователи.ПрочитатьПользователяИБ(СокрП(ТекущийОбъект.Код), ПрочитанныйПользователь, ПрочитанныеРоли);
	//КонецЕсли;
	
	//Костенюк Александр-Старт 18.12.2012
	Если НЕ ЗначениеЗаполнено(ПрочитанныйПользователь.ПользовательИнфБазыУникальныйИдентификатор) Тогда
		Если НЕ ЗначениеЗаполнено(ТекущийОбъект.Ссылка) Тогда
			Пользователи.ПрочитатьПользователяИБ(Неопределено, ПрочитанныйПользователь, ПрочитанныеРоли);
		Иначе
			Пользователи.ПрочитатьПользователяИБ(СокрП(ТекущийОбъект.Код), ПрочитанныйПользователь, ПрочитанныеРоли);
		КонецЕсли;
	КонецЕсли;
	//Костенюк Александр-Финиш 18.12.2012
	
	ПользовательИБ = Новый ФиксированнаяСтруктура(ПрочитанныйПользователь);
	РолиПользователяИБ = Новый ФиксированныйМассив(ПрочитанныеРоли);
	
	Объект.ИдентификаторПользователяИБ = ПользовательИБ.ПользовательИнфБазыУникальныйИдентификатор;
	Если ЗначениеЗаполнено(Параметры.ИдентификаторПользователяИБ) Тогда
		Объект.Код = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеНаименование(Объект.Код, ПользовательИБ.ПользовательИнфБазыИмя);
		Объект.Наименование = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеНаименование(Объект.Наименование, ПользовательИБ.ПользовательИнфБазыПолноеИмя);
	КонецЕсли; 
	
	// АвтоматическоеСозданиеСотрудника.
	АвтоматическоеСозданиеСотрудника = (Не ЗначениеЗаполнено(ТекущийОбъект.Ссылка)) И (Не ЗначениеЗаполнено(ТекущийОбъект.Сотрудник));
	Если АвтоматическоеСозданиеСотрудника Тогда
		Организация = Справочники.Организации.ОсновнаяОрганизация();
	КонецЕсли; 
	
	// Параметры.
	Если ЗначениеЗаполнено(ПолучитьСвойство(Параметры, "ЗначениеКопирования")) Тогда
		ОбъектЗаполнения = Параметры.ЗначениеКопирования;
	Иначе
		ОбъектЗаполнения = ТекущийОбъект;
	КонецЕсли; 
	
	// ГруппыПользователей.
	//ПолучитьГруппыПользователей(ТекущийОбъект, ГруппыПользователей);
	
	//Костенюк Александр-Старт 21.10.2013
	Если НЕ ТекущийОбъект.Ссылка.Пустая() Тогда
		ПолучитьГруппыПользователей(ТекущийОбъект, ГруппыПользователей);
	КонецЕсли;
	//Костенюк Александр-Финиш 21.10.2013
		
	РегистрыСведений.НастройкиПользователей.ПолучитьНастройкиПользователей(ОбъектЗаполнения, НастройкиПользователей);
	РегистрыСведений.ЗначенияДополнительныхПравПользователя.ПолучитьПраваПользователей(ОбъектЗаполнения, ДополнительныеПраваПользователей);
	РегистрыСведений.НастройкиПравДоступаОбъектов.ПолучитьПраваДоступаОбъектов(ОбъектЗаполнения, ПраваДоступаОбъектов);
	//РегистрыСведений.НастройкиПравДоступаПользователей.ПолучитьПраваДоступаПользователей(ОбъектЗаполнения, Новый ОписаниеТипов("СправочникСсылка.ВидыМеню, СправочникСсылка.Меню"), ПраваДоступаПользователей);
	РегистрыСведений.НастройкиПравДоступаПользователей.ПолучитьПраваДоступаПользователей(ОбъектЗаполнения, Новый ОписаниеТипов("СправочникСсылка.ВидыМеню, СправочникСсылка.Меню, СправочникСсылка.ТипыСкидокНаценок"), ПраваДоступаПользователей); //Костенюк Александр-Старт 08.10.2012
	
	//Костенюк Александр-Старт 21.05.2014
	// Заполнение таблицы ресторанов
	Выборка = Справочники.Рестораны.СформироватьЗапросПоАктуальнымРесторанам(ТекущийОбъект.Ссылка).Выбрать();
	Объект.Рестораны.Очистить();
	Пока Выборка.Следующий() Цикл
		НоваяСтрока = Объект.Рестораны.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
	КонецЦикла;
	//Костенюк Александр-Финиш 21.05.2014
	
	// Настройка формы.
	Если АвтоматическоеСозданиеСотрудника Тогда
		Элементы.ГруппаСотрудникСтраницы.ТекущаяСтраница = Элементы.ГруппаОрганизация;
	КонецЕсли; 
	
	Элементы.ГруппаНастройкиПользователей.Видимость = РегистрыСведений.НастройкиПользователей.ПолучитьПрисутсвиеНастроекПользователей(ОбъектЗаполнения);
	Элементы.ГруппаДополнительныеПраваПользователей.Видимость = РегистрыСведений.ЗначенияДополнительныхПравПользователя.ПолучитьПрисутсвиеПравПользователей(ОбъектЗаполнения);
	Элементы.ГруппаПраваДоступаОбъектов.Видимость = РегистрыСведений.НастройкиПравДоступаОбъектов.ПолучитьПрисутсвиеПравДоступаОбъектов(ОбъектЗаполнения);
	Элементы.ГруппаПраваДоступаПользователей.Видимость = РегистрыСведений.НастройкиПравДоступаПользователей.ПолучитьПрисутсвиеПравДоступаПользователей(ОбъектЗаполнения);
	
	РасширенныеНастройкиНаСервере(Элементы.ГруппаНастройкиПользователей.Видимость Или
								  Элементы.ГруппаДополнительныеПраваПользователей.Видимость Или
								  Элементы.ГруппаПраваДоступаОбъектов.Видимость Или
								  Элементы.ГруппаПраваДоступаПользователей.Видимость);
	
КонецПроцедуры // ПриЧтенииНаСервере()

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	//
	//ОчиститьСообщения();
	//
	//ЗаголовокВопросов = НСтр("ru = 'Запись пользователя информационной базы'");
	//
	//Если ДоступКИнформационнойБазеРазрешен Тогда
	//	Если ДействияВФорме.Роли = "Редактирование" И ПользовательИнфБазыРоли.Количество() = 0 Тогда
	//		Ответ = Вопрос(НСтр("ru = 'Пользователю информационной базы не установлено ни одной роли. Продолжить?'"),
	//			РежимДиалогаВопрос.ДаНет, , , ЗаголовокВопросов);
	//		Если Ответ = КодВозвратаДиалога.Нет Тогда
	//			Отказ = Истина;
	//		КонецЕсли;
	//	КонецЕсли;
	//
	//	// Обработка записи первого администратора
	//	ТекстВопроса = "";
	//	Если Пользователи.ТребуетсяСоздатьПервогоАдминистратора(ПолучитьСтруктуруОписанияПользователяИБ(), 
	//		ТекстВопроса) Тогда
	//		
	//		Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет, , , ЗаголовокВопросов);
	//		Если Ответ = КодВозвратаДиалога.Нет Тогда
	//			Отказ = Истина;
	//		КонецЕсли;
	//	КонецЕсли;
	//КонецЕсли;
	//
	
	//Костенюк Александр-Старт 21.10.2013
	Если Объект.Предопределенный И (СокрЛП(Объект.Код) = "Администратор") Тогда
		Если НЕ НазначенаСтандартнаяАутентификация() Тогда
			Режим = РежимДиалогаВопрос.ДаНет;
			Текст = "ru='Пользователю не назначена Аутентификация 1С:Предприятия. Будет произведено удаление пользователя ИБ. Продолжить?';uk='Користувачеві не призначена Аутентифікація 1С:Підприємства. Буде проведено видалення користувача ІБ. Продовжити?'";
			Ответ = Вопрос(НСтр(Текст), Режим, 0);
			Если Ответ = КодВозвратаДиалога.Нет Тогда
				Отказ = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	//Костенюк Александр-Финиш 21.10.2013

КонецПроцедуры // ПередЗаписью()

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Перем ОписаниеОшибки;
	
	//Костенюк Александр-Старт 19.02.2013
	// Проверка на уникальность имени для новых элементов
	Если НЕ ЗначениеЗаполнено(ТекущийОбъект.Ссылка) Тогда
		Результат = Справочники.Пользователи.СформироватьЗапросПользователей(ТекущийОбъект.Код);
		Если НЕ Результат.Пустой() Тогда
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Пользователь с таким именем уже существует!'; uk = 'Користувач з таким іменем вже існує!'"), , , "ГруппыПользователей", Отказ);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	//Костенюк Александр-Финиш 19.02.2013
	
	// ПользовательИБ.
	Если (ДанныеФормыВЗначение(ГруппыПользователей, Тип("ТаблицаЗначений")).Найти("Стандартная", "ТипРегистрации") = Неопределено) Тогда
		
		Если Не Пользователи.УдалитьПользователяИБ(ТекущийОбъект.ИдентификаторПользователяИБ, ОписаниеОшибки) Тогда
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(ОписаниеОшибки, ,, "ГруппыПользователей", Отказ);
		КонецЕсли; 
		
	Иначе
		
		Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПользовательИБ);
		
		Структура.ПользовательИнфБазыИмя = СокрП(ТекущийОбъект.Код);
		Структура.ПользовательИнфБазыПолноеИмя = ТекущийОбъект.Наименование;
		
		Если Не Пользователи.ЗаписатьПользователяИБ(ТекущийОбъект.ИдентификаторПользователяИБ, Структура, РолиПользователяИБ, Не ЗначениеЗаполнено(ТекущийОбъект.ИдентификаторПользователяИБ), ОписаниеОшибки) Тогда
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(ОписаниеОшибки, ,, "ГруппыПользователей", Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
	// Сотрудник.
	Если АвтоматическоеСозданиеСотрудника Тогда
		Попытка
			ТекущийОбъект.Сотрудник = Справочники.СотрудникиОрганизаций.ДобавитьСотрудника(ТекущийОбъект.Наименование, Неопределено, Организация);
		Исключение
			// TODO: Регистрация ошибки.
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось создать сотрудника организации'; uk = 'Не вдалося створити співробітника організації'"), ,, "АвтоматическоеСозданиеСотрудника", Отказ);
		КонецПопытки;
	КонецЕсли; 
	
КонецПроцедуры // ПередЗаписьюНаСервере()

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	// Параметры.
	УстановитьГруппыПользователей(ТекущийОбъект, ГруппыПользователей, Отказ);
	Если Не Отказ Тогда
		РегистрыСведений.НастройкиПользователей.УстановитьНастройкиПользователей(ТекущийОбъект, НастройкиПользователей, Отказ);
		
		Элементы.ГруппаНастройкиПользователей.Видимость = Элементы.ГруппаНастройкиПользователей.Видимость Или Отказ;
	КонецЕсли; 
	Если Не Отказ Тогда
		РегистрыСведений.ЗначенияДополнительныхПравПользователя.УстановитьПраваПользователей(ТекущийОбъект, ДополнительныеПраваПользователей, Отказ);
		
		Элементы.ГруппаДополнительныеПраваПользователей.Видимость = Элементы.ГруппаДополнительныеПраваПользователей.Видимость Или Отказ;
	КонецЕсли; 
	Если Не Отказ Тогда
		РегистрыСведений.НастройкиПравДоступаОбъектов.УстановитьПраваДоступаОбъектов(ТекущийОбъект, ПраваДоступаОбъектов, Отказ);
		
		Элементы.ГруппаПраваДоступаОбъектов.Видимость = Элементы.ГруппаПраваДоступаОбъектов.Видимость Или Отказ;
	КонецЕсли; 
	Если Не Отказ Тогда
		РегистрыСведений.НастройкиПравДоступаПользователей.УстановитьПраваДоступаПользователей(ТекущийОбъект, ПраваДоступаПользователей, Отказ);
		
		Элементы.ГруппаПраваДоступаПользователей.Видимость = Элементы.ГруппаПраваДоступаПользователей.Видимость Или Отказ;
	КонецЕсли; 
	
	// Настройка формы.
	РасширенныеНастройкиНаСервере(Элементы.ГруппаНастройкиПользователей.Видимость Или
								  Элементы.ГруппаДополнительныеПраваПользователей.Видимость Или
								  Элементы.ГруппаПраваДоступаОбъектов.Видимость Или
								  Элементы.ГруппаПраваДоступаПользователей.Видимость);
	
КонецПроцедуры // ПриЗаписиНаСервере()

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// ПользовательИБ.
	Структура = __ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(ПользовательИБ);

	Структура.ПользовательИнфБазыУникальныйИдентификатор = ТекущийОбъект.ИдентификаторПользователяИБ;
	
	ПользовательИБ = Новый ФиксированнаяСтруктура(Структура);
	
КонецПроцедуры // ПослеЗаписиНаСервере()

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Не АвтоматическоеСозданиеСотрудника Тогда
		__ОбщегоНазначенияСервер.ИзменитьПроверяемыеРеквизиты(ПроверяемыеРеквизиты, , "Организация");
	КонецЕсли; 
	
КонецПроцедуры // ОбработкаПроверкиЗаполненияНаСервере()


&НаСервереБезКонтекста
Процедура ПолучитьГруппыПользователей(Ссылка, Объект)

	УстановитьПривилегированныйРежим(Истина);
	
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	&Пользователь КАК Пользователь,
	                      |	ГруппыПользователей.ГруппаПользователей,
	                      |	ГруппыПользователей.Пароль,
	                      |	NULL КАК КодКарты,
	                      |	NULL КАК ВидКарты,
	                      |	ГруппыПользователей.АутентификацияСтандартная КАК АутентификацияСтандартная,
	                      |	ВЫБОР
	                      |		КОГДА ГруппыПользователей.АутентификацияСтандартная
	                      |			ТОГДА ""Стандартная""
	                      |		ИНАЧЕ ""Дополнительная""
	                      |	КОНЕЦ КАК ТипРегистрации,
	                      |	ВЫБОР
	                      |		КОГДА ГруппыПользователей.АутентификацияСтандартная
	                      |			ТОГДА 0
	                      |		ИНАЧЕ 1
	                      |	КОНЕЦ КАК ИндексКартинки
	                      |ИЗ
	                      |	РегистрСведений.ГруппыПользователей КАК ГруппыПользователей
	                      |ГДЕ
	                      |	ГруппыПользователей.Пользователь = &Пользователь
	                      |
	                      |ОБЪЕДИНИТЬ ВСЕ
	                      |
	                      |ВЫБРАТЬ
	                      |	&Пользователь,
	                      |	ИнформационныеКарты.ГруппаПользователей,
	                      |	NULL,
	                      |	ИнформационныеКарты.КодКарты,
	                      |	ИнформационныеКарты.ВидКарты,
	                      |	ЛОЖЬ,
	                      |	""Карта"",
	                      |	2
	                      |ИЗ
	                      |	Справочник.ИнформационныеКарты КАК ИнформационныеКарты
	                      |ГДЕ
	                      |	ИнформационныеКарты.ВладелецКарты = &Пользователь
	                      |	И ИнформационныеКарты.ТипКарты = ЗНАЧЕНИЕ(Перечисление.ТипыИнформационныхКарт.Регистрационная)
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	ИндексКартинки");
	Запрос.УстановитьПараметр("Пользователь", Ссылка.Ссылка);					  
	//.. Начало изменения Dim)on  10 октября 2013 г. 16:39:13
	//
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ИнформационныеКарты.ТипКарты = ЗНАЧЕНИЕ(Перечисление.ТипыИнформационныхКарт.Регистрационная)", "");
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИнформационныеКарты", "РегистрационныеКарты");
	//
	//.. Конец изменения Dim)on  10 октября 2013 г. 16:39:13
						  
	ГруппыПользователей = Запрос.Выполнить().Выгрузить();
	
	ЗначениеВДанныеФормы(ГруппыПользователей, Объект);	

	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры // ПолучитьГруппыПользователей()

&НаСервереБезКонтекста
Процедура УстановитьГруппыПользователей(Ссылка, Объект, Отказ)
	
	Если Не Отказ Тогда

		УстановитьПривилегированныйРежим(Истина);
		
		ГруппыПользователей = ДанныеФормыВЗначение(Объект, Тип("ТаблицаЗначений"));
		
		// Пароли.
		НаборЗаписей = РегистрыСведений.ГруппыПользователей.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Пользователь.Установить(Ссылка.Ссылка);
		
		Для Каждого СтрокаГруппыПользователей Из ГруппыПользователей.НайтиСтроки(Новый Структура("ТипРегистрации", "Стандартная")) Цикл 
			Запись = НаборЗаписей.Добавить();
			ЗаполнитьЗначенияСвойств(Запись, СтрокаГруппыПользователей);
			Запись.Пользователь = Ссылка.Ссылка;
		КонецЦикла; 
		Для Каждого СтрокаГруппыПользователей Из ГруппыПользователей.НайтиСтроки(Новый Структура("ТипРегистрации", "Дополнительная")) Цикл 
			Запись = НаборЗаписей.Добавить();
			ЗаполнитьЗначенияСвойств(Запись, СтрокаГруппыПользователей);
			Запись.Пользователь = Ссылка.Ссылка;
		КонецЦикла; 

		Попытка
			НаборЗаписей.Записать(Истина);
		Исключение
			// TODO: Регистрация ошибки.
			__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось изменить пароли'; uk = 'Не вдалося змінити паролі'"), ,, "ГруппыПользователей", Отказ);
		КонецПопытки;
		
		// Регистрационные карты.
		Если Не Отказ Тогда
			
			АктуальныеРегистрационныхКарт = Новый Массив;
			Для Каждого СтрокаГруппыПользователей Из ГруппыПользователей.НайтиСтроки(Новый Структура("ТипРегистрации", "Карта")) Цикл
				Попытка
					//.. Начало изменения Dim)on  10 октября 2013 г. 16:46:24
					//
					//АктуальныеРегистрационныхКарт.Добавить(Справочники.ИнформационныеКарты.ДобавитьРегистрационнуюКарту(СтрокаГруппыПользователей.КодКарты, СтрокаГруппыПользователей.ВидКарты, Ссылка.Ссылка, СтрокаГруппыПользователей.ГруппаПользователей));
					АктуальныеРегистрационныхКарт.Добавить(Справочники.РегистрационныеКарты.ДобавитьРегистрационнуюКарту(СтрокаГруппыПользователей.КодКарты, СтрокаГруппыПользователей.ВидКарты, Ссылка.Ссылка, СтрокаГруппыПользователей.ГруппаПользователей));
					//
					//.. Конец изменения Dim)on  10 октября 2013 г. 16:46:24
				Исключение
					// TODO: Регистрация ошибки.
					__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось изменить регистрационные карты'; uk = 'Не вдалося змінити реєстраційні картки'"), ,, "ГруппыПользователей", Отказ);
					Прервать;
				КонецПопытки;
			КонецЦикла;
			
		КонецЕсли; 
		Если Не Отказ Тогда
			
			Запрос = Новый Запрос("ВЫБРАТЬ
			                      |	ИнформационныеКарты.Ссылка
			                      |ИЗ
			                      |	Справочник.ИнформационныеКарты КАК ИнформационныеКарты
			                      |ГДЕ
			                      |	ИнформационныеКарты.ВладелецКарты = &ВладелецКарты
			                      |	И ИнформационныеКарты.ТипКарты = ЗНАЧЕНИЕ(Перечисление.ТипыИнформационныхКарт.Регистрационная)
			                      |	И НЕ ИнформационныеКарты.Ссылка В (&АктуальныеРегистрационныхКарт)");
			Запрос.УстановитьПараметр("ВладелецКарты", Ссылка.Ссылка);
			Запрос.УстановитьПараметр("АктуальныеРегистрационныхКарт", АктуальныеРегистрационныхКарт);
			//.. Начало изменения Dim)on  10 октября 2013 г. 16:39:13
			//
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ИнформационныеКарты.ТипКарты = ЗНАЧЕНИЕ(Перечисление.ТипыИнформационныхКарт.Регистрационная)", "");
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИнформационныеКарты", "РегистрационныеКарты");
			//
			//.. Конец изменения Dim)on  10 октября 2013 г. 16:39:13
			
			Выборка = Запрос.Выполнить().Выбрать();
			Пока Выборка.Следующий() Цикл
				Попытка
					//.. Начало изменения Dim)on  10 октября 2013 г. 16:46:24
					//
					//Справочники.ИнформационныеКарты.УдалитьРегистрационнуюКарту(Выборка.Ссылка);
					Справочники.РегистрационныеКарты.УдалитьРегистрационнуюКарту(Выборка.Ссылка);
					//
					//.. Конец изменения Dim)on  10 октября 2013 г. 16:46:24
				Исключение
					// TODO: Регистрация ошибки.
					__ОбщегоНазначенияКлиентСервер.СообщитьОбОшибке(НСтр("ru = 'Не удалось изменить регистрационные карты'; uk = 'Не вдалося змінити реєстраційні картки'"), ,, "ГруппыПользователей", Отказ);
					Прервать;
				КонецПопытки;
			КонецЦикла;
			
		КонецЕсли; 

		УстановитьПривилегированныйРежим(Ложь);
	
	КонецЕсли; 
	
КонецПроцедуры // УстановитьГруппыПользователей()

&НаСервере
//Костенюк Александр-Старт 21.10.2013
Функция НазначенаСтандартнаяАутентификация()
	Если (ДанныеФормыВЗначение(ГруппыПользователей, Тип("ТаблицаЗначений")).Найти("Стандартная", "ТипРегистрации") = Неопределено) Тогда
		Возврат Ложь;
	КонецЕсли;
	Возврат Истина;	
КонецФункции
//Костенюк Александр-Финиш 21.10.2013
