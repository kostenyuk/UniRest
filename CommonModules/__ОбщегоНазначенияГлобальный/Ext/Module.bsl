﻿

Функция Свойство(Структура, Свойство, Значение = Неопределено, ПоУмолчанию = Неопределено) Экспорт
	
	Если (Структура = Неопределено) Тогда
		Значение = ПоУмолчанию; Возврат Ложь;
	КонецЕсли;
	
	ПроверяемоеЗначение = Новый УникальныйИдентификатор; СтруктураПриемник = Новый Структура(Свойство, ПроверяемоеЗначение); 
	ЗаполнитьЗначенияСвойств(СтруктураПриемник, Структура); СтруктураПриемник.Свойство(Свойство, Значение);
	Если (Не Значение = ПроверяемоеЗначение) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Значение = ПоУмолчанию; Возврат Ложь;
	
КонецФункции // Свойство()

Функция ПолучитьСвойство(Структура, Свойство, ПоУмолчанию = Неопределено) Экспорт
	
	Если (Структура = Неопределено) Тогда
		Возврат ПоУмолчанию;
	КонецЕсли;
	
	СтруктураПриемник = Новый Структура(Свойство); ЗаполнитьЗначенияСвойств(СтруктураПриемник, Структура); Если (Не СтруктураПриемник[Свойство] = Неопределено) Тогда
		Возврат СтруктураПриемник[Свойство];
	КонецЕсли;
	
	Возврат ПоУмолчанию;
	
КонецФункции // ПолучитьСвойство()

Процедура УстановитьСвойство(Структура, Свойство, Значение = Неопределено) Экспорт
	
	Если (Структура = Неопределено) Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураИсточник = Новый Структура(Свойство, Значение); ЗаполнитьЗначенияСвойств(Структура, СтруктураИсточник);
	
КонецПроцедуры // УстановитьСвойство()


Функция ПолныйРежим() Экспорт
	
	#Если Сервер Тогда
	Возврат __ВебСервисСервер.РежимЗапускаПриложенияВебСервис();
	#КонецЕсли
	
	#Если Клиент Тогда
    // ...
	#КонецЕсли
	
	Возврат Ложь;
	
КонецФункции // ПолныйРежим()


Функция ПолучитьПараметрыУчета() Экспорт
	
	#Если Сервер Тогда
	Возврат РегистрыСведений.НастройкаПараметровУчета.Получить();
	#Иначе
	Возврат __ОбщегоНазначенияПовторно.ПолучитьНастройкиПараметровУчета();
	#КонецЕсли
	
КонецФункции // ПолучитьПараметрыУчета()

#Если Клиент Тогда
//Костенюк Александр-Старт 10.07.2012
// Процедура обработчик ожидания отвечающая за опрос временных позиций.
Процедура ОбработчикОжиданияОпросВременныхПозиций() Экспорт
	
	ОбработкаТабличныхЧастей.ОпросВременныхПозиций();
	
КонецПроцедуры // ОбработчикОжиданияОпросВременныхПозиций()
//Костенюк Александр-Финиш 10.07.2012
#КонецЕсли
