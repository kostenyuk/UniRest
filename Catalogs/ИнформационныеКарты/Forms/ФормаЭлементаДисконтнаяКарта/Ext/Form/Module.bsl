﻿
&НаКлиенте
Функция ПолучитьНаименование()

	Если (Объект.ТипКарты = ПредопределенноеЗначение("Перечисление.ТипыИнформационныхКарт.Регистрационная")) Тогда
		Возврат НСтр("ru = 'Регистрационная № [КодКарты]'; uk = 'Реєстраційна № [КодКарты]'") + Объект.КодКарты;
	КонецЕсли; 
	
	////Костенюк Александр-Закомментировано 18.03.2015
	//Если (Объект.ТипКарты = ПредопределенноеЗначение("Перечисление.ТипыИнформационныхКарт.Дисконтная")) Тогда
	//	Если ЗначениеЗаполнено(Объект.ВидДисконтнойКарты) И (Не ПустаяСтрока(Объект.КодКарты)) Тогда
	//		//Возврат Шаблон("[ВидДисконтнойКарты] № [КодКарты]", 
	//		//Новый Структура("ВидДисконтнойКарты,КодКарты", Объект.ВидДисконтнойКарты, Объект.КодКарты));
	//		//Костенюк Александр-Старт 19.07.2012
	//		Если ЗначениеЗаполнено(Объект.ВладелецКарты) Тогда
	//			Возврат Шаблон("[ВладелецКарты]", Новый Структура("ВладелецКарты", Объект.ВладелецКарты));
	//		Иначе
	//			Возврат Шаблон("[ВидДисконтнойКарты] № [КодКарты]",	Новый Структура("ВидДисконтнойКарты,КодКарты", Объект.ВидДисконтнойКарты, Объект.КодКарты));
	//		КонецЕсли;
	//		//Костенюк Александр-Финиш 19.07.2012
	//	КонецЕсли; 
	//КонецЕсли; 
	
	Возврат "№" + Объект.КодКарты; 
		
КонецФункции // ПолучитьНаименование()

&НаСервере
Функция ПолучитьНаименованиеНаСервере()

	Если (Объект.ТипКарты = ПредопределенноеЗначение("Перечисление.ТипыИнформационныхКарт.Регистрационная")) Тогда
		Возврат НСтр("ru = 'Регистрационная № [КодКарты]'; uk = 'Реєстраційна № [КодКарты]'") + Объект.КодКарты;
	КонецЕсли;
	
	////Костенюк Александр-Закомментировано 18.03.2015
	//Если (Объект.ТипКарты = ПредопределенноеЗначение("Перечисление.ТипыИнформационныхКарт.Дисконтная")) Тогда
	//	Если ЗначениеЗаполнено(Объект.ВидДисконтнойКарты) И (Не ПустаяСтрока(Объект.КодКарты)) Тогда
	//		//Возврат Шаблон("[ВидДисконтнойКарты] № [КодКарты]", 
	//		//	Новый Структура("ВидДисконтнойКарты,КодКарты", Объект.ВидДисконтнойКарты, Объект.КодКарты));
	//		//Костенюк Александр-Старт 19.07.2012
	//		Если ЗначениеЗаполнено(Объект.ВладелецКарты) Тогда
	//			Возврат Шаблон("[ВладелецКарты]", Новый Структура("ВладелецКарты", Объект.ВладелецКарты));
	//		Иначе
	//			Возврат Шаблон("[ВидДисконтнойКарты] № [КодКарты]",	Новый Структура("ВидДисконтнойКарты,КодКарты", Объект.ВидДисконтнойКарты, Объект.КодКарты));
	//		КонецЕсли;
	//		//Костенюк Александр-Финиш 19.07.2012
	//	КонецЕсли; 
	//КонецЕсли; 
	
	Возврат "№" + Объект.КодКарты; 
		
КонецФункции // ПолучитьНаименованиеНаСервере()


&НаКлиенте
Процедура ВидДисконтнойКартыПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименование(), Элементы.Наименование);
	
КонецПроцедуры // ВидДисконтнойКартыПриИзменении()

&НаСервере
Процедура ВидДисконтнойКартыПриИзмененииСервер()
	
	//Элементы.ВидДисконтнойКарты.ТолькоПросмотр = Объект.Ссылка.ВидДисконтнойКарты.OnLine;
	//Элементы.ВидКарты.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.КодКарты.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.ТипШтрихкода.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.Штрихкод.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.ПроцентУточняемый.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.ТипВладелецаКарты.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.ВладелецКарты.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.ДатаРождения.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//
	//Элементы.Телефон.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.Адресс.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//Элементы.EMail.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	
	//Костенюк Александр-Старт 15.12.2014
	// Только просмотр для основных параметров
	Элементы.ВидДисконтнойКарты.ТолькоПросмотр = Объект.Ссылка.ВидДисконтнойКарты.OnLine ИЛИ (Объект.Ссылка.ВидДисконтнойКарты.Локальная И РольДоступна("Администратор"));
	Элементы.ВидКарты.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	Элементы.КодКарты.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	Элементы.Наименование.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	Элементы.ТипШтрихкода.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	Элементы.Штрихкод.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	Элементы.ПроцентУточняемый.ТолькоПросмотр = Элементы.ВидДисконтнойКарты.ТолькоПросмотр;
	//// Только просмотр для групп элементов
	//Элементы.ГруппаВладелецКарты.ТолькоПросмотр = Объект.Ссылка.ВидДисконтнойКарты.OnLine;
	//Элементы.ГруппаКонтактнаяИнформация.ТолькоПросмотр = Объект.Ссылка.ВидДисконтнойКарты.OnLine;
	//Элементы.ГруппаМестоВыдачи.ТолькоПросмотр = Объект.Ссылка.ВидДисконтнойКарты.OnLine;
	//Элементы.ГруппаЧленыСемьи.ТолькоПросмотр = Объект.Ссылка.ВидДисконтнойКарты.OnLine;
	//Костенюк Александр-Финиш 15.12.2014
	
КонецПроцедуры // ВидДисконтнойКартыПриИзменении()

&НаКлиенте
Процедура ВидКартыПриИзменении(Элемент)
	
	Если Не ЗначениеЗаполнено(Объект.ВидКарты) Тогда
		Объект.ВидКарты = ПредопределенноеЗначение("Перечисление.ВидыИнформационныхКарт.Магнитная");
	КонецЕсли; 
	
	Если (Объект.ВидКарты = ПредопределенноеЗначение("Перечисление.ВидыИнформационныхКарт.Штриховая")) Тогда
		Элементы.ГруппаГруппаКодКартыВидКартыСтраници.ТекущаяСтраница = Элементы.ГруппаКодКартыШтриховая;
	Иначе
		Элементы.ГруппаГруппаКодКартыВидКартыСтраници.ТекущаяСтраница = Элементы.ГруппаКодКартыМагнитная;
	КонецЕсли; 
	
КонецПроцедуры // ВидКартыПриИзменении()

&НаКлиенте
Процедура ТипШтрихкодаПриИзменении(Элемент)
	
	Если Не ЗначениеЗаполнено(Объект.ТипШтрихкода) Тогда
		Объект.ТипШтрихкода = ПредопределенноеЗначение("ПланВидовХарактеристик.ТипыШтрихкодов.EAN13");
	КонецЕсли; 
	
КонецПроцедуры // ТипШтрихкодаПриИзменении()

&НаКлиенте
Процедура ШтрихкодНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ШтрихкодНачалоВыбораСервер();
	
	КодКартыПриИзменении(Элемент);
	
КонецПроцедуры // ШтрихкодНачалоВыбора()

&НаСервере
Процедура ШтрихкодНачалоВыбораСервер()
	
	Объект.КодКарты = РегистрыСведений.Штрихкоды.СформироватьШтрихКод(Неопределено, Объект.ТипШтрихкода);
	
КонецПроцедуры // ШтрихкодНачалоВыбораСервер()

&НаКлиенте
Процедура КодКартыПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеСформировать(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименование(), Элементы.Наименование);
	
КонецПроцедуры // КодКартыПриИзменении()

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименование(), Элементы.Наименование);
	
КонецПроцедуры // НаименованиеПриИзменении()

&НаКлиенте
Процедура ВладелецКартыПриИзменении(Элемент)
	
	ТипВладелецаКартыПриИзменении(Элемент);
	
КонецПроцедуры // ВладелецКартыПриИзменении()

&НаКлиенте
Процедура ТипВладелецаКартыПриИзменении(Элемент)
	
	ТипВладелецаКарты = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеЗначение(ТипВладелецаКарты, "Строка");
	
	ОписаниеТипов = Новый ОписаниеТипов(ТипВладелецаКарты);
	Объект.ВладелецКарты = ОписаниеТипов.ПривестиЗначение(Объект.ВладелецКарты);
	
КонецПроцедуры // ТипВладелецаКартыПриИзменении()

&НаКлиенте
Процедура ПоследнееПоздравлениеНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПоследнееПоздравлениеНажатиеНаСервере();
	
КонецПроцедуры // ПоследнееПоздравлениеНажатие()

&НаСервере
Процедура ПоследнееПоздравлениеНажатиеНаСервере()
	
	Элементы.ПоследнееПоздравление.Вид = ВидПоляФормы.ПолеВвода;
	
КонецПроцедуры // ПоследнееПоздравлениеНажатиеНаСервере()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// ВладелецаКарты.
	Если (ТипЗнч(Объект.ВладелецКарты) = Тип("Строка")) Тогда
		ТипВладелецаКарты = "Строка";
	КонецЕсли; 
	Если (ТипЗнч(Объект.ВладелецКарты) = Тип("СправочникСсылка.Контрагенты")) Тогда
		ТипВладелецаКарты = "СправочникСсылка.Контрагенты";
	КонецЕсли; 
	ТипВладелецаКарты = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеЗначение(ТипВладелецаКарты, "Строка");
	
	// Данные.
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииНаСервере(Объект);	
	КонецЕсли;
	
	// Отказ.
	Отказ = (Объект.ТипКарты = Перечисления.ТипыИнформационныхКарт.Регистрационная);
	
	// Настройка формы.
	Элементы.ДатаОкончанияПериода.Видимость = ЗначениеЗаполнено(Объект.ДатаОкончанияПериода);
	
КонецПроцедуры // ПриСозданииНаСервере()

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Настройка формы.	
	ВидКартыПриИзменении(Неопределено);
	ТипВладелецаКартыПриИзменении(Неопределено);

КонецПроцедуры // ПриОткрытии()

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Объект.ТипКарты = __ОбщегоНазначенияКлиентСервер.ПолучитьНеПустоеЗначение(Объект.ТипКарты, Перечисления.ТипыИнформационныхКарт.Дисконтная);
	
	Если Не ЗначениеЗаполнено(ТекущийОбъект.ТипШтрихкода) Тогда
		Объект.ТипШтрихкода = ПредопределенноеЗначение("ПланВидовХарактеристик.ТипыШтрихкодов.EAN13");
	КонецЕсли; 
	
	// Автоматическое формирование наименования.
	__РаботаСДиалогамиКлиентСервер.ФормаНаименованиеАвтоматическоеФормированиеУстановитьПризнак(ФормироватьНаименованиеАвтоматически, Объект.Наименование, ПолучитьНаименованиеНаСервере(), Элементы.Наименование);
	
	// Настройка формы.
	ВидДисконтнойКартыПриИзмененииСервер();

КонецПроцедуры // ПриЧтенииНаСервере()

&НаКлиенте
//Костенюк Александр-Старт 18.10.2012
Процедура ЗаполнитьКонтактнуюИнформацию(Команда)
	
	Если НЕ ЗначениеЗаполнено(Объект.ВладелецКарты) Тогда
		Предупреждение(НСтр("ru='Не указан владелец карты';uk='Не вказаний власник карти'"), 10);
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Объект.ВладелецКарты) <> Тип("СправочникСсылка.Контрагенты") Тогда
		Предупреждение(НСтр("ru='Владелец не является ссылкой на справочник ""Контрагенты""';uk='Власник не є посиланням на довідник ""Контрагенти""'"), 10);
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.Телефон) ИЛИ
		ЗначениеЗаполнено(Объект.Адресс) ИЛИ
		ЗначениеЗаполнено(Объект.EMail) Тогда
		Режим = РежимДиалогаВопрос.ДаНет;
		Текст = "ru='Контактная информация будет перезаполнена. Продолжить?';uk='Контактна інформація буде перенаповнена. Продовжити?'";
		Ответ = Вопрос(НСтр(Текст), Режим, 0);
		Если Ответ = КодВозвратаДиалога.Нет Тогда
			Возврат;
		КонецЕсли;
		ОчиститьКонтактнуюИнформациюНаСервере();
	КонецЕсли;
	
	ЗаполнитьКонтактнуюИнформациюНаСервере();
	
	Модифицированность = Истина;
	
КонецПроцедуры
//Костенюк Александр-Финиш 18.10.2012

&НаСервере
//Костенюк Александр-Старт 18.10.2012
Процедура ЗаполнитьКонтактнуюИнформациюНаСервере()
	
	ЭтотОбъект = РеквизитФормыВЗначение("Объект");
	ЭтотОбъект.ЗаполнитьКонтактнуюИнформацию(Объект.ВладелецКарты);
	ЗначениеВРеквизитФормы(ЭтотОбъект, "Объект");
	
КонецПроцедуры
//Костенюк Александр-Финиш 18.10.2012

//Костенюк Александр-Старт 18.10.2012
&НаСервере
Процедура ОчиститьКонтактнуюИнформациюНаСервере()
	
	ЭтотОбъект = РеквизитФормыВЗначение("Объект");
	ЭтотОбъект.ОчиститьКонтактнуюИнформацию();
	ЗначениеВРеквизитФормы(ЭтотОбъект, "Объект");
	
КонецПроцедуры
//Костенюк Александр-Финиш 18.10.2012
