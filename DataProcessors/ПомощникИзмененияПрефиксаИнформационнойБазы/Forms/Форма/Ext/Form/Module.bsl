﻿
&НаКлиенте
Перем ЗакрытьФормуБезусловно;

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Не Пользователи.РолиДоступны("ПолныеПрава") Тогда
		ВызватьИсключение НСтр("ru = 'Нет прав на изменение префикса информационной базы.'");
	КонецЕсли;
	
	ПредыдущийПрефиксИнформационнойБазы = Неопределено;
	
	Если Параметры.Свойство("ПредыдущийПрефиксИБ") Тогда
		ПредыдущийПрефиксИнформационнойБазы = Параметры.ПредыдущийПрефиксИБ;
	КонецЕсли;
	
	СобытиеЖурналаРегистрацииОбработкаДанных = НСтр("ru = 'Префиксация объектов.Изменение префикса информационной базы'",
		ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
	
	НовыйПрефиксИнформационнойБазы = ПолучитьФункциональнуюОпцию("ПрефиксИнформационнойБазы");
	
	ДатаНачалаОбработки = НачалоГода(ТекущаяДатаСеанса());
	
	РежимОбработкиДанных = "ОбработатьВсеДанные";
	
	ВыполнитьОбработкуДанных = Истина;
	
	РежимВыбораПериодаОбработкиДанных = "ЗаВесьПериод";
	
	Элементы.АктивныеПользователи.Видимость = Ложь;
	Элементы.СообщениеОНеобходимостиБлокировкиРаботыПользователей.Видимость = Ложь;
	
	// Устанавливаем текущую таблицу переходов
	ОсновнойСценарийПомощника();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ВыполнитьОбработкуДанныхПриИзмененииЗначения();
	
	РежимОбработкиДанныхПриИзмененииЗначения();
	
	РежимВыбораПериодаОбработкиДанныхПриИзмененииЗначения();
	
	ДатаНачалаОбработкиПриИзмененииЗначения();
	
	// Позиционируемся на первом шаге помощника
	УстановитьПорядковыйНомерПерехода(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ЗапроситьПодтверждениеЗакрытияФормы(Отказ, , ЗакрытьФормуБезусловно, 
		НСтр("ru = 'Отменить установку нового префикса информационной базы?'"));
	
КонецПроцедуры

// Обработчики ожидания

&НаКлиенте
Процедура ОбработчикОжиданияДлительнойОперации()
	
	Попытка
		
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда
			
			ДлительнаяОперация = Ложь;
			ДлительнаяОперацияЗавершена = Истина;
			ПерейтиДалее();
			
		Иначе
			ПодключитьОбработчикОжидания("ОбработчикОжиданияДлительнойОперации", 5, Истина);
		КонецЕсли;
		
	Исключение
		ЗаписатьОшибкуВЖурналРегистрации(
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()), СобытиеЖурналаРегистрацииОбработкаДанных);
		ДлительнаяОперация = Ложь;
		ПерейтиНазад();
		Предупреждение(НСтр("ru = 'Не удалось выполнить обработку данных.'"));
		
	КонецПопытки;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

////////////////////////////////////////////////////////////////////////////////
// Поставляемая часть

&НаКлиенте
Процедура КомандаДалее(Команда)
	
	ИзменитьПорядковыйНомерПерехода(+1);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаНазад(Команда)
	
	ИзменитьПорядковыйНомерПерехода(-1);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаГотово(Команда)
	
	ЗакрытьФормуБезусловно = Истина;
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Переопределяемая часть

&НаКлиенте
Процедура ВыполнитьОбработкуДанныхПриИзменении(Элемент)
	
	ВыполнитьОбработкуДанныхПриИзмененииЗначения();
	
	РежимОбработкиДанныхПриИзмененииЗначения();
	
	РежимВыбораПериодаОбработкиДанныхПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура РежимОбработкиДанныхПриИзменении(Элемент)
	
	РежимОбработкиДанныхПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура РежимВыбораПериодаОбработкиДанныхПриИзменении(Элемент)
	
	РежимВыбораПериодаОбработкиДанныхПриИзмененииЗначения();
	
	ДатаНачалаОбработкиПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаОбработкиПриИзменении(Элемент)
	
	ДатаНачалаОбработкиПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура АктивныеПользователи(Команда)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьФорму("Обработка.БлокировкаРаботыПользователей.Форма",, ЭтаФорма);
	
	Если СтандартнаяОбработка Тогда
		
		Предупреждение(НСтр("ru = 'Данная функциональность не поддерживается.'"));
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Поставляемая часть

&НаКлиенте
Процедура ИзменитьПорядковыйНомерПерехода(Итератор)
	
	ОчиститьСообщения();
	
	УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + Итератор);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПорядковыйНомерПерехода(Знач Значение)
	
	ЭтоПереходДалее = (Значение > ПорядковыйНомерПерехода);
	
	ПорядковыйНомерПерехода = Значение;
	
	Если ПорядковыйНомерПерехода < 0 Тогда
		
		ПорядковыйНомерПерехода = 0;
		
	КонецЕсли;
	
	ПорядковыйНомерПереходаПриИзменении(ЭтоПереходДалее);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядковыйНомерПереходаПриИзменении(Знач ЭтоПереходДалее)
	
	// Выполняем обработчики событий перехода
	ВыполнитьОбработчикиСобытийПерехода(ЭтоПереходДалее);
	
	// Устанавливаем отображение страниц
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	Элементы.ПанельОсновная.ТекущаяСтраница  = Элементы[СтрокаПереходаТекущая.ИмяОсновнойСтраницы];
	Элементы.ПанельНавигации.ТекущаяСтраница = Элементы[СтрокаПереходаТекущая.ИмяСтраницыНавигации];
	
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяСтраницыДекорации) Тогда
		
		Элементы.ПанельДекорации.ТекущаяСтраница = Элементы[СтрокаПереходаТекущая.ИмяСтраницыДекорации];
		
	КонецЕсли;
	
	// Устанавливаем текущую кнопку по умолчанию
	КнопкаДалее = ПолучитьКнопкуФормыПоИмениКоманды(Элементы.ПанельНавигации.ТекущаяСтраница, "КомандаДалее");
	
	Если КнопкаДалее <> Неопределено Тогда
		
		КнопкаДалее.КнопкаПоУмолчанию = Истина;
		
	Иначе
		
		КнопкаГотово = ПолучитьКнопкуФормыПоИмениКоманды(Элементы.ПанельНавигации.ТекущаяСтраница, "КомандаГотово");
		
		Если КнопкаГотово <> Неопределено Тогда
			
			КнопкаГотово.КнопкаПоУмолчанию = Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если ЭтоПереходДалее И СтрокаПереходаТекущая.ДлительнаяОперация Тогда
		
		ПодключитьОбработчикОжидания("ВыполнитьОбработчикДлительнойОперации", 0.1, Истина);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработчикиСобытийПерехода(Знач ЭтоПереходДалее)
	
	// Обработчики событий переходов
	Если ЭтоПереходДалее Тогда
		
		СтрокиПерехода = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода - 1));
		
		Если СтрокиПерехода.Количество() > 0 Тогда
			
			СтрокаПерехода = СтрокиПерехода[0];
			
			// обработчик ПриПереходеДалее
			Если Не ПустаяСтрока(СтрокаПерехода.ИмяОбработчикаПриПереходеДалее)
				И Не СтрокаПерехода.ДлительнаяОперация Тогда
				
				ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ)";
				ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПерехода.ИмяОбработчикаПриПереходеДалее);
				
				Отказ = Ложь;
				
				А = Вычислить(ИмяПроцедуры);
				
				Если Отказ Тогда
					
					УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
					
					Возврат;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	Иначе
		
		СтрокиПерехода = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода + 1));
		
		Если СтрокиПерехода.Количество() > 0 Тогда
			
			СтрокаПерехода = СтрокиПерехода[0];
			
			// обработчик ПриПереходеНазад
			Если Не ПустаяСтрока(СтрокаПерехода.ИмяОбработчикаПриПереходеНазад)
				И Не СтрокаПерехода.ДлительнаяОперация Тогда
				
				ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ)";
				ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПерехода.ИмяОбработчикаПриПереходеНазад);
				
				Отказ = Ложь;
				
				А = Вычислить(ИмяПроцедуры);
				
				Если Отказ Тогда
					
					УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
					
					Возврат;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	Если СтрокаПереходаТекущая.ДлительнаяОперация И Не ЭтоПереходДалее Тогда
		
		УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
		Возврат;
	КонецЕсли;
	
	// обработчик ПриОткрытии
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяОбработчикаПриОткрытии) Тогда
		
		ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ, ПропуститьСтраницу, ЭтоПереходДалее)";
		ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПереходаТекущая.ИмяОбработчикаПриОткрытии);
		
		Отказ = Ложь;
		ПропуститьСтраницу = Ложь;
		
		А = Вычислить(ИмяПроцедуры);
		
		Если Отказ Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
			
			Возврат;
			
		ИначеЕсли ПропуститьСтраницу Тогда
			
			Если ЭтоПереходДалее Тогда
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
				
				Возврат;
				
			Иначе
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
				
				Возврат;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработчикДлительнойОперации()
	
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	// обработчик ОбработкаДлительнойОперации
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяОбработчикаДлительнойОперации) Тогда
		
		ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ, ПерейтиДалее)";
		ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПереходаТекущая.ИмяОбработчикаДлительнойОперации);
		
		Отказ = Ложь;
		ПерейтиДалее = Истина;
		
		А = Вычислить(ИмяПроцедуры);
		
		Если Отказ Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
			
			Возврат;
			
		ИначеЕсли ПерейтиДалее Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
			
			Возврат;
			
		КонецЕсли;
		
	Иначе
		
		УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
		
		Возврат;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ТаблицаПереходовНоваяСтрока(ПорядковыйНомерПерехода,
									ИмяОсновнойСтраницы,
									ИмяСтраницыНавигации,
									ИмяСтраницыДекорации = "",
									ИмяОбработчикаПриОткрытии = "",
									ИмяОбработчикаПриПереходеДалее = "",
									ИмяОбработчикаПриПереходеНазад = "",
									ДлительнаяОперация = Ложь,
									ИмяОбработчикаДлительнойОперации = "")
	НоваяСтрока = ТаблицаПереходов.Добавить();
	
	НоваяСтрока.ПорядковыйНомерПерехода = ПорядковыйНомерПерехода;
	НоваяСтрока.ИмяОсновнойСтраницы     = ИмяОсновнойСтраницы;
	НоваяСтрока.ИмяСтраницыДекорации    = ИмяСтраницыДекорации;
	НоваяСтрока.ИмяСтраницыНавигации    = ИмяСтраницыНавигации;
	
	НоваяСтрока.ИмяОбработчикаПриПереходеДалее = ИмяОбработчикаПриПереходеДалее;
	НоваяСтрока.ИмяОбработчикаПриПереходеНазад = ИмяОбработчикаПриПереходеНазад;
	НоваяСтрока.ИмяОбработчикаПриОткрытии      = ИмяОбработчикаПриОткрытии;
	
	НоваяСтрока.ДлительнаяОперация = ДлительнаяОперация;
	НоваяСтрока.ИмяОбработчикаДлительнойОперации = ИмяОбработчикаДлительнойОперации;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьКнопкуФормыПоИмениКоманды(ЭлементФормы, ИмяКоманды)
	
	Для Каждого Элемент Из ЭлементФормы.ПодчиненныеЭлементы Цикл
		
		Если ТипЗнч(Элемент) = Тип("ГруппаФормы") Тогда
			
			ЭлементФормыПоИмениКоманды = ПолучитьКнопкуФормыПоИмениКоманды(Элемент, ИмяКоманды);
			
			Если ЭлементФормыПоИмениКоманды <> Неопределено Тогда
				
				Возврат ЭлементФормыПоИмениКоманды;
				
			КонецЕсли;
			
		ИначеЕсли ТипЗнч(Элемент) = Тип("КнопкаФормы")
			И Найти(Элемент.ИмяКоманды, ИмяКоманды) > 0 Тогда
			
			Возврат Элемент;
			
		Иначе
			
			Продолжить;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Переопределяемая часть - Обработчики событий переходов

&НаКлиенте
Функция Подключаемый_ОбработкаДанных_ОбработкаДлительнойОперации(Отказ, ПерейтиДалее)
	
	ДлительнаяОперация = Ложь;
	ДлительнаяОперацияЗавершена = Ложь;
	ИдентификаторЗадания = Неопределено;
	ОтказУстановкиМонопольногоРежима = Ложь;
	
	ВыполнитьОбработкуДанныхНаСервере(Отказ, ОтказУстановкиМонопольногоРежима);
	
	Если ОтказУстановкиМонопольногоРежима Тогда
		
		Предупреждение(НСтр("ru = 'Ошибка разделенного доступа к базе данных.
			|Воспользуйтесь функционалом блокировки работы пользователей.'"));
		
	ИначеЕсли Отказ Тогда
		
		Предупреждение(НСтр("ru = 'Не удалось выполнить обработку данных.'"));
		
	ИначеЕсли Не ДлительнаяОперация Тогда
		
		Оповестить("НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы", НовыйПрефиксИнформационнойБазы, ИмяФормы);
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_ОбработкаДанныхДлительнаяОперация_ОбработкаДлительнойОперации(Отказ, ПерейтиДалее)
	
	Если ДлительнаяОперация Тогда
		
		ПерейтиДалее = Ложь;
		
		ПодключитьОбработчикОжидания("ОбработчикОжиданияДлительнойОперации", 5, Истина);
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_ОбработкаДанныхДлительнаяОперацияОкончание_ОбработкаДлительнойОперации(Отказ, ПерейтиДалее)
	
	Если ДлительнаяОперацияЗавершена Тогда
		
		РезультатОбработкиДанных = ПолучитьИзВременногоХранилища(АдресВременногоХранилища);
		ОбъектовОбработано = РезультатОбработкиДанных.ОбъектовОбработано;
		
		Оповестить("НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы", НовыйПрефиксИнформационнойБазы, ИмяФормы);
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_Окончание_ПриОткрытии(Отказ, ПропуститьСтраницу, Знач ЭтоПереходДалее)
	
	Если ВыполнитьОбработкуДанных И ОбъектовОбработано <> 0 Тогда
		
		Если РежимОбработкиДанных = "ОбработатьВсеДанные" Тогда
			
			Результат = НСтр("ru = 'Было изменено %1 объектов.'");
			
		ИначеЕсли РежимОбработкиДанных = "ОбработатьДанныеТекущейИнформационнойБазы" Тогда
			
			Результат = НСтр("ru = 'Было изменено %1 объектов.'");
			
		ИначеЕсли РежимОбработкиДанных = "ОбработатьПоследниеДанные" Тогда
			
			Результат = НСтр("ru = 'Было изменено %1 объектов.'");
			
		ИначеЕсли РежимОбработкиДанных = "СоздатьНовыеДанные" Тогда
			
			Результат = НСтр("ru = 'Было создано %1 объектов.'");
			
		Иначе
			
			Результат = НСтр("ru = 'Существующие объекты не были изменены.'");
			
		КонецЕсли;
		
		Результат = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Результат, Формат(ОбъектовОбработано, "ЧН=0"));
		
	Иначе
		
		Результат = НСтр("ru = 'Существующие объекты не были изменены.'");
		
	КонецЕсли;
	
	Элементы.РезультатОбработкиДанных.Заголовок = Результат;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Переопределяемая часть – Служебные процедуры и функции

&НаСервере
Процедура ВыполнитьОбработкуДанныхНаСервере(Отказ, ОтказУстановкиМонопольногоРежима)
	
	// Проверка на возможность установки монопольного режима
	Попытка
		ОбщегоНазначения.ЗаблокироватьИБ();
		ОбщегоНазначения.РазблокироватьИБ();
	Исключение
		Элементы.АктивныеПользователи.Видимость = Истина;
		Элементы.СообщениеОНеобходимостиБлокировкиРаботыПользователей.Видимость = Истина;
		Отказ = Истина;
		ОтказУстановкиМонопольногоРежима = Истина;
		СообщениеОНеобходимостиБлокировкиРаботыПользователей = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Возврат;
	КонецПопытки;
	
	Элементы.АктивныеПользователи.Видимость = Ложь;
	Элементы.СообщениеОНеобходимостиБлокировкиРаботыПользователей.Видимость = Ложь;
	
	НовыйПрефиксИнформационнойБазы = СокрЛП(НовыйПрефиксИнформационнойБазы);
	
	Если Не ВыполнитьОбработкуДанных Тогда
		
		Попытка
			
			УстановитьПривилегированныйРежим(Истина);
			Константы.ПрефиксУзлаРаспределеннойИнформационнойБазы.Установить(НовыйПрефиксИнформационнойБазы);
			
		Исключение
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()),,,, Отказ);
			Возврат;
		КонецПопытки;
		
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначения.ИнформационнаяБазаФайловая()
		ИЛИ Не ОбщегоНазначенияПовтИсп.РазделениеВключено() Тогда
		
		ОбъектовОбработано = 0;
		
		Попытка
			
			Если РежимОбработкиДанных = "ОбработатьВсеДанные" Тогда
				
				ПерепрефиксацияОбъектов.УстановитьПрефиксИБИПерепрефиксоватьВсеОбъекты(
					НовыйПрефиксИнформационнойБазы,
					ДатаНачалаОбработки,
					ПредыдущийПрефиксИнформационнойБазы,
					ОбъектовОбработано);
				
			ИначеЕсли РежимОбработкиДанных = "ОбработатьДанныеТекущейИнформационнойБазы" Тогда
				
				ПерепрефиксацияОбъектов.УстановитьПрефиксИБИПерепрефиксоватьОбъектыСозданныеВЭтойИБ(
					НовыйПрефиксИнформационнойБазы,
					ДатаНачалаОбработки,
					ПредыдущийПрефиксИнформационнойБазы,
					ОбъектовОбработано);
				
			ИначеЕсли РежимОбработкиДанных = "СоздатьНовыеДанные" Тогда
				
				ПерепрефиксацияОбъектов.УстановитьПрефиксИБИСоздатьОбъекты(
					НовыйПрефиксИнформационнойБазы,
					ДатаНачалаОбработки,
					ПредыдущийПрефиксИнформационнойБазы,
					ОбъектовОбработано);
				
			ИначеЕсли РежимОбработкиДанных = "ОбработатьПоследниеДанные" Тогда
				
				ПерепрефиксацияОбъектов.УстановитьПрефиксИБИПерепрефиксоватьПоследниеОбъекты(
					НовыйПрефиксИнформационнойБазы,
					ДатаНачалаОбработки,
					ПредыдущийПрефиксИнформационнойБазы,
					ОбъектовОбработано);
				
			Иначе
				
				ВызватьИсключение НСтр("ru = 'Режим обработки данных не поддерживается.'");
				
			КонецЕсли;
			
		Исключение
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()),,,, Отказ);
			Возврат;
		КонецПопытки;
		
	Иначе
		
		Попытка
			
			Если РежимОбработкиДанных = "ОбработатьВсеДанные" Тогда
				
				ПараметрыМетода = Новый Структура;
				ПараметрыМетода.Вставить("НовыйПрефикс", НовыйПрефиксИнформационнойБазы);
				ПараметрыМетода.Вставить("СДаты", ДатаНачалаОбработки);
				ПараметрыМетода.Вставить("ПредыдущийПрефиксИнформационнойБазы", ПредыдущийПрефиксИнформационнойБазы);
				
				Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
					УникальныйИдентификатор,
					"Обработки.ПомощникИзмененияПрефиксаИнформационнойБазы.УстановитьПрефиксИБИПерепрефиксоватьВсеОбъекты",
					ПараметрыМетода,
					НСтр("ru = 'Изменение префикса информационной базы и обработка данных'"));
				
				
			ИначеЕсли РежимОбработкиДанных = "ОбработатьДанныеТекущейИнформационнойБазы" Тогда
				
				ПараметрыМетода = Новый Структура;
				ПараметрыМетода.Вставить("НовыйПрефикс", НовыйПрефиксИнформационнойБазы);
				ПараметрыМетода.Вставить("СДаты", ДатаНачалаОбработки);
				ПараметрыМетода.Вставить("ПредыдущийПрефиксИнформационнойБазы", ПредыдущийПрефиксИнформационнойБазы);
				
				Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
					УникальныйИдентификатор,
					"Обработки.ПомощникИзмененияПрефиксаИнформационнойБазы.УстановитьПрефиксИБИПерепрефиксоватьОбъектыСозданныеВЭтойИБ",
					ПараметрыМетода,
					НСтр("ru = 'Изменение префикса информационной базы и обработка данных'"));
				
			ИначеЕсли РежимОбработкиДанных = "СоздатьНовыеДанные" Тогда
				
				ПараметрыМетода = Новый Структура;
				ПараметрыМетода.Вставить("НовыйПрефикс", НовыйПрефиксИнформационнойБазы);
				ПараметрыМетода.Вставить("СДаты", ДатаНачалаОбработки);
				ПараметрыМетода.Вставить("ПредыдущийПрефиксИнформационнойБазы", ПредыдущийПрефиксИнформационнойБазы);
				
				Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
					УникальныйИдентификатор,
					"Обработки.ПомощникИзмененияПрефиксаИнформационнойБазы.УстановитьПрефиксИБИСоздатьОбъекты",
					ПараметрыМетода,
					НСтр("ru = 'Изменение префикса информационной базы и обработка данных'"));
				
			ИначеЕсли РежимОбработкиДанных = "ОбработатьПоследниеДанные" Тогда
				
				ПараметрыМетода = Новый Структура;
				ПараметрыМетода.Вставить("НовыйПрефикс", НовыйПрефиксИнформационнойБазы);
				ПараметрыМетода.Вставить("СДаты", ДатаНачалаОбработки);
				ПараметрыМетода.Вставить("ПредыдущийПрефиксИнформационнойБазы", ПредыдущийПрефиксИнформационнойБазы);
				
				Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
					УникальныйИдентификатор,
					"Обработки.ПомощникИзмененияПрефиксаИнформационнойБазы.УстановитьПрефиксИБИПерепрефиксоватьПоследниеОбъекты",
					ПараметрыМетода,
					НСтр("ru = 'Изменение префикса информационной базы и обработка данных'"));
				
			Иначе
				
				ВызватьИсключение НСтр("ru = 'Режим обработки данных не поддерживается.'");
				
			КонецЕсли;
			
		Исключение
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()),,,, Отказ);
			Возврат;
		КонецПопытки;
		
		АдресВременногоХранилища = Результат.АдресХранилища;
		
		Если Результат.ЗаданиеВыполнено Тогда
			
			РезультатОбработкиДанных = ПолучитьИзВременногоХранилища(АдресВременногоХранилища);
			ОбъектовОбработано = РезультатОбработкиДанных.ОбъектовОбработано;
			
		Иначе
			
			ДлительнаяОперация = Истина;
			ИдентификаторЗадания = Результат.ИдентификаторЗадания;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработкуДанныхПриИзмененииЗначения()
	
	Элементы.РежимОбработкиДанных.Доступность = ВыполнитьОбработкуДанных;
	Элементы.РежимВыбораПериодаОбработкиДанных.Доступность = ВыполнитьОбработкуДанных;
	Элементы.ДатаНачалаОбработки.Доступность = ВыполнитьОбработкуДанных;
	
КонецПроцедуры

&НаКлиенте
Процедура РежимОбработкиДанныхПриИзмененииЗначения()
	
	Если ВыполнитьОбработкуДанных Тогда
		
		Если РежимОбработкиДанных = "ОбработатьВсеДанные" Тогда
			
			Элементы.ПоясненияКРежимуОбработкиДанных.ТекущаяСтраница = Элементы.ПояснениеКРежимуОбработкиВсехДанных;
			
		ИначеЕсли РежимОбработкиДанных = "ОбработатьДанныеТекущейИнформационнойБазы" Тогда
			
			Элементы.ПоясненияКРежимуОбработкиДанных.ТекущаяСтраница = Элементы.ПояснениеКРежимуОбработкиДанныхСозданныеВТекущейИнформационнойБазе;
			
		ИначеЕсли РежимОбработкиДанных = "СоздатьНовыеДанные" Тогда
			
			Элементы.ПоясненияКРежимуОбработкиДанных.ТекущаяСтраница = Элементы.ПояснениеКРежимуСозданияНовыхДанных;
			
		ИначеЕсли РежимОбработкиДанных = "ОбработатьПоследниеДанные" Тогда
			
			Элементы.ПоясненияКРежимуОбработкиДанных.ТекущаяСтраница = Элементы.ПояснениеКРежимуОбработкиПоследнихДанных;
			
		Иначе
			
			Элементы.ПоясненияКРежимуОбработкиДанных.ТекущаяСтраница = Элементы.ПояснениеКРежимуБезОбработки;
			
		КонецЕсли;
		
	Иначе
		
		Элементы.ПоясненияКРежимуОбработкиДанных.ТекущаяСтраница = Элементы.ПояснениеКРежимуБезОбработки;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РежимВыбораПериодаОбработкиДанныхПриИзмененииЗначения()
	
	Элементы.ДатаНачалаОбработки.Доступность = (РежимВыбораПериодаОбработкиДанных = "НачинаяСДаты");
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаОбработкиПриИзмененииЗначения()
	
	Период = НСтр("ru = ', начиная с %1,'");
	Период = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Период, Формат(ДатаНачалаОбработки, "ДЛФ=DD; ДП='начала ведения учета в программе'"));
	
	//
	
	Пояснение = НСтр("ru = 'Будут изменены номера и коды всех объектов%1
		|в соответствии с новым префиксом информационной базы.'");
	Пояснение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Пояснение, ?(РежимВыбораПериодаОбработкиДанных = "НачинаяСДаты", Период, ""));
	Элементы.ДекорацияПояснениеКРежимуОбработкиВсехДанных.Заголовок = Пояснение;
	
	//
	
	Пояснение = НСтр("ru = 'Будут изменены номера и коды только для объектов,
		|созданных в текущей информационной базе%1
		|в соответствии с новым префиксом информационной базы.'");
	Пояснение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Пояснение, ?(РежимВыбораПериодаОбработкиДанных = "НачинаяСДаты", Период, ""));
	Элементы.ДекорацияПояснениеКРежимуОбработкиДанныхСозданныеВТекущейИнформационнойБазе.Заголовок = Пояснение;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиДалее()
	
	ИзменитьПорядковыйНомерПерехода(+1);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНазад()
	
	ИзменитьПорядковыйНомерПерехода(-1);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаписатьОшибкуВЖурналРегистрации(СтрокаСообщенияОбОшибке, Событие)
	
	ЗаписьЖурналаРегистрации(Событие, УровеньЖурналаРегистрации.Ошибка,,, СтрокаСообщенияОбОшибке);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Переопределяемая часть - Инициализация переходов помощника

&НаСервере
Процедура ОсновнойСценарийПомощника()
	
	ТаблицаПереходов.Очистить();
	
	ТаблицаПереходовНоваяСтрока(1, "Начало",          "СтраницаНавигацииНачало");
	ТаблицаПереходовНоваяСтрока(2, "ОбработкаДанных", "СтраницаНавигацииОжидание",,,,, Истина, "ОбработкаДанных_ОбработкаДлительнойОперации");
	ТаблицаПереходовНоваяСтрока(3, "ОбработкаДанных", "СтраницаНавигацииОжидание",,,,, Истина, "ОбработкаДанныхДлительнаяОперация_ОбработкаДлительнойОперации");
	ТаблицаПереходовНоваяСтрока(4, "ОбработкаДанных", "СтраницаНавигацииОжидание",,,,, Истина, "ОбработкаДанныхДлительнаяОперацияОкончание_ОбработкаДлительнойОперации");
	ТаблицаПереходовНоваяСтрока(5, "Окончание",       "СтраницаНавигацииОкончание",, "Окончание_ПриОткрытии");
	
КонецПроцедуры
