﻿
#Если Клиент Тогда
	
// Процедура инициализация модуля рабочего места.
//
Процедура Инициализация() Экспорт
	
	// Проверка режима.
	Если ПолучитьСерверFrontOffice().РежимBackOffice Тогда
		Возврат;
	КонецЕсли;
	
	// Создание формы.
	Если (Форма = Неопределено) Тогда
		Форма = ЭтотОбъект.ПолучитьФорму("Форма");
		ПолучитьСерверFrontOffice().__ОткрытьФорму(Форма);
		Сообщить(ОписаниеОшибки());
	КонецЕсли;
		
КонецПроцедуры // Инициализация()

// Процедура открытия формы рабочего места.
//
Процедура Открыть() Экспорт
	
	// Открытие формы.
	ПолучитьСерверFrontOffice().__ОткрытьФорму(Форма);
		
КонецПроцедуры // Открыть()


Функция ВыборКассыККМ(Значение = Неопределено) Экспорт
	
	// Данные.
	Запрос = Новый Запрос("ВЫБРАТЬ Ссылка, Владелец КАК Родитель, ЛОЖЬ КАК ЭтоГруппа, Представление КАК Наименование ИЗ ВременнаяКассыККМ КАК КассыККМ ГДЕ НЕ ПометкаУдаления
						  |ОБЪЕДИНИТЬ ВСЕ
						  |ВЫБРАТЬ Ссылка, NULL, ИСТИНА КАК ЭтоГруппа, Представление КАК Наименование ИЗ ВременнаяОрганизации КАК Организации");
	Запрос.МенеджерВременныхТаблиц = ПолучитьСерверFrontOffice().МенеджерВременныхТаблиц;
	ДеревоЗначений = ОбщегоНазначения.ТаблицуЗначенийВДеревоЗначений(Запрос.Выполнить().Выгрузить(), "Ссылка", "Родитель");
	СтрокаДерева = ДеревоЗначений.Строки.Найти(Значение, "Ссылка", Истина);
	
	// Выбор.
	Если Обработки.FrontOfficeВыборЗначения.Создать().ВыборИзДереваЗначений(СтрокаДерева, НСтр("ru='Выберите кассу';uk='Виберіть касу'") , ДеревоЗначений, "Картинка,Наименование") Тогда
		Значение = СтрокаДерева.Ссылка;
		ДеревоЗначений = Неопределено;
		Возврат Истина;
	КонецЕсли;
	
	ДеревоЗначений = Неопределено;
	
	Возврат Ложь;
	
КонецФункции

Функция ВыборСотрудника(Значение = Неопределено) Экспорт
	
	// Данные.
	Запрос = Новый Запрос("ВЫБРАТЬ *, Представление КАК Наименование ИЗ ВременнаяСотрудникиОрганизаций ГДЕ НЕ ПометкаУдаления");
	Запрос.МенеджерВременныхТаблиц = ПолучитьСерверFrontOffice().МенеджерВременныхТаблиц;
	ДеревоЗначений = ОбщегоНазначения.ТаблицуЗначенийВДеревоЗначений(Запрос.Выполнить().Выгрузить(), "Ссылка", "Родитель");
	СтрокаДерева = ДеревоЗначений.Строки.Найти(Значение, "Ссылка", Истина);
	
	// Выбор.
	Если Обработки.FrontOfficeВыборЗначения.Создать().ВыборИзДереваЗначений(СтрокаДерева, НСтр("ru='Выберите сотрудника';uk='Виберіть працівника'"), ДеревоЗначений, "Картинка,Наименование") Тогда
		Значение = СтрокаДерева.Ссылка;
		ДеревоЗначений = Неопределено;
		Возврат Истина;
	КонецЕсли;
	
	ДеревоЗначений = Неопределено;
	
	Возврат Ложь;
	
КонецФункции

Функция ВыборРежимаЗавершенияРаботыПользователей(Значение = Неопределено) Экспорт
	
	// Данные.
	ТаблицаЗначений = Новый ТаблицаЗначений;
	ТаблицаЗначений.Колонки.Добавить("Ссылка", Новый ОписаниеТипов("ПеречислениеСсылка.РежимыЗавершенияРаботыПользователей"));
	ТаблицаЗначений.Колонки.Добавить("Наименование", Новый ОписаниеТипов("Строка"), "Наименование", СтрДлина(Метаданные.Перечисления.РежимыЗавершенияРаботыПользователей.ЗначенияПеречисления.ПредупредитьПользователейОЗавершенииРаботы.Синоним));
	Для Каждого ЗначениеПеречисления Из Метаданные.Перечисления.РежимыЗавершенияРаботыПользователей.ЗначенияПеречисления Цикл
		СтрокаТаблицы = ТаблицаЗначений.Добавить();
		СтрокаТаблицы.Ссылка = Перечисления.РежимыЗавершенияРаботыПользователей[ЗначениеПеречисления.Имя];
		СтрокаТаблицы.Наименование = ЗначениеПеречисления.Синоним;
	КонецЦикла;
	СтрокаТаблицы = ТаблицаЗначений.Найти(Значение, "Ссылка");
	
	// Выбор.
	Если Обработки.FrontOfficeВыборЗначения.Создать().ВыборИзТаблицыЗначений(СтрокаТаблицы, НСтр("ru='Выберите режимы завершения работы пользователей';uk='Виберіть режими завершення роботи користувачів'") , ТаблицаЗначений, "Картинка,Наименование") И (Не Значение = СтрокаТаблицы.Ссылка) Тогда
		Значение = СтрокаТаблицы.Ссылка;
		ТаблицаЗначений = Неопределено;
		Возврат Истина;
	КонецЕсли;
	
	ТаблицаЗначений = Неопределено;
	
	Возврат Ложь;
	
КонецФункции // ВыборРежимаЗавершенияРаботыПользователей()


// Процедура заполнения табличного поля пользоваителей.
//
// Параметры:
//
//Процедура ДеревоПользователейПрочитать(ТабличноеПоле, Разрешено = Истина) Экспорт
//Костенюк Александр-Старт 23.04.2012
Процедура ДеревоПользователейПрочитать(ТабличноеПоле, Разрешено = Истина, ТекущийПользователь = Неопределено) Экспорт
//Костенюк Александр-Финиш 23.04.2012
	
	// Данные.
	Данные = ТабличноеПоле.Данные();
	Если (Данные = Неопределено) Тогда
		Данные = Новый ДеревоЗначений;
		Данные.Колонки.Добавить("ПользовательГруппыПользователей", Новый ОписаниеТипов("СправочникСсылка.Пользователи,СправочникСсылка.ГруппыПользователей"));
		//Данные.Колонки.Добавить("ПользовательГруппыПользователейПредставление", Новый ОписаниеТипов("Строка"), "Пользователь/группы пользователей");
		//Костенюк Александр-Старт 31.05.2012
		Данные.Колонки.Добавить("ПользовательГруппыПользователейПредставление", Новый ОписаниеТипов("Строка"), НСтр("ru='Пользователь/группы пользователей';uk='Користувач/групи користувачів'"));
		//Костенюк Александр-Финиш 31.05.2012
		Данные.Колонки.Добавить("СотрудникПарольИнформационнаяКарта", Новый ОписаниеТипов("СправочникСсылка.СотрудникиОрганизаций,Строка,СправочникСсылка.ИнформационныеКарты,СправочникСсылка.РегистрационныеКарты"));
		//Данные.Колонки.Добавить("СотрудникПарольИнформационнаяКартаПредставление", Новый ОписаниеТипов("Строка"), "Сотрудник/пароль/регистрационная карта");
		//Костенюк Александр-Старт 19.04.2012
		Данные.Колонки.Добавить("СотрудникПарольИнформационнаяКартаПредставление", Новый ОписаниеТипов("Строка"), НСтр("ru='Пароль/регистрационная карта';uk='Пароль/реєстраційна карта'"));
		//Костенюк Александр-Финиш 19.04.2012
		Данные.Колонки.Добавить("ЭтоГруппа", Новый ОписаниеТипов("Булево"));
		
		ТабличноеПоле.Данные(Данные); ТабличноеПоле.СоздатьКолонки("Картинка,ПользовательГруппыПользователейПредставление,СотрудникПарольИнформационнаяКартаПредставление");
		ТабличноеПоле.Колонки.Получить("ПользовательГруппыПользователейПредставление").Ширина = 400 * 0.65;
		ТабличноеПоле.Колонки.Получить("СотрудникПарольИнформационнаяКартаПредставление").Ширина = 400 * 0.35;
		//Возврат;
	Иначе
		Данные.Строки.Очистить();
	КонецЕсли;
	
	ТабличноеПоле.ОбновитьСтроки();
	//Возврат;
	
	// Выборка данных.
	Если Разрешено Тогда
		
		Запрос = Новый Запрос("ВЫБРАТЬ
		                      |	ВложенныйЗапрос.Пользователь,
		                      |	ВложенныйЗапрос.ПользовательПредставление КАК ПользовательПредставление,
		                      |	ВложенныйЗапрос.Пароль,
		                      |	ВложенныйЗапрос.ПарольПредставление,
		                      |	ВложенныйЗапрос.ГруппаПользователей,
		                      |	ВложенныйЗапрос.ГруппаПользователейПредставление,
		                      |	ВложенныйЗапрос.Сотрудник,
		                      |	ВложенныйЗапрос.СотрудникПредставление
		                      |ИЗ
		                      |	(ВЫБРАТЬ
		                      |		ГруппыПользователей.Пользователь.Ссылка КАК Пользователь,
		                      |		ГруппыПользователей.Пользователь.Представление КАК ПользовательПредставление,
		                      |		ГруппыПользователей.Пароль КАК Пароль,
		                      |		ГруппыПользователей.Пароль КАК ПарольПредставление,
		                      |		ГруппыПользователей.ГруппаПользователей.Ссылка КАК ГруппаПользователей,
		                      |		ГруппыПользователей.ГруппаПользователей.Представление КАК ГруппаПользователейПредставление,
		                      |		ГруппыПользователей.Пользователь.Сотрудник КАК Сотрудник,
		                      |		ГруппыПользователей.Пользователь.Сотрудник.Представление КАК СотрудникПредставление
		                      |	ИЗ
		                      |		РегистрСведений.ГруппыПользователей КАК ГруппыПользователей
		                      |	
		                      |	ОБЪЕДИНИТЬ ВСЕ
		                      |	
		                      |	ВЫБРАТЬ
		                      |		ИнформационныеКарты.ВладелецКарты.Ссылка,
		                      |		ИнформационныеКарты.ВладелецКарты.Представление,
		                      |		ИнформационныеКарты.Ссылка,
		                      |		ИнформационныеКарты.КодКарты,
		                      |		ИнформационныеКарты.ГруппаПользователей.Ссылка,
		                      |		ИнформационныеКарты.ГруппаПользователей.Представление,
		                      |		ИнформационныеКарты.ВладелецКарты.Сотрудник.Ссылка,
		                      |		ИнформационныеКарты.ВладелецКарты.Сотрудник.Представление
		                      |	ИЗ
		                      |		Справочник.ИнформационныеКарты КАК ИнформационныеКарты
		                      |	ГДЕ
		                      |		ИнформационныеКарты.ВладелецКарты.Ссылка В
		                      |				(ВЫБРАТЬ
		                      |					Пользователи.Ссылка
		                      |				ИЗ
		                      |					Справочник.Пользователи КАК Пользователи)
							  |		И ИнформационныеКарты.ТипКарты = ЗНАЧЕНИЕ(Перечисление.ТипыИнформационныхКарт.Регистрационная)) КАК ВложенныйЗапрос
		                      //|		ПОЛНОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Пользователи
							  //Костенюк Алекандр-Старт 18.04.12
							  // Нет смысла выбирать инфо карты по тем элементам, которые не присутствуют в справочнике "Пользователи"
							  // поэтому установим связь ЛЕВОЕ СОЕДИНЕНИЕ
							  |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи КАК Пользователи
							  //Костенюк Алекандр-Финиш 18.04.12
		                      |		ПО ВложенныйЗапрос.Пользователь = Пользователи.Ссылка
							  //Костенюк Алекандр-Старт 18.04.12
							  // Связь по представлению некорректна, т.к. Представление имеет тип "Строка"
							  //|			И ВложенныйЗапрос.ПользовательПредставление = Пользователи.Представление
							  |				И ВложенныйЗапрос.Сотрудник = Пользователи.Сотрудник
							  //Костенюк Алекандр-Финиш 18.04.12
		                      |ГДЕ
		                      |	(НЕ Пользователи.ПометкаУдаления)
		                      |
		                      |УПОРЯДОЧИТЬ ПО
		                      |	ПользовательПредставление");
							  
		//.. Начало изменения Dim)on  10 октября 2013 г. 16:39:13
		//
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ИнформационныеКарты.ТипКарты = ЗНАЧЕНИЕ(Перечисление.ТипыИнформационныхКарт.Регистрационная)", "");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ИнформационныеКарты", "РегистрационныеКарты");
		//
		//.. Конец изменения Dim)on  10 октября 2013 г. 16:39:13
			
		Выборка = Запрос.Выполнить().Выбрать();

		Пока Выборка.Следующий() Цикл
			
			//// -- Пользователь.
			//СтрокаГруппы = Данные.Строки.Найти(Выборка.Пользователь, "ПользовательГруппыПользователей");
			//Если (СтрокаГруппы = Неопределено) Тогда
			//	СтрокаГруппы = Данные.Строки.Добавить();
			//	СтрокаГруппы.ПользовательГруппыПользователей = Выборка.Пользователь;
			//	СтрокаГруппы.ПользовательГруппыПользователейПредставление = Выборка.ПользовательПредставление;
			//	СтрокаГруппы.СотрудникПарольИнформационнаяКарта = Выборка.Сотрудник;
			//	СтрокаГруппы.СотрудникПарольИнформационнаяКартаПредставление = Выборка.СотрудникПредставление;
			//	СтрокаГруппы.ЭтоГруппа = Истина;
			//КонецЕсли;
			//
			//// -- Проверка пароля.
			//Если (ТипЗнч(Выборка.Пароль) = Тип("Строка")) Тогда
			//	Если ПустаяСтрока(Выборка.Пароль) Или (Не ОбщегоНазначения.ТолькоЦифрыВСтроке(Выборка.Пароль)) Тогда
			//		Продолжить;
			//	КонецЕсли;
			//КонецЕсли;
			//
			//// -- Группа пользователей.
			//СтрокаДанных = СтрокаГруппы.Строки.Добавить();
			//СтрокаДанных.ПользовательГруппыПользователей = Выборка.ГруппаПользователей;
			//СтрокаДанных.ПользовательГруппыПользователейПредставление = Выборка.ГруппаПользователейПредставление;
			//СтрокаДанных.СотрудникПарольИнформационнаяКарта = Выборка.Пароль;
			//СтрокаДанных.СотрудникПарольИнформационнаяКартаПредставление = Выборка.ПарольПредставление;
			
			//Костенюк Александр-Старт 18.04.2012
			// Правильнее будет выводить сначала группы пользователей,  затем самих пользователей
			// -- Группа пользователей.
			СтрокаГруппы = Данные.Строки.Найти(Выборка.ГруппаПользователей, "ПользовательГруппыПользователей");
			Если (СтрокаГруппы = Неопределено) Тогда
				СтрокаГруппы = Данные.Строки.Добавить();
				СтрокаГруппы.ПользовательГруппыПользователей = Выборка.ГруппаПользователей;
				СтрокаГруппы.ПользовательГруппыПользователейПредставление = Выборка.ГруппаПользователейПредставление;
				//СтрокаГруппы.СотрудникПарольИнформационнаяКарта = Выборка.Сотрудник;
				//СтрокаГруппы.СотрудникПарольИнформационнаяКартаПредставление = Выборка.СотрудникПредставление;
				СтрокаГруппы.СотрудникПарольИнформационнаяКарта = "";
				СтрокаГруппы.СотрудникПарольИнформационнаяКартаПредставление = "";
				СтрокаГруппы.ЭтоГруппа = Истина;
			КонецЕсли;
			
			// -- Пользователь.
			СтрокаДанных = СтрокаГруппы.Строки.Добавить();
			СтрокаДанных.ПользовательГруппыПользователей = Выборка.Пользователь;
			СтрокаДанных.ПользовательГруппыПользователейПредставление = Выборка.ПользовательПредставление;
			СтрокаДанных.СотрудникПарольИнформационнаяКарта = Выборка.Пароль;
			СтрокаДанных.СотрудникПарольИнформационнаяКартаПредставление = Выборка.ПарольПредставление;
			
			// -- Проверка пароля.
			Если (ТипЗнч(Выборка.Пароль) = Тип("Строка")) Тогда
				Если ПустаяСтрока(Выборка.Пароль) Или (Не ОбщегоНазначения.ТолькоЦифрыВСтроке(Выборка.Пароль)) Тогда
					Продолжить;
				КонецЕсли;
			КонецЕсли;
			//Костенюк Александр-Финиш 18.04.2012
			
		КонецЦикла;
	
	КонецЕсли;
	
	//Костенюк Александр-Старт 18.04.2012
	// -- Сортировка.	
	Данные.Строки.Сортировать("ЭтоГруппа Убыв, ПользовательГруппыПользователейПредставление Возр", Истина);
	Если НЕ ТекущийПользователь = Неопределено Тогда
		ИскомаяСтрока = Данные.Строки.Найти(ТекущийПользователь, "ПользовательГруппыПользователей", Истина);
		ТабличноеПоле.ТекущаяСтрока(ИскомаяСтрока);
	КонецЕсли;
	//Костенюк Александр-Финиш 18.04.2012
	
	// Обновление.
	ТабличноеПоле.ОбновитьСтроки();
	
	Выборка = Неопределено;
	
КонецПроцедуры // ДеревоПользователейПрочитать()

// Процедура обработчик события ПриВыводеСтроки табличного пользоваителей.
//
Процедура ДеревоПользователейВывестиСтроку(Элемент, ОформлениеСтроки, ДанныеСтроки) Экспорт
	
	// СотрудникПарольИнформационнаяКартаПредставление.
	Если (Не ДанныеСтроки.Родитель = Неопределено) Тогда
		Если (ТипЗнч(ДанныеСтроки.СотрудникПарольИнформационнаяКарта) = Тип("Строка")) Тогда // *٭•▪●
			ОформлениеСтроки.Ячейки("СотрудникПарольИнформационнаяКартаПредставление").Текст = Неопределено;
			ОформлениеСтроки.Ячейки("СотрудникПарольИнформационнаяКартаПредставление").УстановитьКартинку(БиблиотекаКартинок.ПользовательСАутентификацией);
		Иначе
			ОформлениеСтроки.Ячейки("СотрудникПарольИнформационнаяКартаПредставление").УстановитьКартинку(БиблиотекаКартинок.СправочникОбъект);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры	// ДеревоПользователейВывестиСтроку()

Процедура ДеревоПользователейДобавитьПользователя(ТабличноеПоле, Пользователь) Экспорт
	
	// Обновление
	ТабличноеПоле.ОбновитьСтроки();

КонецПроцедуры // ДеревоПользователейДобавитьПользователя()

Процедура ДеревоПользователейДобавитьПароль(ТабличноеПоле, ГруппыПользователей, Пароль) Экспорт
	
	// Обновление
	ТабличноеПоле.ОбновитьСтроки();

КонецПроцедуры // ДеревоПользователейДобавитьПароль()


// Процедура заполнения кмандной панели программ.
//
// Параметры:
//	КоманднаяПанель - ДокументОбъект.TouchКоманднаяПанель. Командная панель.
//
Процедура ДействияПрограммйПрочитать(КоманднаяПанель) Экспорт
	
	// Данные.
	Индекс = 0; Пока (Индекс <= КоманднаяПанель.Кнопки.Количество() - 1) Цикл
		Если (Не КоманднаяПанель.Кнопки.Получить(Индекс).Тег = Неопределено) Тогда
			КоманднаяПанель.Кнопки.Удалить(Индекс);
			Продолжить;
		КонецЕсли;
		
		Индекс = Индекс + 1;
	КонецЦикла;
		
	// Выборка данных.
	Запрос = Новый Запрос("ВЫБРАТЬ
						  |	ПрограммыАдминистрирования.Наименование КАК Наименование,
						  |	ПрограммыАдминистрирования.СтрокаКоманды КАК СтрокаКоманды,
						  |	ПрограммыАдминистрирования.Картинка КАК Картинка
						  |ИЗ
						  |	РегистрСведений.ПрограммыАдминистрирования КАК ПрограммыАдминистрирования
						  |
						  |УПОРЯДОЧИТЬ ПО
						  |	Наименование");
	Выборка = Запрос.Выполнить().Выбрать();

	Пока Выборка.Следующий() Цикл
		Картинка = Выборка.Картинка.Получить();
		
		Кнопка = КоманднаяПанель.Кнопки.Добавить(,, Выборка.Наименование, "ДействияПрограммДействиеНажатие");
		Кнопка.Тег = Выборка.СтрокаКоманды;
		Кнопка.Отображение = ОтображениеКнопкиКоманднойПанели.НадписьКартинка;
		Если (Не Картинка = Неопределено) Тогда
			Попытка Кнопка.Картинка = Новый Картинка(Картинка, Истина); Исключение КонецПопытки;
		КонецЕсли;
	КонецЦикла;
	
	// Обновление.
	КоманднаяПанель.ОбновитьКнопки();
	
	Выборка = Неопределено;

КонецПроцедуры // ДействияПрограммйПрочитать()


Функция ПрограммыДатаВремя(Дата = Неопределено, Время = Неопределено) Экспорт

	// Действие.
	Попытка
	
		// TODO: Установки даты и времени.
	
	Исключение
		FrontOffice.СообщитьОбОшибке(НСтр("ru='Невозможно выполнить операцию.';uk='Неможливо виконати операцію'")  + ОписаниеОшибки() + ".");
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции // ПрограммыДатаВремя()

Функция  ПрограммыЗапуститьПриложение(СтрокаКоманды) Экспорт
	
	// Действие.
	Попытка
		ЗапуститьПриложение(СтрокаКоманды);
//$WSHShell=WScript.CreateObject("WScript.Shell");
//$WSHShell.Run("<путь к файлу>",$state);		
	Исключение
		FrontOffice.СообщитьОбОшибке(НСтр("ru='Невозможно выполнить операцию.';uk='Неможливо виконати операцію'") + ОписаниеОшибки() + "!");
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции // ПрограммыЗапуститьПриложение()

Процедура ПрограммыWindowsПуск() Экспорт
	
	// Действие.
	Попытка
		WshShell = Новый COMОбъект("WScript.Shell");
		WshShell.SendKeys("^{ESC}");
	Исключение
		FrontOffice.СообщитьОбОшибке(НСтр("ru='Невозможно выполнить операцию.';uk='Неможливо виконати операцію'") + ОписаниеОшибки() + "!");
	КонецПопытки;
	
КонецПроцедуры	// ПрограммыWindowsПуск()


Функция АдминистрированиеЗавершениеРаботыПользователей(Режим) Экспорт
	
	// Действие.
	Попытка
		Константы.РежимЗавершенияРаботыПользователей.Установить(Режим);
	Исключение
		FrontOffice.СообщитьОбОшибке(НСтр("ru='Невозможно выполнить операцию.';uk='Неможливо виконати операцію'") + ОписаниеОшибки() + "!");
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции	// АдминистрированиеЗавершениеРаботыПользователей()

Процедура АдминистрированиеСвернутьСистему() Экспорт
	
	// Действие.
	
	// TODO: Сворачивание программы.
	
КонецПроцедуры	// АдминистрированиеСвернутьСистему()

Процедура АдминистрированиеЗапуститьСистему() Экспорт
	
	Если УправлениеПользователями.ПолучитьЗначениеПрава(ПланыВидовХарактеристик.ПраваПользователей.FrontOfficeРазрешитьЗавершениеРаботы) Тогда
		// Настройка формы.
		ФормаЗавершениеРаботы = ЭтотОбъект.ПолучитьФорму("ФормаЗавершениеРаботы");
		//ФормаЗавершениеРаботы.ЭлементыФормы.НадписьТекст.Заголовок = НСтр("ru=' Завершить работу программы перед запуском 1С:Предприятия?';uk='Завершити роботу програми перед запуском 1С:Підприємстов?'");
		//Костенюк Александр-Старт 20.03.2012
		//синтаксическая ошибка
		ФормаЗавершениеРаботы.ЭлементыФормы.НадписьТекст.Заголовок = НСтр("ru=' Завершить работу программы перед запуском 1С:Предприятия?';uk='Завершити роботу програми перед запуском 1С:Підприємство?'");
		//Костенюк Александр-Финиш 20.03.2012
		ФормаЗавершениеРаботы.ЭлементыФормы.КнопкаПерезагрузка.Видимость = Ложь;
		ФормаЗавершениеРаботы.ЭлементыФормы.КнопкаОтмена.Видимость = Истина;
		
		// Открываем форму.
		ПараметрЗакрытия = ФормаЗавершениеРаботы.ОткрытьМодально();
		Если (Не ПараметрЗакрытия = КодВозвратаДиалога.Да) И (Не ПараметрЗакрытия = КодВозвратаДиалога.Нет) Тогда
			Возврат;
		КонецЕсли;
	Иначе
		ПараметрЗакрытия = КодВозвратаДиалога.Нет;
	КонецЕсли;
	
	// Действие.
	ЗапуститьСистему("/N");
	Если (ПараметрЗакрытия = КодВозвратаДиалога.Да) Тогда
		ЗавершитьРаботуСистемы(Ложь);
	КонецЕсли;
	
КонецПроцедуры	// АдминистрированиеЗапуститьСистему()

Процедура АдминистрированиеЗавершениеРаботыСистемы() Экспорт
	
	// Настройка формы.
	ФормаЗавершениеРаботы = ЭтотОбъект.ПолучитьФорму("ФормаЗавершениеРаботы");
	
	// Открываем форму.
	ПараметрЗакрытия = ФормаЗавершениеРаботы.ОткрытьМодально();
	Если (Не ПараметрЗакрытия = КодВозвратаДиалога.Да) Тогда
		Возврат;
	КонецЕсли;
	
	// Действие.
	ЗавершитьРаботуСистемы(Ложь, ФормаЗавершениеРаботы.Перезагрузка);
	
КонецПроцедуры	// АдминистрированиеЗавершениеРаботыСистемы()

//Костенюк Александр-Старт 19.04.2012
// Открытие формы выбора действия
Функция ВыборДействия(Значение = Неопределено) Экспорт	
	
	ФормаВыбора = ЭтотОбъект.ПолучитьФорму("ФормаВыбораДействия");	
	ПараметрЗакрытия = ФормаВыбора.ОткрытьМодально();
	
	Возврат ПараметрЗакрытия;
	
КонецФункции 
//Костенюк Александр-Финиш 19.04.2012

//Костенюк Александр-Старт 19.04.2012
Процедура ИзменитьКарту() Экспорт
	
	TouchВводЗначения = Обработки.TouchВводЗначения.Создать();
	ФормаВводаЗначения = TouchВводЗначения.ПолучитьФорму("ФормаЧисла");
	ФормаВводаЗначения.Заголовок = "Считайте карту";
	ФормаВводаЗначения.Формат = "ЧЦ=12; ЧДЦ=0; ЧГ=";
	ФормаВводаЗначения.ВладелецФормы = ЭтотОбъект.ПолучитьФорму("Форма");;
	ФормаВводаЗначения.ОткрытьМодально();
	
КонецПроцедуры
//Костенюк Александр-Финиш 19.04.2012

#КонецЕсли
