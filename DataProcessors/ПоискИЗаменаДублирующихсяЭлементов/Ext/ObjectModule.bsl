﻿
Перем ТаблицаБукв;
Перем мИскомыйОбъектПоискаДублей Экспорт;
Перем мСтруктураПоиска Экспорт;

Функция ЭтоБуква (Символ)
	
	Код = КодСимвола(Символ);
	
	Если (Код<=47) ИЛИ (Код>=58 И Код<=64) ИЛИ (Код>=91 И Код<=96)  ИЛИ (Код>=123 И Код<=126) Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

Функция АнализРазличийВСловах(Список1, Список2, ПолныйСписок, ОдинаковыхСлов,ДопустимоеРазличиеСлов) Экспорт
	Если Список1.Количество() = ПолныйСписок.Количество()
		 ИЛИ Список2.Количество() = ПолныйСписок.Количество() Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если ПолныйСписок.Количество() = 0 Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если Список1.Количество() = Список2.Количество() Тогда
		ЕстьОтличия = ПроверитьСловаНаОтличие(Список1, Список2, ДопустимоеРазличиеСлов);
		ЕСли  НЕ ЕстьОтличия Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
	ЦелоеСлово = "";
	Для Каждого Слово ИЗ ПолныйСписок Цикл
		ЦелоеСлово = ЦелоеСлово + Слово.Значение;
	КонецЦикла;
	Слово1 = "";
	Для Каждого Слово ИЗ Список1 Цикл
		Слово1 = Слово1 + Слово.Значение;
	КонецЦикла;
	Слово2 = "";
	Для Каждого Слово ИЗ Список2 Цикл
		Слово2 = Слово2 + Слово.Значение;
	КонецЦикла;
	
	Если Окр(СтрДлина(Слово1)/СтрДлина(ЦелоеСлово)*100) < ДопустимоеРазличиеСлов
		И Окр(СтрДлина(Слово2)/СтрДлина(ЦелоеСлово)*100) < ДопустимоеРазличиеСлов Тогда
		Возврат Ложь;
	КонецЕсли;	
	
	Возврат Истина;
	
КонецФункции

Функция СравнитьСлова(Слово1, Слово2, ДопустимоеРазличиеСлов)
	ТаблицаБукв.Очистить();
	ТаблицаБуквПустая = Истина;
		
	ЕСли СтрДлина(Слово1)<=СтрДлина(Слово2) Тогда
		Слово = ВРЕГ(Слово1);
		ИскомоеСлово = ВРЕГ(Слово2);
	Иначе
		Слово = ВРЕГ(Слово2);
		ИскомоеСлово = ВРЕГ(Слово1);
	КонецЕсли;
	
	Для индекс = 1 по СтрДлина(Слово) Цикл
		Символ = Сред(Слово, индекс, 1);
		ЕСли ТаблицаБуквПустая  Тогда
			поз = Найти(ИскомоеСлово, Символ);
			поправка = 0;
			Пока поз>0 Цикл
				ТаблицаБуквПустая = Ложь;
				НовСтр = ТаблицаБукв.Добавить();
				НовСтр.Позиция = поз + поправка;
				НовСтр.ДлинаСлова = 1;
				НовСтр.КолвоПропущенных = 0;
				поправка = поправка + поз;
				поз = Найти(Сред(ИскомоеСлово, поправка+1), Символ);
			КонецЦикла;
		Иначе
			Для Каждого Вхождение ИЗ ТаблицаБукв Цикл
				Если Сред(ИскомоеСлово, Вхождение.Позиция + Вхождение.ДлинаСлова, 1) = Символ Тогда
					Вхождение.ДлинаСлова = Вхождение.ДлинаСлова + 1;
				ИначеЕсли Сред(Слово, Вхождение.Позиция + Вхождение.ДлинаСлова - Вхождение.КолвоПропущенных, 1) = Вхождение.ПропущеноНа Тогда
					Вхождение.ПропущеноНа = "";
					Вхождение.ДлинаСлова = Вхождение.ДлинаСлова + 1;
					Если Сред(ИскомоеСлово, Вхождение.Позиция + Вхождение.ДлинаСлова, 1) = Символ Тогда
						Вхождение.ДлинаСлова = Вхождение.ДлинаСлова + 1;
					Иначе
						Вхождение.КолвоПропущенных = Вхождение.КолвоПропущенных + 1;
					КонецЕсли;
				Иначе					
					ЕСли Окр((Вхождение.КолвоПропущенных + 1) / СтрДлина(ИскомоеСлово) * 100)<=ДопустимоеРазличиеСлов Тогда
						Вхождение.КолвоПропущенных = Вхождение.КолвоПропущенных + 1;
						Вхождение.ДлинаСлова = Вхождение.ДлинаСлова + 1;
						Вхождение.ПропущеноНа = Символ;
					Иначе
						Вхождение.КолвоПропущенных = Вхождение.КолвоПропущенных + 1;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;			
		КонецЕсли;		
	КонецЦикла;
	
	ЕСли ТаблицаБуквПустая Тогда
		Возврат Ложь;
	КонецЕсли;
	
	
	ТаблицаБукв.Сортировать("ДлинаСлова УБЫВ, КолвоПропущенных ВОЗР");
	
	СовпалоСимволов = ТаблицаБукв[0].ДлинаСлова - ТаблицаБукв[0].КолвоПропущенных;
	
	Возврат (Окр(СовпалоСимволов / СтрДлина(ИскомоеСлово) * 100) >= (100 - ДопустимоеРазличиеСлов));
		
КонецФункции

Функция ПроверитьСловаНаОтличие(СписокСлов1, СписокСлов2, ДопустимоеРазличиеСлов) Экспорт
	СписокРазличающихсяСлов = Новый СписокЗначений;
	Для Каждого Слово1 ИЗ СписокСлов1 Цикл
		ЕстьПара = Ложь;
		Для Каждого Слово2 Из СписокСлов2 Цикл
			Если СравнитьСлова(Слово1.Значение, Слово2.Значение, ДопустимоеРазличиеСлов) Тогда
				ЕстьПара = Истина;
				СписокСлов2.Удалить(Слово2);
				Прервать;
			КонецЕсли;
		КонецЦикла;
		ЕСли НЕ ЕстьПара Тогда
			СписокРазличающихсяСлов.Добавить(Слово1.Значение);
		КонецЕсли;
	КонецЦикла;	
	
	СписокСлов1 = СписокРазличающихсяСлов;
	
	Возврат Не (СписокСлов1.Количество() = 0 И СписокСлов2.Количество() = 0)
	
КонецФункции

Функция ПолучитьСписокСлов(ЗначениеРеквизита) Экспорт
	
	СписокСлов = Новый СписокЗначений;
	Слово = "";
	Для индекс = 1 по СтрДлина(ЗначениеРеквизита) Цикл
		Символ = Сред(ЗначениеРеквизита, индекс, 1);
		Если ЭтоБуква(Символ) Тогда
			Слово = Слово + Символ;
		Иначе
			Если Слово<>"" Тогда
			СписокСлов.Добавить(ВРЕГ(Слово));
			Слово = "";
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если Слово<>"" Тогда
		СписокСлов.Добавить(ВРЕГ(Слово));
	КонецЕсли;
	СписокСлов.СортироватьПоЗначению();
	Возврат СписокСлов;
	
КонецФункции // ()

Функция НайтиДубли(ИскомыйОбъект,СтруктураПоиска) Экспорт
	
	мИскомыйОбъектПоискаДублей   = ИскомыйОбъект;
	мСтруктураПоиска             = СтруктураПоиска;
	
	НайденныеОбъекты = Новый ТаблицаЗначений;
	НайденныеОбъекты.Колонки.Добавить("Ссылка");
	ИмяСправочника = ИскомыйОбъект.Метаданные().Имя;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ Разрешенные 
	|	Ссылка*
	|Из Справочник." + ИмяСправочника + " КАК Спр
	|Где Не Спр.ЭтоГруппа";
	
	
	Реквизиты = "";
	СтрокаГде = "";
	ВЗапросеТолькоРавенство = Истина;
	МетаданныеРеквизитов = ИскомыйОбъект.Метаданные().Реквизиты;
	СтруктураИсходныхРеквизитов = Новый Структура;
	
	Для каждого КлючИЗначение Из СтруктураПоиска Цикл
		ИмяРеквизита      = КлючИЗначение.Ключ;
		СтепеньСхожести   = КлючИЗначение.Значение;
		ЗначениеРеквизита = ИскомыйОбъект[ИмяРеквизита];
		 
		МетаданныеРеквизита    = МетаданныеРеквизитов.Найти(ИмяРеквизита);
		ПредставлениеРеквизита = ?(МетаданныеРеквизита = Неопределено,ИмяРеквизита,Строка(МетаданныеРеквизита));
		
		СтруктураИсходногоРеквизита = Новый Структура("ЗначениеРеквизита,СтепеньСхожести,СписокСлов"
		,ЗначениеРеквизита,СтепеньСхожести,ПолучитьСписокСлов(ЗначениеРеквизита));
		
		СтруктураИсходныхРеквизитов.Вставить(ИмяРеквизита,СтруктураИсходногоРеквизита);
		
		
		НайденныеОбъекты.Колонки.Добавить(ИмяРеквизита);
		НайденныеОбъекты.Колонки.Добавить(ИмяРеквизита+"_Флаг");
		
		Реквизиты = Реквизиты+",
		|	"+ ИмяРеквизита;
		
		Если ЗначениеЗаполнено(ЗначениеРеквизита) Тогда
			
			Если СтепеньСхожести = "=" Тогда
				
				ЗнакСравнения = ?(Не МетаданныеРеквизита = Неопределено И МетаданныеРеквизита.Тип.СодержитТип(Тип("Строка")) и МетаданныеРеквизита.Тип.КвалификаторыСтроки.Длина = 0,"Подобно","=");
				СтрокаГде = ?(СтрокаГде = "", "",СтрокаГде +" или ")+"Спр."+ИмяРеквизита +" " +ЗнакСравнения+ " &"+ИмяРеквизита;
				Запрос.УстановитьПараметр(""+ИмяРеквизита,ЗначениеРеквизита);
				
			ИначеЕсли Не СтепеньСхожести = Неопределено Тогда
				
				ВЗапросеТолькоРавенство = Ложь;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "*", Реквизиты);
	
	Если ВЗапросеТолькоРавенство И НЕ ПустаяСтрока(СтрокаГде) Тогда
		
		Запрос.Текст = Запрос.Текст + Символы.ПС + "	И("+СтрокаГде+")";
		
	КонецЕсли;

	ТаблицаСправочника = Запрос.Выполнить().Выгрузить();
	
	Для каждого Строка Из ТаблицаСправочника Цикл
		
		СтруктураНайденных = Новый Структура;
		
		Для каждого КлючИЗначение Из СтруктураИсходныхРеквизитов Цикл
			
			СтепеньСхожести   = КлючИЗначение.Значение.СтепеньСхожести;
			
			Если СтепеньСхожести = "=" Тогда
				
				ИмяРеквизита      = КлючИЗначение.Ключ;
				ЗначениеРеквизита = КлючИЗначение.Значение.ЗначениеРеквизита;
				
				//Поиск по равному значению
				Если ЗначениеРеквизита = Строка[ИмяРеквизита] Тогда
					
					СтруктураНайденных.Вставить(ИмяРеквизита);
					
				КонецЕсли;
				
			ИначеЕсли Не СтепеньСхожести = Неопределено Тогда
				
				ИмяРеквизита      = КлючИЗначение.Ключ;
				
				//Поиск по похожим словам
				СписокИскомыхСлов  = КлючИЗначение.Значение.СписокСлов.Скопировать();
				СписокНайденыхСлов = ПолучитьСписокСлов(Строка[ИмяРеквизита]);
				Если Не ПроверитьСловаНаОтличие(СписокИскомыхСлов,СписокНайденыхСлов,СтепеньСхожести) Тогда
					
					СтруктураНайденных.Вставить(ИмяРеквизита);
					
				КонецЕсли;
				 
			КонецЕсли;
			
		КонецЦикла;
		
		Если Не СтруктураНайденных.Количество()=0 Тогда
			
			НоваяСтрока = НайденныеОбъекты.Добавить();
			НоваяСтрока.Ссылка = Строка.Ссылка;
			Для каждого КлючИЗначение Из СтруктураПоиска Цикл
				
				ИмяРеквизита    = КлючИЗначение.Ключ;
				
				НоваяСтрока[ИмяРеквизита] = Строка[ИмяРеквизита];
				НоваяСтрока[ИмяРеквизита+"_Флаг"] = СтруктураНайденных.Свойство(ИмяРеквизита);
				
			КонецЦикла;
			
		КонецЕсли;
		 
	КонецЦикла;
	
	Возврат НайденныеОбъекты;
	
КонецФункции // ()

ТаблицаБукв = Новый ТаблицаЗначений;
ТаблицаБукв.Колонки.Добавить("Позиция");
ТаблицаБукв.Колонки.Добавить("КолвоПропущенных");
ТаблицаБукв.Колонки.Добавить("ДлинаСлова");
ТаблицаБукв.Колонки.Добавить("ПропущеноНа");

ПослеЗаменыВозвратитсяНаЗакладкуРезультатовПоиска = Истина;
ОтключатьКонтрольЗаписи = Истина;
ВыполнятьВТранзакции = Истина;
ЗадаватьВопросПередНачаломЗамены = Истина;
УведомлятьПользователяОбОкончанииЗамены = Истина;
УдалятьЭлементыПослеЗамены = Истина;
ПредгалатьЗаменятьЭлементыПриВыбореПравильного = Истина;