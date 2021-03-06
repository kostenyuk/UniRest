﻿////
//Для файлового варианта определены следующие параметры: 
//File - каталог, в котором размещается файл информационной базы 
//Locale - Язык (Страна), которые будут использованы при создании информационной базы. Допустимые значения такие же как у метода Формат 
//Параметр Locale задавать не обязательно. Если не задан, то будут использованы региональные установки текущей информационной базы. 

//Для клиент-серверного варианта определены следующие параметры: 
//Srvr - имя сервера 1С:Предприятия 
//Ref - Имя информационной базы на сервере 
//DBMS - тип сервера баз данных. Возможные значения: MSSQLServer - Microsoft SQL Server, PostgreSQL - PostgreSQL, IBMDB2 - IBM DB2. По умолчанию - Microsoft SQL Server 
//DBSrvr - имя сервера баз данных 
//DB - имя базы данных в сервере баз данных 
//DBUID - имя пользователя сервера баз данных 
//DBPwd - пароль пользователя сервера баз данных. Если пароль для пользователя СУБД не задан, то данный параметр можно не указывать 
//SQLYOffs - смещение дат, используемое для хранения дат в Microsoft SQL Server. Может принимать значения 0 или 2000 
//Данный параметр задавать не обязательно. Если не задан принимается значение 0. 
//Locale - Язык (Страна), которые будут использованы при создании информационной базы. Допустимые значения такие же как у метода Формат 
//Параметр Locale задавать не обязательно. Если не задан, то будут использованы региональные установки текущей информационной базы. 
//CrSQLDB - создать базу данных в случае ее отсутствия (Y/N). Значение по умолчанию - N. 
//SchJobDn - в созданной информационной базе запретить выполнение регламентных созданий (Y/N). Значение по умолчанию - N. 
//SUsr - имя администратора кластера, в котором должен быть создан начальный образ. Параметр необходимо задавать, если в кластере определены администраторы и для них аутентификация операционной системы не установлена или не подходит. 
//SPwd - пароль администратора кластера. 
//Для совместимости с 1С:Предприятием 8.1 для следующих параметров предусмотрена возможность использования устаревших названий: DBSrvr - SQLSrvr, DB - SQLDB, DBUID - SQLUID, DBPwd - SQLPwd. 
//Описание: 
//Создает начальный образ подчиненного узла распределенной информационной базы. Начальный образ выгружается в информационную базу, которая создается в процессе создания начального образа или должна быть пустой. 


&НаСервере
Процедура СоздатьНачальныйОбразФайловыйВариант(Путь)

	Попытка
	
		ПланыОбмена.СоздатьНачальныйОбраз(ДанныеФормыВЗначение(Объект, Тип("ПланОбменаОбъект.ОбменДанными2K_CRS")),
		"File="""+Путь+""";Locale=ru_RU");
		
	Исключение
		Сообщить(ОписаниеОшибки())
	КонецПопытки;
	
КонецПроцедуры // СоздатьНачальныйОбраз()

&НаКлиенте
Процедура СоздатьНачальныйОбразФайловыйВариантНаКлиенте(Команда)
	
	ОчиститьСообщения();
	
	//Выгрузка в файловом варианте 
	//Создать начальный образ периферийной базы в файл 1CD, 
	//потом передать на компьютер клиента 
	//и там подключить к файлу 1С.

	Если Не ПроверитьЗаполнение() Тогда
		Возврат	
	КонецЕсли;

	ИмяФайлаБазы = "1Cv8.1CD";
	Путь = ПутьФайловый;
	
	Если РаботаСФайлами.ФайлСуществует(РаботаСФайлами.НормализоватьКаталог(Путь)+ИмяФайлаБазы) Тогда
		УдалитьФайлы(РаботаСФайлами.НормализоватьКаталог(Путь)+ИмяФайлаБазы);
	КонецЕсли;
	
	Путь = СокрЛП(СтрЗаменить(Путь, "\", "/"));
	Если Прав(Путь,1) = "/" Тогда
		Путь = Лев(Путь, СтрДлина(Путь)-1);
	КонецЕсли;
	
	СоздатьНачальныйОбразФайловыйВариант(Путь);
	
	Если РаботаСФайлами.ФайлСуществует(РаботаСФайлами.НормализоватьКаталог(Путь)+ИмяФайлаБазы) Тогда
		Предупреждение("Начальный образ успешно создан!");
	Иначе
		Предупреждение("Начальный образ создать не удалось!");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьНачальныйОбразСерверныйВариант(БылиОшибки)
	
	Попытка
		
		ПланыОбмена.СоздатьНачальныйОбраз(ДанныеФормыВЗначение(Объект, Тип("ПланОбменаОбъект.ОбменДанными2K_CRS")),
		"Srvr="""+ИмяСервера+""";"+
		"Ref="""+ИмяИнформационнойБазыНаСервере+""";"+
		"DBMS="""+ТипСУБД+""";"+
		"DBSrvr="""+ИмяСервераБазДанных+""";"+
		"DB="""+ИмяБазыДанных+""";"+
		"DBUID="""+ПользовательБазыДанных+""";"+
		"DBPwd="""+ПарольПользователя+""";"+
		"SQLYOffs="""+СмещениеДат+""";"+
		"CrSQLDB="""+Формат(СоздатьБазуДанныхВСлучаеОтсутствия, "БЛ=N; БИ=Y")+""";"+
		"SchJobDn="""+Формат(УстановитьБлокировкуРегламентныхЗаданий, "БЛ=N; БИ=Y")+""""+";Locale=ru_RU");
		БылиОшибки = Ложь;
	Исключение
		БылиОшибки = Истина;
		Сообщить(ОписаниеОшибки())
	КонецПопытки;
	
КонецПроцедуры // СоздатьНачальныйОбраз()

&НаКлиенте
Процедура СоздатьНачальныйОбразСерверныйВариантНаКлиенте(Команда)
	
	ОчиститьСообщения();
	
	//Выгрузка в серверном варианте 
	//Создать начальный образ периферийной базы сразу на SQL, 
	//потом отцепить (detach) файл данных и лог, 
	//перетащить их на пер. сервер 
	//и там подцепить (attach) 
	//Потом 1С подключить к этой базе.
	Если ПроверитьЗаполнение() Тогда
		БылиОшибки = Ложь;
		СоздатьНачальныйОбразСерверныйВариант(БылиОшибки);
		Если Не БылиОшибки Тогда
			Предупреждение("Начальный образ успешно создан!");		
			Закрыть();
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры


&НаКлиенте
Процедура ПутьФайловыйНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	
	Диалог.Заголовок = НСтр("ru = 'Укажите каталог для сохранения базы данных'");
	Диалог.МножественныйВыбор = Ложь;
	Диалог.Каталог = ПутьФайловый;
	
	Если Диалог.Выбрать() Тогда
		
		ПутьФайловый = Диалог.Каталог;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВариантСозданияОбразаПриИзменении(Элемент)
	Если ВариантСозданияОбраза = "С" Тогда
		Элементы.ВариантыСозданияОбраза.ТекущаяСтраница = Элементы.СтраницаСерверный;
		Элементы.ГруппаКнопки.ТекущаяСтраница = Элементы.КнопкиС;
	Иначе
		Элементы.ВариантыСозданияОбраза.ТекущаяСтраница = Элементы.СтраницаФайловый;
		Элементы.ГруппаКнопки.ТекущаяСтраница = Элементы.КнопкиФ;
	КонецЕсли;	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВариантСозданияОбраза = "Ф";
	//СоздатьБазуДанныхВСлучаеОтсутствия = Истина;
	СоздатьБазуДанныхВСлучаеОтсутствия = Ложь; //Костенюк Александр 07.04.2014
	СмещениеДат = "2000";
	ТипСУБД = "MSSQLServer";
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Элементы.ВариантыСозданияОбраза.ТекущаяСтраница = Элементы.СтраницаФайловый;
	Элементы.ГруппаКнопки.ТекущаяСтраница = Элементы.КнопкиФ;
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Если ВариантСозданияОбраза = "Ф" Тогда
		ПроверяемыеРеквизиты.Очистить();
		ПроверяемыеРеквизиты.Добавить("ПутьФайловый");
	Иначе
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ПутьФайловый"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТипСУБДПриИзменении(Элемент)
	Если ТипСУБД = "MSSQLServer" Тогда
		Элементы.СмещениеДат.ТолькоПросмотр = Ложь;
		СмещениеДат = "2000";
	Иначе	
		Элементы.СмещениеДат.ТолькоПросмотр = Истина;
		СмещениеДат = "0";
	КонецЕсли;
КонецПроцедуры
