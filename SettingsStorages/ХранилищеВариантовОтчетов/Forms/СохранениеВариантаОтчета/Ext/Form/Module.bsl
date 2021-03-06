﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	КлючОтчета = Параметры.КлючОбъекта;
	ПрототипКлюч = Параметры.КлючТекущихНастроек;
	
	ОтчетИнформация = ВариантыОтчетов.СформироватьИнформациюОбОтчетеПоПолномуИмени(КлючОтчета);
	Если ТипЗнч(ОтчетИнформация.ТекстОшибки) = Тип("Строка") Тогда
		ВызватьИсключение ОтчетИнформация.ТекстОшибки;
	КонецЕсли;
	ОтчетИнформация.Удалить("ОтчетМетаданные");
	ОтчетИнформация.Удалить("ТекстОшибки");
	ОтчетИнформация.Вставить("ЭтоВнешний", ОтчетИнформация.ТипОтчета = Перечисления.ТипыОтчетов.Внешний);
	ОтчетИнформация = Новый ФиксированнаяСтруктура(ОтчетИнформация);
	
	ПолныеПраваНаВарианты = ВариантыОтчетов.ПолныеПраваНаВарианты();
	
	Элементы.ТолькоДляАвтора.Подсказка        = Метаданные.Справочники.ВариантыОтчетов.Реквизиты.ТолькоДляАвтора.Подсказка;
	
	Если НЕ ПолныеПраваНаВарианты Тогда
		Элементы.ТолькоДляАвтора.Доступность      = Ложь;
		Элементы.ВидимостьПоУмолчанию.Доступность = Ложь;
		Элементы.Автор.Доступность                = Ложь;
	КонецЕсли;
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВариантыОтчетов.Ссылка КАК Ссылка,
	|	ВариантыОтчетов.Пользовательский КАК Пользовательский,
	|	ВариантыОтчетов.Наименование КАК Наименование,
	|	ВариантыОтчетов.Автор КАК Автор,
	|	ВариантыОтчетов.Описание КАК Описание,
	|	ВариантыОтчетов.ТипОтчета КАК Тип,
	|	ВариантыОтчетов.КлючВарианта КАК КлючВарианта,
	|	ВариантыОтчетов.ТолькоДляАвтора КАК ТолькоДляАвтора,
	|	ВЫБОР
	|		КОГДА ВариантыОтчетов.Автор = &ТекущийПользователь
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК АвторТекущийПользователь
	|ИЗ
	|	Справочник.ВариантыОтчетов КАК ВариантыОтчетов
	|ГДЕ
	|	ВариантыОтчетов.Отчет = &Отчет
	|	И ВариантыОтчетов.ПометкаУдаления = ЛОЖЬ";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Отчет",               ОтчетИнформация.Отчет);
	Запрос.УстановитьПараметр("ТекущийПользователь", ТекущийПользователь);
	Запрос.Текст = ТекстЗапроса;
	
	ТаблицаЗначений = Запрос.Выполнить().Выгрузить();
	
	ВариантыОтчета.Загрузить(ТаблицаЗначений);
	
	ДобавитьПредопределенныеВариантыВнешнегоОтчета();
	
	ВариантыОтчета.Сортировать("Наименование Возр");
	
	ИдентификаторТекущейСтроки = -1;
	Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("КлючВарианта", ПрототипКлюч));
	Если Найденные.Количество() > 0 Тогда
		Вариант = Найденные[0];
		ПрототипСсылка = Вариант.Ссылка;
		ВариантОписание = Вариант.Описание;
		ИдентификаторТекущейСтроки = Вариант.ПолучитьИдентификатор();
		Элементы.ВариантыОтчета.ТекущаяСтрока = ИдентификаторТекущейСтроки;
		ВариантыОтчетаОбработчикАктивизацииСтроки(ЭтаФорма);
	КонецЕсли;
	
	ВариантыОтчетов.ДеревоПодсистемДобавитьУсловноеОформление(ЭтаФорма);
	
	Если ОтчетИнформация.ЭтоВнешний Тогда
		Элементы.ОписаниеВнешнегоОтчета.Видимость = Истина;
		Элементы.Назад.Видимость = Ложь;
		Элементы.Далее.Видимость = Ложь;
		Элементы.ДекорацияДалее.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Если НЕ ЗначениеЗаполнено(ВариантНаименование) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Поле ""Наименование"" не заполнено'"),
			,
			"Наименование"
		);
		Отказ = Истина;
	ИначеЕсли ВариантыОтчетов.НаименованиеЗанято(ОтчетИнформация.Отчет, ВариантСсылка, ВариантНаименование) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = '""%1"" занято, необходимо указать другое Наименование.'"),
				ВариантНаименование
			),
			,
			"Наименование"
		);
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если Источник = ИмяФормы Тогда
		Возврат;
	КонецЕсли;
	
	Если ИмяСобытия = ВариантыОтчетовКлиентСервер.ИмяСобытияИзменениеВарианта()
		И ТипЗнч(Параметр) = Тип("Структура")
		И Параметр.Свойство("Ссылка") Тогда
		
		Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("Ссылка", Параметр.Ссылка));
		Если Найденные.Количество() = 1 Тогда
			Вариант = Найденные[0];
			ЗаполнитьЗначенияСвойств(Вариант, Параметр);
			Вариант.АвторТекущийПользователь = (Вариант.Автор = ТекущийПользователь);
			ВариантыОтчетаОбработчикАктивизацииСтроки(ЭтаФорма);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ТекущийЭлемент = Элементы.Наименование;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("Наименование", ВариантНаименование));
	Если Найденные.Количество() > 0 Тогда
		Элементы.ВариантыОтчета.ТекущаяСтрока = Найденные[0].ПолучитьИдентификатор();
		ВариантыОтчетаОбработчикАктивизацииСтроки(ЭтаФорма);
	Иначе
		ВариантСсылка = Неопределено;
		УстановитьЧтоБудетДальше(ЭтаФорма, Ложь);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("Наименование", Текст));
	УстановитьЧтоБудетДальше(ЭтаФорма, Найденные.Количество() > 0);
КонецПроцедуры

&НаКлиенте
Процедура ТолькоДляАвтораПриИзменении(Элемент)
	УстановитьВидимостьПоУмолчанию(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура АвторОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ОписаниеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	__ОбщегоНазначенияКлиентСервер.ОткрытьФормуРедактированияМногострочногоТекста(
		ВариантОписание,
		ВариантОписание,
		Модифицированность,
		НСтр("ru = 'Описание'")
	);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ВариантыОтчета

&НаКлиенте
Процедура ВариантыОтчетаПриАктивизацииСтроки(Элемент)
	Если ИдентификаторТекущейСтроки = Элементы.ВариантыОтчета.ТекущаяСтрока Тогда
		Возврат;
	КонецЕсли;
	ВариантыОтчетаОбработчикАктивизацииСтроки(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ВариантыОтчетаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	СохранитьИЗакрыть();
КонецПроцедуры

&НаКлиенте
Процедура ВариантыОтчетаПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	ОткрытьВариантДляИзменения();
КонецПроцедуры

&НаКлиенте
Процедура ВариантыОтчетаПередУдалением(Элемент, Отказ)
	Вариант = Элементы.ВариантыОтчета.ТекущиеДанные;
	Если Вариант = Неопределено ИЛИ НЕ ЗначениеЗаполнено(Вариант.Ссылка) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если НЕ ПолныеПраваНаВарианты И НЕ Вариант.АвторТекущийПользователь Тогда
		Отказ = Истина;
		Предупреждение(НСтр("ru = 'Недостаточно прав доступа для удаления варианта'") + " " + Вариант.Наименование);
		Возврат;
	КонецЕсли;
	
	Если НЕ Вариант.Пользовательский Тогда
		Отказ = Истина;
		Предупреждение(НСтр("ru = 'Невозможно удалить предопределенный вариант.'"));
		Возврат;
	КонецЕсли;
	
	ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Пометить ""%1"" на удаление?'"),
		Вариант.Наименование
	);
	
	Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет, 60, КодВозвратаДиалога.Да); 
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	УдалитьВариантНаСервере(Вариант.Ссылка);
	ВариантСсылка = Неопределено;
	УстановитьЧтоБудетДальше(ЭтаФорма, ЗначениеЗаполнено(ВариантСсылка));
КонецПроцедуры

&НаКлиенте
Процедура ВариантыОтчетаПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	Отказ = Истина;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ДеревоПодсистем

&НаКлиенте
Процедура ДеревоПодсистемИспользованиеПриИзменении(Элемент)
	ВариантыОтчетовКлиент.ДеревоПодсистемИспользованиеПриИзменении(ЭтаФорма, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПодсистемВажностьПриИзменении(Элемент)
	ВариантыОтчетовКлиент.ДеревоПодсистемВажностьПриИзменении(ЭтаФорма, Элемент);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура Назад(Команда)
	Элементы.Страницы.ТекущаяСтраница = Элементы.Страница1;
	Элементы.Назад.Доступность        = Ложь;
	Элементы.Далее.Заголовок          = "";
	Элементы.Далее.Доступность        = Истина;
КонецПроцедуры

&НаКлиенте
Процедура Далее(Команда)
	Если ПерейтиНаСтраницу2Клиент() Тогда
		ПерезаполнитьДерево();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьИЗакрыть();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Функция ПерейтиНаСтраницу2Клиент()
	Если НЕ ЗначениеЗаполнено(ВариантНаименование) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Поле ""Наименование"" не заполнено'"),
			,
			"ВариантНаименование"
		);
		Возврат Ложь;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ВариантСсылка) Тогда
		Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("Ссылка", ВариантСсылка));
		Вариант = Найденные[0];
		Если НЕ ПравоЗаписиВарианта(Вариант, ПравоНастройкиВарианта(Вариант, ПолныеПраваНаВарианты)) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Недостаточно прав на изменение варианта ""%1"", необходимо выбрать другой вариант или изменить Наименование.'"),
					ВариантНаименование
				),
				,
				"ВариантНаименование"
			);
			Возврат Ложь;
		КонецЕсли;
		
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Заменить ранее сохраненный вариант отчета ""%1""?'"),
			ВариантНаименование
		);
		
		Ответ = Вопрос(ТекстВопроса, РежимДиалогаВопрос.ДаНет, 60, КодВозвратаДиалога.Да); 
		Если Ответ <> КодВозвратаДиалога.Да Тогда
			Возврат Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	// Для внешних отчетов выполняются только проверки заполнения, без переключения страницы.
	Если ОтчетИнформация.ЭтоВнешний Тогда
		Возврат Истина;
	КонецЕсли;
	
	// Для отчетов конфигурации переключается страница.
	Если ВариантТолькоДляАвтора Тогда
		ВариантВидимостьПоУмолчанию = Ложь;
		Элементы.ВидимостьПоУмолчанию.Видимость = Ложь;
	Иначе
		Элементы.ВидимостьПоУмолчанию.Видимость = Истина;
	КонецЕсли;
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.Страница2;
	Элементы.Назад.Доступность        = Истина;
	Элементы.Далее.Доступность        = Ложь;
	
	Возврат Истина;
КонецФункции

&НаКлиенте
Процедура ОткрытьВариантДляИзменения()
	Вариант = Элементы.ВариантыОтчета.ТекущиеДанные;
	Если Вариант = Неопределено ИЛИ НЕ ЗначениеЗаполнено(Вариант.Ссылка) Тогда
		Возврат;
	КонецЕсли;
	Если НЕ ПравоНастройкиВарианта(Вариант, ПолныеПраваНаВарианты) Тогда
		Предупреждение(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Недостаточно прав доступа для изменения варианта ""%1"".'"),
				Вариант.Наименование
			)
		);
		Возврат;
	КонецЕсли;
	ОткрытьЗначение(Вариант.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрыть()
	Страница2Заполнена = (Элементы.Страницы.ТекущаяСтраница = Элементы.Страница2);
	Если НЕ Страница2Заполнена Тогда
		Если НЕ ПерейтиНаСтраницу2Клиент() Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Если ПроверитьИЗаписатьНаСервере(Страница2Заполнена) И ЗначениеЗаполнено(ВариантКлючВарианта) Тогда
		
		ВариантыОтчетовКлиент.ОбновитьОткрытыеПанелиОтчетов(, ИмяФормы);
		
		Закрыть(Новый ВыборНастроек(ВариантКлючВарианта));
		
	КонецЕсли;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Клиент и сервер

&НаКлиентеНаСервереБезКонтекста
Процедура ВариантыОтчетаОбработчикАктивизацииСтроки(ЭтаФорма)
	ЭтаФорма.ИдентификаторТекущейСтроки = ЭтаФорма.Элементы.ВариантыОтчета.ТекущаяСтрока;
	
	Вариант = ЭтаФорма.ВариантыОтчета.НайтиПоИдентификатору(ЭтаФорма.ИдентификаторТекущейСтроки);
	Если Вариант = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПравоНастройкиВарианта = ПравоНастройкиВарианта(Вариант, ЭтаФорма.ПолныеПраваНаВарианты);
	ПравоЗаписиВарианта    = ПравоЗаписиВарианта(Вариант, ПравоНастройкиВарианта);
	ЭтаФорма.Элементы.ВариантыОтчетаИзменить.Доступность = ПравоНастройкиВарианта;
	ЭтаФорма.Элементы.ВариантыОтчетаУдалить.Доступность  = ПравоЗаписиВарианта;
	Если ПравоЗаписиВарианта Тогда
		ЭтаФорма.ВариантНаименование    = Вариант.Наименование;
		ЭтаФорма.ВариантТолькоДляАвтора = Вариант.ТолькоДляАвтора;
		ЭтаФорма.ВариантАвтор           = Вариант.Автор;
		ЭтаФорма.ВариантСсылка          = Вариант.Ссылка;
		ЭтаФорма.ВариантОписание        = Вариант.Описание;
	Иначе
		ЭтаФорма.ВариантНаименование    = СформироватьСвободноеНаименование(Вариант, ЭтаФорма.ВариантыОтчета);
		ЭтаФорма.ВариантТолькоДляАвтора = Истина;
		ЭтаФорма.ВариантАвтор           = ЭтаФорма.ТекущийПользователь;
		ЭтаФорма.ВариантСсылка          = Неопределено;
		ЭтаФорма.ВариантОписание        = "";
	КонецЕсли;
	
	УстановитьЧтоБудетДальше(ЭтаФорма, ЗначениеЗаполнено(ЭтаФорма.ВариантСсылка));
	УстановитьВидимостьПоУмолчанию(ЭтаФорма);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПравоНастройкиВарианта(Вариант, ПолныеПраваНаВарианты)
	Возврат (ПолныеПраваНаВарианты ИЛИ Вариант.АвторТекущийПользователь) И ЗначениеЗаполнено(Вариант.Ссылка);
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПравоЗаписиВарианта(Вариант, ПравоНастройкиВарианта)
	Возврат Вариант.Пользовательский И ПравоНастройкиВарианта;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция СформироватьСвободноеНаименование(Вариант, ВариантыОтчета)
	ШаблонИмениВарианта = СокрЛП(Вариант.Наименование) +" - "+ НСтр("ru = 'копия'");
	
	СвободноеНаименование = ШаблонИмениВарианта;
	Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("Наименование", СвободноеНаименование));
	Если Найденные.Количество() = 0 Тогда
		Возврат СвободноеНаименование;
	КонецЕсли;
	
	ШаблонИмениВарианта = ШаблонИмениВарианта +" (%1)";
	НомерВарианта = 1;
	Пока Истина Цикл
		НомерВарианта = НомерВарианта + 1;
		СвободноеНаименование = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ШаблонИмениВарианта,
			Формат(НомерВарианта, "")
		);
		Найденные = ВариантыОтчета.НайтиСтроки(Новый Структура("Наименование", СвободноеНаименование));
		Если Найденные.Количество() = 0 Тогда
			Возврат СвободноеНаименование;
		КонецЕсли;
	КонецЦикла;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьПоУмолчанию(ЭтаФорма)
	ЭтаФорма.Элементы.ВидимостьПоУмолчанию.Видимость = НЕ (ЭтаФорма.ОтчетИнформация.ЭтоВнешний И ЭтаФорма.ВариантТолькоДляАвтора);
	Если ЭтаФорма.ВариантТолькоДляАвтора Тогда
		ЭтаФорма.ВариантВидимостьПоУмолчанию = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЧтоБудетДальше(ЭтаФорма, Перезапись)
	Если Перезапись Тогда
		ЭтаФорма.Элементы.ПерезаписьИлиНовый.ТекущаяСтраница = ЭтаФорма.Элементы.Перезапись;
	Иначе
		ЭтаФорма.Элементы.ПерезаписьИлиНовый.ТекущаяСтраница = ЭтаФорма.Элементы.Новый;
	КонецЕсли;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервереБезКонтекста
Процедура УдалитьВариантНаСервере(Ссылка)
	ВариантОбъект = Ссылка.ПолучитьОбъект();
	ВариантОбъект.УстановитьПометкуУдаления(Истина);
КонецПроцедуры

&НаСервере
Функция ПерезаполнитьДерево()
	Если ЗначениеЗаполнено(ВариантСсылка) Тогда
		ВариантОснование = ВариантСсылка;
	Иначе
		ВариантОснование = ПрототипСсылка;
	КонецЕсли;
	
	ДеревоПриемник = ВариантыОтчетов.ДеревоПодсистемСформировать(ЭтаФорма, ВариантОснование);
	
	Найденные = ДеревоПриемник.Строки.НайтиСтроки(Новый Структура("Использование", 1), Истина);
	Для Каждого Приемник Из Найденные Цикл
		Приемник.ИспользованиеПоУмолчанию = 0;
		Приемник.ВажностьПоУмолчанию      = "";
		Приемник.ИзмененПользователем     = Истина;
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ДеревоПриемник, "ДеревоПодсистем");
	
	Возврат Истина;
КонецФункции

&НаСервере
Функция ПроверитьИЗаписатьНаСервере(Страница2Заполнена)
	Если НЕ Страница2Заполнена И НЕ ОтчетИнформация.ЭтоВнешний Тогда
		ПерезаполнитьДерево();
	КонецЕсли;
	
	ВариантЭтоНовый = НЕ ЗначениеЗаполнено(ВариантСсылка);
	
	Если ВариантЭтоНовый И ВариантыОтчетов.НаименованиеЗанято(ОтчетИнформация.Отчет, ВариантСсылка, ВариантНаименование) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = '""%1"" занято, необходимо указать другое Наименование.'"),
				ВариантНаименование
			),
			,
			"ВариантНаименование"
		);
		Возврат Ложь;
	КонецЕсли;
	
	Если ВариантЭтоНовый Тогда
		ВариантОбъект = Справочники.ВариантыОтчетов.СоздатьЭлемент();
		ВариантОбъект.Отчет            = ОтчетИнформация.Отчет;
		ВариантОбъект.ТипОтчета        = ОтчетИнформация.ТипОтчета;
		ВариантОбъект.КлючВарианта     = Строка(Новый УникальныйИдентификатор());
		ВариантОбъект.Пользовательский = Истина;
	Иначе
		ВариантОбъект = ВариантСсылка.ПолучитьОбъект();
	КонецЕсли;
	
	Если ОтчетИнформация.ЭтоВнешний Тогда
		ВариантОбъект.Размещение.Очистить();
	Иначе
		ВариантыОтчетов.ДеревоПодсистемЗаписать(ЭтаФорма, ВариантОбъект);
	КонецЕсли;
	
	ВариантОбъект.Автор           = ВариантАвтор;
	ВариантОбъект.Наименование    = ВариантНаименование;
	ВариантОбъект.Описание        = ВариантОписание;
	ВариантОбъект.ТолькоДляАвтора = ВариантТолькоДляАвтора;
	
	Если ОтчетИнформация.ЭтоВнешний Тогда
		ВариантОбъект.ВидимостьПоУмолчанию = Ложь;
	Иначе
		ВариантОбъект.ВидимостьПоУмолчанию = ВариантВидимостьПоУмолчанию;
	КонецЕсли;
	
	ВариантОбъект.Записать();
	
	ВариантСсылка       = ВариантОбъект.Ссылка;
	ВариантКлючВарианта = ВариантОбъект.КлючВарианта;
	Возврат Истина;
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Процедура ДобавитьПредопределенныеВариантыВнешнегоОтчета()
	
	Если НЕ ОтчетИнформация.ЭтоВнешний Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ОтчетОбъект = ВнешниеОтчеты.Создать(ОтчетИнформация.ОтчетИмя);
	Исключение
		ВариантыОтчетов.ОшибкаПоВарианту(Неопределено,
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не удалось получить список предопределенных вариантов
				|внешнего отчета ""%1"":'"),
				ОтчетИнформация.ОтчетИмя
			) + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке())
		);
		Возврат;
	КонецПопытки;
	
	Если ОтчетОбъект.СхемаКомпоновкиДанных = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ВариантНастроекКД Из ОтчетОбъект.СхемаКомпоновкиДанных.ВариантыНастроек Цикл
		Вариант = ВариантыОтчета.Добавить();
		Вариант.Пользовательский = Ложь;
		Вариант.Наименование = ВариантНастроекКД.Представление;
		Вариант.КлючВарианта = ВариантНастроекКД.Имя;
		Вариант.ТолькоДляАвтора = Ложь;
		Вариант.АвторТекущийПользователь = Ложь;
	КонецЦикла;
	
КонецПроцедуры
