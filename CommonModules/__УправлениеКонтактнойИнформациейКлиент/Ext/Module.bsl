﻿
Процедура НаименованиеСокращенноеПриИзменении(Объект) Экспорт
	
	Объект.Наименование = Объект.НаименованиеСокращенное;
	Если (Не Объект.ЭтоГруппа) И (Не ПустаяСтрока(Объект.Наименование)) И ЗначениеЗаполнено(Объект.Тип) Тогда
		Объект.Наименование = Строка(Объект.Тип) + " " + Объект.Наименование;
	КонецЕсли;		
	
КонецПроцедуры // НаименованиеСокращенноеПриИзменении()

Процедура ТелефонныеКодаКодПриИзменении(Объект, Элемент) Экспорт
	
	ТекущиеДанные = Элемент.Родитель.ТекущиеДанные;
	
	// Нормализация.
	Если ТипЗнч(Объект.Ссылка) = Тип("СправочникСсылка.КлассификаторСтранМира") Тогда
		ТекущиеДанные.Код = __УправлениеКонтактнойИнформациейКлиентСервер.ПривестиКодСтраныНомераТелефонаКШаблону(ТекущиеДанные.Код);
	КонецЕсли;
	Если (ТипЗнч(Объект.Ссылка) = Тип("СправочникСсылка.КлассификаторГородов")) Или 
		 (ТипЗнч(Объект.Ссылка) = Тип("СправочникСсылка.КлассификаторОператоровСвязи")) Тогда
		ТекущиеДанные.Код = __УправлениеКонтактнойИнформациейКлиентСервер.ПривестиКодГородаНомераТелефонаКШаблону(ТекущиеДанные.Код);
	КонецЕсли;
	
КонецПроцедуры // ТелефонныеКодаКодПриИзменении()

Процедура ТелефонныеКодаПриОкончанииРедактирования(Объект, Элемент, НоваяСтрока, ОтменаРедактирования) Экспорт
	
	// Удаление пустых.
	Если Не ОтменаРедактирования Тогда
		Если ПустаяСтрока(Элемент.ТекущиеДанные.Код) Тогда
			
			Объект.ТелефонныеКода.Удалить(Элемент.ТекущиеДанные);
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ТелефонныеКодаПриОкончанииРедактирования()



//&НаКлиенте
//Функция КонтактнаяИнформацияОсновнойДоступность(КонтактнаяИнформация, Элемент) Экспорт
//	
//	ТекущиеДанные = Элемент.ТекущиеДанные; 
//	Если (ТекущиеДанные = Неопределено) Или (ТекущиеДанные.Пустой) Или (Не ТекущиеДанные.Вид = ТекущиеДанные.Тип) Тогда
//		Возврат Ложь;
//	КонецЕсли;
//	
//	Тип = ТекущиеДанные.Тип; Если __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияТелефон(ТекущиеДанные, Тип) Или __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияАдрес(ТекущиеДанные, Тип) Тогда
//		Возврат Истина;
//	КонецЕсли;
//	
//	Возврат Ложь;
//	
//КонецФункции // КонтактнаяИнформацияОсновнойДоступность()

//&НаКлиенте
//Функция КонтактнаяИнформацияДополнительныйДоступность(КонтактнаяИнформация, Элемент) Экспорт
//	
//	ТекущиеДанные = Элемент.ТекущиеДанные; 
//	Если (ТекущиеДанные = Неопределено) Или (ТекущиеДанные.Пустой) Или (Не ТекущиеДанные.Вид = ТекущиеДанные.Тип) Или (ТекущиеДанные.Основной) Тогда
//		Возврат Ложь;
//	КонецЕсли;
//	
//	Тип = ТекущиеДанные.Тип; Если __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияТелефон(ТекущиеДанные, Тип) Тогда
//		
//		Коллекция = __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьКоллекцию(КонтактнаяИнформация); Отмена = ТекущиеДанные.Основной;
//		Для Каждого Структура Из Коллекция Цикл
//			Если (Структура.Тип = Тип) И (Структура.Основной) Тогда
//				Если  (Структура.Основной) Тогда
//					Возврат Истина;
//				КонецЕсли;
//			КонецЕсли;
//		КонецЦикла;
//		
//	КонецЕсли;
//	
//	Возврат Ложь;
//	
//КонецФункции // КонтактнаяИнформацияДополнительныйДоступность()

//&НаКлиенте
//Процедура КонтактнаяИнформацияОсновнойПриИзменении(КонтактнаяИнформация, Элемент) Экспорт
//	
//	ТекущиеДанные = Элемент.ТекущиеДанные; 
//	Если (ТекущиеДанные = Неопределено) Или (ТекущиеДанные.Пустой) Или (Не ТекущиеДанные.Вид = ТекущиеДанные.Тип) Тогда
//		Возврат;
//	КонецЕсли;
//	
//	Тип = ТекущиеДанные.Тип; Если __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияТелефон(ТекущиеДанные, Тип) Или __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияАдрес(ТекущиеДанные, Тип) Тогда
//		
//		Коллекция = __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьКоллекцию(КонтактнаяИнформация); Отмена = ТекущиеДанные.Основной;
//		Для Каждого Структура Из Коллекция Цикл
//			Если (Структура.Тип = Тип) Тогда
//				Если (Структура = ТекущиеДанные) Тогда
//					Структура.Основной = (Не Структура.Основной); Структура.Дополнительный = Ложь;  
//				Иначе
//					Структура.Основной = Отмена И Структура.Дополнительный; Структура.Дополнительный = (Не Отмена) И Структура.Дополнительный;
//				КонецЕсли;
//			КонецЕсли;
//		КонецЦикла;
//		
//	КонецЕсли;
//	
//КонецПроцедуры // КонтактнаяИнформацияОсновнойПриИзменении()

//&НаКлиенте
//Процедура КонтактнаяИнформацияДополнительныйПриИзменении(КонтактнаяИнформация, Элемент) Экспорт
//	
//	ТекущиеДанные = Элемент.ТекущиеДанные; 
//	Если (ТекущиеДанные = Неопределено) Или (ТекущиеДанные.Пустой) Или (Не ТекущиеДанные.Вид = ТекущиеДанные.Тип) Тогда
//		Возврат;
//	КонецЕсли;
//	
//	Тип = ТекущиеДанные.Тип; Если __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияТелефон(ТекущиеДанные, Тип) Тогда
//		
//		Коллекция = __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьКоллекцию(КонтактнаяИнформация); Установка = Не ТекущиеДанные.Дополнительный;
//		Для Каждого Структура Из Коллекция Цикл
//			Если (Структура.Тип = Тип) И (Структура.Основной) Тогда
//				Если (Не Структура = ТекущиеДанные) Тогда
//					Основной = Структура; Прервать;
//				КонецЕсли;
//			КонецЕсли;
//		КонецЦикла;
//		Для Каждого Структура Из Коллекция Цикл
//			Если (Структура.Тип = Тип) Тогда
//				Если (Структура = ТекущиеДанные) Тогда
//					Структура.Дополнительный = (Не Структура.Дополнительный);
//				Иначе
//					Структура.Дополнительный = Ложь;
//				КонецЕсли;
//			КонецЕсли;
//		КонецЦикла;
//		Если Установка  Тогда
//			Если (Основной = Неопределено) Тогда
//				ТекущиеДанные.Дополнительный = Ложь; ТекущиеДанные.Основной = Истина;
//			КонецЕсли;
//		КонецЕсли;
//		
//	КонецЕсли;
//	
//КонецПроцедуры // КонтактнаяИнформацияДополнительныйПриИзменении()

//&НаКлиенте
//Процедура КонтактнаяИнформацияНаименованиеПриИзменении(КонтактнаяИнформация, Элемент) Экспорт
//	
//	Если (Элемент = Неопределено) Тогда
//		__УправлениеКонтактнойИнформациейКлиентСервер.ПолеПриИзменении(КонтактнаяИнформация, , "Наименование");
//	Иначе
//		__УправлениеКонтактнойИнформациейКлиентСервер.ПолеПриИзменении(Элемент.Родитель.ТекущиеДанные, , Элемент);
//	КонецЕсли;
//	
//КонецПроцедуры // КонтактнаяИнформацияНаименованиеПриИзменении()

//&НаКлиенте
//Процедура КонтактнаяИнформацияПередНачаломДобавления(КонтактнаяИнформация, Элемент, Отказ, Копирование, Родитель = Неопределено, Группа = Неопределено, ДобавляемыйТип = Неопределено) Экспорт
//	
//	Отказ = Истина;
//	
//	// Тип.
//	Если (ДобавляемыйТип = Неопределено) Тогда
//		Форма = ПолучитьФорму("Обработка.__КонтактнаяИнформация.Форма.ФормаВыбораТипа", , Элемент);
//		Если (Не Форма.ОткрытьМодально() = КодВозвратаДиалога.ОК) Тогда
//			Возврат;
//		КонецЕсли;
//		Тип = Форма.Тип;
//	Иначе
//		Тип = ДобавляемыйТип; ДобавляемыйТип = Неопределено;
//	КонецЕсли;
//	
//	// Редактирование.
//	Коллекция = __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьКоллекцию(КонтактнаяИнформация);
//	КонтактнаяИнформацияПередНачаломИзменения(КонтактнаяИнформация, Элемент, Истина, Коллекция.НайтиСтроки(Новый Структура("Тип,Пустой", Тип, Истина))[0]);

//КонецПроцедуры // КонтактнаяИнформацияПередНачаломДобавления()

//&НаКлиенте
//Процедура КонтактнаяИнформацияПередНачаломИзменения(КонтактнаяИнформация, Элемент, Отказ, ТекущиеДанные = Неопределено) Экспорт
//	
//	Если (Элемент = Неопределено) Тогда
//		ТекущиеДанные = КонтактнаяИнформация;
//		РедакированиеВФорме = Истина;
//	Иначе
//		Если (ТекущиеДанные = Неопределено) Тогда
//			ТекущиеДанные = Элемент.ТекущиеДанные;
//		Иначе
//			РедакированиеВФорме = Истина;
//		КонецЕсли;
//	КонецЕсли;
//	
//	// Соответсвие типа и формы.
//	Если __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияТелефон(ТекущиеДанные) Тогда
//		ИмяФормы = "ФормаТелефона";
//	ИначеЕсли __УправлениеКонтактнойИнформациейКлиентСервер.КонтактнаяИнформацияАдрес(ТекущиеДанные) Тогда
//		ИмяФормы = "ФормаАдреса";
//	Иначе
//	КонецЕсли;
//	
//	// Данные.
//	Если (РедакированиеВФорме = Неопределено) Тогда
//		ИмяДанных = __УправлениеКонтактнойИнформациейКлиентСервер.ПолеИмяДанных(Элемент.ТекущийЭлемент);
//		Если (ИмяДанных = "наименование") Тогда
//			РедакированиеВФорме = (ИмяФормы = "ФормаАдреса"); 
//		Иначе
//			РедакированиеВФорме = ПустаяСтрока(ТекущиеДанные.Наименование) Или (Не ИмяДанных = "комментарий");
//		КонецЕсли;
//	КонецЕсли;
//	
//	Если РедакированиеВФорме Тогда

//		// Редакирование в форме.
//		Отказ = Истина;	Форма = ПолучитьФорму("Обработка.__КонтактнаяИнформация.Форма." + ИмяФормы, Новый Структура("ЗначенияЗаполнения", __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьСтруктуру(ТекущиеДанные)), Элемент);
//		Если (Форма.ОткрытьМодально() = КодВозвратаДиалога.ОК) Тогда
//			ЗаполнитьЗначенияСвойств(ТекущиеДанные, Форма.Объект);
//			КонтактнаяИнформацияПриОкончанииРедактирования(КонтактнаяИнформация, Элемент, Неопределено, Ложь, ТекущиеДанные)
//		КонецЕсли;
//	
//	Иначе
//		
//		// Блокировка полей.
//		Для Каждого ПодчиненныйЭлемент Из Элемент.ПодчиненныеЭлементы Цикл
//			ИмяДанных = __УправлениеКонтактнойИнформациейКлиентСервер.ПолеИмяДанных(ПодчиненныйЭлемент);
//			ПодчиненныйЭлемент.ТолькоПросмотр = (Не ИмяДанных = "наименование") И (Не ИмяДанных = "комментарий"); 
//		КонецЦикла;
//		
//	КонецЕсли;

//КонецПроцедуры // КонтактнаяИнформацияПередНачаломИзменения()

//&НаКлиенте
//Процедура КонтактнаяИнформацияПередУдалением(КонтактнаяИнформация, Элемент, Отказ) Экспорт
//	
//	// Блокировка.
//	Отказ = Элемент.ТекущиеДанные.Пустой;
//	
//	// Сортировка.
//	Если Не Отказ Тогда
//		Если Элемент.ТекущиеДанные.Основной Тогда
//			Коллекция = __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьКоллекцию(КонтактнаяИнформация); Тип = Элемент.ТекущиеДанные.Тип;
//			Для Каждого Структура Из Коллекция Цикл
//				Если (Структура.Тип = Тип) Тогда
//					Если Структура.Дополнительный Тогда
//						Структура.Основной = Истина; Структура.Дополнительный = Ложь;
//					КонецЕсли;
//				КонецЕсли;
//			КонецЦикла;
//		КонецЕсли;
//	КонецЕсли;
//	
//КонецПроцедуры // КонтактнаяИнформацияПередУдалением()

//&НаКлиенте
//Процедура КонтактнаяИнформацияПриОкончанииРедактирования(КонтактнаяИнформация, Элемент, НоваяСтрока, ОтменаРедактирования, ТекущиеДанные = Неопределено) Экспорт
//	
//	Если (Элемент = Неопределено) Тогда
//		Возврат;
//	КонецЕсли;
//	
//	// Разблокировка полей.
//	Для Каждого ПодчиненныйЭлемент Из Элемент.ПодчиненныеЭлементы Цикл
//		ПодчиненныйЭлемент.ТолькоПросмотр = Ложь; 
//	КонецЦикла;
//		
//	Если ОтменаРедактирования Тогда 
//		Возврат;
//	КонецЕсли;
//	
//	Если (ТекущиеДанные = Неопределено) Тогда
//		ТекущиеДанные = Элемент.ТекущиеДанные;
//	Иначе
//		РедакированиеВФорме = Истина;
//	КонецЕсли;
//	
//	// Автодобавление строк.
//	Коллекция = __УправлениеКонтактнойИнформациейКлиентСервер.ПолучитьКоллекцию(КонтактнаяИнформация);
//	Если ПустаяСтрока(ТекущиеДанные.Наименование) Тогда
//		Если Не ТекущиеДанные.Пустой Тогда
//			Коллекция.Удалить(Элемент.ТекущиеДанные);
//		КонецЕсли;
//	Иначе
//		Индекс = Коллекция.Количество(); Пока (Индекс > 0) Цикл
//			Индекс = Индекс - 1; Структура = Коллекция.Получить(Индекс);
//			Если (Не Структура = ТекущиеДанные) И (Структура.Вид = ТекущиеДанные.Тип) И (Не Структура.Пустой) И (Структура.Наименование = ТекущиеДанные.Наименование) Тогда
//				Если ПустаяСтрока(ТекущиеДанные.Комментарий) Тогда
//					ТекущиеДанные.Комментарий = Структура.Комментарий;
//				КонецЕсли;
//				ТекущиеДанные.ДатаНачалаПериода = Структура.ДатаНачалаПериода;
//				ТекущиеДанные.ДатаОкончанияПериода = Структура.ДатаОкончанияПериода;
//				ТекущиеДанные.Основной = Структура.Основной;
//				ТекущиеДанные.Дополнительный = Структура.Дополнительный;
//				Если (Структура.Вид = ТекущиеДанные.Тип) Тогда
//					Коллекция.Удалить(Структура);
//				КонецЕсли;
//			КонецЕсли;
//		КонецЦикла;
//		Если ТекущиеДанные.Пустой Тогда
//			Пустой = Коллекция.Добавить(); ЗаполнитьЗначенияСвойств(Пустой, ТекущиеДанные, "Вид,Тип,Сортировка,НомерКартинки"); Пустой.Пустой = Истина;
//			ТекущиеДанные.Пустой = Ложь;
//		КонецЕсли;
//	КонецЕсли;
//	
//	// Сортировка.
//	Коллекция.Сортировать("Сортировка,Пустой,Наименование");
//	
//КонецПроцедуры // КонтактнаяИнформацияПриОкончанииРедактирования()
