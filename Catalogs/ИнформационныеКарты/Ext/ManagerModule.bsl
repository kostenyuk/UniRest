﻿
Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если (ВидФормы = "ФормаОбъекта") Тогда
		СтандартнаяОбработка = Ложь;
		
		Если (ПолучитьСвойство(Параметры, "Ключ", Справочники.ИнформационныеКарты.ПустаяСсылка()).ТипКарты = Перечисления.ТипыИнформационныхКарт.Регистрационная) Или
			 (ТипЗнч(ПолучитьСвойство(Параметры, "Основание")) = Тип("СправочникСсылка.Пользователи")) Или
			 (Параметры.Свойство("ЗначенияЗаполнения") И ПолучитьСвойство(Параметры.ЗначенияЗаполнения, "ТипКарты") = Перечисления.ТипыИнформационныхКарт.Регистрационная) Тогда
			 ВыбраннаяФорма = "ФормаЭлементаРегистрационнаяКарта"; 
		Иначе
			 ВыбраннаяФорма = "ФормаЭлементаДисконтнаяКарта"; 
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры // ОбработкаПолученияФормы()


Функция НайтиПоКодуКарты(КодКарты) Экспорт
	
	// Поиск.
	Возврат Справочники.ИнформационныеКарты.НайтиПоРеквизиту("КодКарты", КодКарты);

КонецФункции // НайтиПоКодуКарты()


Функция ДобавитьРегистрационнуюКарту(КодКарты, ВидКарты = Неопределено, ВладелецКарты, ГруппаПользователей) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	РегистрационнаяКартаСсылка = НайтиПоКодуКарты(КодКарты);
	Если ЗначениеЗаполнено(РегистрационнаяКартаСсылка) Тогда
		РегистрационнаяКартаОбъект = РегистрационнаяКартаСсылка.ПолучитьОбъект();
	Иначе
		РегистрационнаяКартаОбъект = Справочники.ИнформационныеКарты.СоздатьЭлемент();
	КонецЕсли;
	РегистрационнаяКартаОбъект.КодКарты = КодКарты;
	РегистрационнаяКартаОбъект.ВидКарты = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеЗначение(ВидКарты, Перечисления.ВидыИнформационныхКарт.Магнитная);
	РегистрационнаяКартаОбъект.ТипКарты = Перечисления.ТипыИнформационныхКарт.Регистрационная;
	РегистрационнаяКартаОбъект.ВладелецКарты = ВладелецКарты.Ссылка;
	РегистрационнаяКартаОбъект.ГруппаПользователей = ГруппаПользователей;
	РегистрационнаяКартаОбъект.ПометкаУдаления = Ложь;
	
	РегистрационнаяКартаОбъект.Записать();

	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат РегистрационнаяКартаОбъект.Ссылка;
	
КонецФункции // ДобавитьРегистрационнуюКарту()

Процедура УдалитьРегистрационнуюКарту(КодКарты, Удалить = Ложь) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	Если (ТипЗнч(КодКарты) = Тип("СправочникСсылка.ИнформационныеКарты")) Тогда
		РегистрационнаяКартаСсылка = КодКарты;
	Иначе
		РегистрационнаяКартаСсылка = НайтиПоКодуКарты(КодКарты);
	КонецЕсли; 
	Если ЗначениеЗаполнено(РегистрационнаяКартаСсылка) Тогда
		РегистрационнаяКартаОбъект = РегистрационнаяКартаСсылка.ПолучитьОбъект();
		РегистрационнаяКартаОбъект.ВладелецКарты = Справочники.Пользователи.ПустаяСсылка();
		РегистрационнаяКартаОбъект.ГруппаПользователей = Неопределено;
		РегистрационнаяКартаОбъект.ПометкаУдаления = РегистрационнаяКартаОбъект.ПометкаУдаления Или Удалить;
		
		РегистрационнаяКартаОбъект.Записать();
	КонецЕсли; 
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры // УдалитьРегистрационнуюКарту()





Процедура СоздатьЗаписьВСправочнике(CODE, CODESTR, NAME, TIP, DISC, CHECKCARD, OLDCODE, PERCENT, SUM, ВидКарты ,ТипКарты ,СтрАнализа ) Экспорт 
	
	Если TIP = 2 Тогда
		СтрАнализа.Удаленных = СтрАнализа.Удаленных + 1;
	КонецЕсли;
	
	Запрос = Новый Запрос;  
	Запрос.УстановитьПараметр("КодКарты", CODE);
	Запрос.УстановитьПараметр("Диск", DISC);	
	Запрос.УстановитьПараметр("ВладелецКарты", NAME);	
	//Запрос.УстановитьПараметр("ПроцентУточняемый", ЧИСЛО(PERCENT));
	//Костенюк Александр-Старт 02.04.2012
	Если ЗначениеЗаполнено(PERCENT) Тогда
		Запрос.УстановитьПараметр("ПроцентУточняемый", ЧИСЛО(PERCENT));
	Иначе
		Запрос.УстановитьПараметр("ПроцентУточняемый", "");
	КонецЕсли;
	//Костенюк Александр-Финиш 02.04.2012
	Запрос.Текст = "ВЫБРАТЬ
	               |	ДКарты.Ссылка,
	               |	ВЫБОР
	               |		КОГДА ДКарты.ВладелецКарты = &ВладелецКарты
	               |			ТОГДА ВЫБОР
	               |					КОГДА ДКарты.ВидДисконтнойКартыДиск = &Диск
	               |						ТОГДА ВЫБОР
	               |								КОГДА ДКарты.ПроцентУточняемый = &ПроцентУточняемый
	               |									ТОГДА ЛОЖЬ
	               |								ИНАЧЕ ИСТИНА
	               |							КОНЕЦ
	               |					ИНАЧЕ ИСТИНА
	               |				КОНЕЦ
	               |		ИНАЧЕ ИСТИНА
	               |	КОНЕЦ КАК Проверка
	               |ИЗ
	               |	(ВЫБРАТЬ ПЕРВЫЕ 1
	               |		ИнформационныеКарты.Ссылка КАК Ссылка,
	               |		ИнформационныеКарты.ВидДисконтнойКарты.Диск КАК ВидДисконтнойКартыДиск,
	               |		ИнформационныеКарты.ВладелецКарты КАК ВладелецКарты,
	               |		ИнформационныеКарты.ПроцентУточняемый КАК ПроцентУточняемый
	               |	ИЗ
	               |		Справочник.ИнформационныеКарты КАК ИнформационныеКарты
	               |	ГДЕ
	               |		ИнформационныеКарты.КодКарты = &КодКарты) КАК ДКарты";
	
	Результат =  Запрос.Выполнить();	  
	Выборка = Результат.Выбрать(ОбходРезультатаЗапроса.Прямой);	  
	
	Если Выборка.Следующий() Тогда 	  	  
		Если Выборка.Проверка Тогда
			НовыйСправочник = Выборка.Ссылка.ПолучитьОбъект();
		Иначе
			Возврат;
		КонецЕсли;	  
	Иначе 
		СтрАнализа.Новых  =  СтрАнализа.Новых + 1;
		НовыйСправочник = Справочники.ИнформационныеКарты.СоздатьЭлемент();
		НовыйСправочник.УстановитьНовыйКод();
	КонецЕсли;
	
	Если ПустаяСтрока(НовыйСправочник.Код) Тогда 
		НовыйСправочник.УстановитьНовыйКод();  
	КонецЕсли;
	
	НовыйСправочник.Наименование = "№"+ CODE;
	НовыйСправочник.ВидДисконтнойКарты = Справочники.ВидыДисконтныхКарт.ПолучитьВидДисконтнойКарты(TIP, DISC);
	НовыйСправочник.ВидКарты  = ВидКарты;
	НовыйСправочник.КодКарты  = CODE;
	НовыйСправочник.ВладелецКарты = NAME;
	НовыйСправочник.ТипКарты  =  ТипКарты;
	//НовыйСправочник.ПроцентУточняемый = Число(PERCENT);
	//Костенюк Александр-Старт 02.04.2012
	Если ЗначениеЗаполнено(PERCENT) Тогда
		НовыйСправочник.ПроцентУточняемый = Число(PERCENT);
	КонецЕсли;
	//Костенюк Александр-Финиш 02.04.2012
	
	Попытка 
		НовыйСправочник.ОбменДанными.Загрузка =Истина;
		НовыйСправочник.Записать();  
	Исключение  
		
	КонецПопытки;
	
КонецПроцедуры

Функция НайтиЭлементВСправочнике(CODE) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("КодКарты", CODE);	
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИнформационныеКарты.Ссылка
	|ИЗ
	|	Справочник.ИнформационныеКарты КАК ИнформационныеКарты
	|ГДЕ
	|	ИнформационныеКарты.КодКарты = &КодКарты";
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Справочники.ИнформационныеКарты.ПустаяСсылка();
	Иначе 
		Возврат Результат.Выгрузить()[0].Ссылка;
	КонецЕсли;	 	
	
КонецФункции

//Костенюк Александр-Старт 05.07.2012
// Процедура производит заполнение реквизитов справочника
// 
// Параметры
// СправочникОбъект - Тип: СправочникОбъект.ИнформационныеКарты
// СтруктураРеквизитов - Тип: Структура, значения реквизитов, которые подлежат заполнению
// 
Процедура ЗаполнитьРеквизитыЭлементаСправочника(СправочникОбъект, СтруктураРеквизитов) Экспорт
	
	//СправочникОбъект.Наименование 		= "№ "+ СтруктураРеквизитов.КодКарты;
	ЗаполнитьЗначенияСвойств(СправочникОбъект, СтруктураРеквизитов);
	
КонецПроцедуры
//Костенюк Александр-Финиш 05.07.2012

