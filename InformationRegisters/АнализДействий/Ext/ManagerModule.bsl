﻿Процедура СоздатьЗаписьВРегистреАнализДействий(Ссылка, СтруктураДействий )  Экспорт          
	
	АнализДействий  = РегистрыСведений.АнализДействий.СоздатьМенеджерЗаписи();	
	АнализДействий.Дата	= ТекущаяДата();
	АнализДействий.Пользователь = глЗначениеПеременной("глТекущийПользователь");
	АнализДействий.Действие = СтруктураДействий["Действие"];
	АнализДействий.Заказ = Ссылка; 
	АнализДействий.Компьютер  = ПараметрыСеанса.ТекущийКомпьютер; //ПолучитьСерверТО().ПолучитьКомпьютерТО();
	АнализДействий.Изменение =  СтруктураДействий["ЧтоИзменялось"];
	АнализДействий.Количество = СтруктураДействий["Количество"];  
	АнализДействий.Коментарий = СтруктураДействий["Коментарий"];
	
	//Костенюк Александр-Старт 29.03.2012
	Если НЕ Ссылка.Пустая() Тогда
		Если ОбщегоНазначения.ЕстьРеквизитДокумента("ДисконтнаяКарта", Ссылка.ПолучитьОбъект().Метаданные()) Тогда
			АнализДействий.ДисконтнаяКарта = Ссылка.ДисконтнаяКарта; 
		КонецЕсли;
	КонецЕсли;
	//Костенюк Александр-Финиш 29.03.2012
	
	Попытка
		АнализДействий.Записать(); 
	Исключение
		ОбщегоНазначения.СообщитьОбОшибкеЗапеисиРегистра(ОписаниеОшибки(), , ,,);
	КонецПопытки;
	
КонецПроцедуры

// Чистяков Павел 01.03.2012 13:50:52 
Процедура Зарегистрировать(Действие,Заказ,Изменение=Неопределено,Комментарий="",Количество=0,СвязанныйДокумент=Неопределено) Экспорт
	
	АнализДействий  			= РегистрыСведений.АнализДействий.СоздатьМенеджерЗаписи();	
	
	//Костенюк Александр-Закомментировано 14.05.2013
	// такой механизм неоптимален
	//Запрос = Новый Запрос(
	//"ВЫБРАТЬ ПЕРВЫЕ 1
	//|	МАКСИМУМ(АнализДействий.Ключ) КАК Ключ
	//|ИЗ
	//|	РегистрСведений.АнализДействий КАК АнализДействий"
	//);
	//Выборка = Запрос.Выполнить().Выбрать();
	//Если Выборка.Следующий() Тогда
	//	Если Выборка.Ключ<>Неопределено
	//		И Выборка.Ключ<>null Тогда
	//		АнализДействий.Ключ	= Выборка.Ключ+1;
	//	КонецЕсли; 
	//КонецЕсли; 
	
	//Костенюк Александр-Старт 14.05.2013
	НомерОперации = РегистрыСведений.НомерОперацииАнализаДействий.ПолучитьНомерОперации();
	// Если еще нет записей в регистре НомерОперацииАнализаДействий, то используем старый алгоритм
	// т.е. получаем максимальное значение из регистра "АнализДействий"
	Если НомерОперации = 0 Тогда
		Запрос = Новый Запрос(
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	МАКСИМУМ(АнализДействий.Ключ) КАК Ключ
		|ИЗ
		|	РегистрСведений.АнализДействий КАК АнализДействий"
		);
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			Если Выборка.Ключ<>Неопределено
				И Выборка.Ключ<>null Тогда
				НомерОперации = Выборка.Ключ; 
			КонецЕсли; 
		КонецЕсли; 
	КонецЕсли;
	АнализДействий.Ключ = НомерОперации + 1;
	//Костенюк Александр-Финиш 14.05.2013
	
	АнализДействий.Дата			= ТекущаяДата();
	АнализДействий.Пользователь = ПараметрыСеанса.ТекущийПользователь;
	АнализДействий.Действие		= Действие;
	АнализДействий.Заказ		= Заказ; 
	АнализДействий.Компьютер	= ПараметрыСеанса.ТекущийКомпьютер;
	АнализДействий.Изменение	= Изменение;
	АнализДействий.Количество	= Количество;
	АнализДействий.Коментарий	= Комментарий;
	АнализДействий.СязанныйДокумент = СвязанныйДокумент;
	
	//Костенюк Александр-Старт 29.03.2012
	Если НЕ Заказ.Пустая() Тогда
		Если ОбщегоНазначения.ЕстьРеквизитДокумента("ДисконтнаяКарта", Заказ.ПолучитьОбъект().Метаданные()) Тогда
			АнализДействий.ДисконтнаяКарта = Заказ.ДисконтнаяКарта; 
		КонецЕсли;
	КонецЕсли;
	//Костенюк Александр-Финиш 29.03.2012

	АнализДействий.Записать();
	РегистрыСведений.НомерОперацииАнализаДействий.ЗаписатьНомерОперации(АнализДействий.Ключ); //Костенюк Александр 14.05.2013
	
КонецПроцедуры