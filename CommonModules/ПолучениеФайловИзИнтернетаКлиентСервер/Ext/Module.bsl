﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Получение файлов из Интернета"
// 
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Создаёт экземпляр ИнтернетПрокси по сохраненным настройкам.
Функция ПолучитьПрокси(Протокол) Экспорт
	
	Возврат СформироватьПрокси(ПолучитьПустыеНастройкиПроксиСервера(), Протокол);
	
КонецФункции

// Разделяет URL по составным частям: протокол, сервер, путь к ресурсу.
//
// Параметры:
//  URL - Строка - ссылка на ресурс в сети Интернет
//
// Возвращаемое значение:
//  Структура:
//             Протокол            - Строка - протокол доступа к ресурсу
//             ИмяСервера          - Строка - сервер, на котором располагается ресурс
//             ПутьКФайлуНаСервере - Строка - путь к ресурсу на сервере
//
Функция РазделитьURL(знач URL) Экспорт
	
	СтруктураURL = СтруктураURI(URL);
	
	Результат = Новый Структура;
	Результат.Вставить("Протокол", ?(ПустаяСтрока(СтруктураURL.Схема),"http",СтруктураURL.Схема));
	Результат.Вставить("ИмяСервера", СтруктураURL.ИмяСервера);
	Результат.Вставить("ПутьКФайлуНаСервере", СтруктураURL.ПутьНаСервере);
	
	Возврат Результат;
	
КонецФункции

// Разбирает строку URI на составные части и возвращает в виде структуры.
// На основе RFC 3986.
//
// Параметры:
//  СтрокаURI - Строка - ссылка на ресурс в формате:
//    
//     <схема>://<логин>:<пароль>@<хост>:<порт>/<путь>?<параметры>#<якорь>
//               \______________/ \___________/
//                      |               |
//           	   авторизация     имя сервера
//               \____________________________/ \________________________/
//                              |                            |
//                       строка соединения            путь на сервере
//
// Возвращаемое значение:
//  Структура:
//             Схема         - Строка;
//             Логин         - Строка; 
//             Пароль        - Строка;
//             ИмяСервера    - Строка;
//             Хост          - Строка; 
//             Порт          - Строка; 
//             ПутьНаСервере - Строка;
//
Функция СтруктураURI(Знач СтрокаURI) Экспорт
	
	СтрокаURI = СокрЛП(СтрокаURI);
	
	// схема
	Схема = "";
	Позиция = Найти(СтрокаURI, "://");
	Если Позиция > 0 Тогда
		Схема = НРег(Лев(СтрокаURI, Позиция - 1));
		СтрокаURI = Сред(СтрокаURI, Позиция + 3);
	КонецЕсли;

	// строка соединения и путь на сервере
	СтрокаСоединения = СтрокаURI;
	ПутьНаСервере = "";
	Позиция = Найти(СтрокаСоединения, "/");
	Если Позиция > 0 Тогда
		ПутьНаСервере = Сред(СтрокаСоединения, Позиция + 1);
		СтрокаСоединения = Лев(СтрокаСоединения, Позиция - 1);
	КонецЕсли;
		
	// информация пользователя и имя сервера
	СтрокаАвторизации = "";
	ИмяСервера = СтрокаСоединения;
	Позиция = Найти(СтрокаСоединения, "@");
	Если Позиция > 0 Тогда
		СтрокаАвторизации = Лев(СтрокаСоединения, Позиция - 1);
		ИмяСервера = Сред(СтрокаСоединения, Позиция + 1);
	КонецЕсли;
	
	// логин и пароль
	Логин = СтрокаАвторизации;
	Пароль = "";
	Позиция = Найти(СтрокаАвторизации, ":");
	Если Позиция > 0 Тогда
		Логин = Лев(СтрокаАвторизации, Позиция - 1);
		Пароль = Сред(СтрокаАвторизации, Позиция + 1);
	КонецЕсли;
	
	// хост и порт
	Хост = ИмяСервера;
	Порт = "";
	Позиция = Найти(ИмяСервера, ":");
	Если Позиция > 0 Тогда
		Хост = Лев(ИмяСервера, Позиция - 1);
		Порт = Сред(ИмяСервера, Позиция + 1);
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Схема", Схема);
	Результат.Вставить("Логин", Логин);
	Результат.Вставить("Пароль", Пароль);
	Результат.Вставить("ИмяСервера", ИмяСервера);
	Результат.Вставить("Хост", Хост);
	Результат.Вставить("Порт", Порт);
	Результат.Вставить("ПутьНаСервере", ПутьНаСервере);
	
	Возврат Результат;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

////////////////////////////////////////////////////////////////////////////////
// Экспортные служебные процедуры и функции

// Функция для получения файла из сети Интернет.
//
// Параметры:
// URL           - строка - url файла в формате:
//                 [Протокол://]<Сервер>/<Путь к файлу на сервере>
// Пользователь  - строка - пользователь от имени которого установлено соединение
// Пароль        - строка - пароль пользователя от которого установлено соединение
// Порт          - число  - порт сервера с которым установлено соединение
// ЗащищенноеПассивноеСоединение
//
// НастройкаСохранения - соответствие - содержит параметры для сохранения скачанного файла
//                 ключи:
//                 МестоХранения - строка - может содержать 
//                        "Клиент" - клиент,
//                        "Сервер" - сервер,
//                        "ВременноеХранилище" - временное хранилище
//                 Путь - строка (необязательный параметр) - 
//                        путь к каталогу на клиенте либо на сервере либо адрес во временном хранилище
//                        если не задано будет сгенерировано автоматически
//
// Возвращаемое значение:
// структура
// успех  - булево - успех или неудача операции
// строка - строка - в случае успеха либо строка-путь сохранения файла
//                   либо адрес во временном хранилище
//                   в случае неуспеха сообщение об ошибке
//
Функция ПодготовитьПолучениеФайла(знач URL, знач Пользователь = Неопределено, знач Пароль = Неопределено,
	знач Порт = Неопределено, знач Таймаут, знач ЗащищенноеСоединение = Ложь, знач ПассивноеСоединение = Ложь, 
	знач НастройкаСохранения) Экспорт
	
	НастройкаСоединения = Новый Соответствие;
	НастройкаСоединения.Вставить("Пользователь", Пользователь);
	НастройкаСоединения.Вставить("Пароль",       Пароль);
	НастройкаСоединения.Вставить("Порт",         Порт);
	НастройкаСоединения.Вставить("Таймаут",      Таймаут);
	
	Протокол = РазделитьURL(URL).Протокол;
	
	Если Протокол = "ftp" Тогда
		НастройкаСоединения.Вставить("ПассивноеСоединение", ПассивноеСоединение);
	Иначе
		НастройкаСоединения.Вставить("ЗащищенноеСоединение", ЗащищенноеСоединение);
	КонецЕсли;
	
	#Если Клиент Тогда
		НастройкаПроксиСервера = СтандартныеПодсистемыКлиентПовтИсп.ПараметрыРаботыКлиента().НастройкиПроксиСервера;
	#Иначе
		НастройкаПроксиСервера = ПолучениеФайловИзИнтернета.НастройкиПроксиНаСервере();
	#КонецЕсли
	
	Если НастройкаПроксиСервера = Неопределено
		ИЛИ НастройкаПроксиСервера.Получить("ИспользоватьПрокси") <> Истина Тогда
		НастройкаПроксиСервера = ПолучитьПустыеНастройкиПроксиСервера();
	КонецЕсли;
	
	Результат = ПолучитьФайлИзИнтернет(URL, НастройкаСохранения, НастройкаСоединения, НастройкаПроксиСервера);
	
	Возврат Результат;
	
КонецФункции

// Функция возвращает пустые настройки прокси-сервера, соответствующие не использованию прокси-сервера
//
// Возвращаемое значение - структура:
//		ИспользоватьПрокси - использовать ли прокси-сервер
//		НеИспользоватьПроксиДляЛокальныхАдресов - использовать ли прокси-сервер для локальных адресов
//		ИспользоватьСистемныеНастройки - использовать ли системные настройки прокси-сервера
//		Сервер       - адрес прокси-сервера
//		Порт         - порт прокси-сервера
//		Пользователь - имя пользователя для авторизации на прокси-сервере
//		Пароль       - пароль пользователя
//
Функция ПолучитьПустыеНастройкиПроксиСервера() Экспорт
	
	НастройкаПроксиСервера = Новый Соответствие;
	НастройкаПроксиСервера.Вставить("ИспользоватьПрокси", Ложь);
	НастройкаПроксиСервера.Вставить("Пользователь", "");
	НастройкаПроксиСервера.Вставить("Пароль", "");
	НастройкаПроксиСервера.Вставить("Порт", "");
	НастройкаПроксиСервера.Вставить("Сервер", "");
	НастройкаПроксиСервера.Вставить("НеИспользоватьПроксиДляЛокальныхАдресов", Ложь);
	НастройкаПроксиСервера.Вставить("ИспользоватьСистемныеНастройки", Ложь);
	
	Возврат НастройкаПроксиСервера;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Локальные служебные процедуры и функции

// Функция для получения файла из сети Интернет.
//
// Параметры:
// URL - строка - url файла в формате: [Протокол://]<Сервер>/<Путь к файлу на сервере>
//
// НастройкаСоединения - Соответствие -
//		ЗащищенноеСоединение* - булево - соединение защищенное
//		ПассивноеСоединение*  - булево - соединение защищенное
//		Пользователь - строка - пользователь от имени которого установлено соединение
//		Пароль       - строка - пароль пользователя от которого установлено соединение
//		Порт         - число  - порт сервера с которым установлено соединение
//		* - взаимоисключающие ключи
//
// НастройкиПрокси - Соответствие:
//		ИспользоватьПрокси - использовать ли прокси-сервер
//		НеИспользоватьПроксиДляЛокальныхАдресов - использовать ли прокси-сервер для локальных адресов
//		ИспользоватьСистемныеНастройки - использовать ли системные настройки прокси-сервера
//		Сервер       - адрес прокси-сервера
//		Порт         - порт прокси-сервера
//		Пользователь - имя пользователя для авторизации на прокси-сервере
//		Пароль       - пароль пользователя
//
// НастройкаСохранения - соответствие - содержит параметры для сохранения скачанного файла
//		МестоХранения - строка - может содержать 
//			"Клиент" - клиент,
//			"Сервер" - сервер,
//			"ВременноеХранилище" - временное хранилище
//		Путь - строка (необязательный параметр) - путь к каталогу на клиенте либо на сервере, 
//			либо адрес во временном хранилище,  если не задано будет сгенерировано автоматически
//
// Возвращаемое значение:
// структура
// успех  - булево - успех или неудача операции
// строка - строка - в случае успеха либо строка-путь сохранения файла
//                   либо адрес во временном хранилище
//                   в случае неуспеха сообщение об ошибке
//
Функция ПолучитьФайлИзИнтернет(знач URL, знач НастройкаСохранения, знач НастройкаСоединения = Неопределено,
	знач НастройкиПрокси = Неопределено)
	
	// Объявление переменных перед первым использованием в качестве
	// параметра метода Свойство, при анализе параметров получения файлов
	// из ПараметрыПолучения. Содержат значения переданных параметров получения файла
	Перем ИмяСервера, ИмяПользователя, Пароль, Порт,
	      ЗащищенноеСоединение,ПассивноеСоединение,
	      ПутьКФайлуНаСервере, Протокол;
	
	URLРазделенный = РазделитьURL(URL);
	
	ИмяСервера           = URLРазделенный.ИмяСервера;
	ПутьКФайлуНаСервере  = URLРазделенный.ПутьКФайлуНаСервере;
	Протокол             = URLРазделенный.Протокол;
	
	ЗащищенноеСоединение = НастройкаСоединения.Получить("ЗащищенноеСоединение");
	ПассивноеСоединение  = НастройкаСоединения.Получить("ПассивноеСоединение");
	
	ИмяПользователя      = НастройкаСоединения.Получить("Пользователь");
	ПарольПользователя   = НастройкаСоединения.Получить("Пароль");
	Порт                 = НастройкаСоединения.Получить("Порт");
	Таймаут              = НастройкаСоединения.Получить("Таймаут");
	
	Если Протокол = "https" Тогда
		ЗащищенноеСоединение = Истина;
	КонецЕсли;
	
	Если Порт = Неопределено Тогда
		ПолнаяСтруктураURL = СтруктураURI(URL);
		
		Если НЕ ПустаяСтрока(ПолнаяСтруктураURL.Порт) Тогда
			ИмяСервера = ПолнаяСтруктураURL.Хост;
			Порт = ПолнаяСтруктураURL.Порт;
		КонецЕсли;
	КонецЕсли;
	
	НастройкиПрокси = ?(НастройкиПрокси = Неопределено, ПолучитьПустыеНастройкиПроксиСервера(), НастройкиПрокси);
	Прокси = СформироватьПрокси(НастройкиПрокси, Протокол);
	
	ПараметрыСоединения = Новый Массив;
	ПараметрыСоединения.Добавить(ИмяСервера);
	ПараметрыСоединения.Добавить(Порт);
	ПараметрыСоединения.Добавить(ИмяПользователя);
	ПараметрыСоединения.Добавить(ПарольПользователя);
	ПараметрыСоединения.Добавить(Прокси);
	
	Если Протокол = "ftp" Тогда
		
		ПараметрыСоединения.Добавить(ПассивноеСоединение);
		
		ПараметрыСоединения.Добавить(Таймаут);
		
		Попытка
			Соединение = Новый(Тип("FTPСоединение"), ПараметрыСоединения);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			СообщениеОбОшибке = НСтр("ru = 'Ошибка при создании FTP-соединения с сервером %1:'") + Символы.ПС + "%2";
			
			ЗаписатьОшибкуВЖурналРегистрации(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				СообщениеОбОшибке, ИмяСервера, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке)));
			СообщениеОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СообщениеОбОшибке, ИмяСервера,
					КраткоеПредставлениеОшибки(ИнформацияОбОшибке));
			Возврат СформироватьРезультат(Ложь, СообщениеОбОшибке);
		КонецПопытки;
	Иначе
		
		ПараметрыСоединения.Добавить(Таймаут);
		
		Если ЗащищенноеСоединение = Истина Тогда
			ИмяТип = "ЗащищенноеСоединениеOpenSSL";
			ЗащищенноеСоединение = Новый(Тип(ИмяТип));
		Иначе
			ЗащищенноеСоединение = Неопределено;
		КонецЕсли;
		ПараметрыСоединения.Добавить(ЗащищенноеСоединение);
		
		Попытка
			Соединение = Новый(Тип("HTTPСоединение"), ПараметрыСоединения);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			СообщениеОбОшибке = НСтр("ru = 'Ошибка при создании HTTP-соединения с сервером %1:'") + Символы.ПС + "%2";
			ЗаписатьОшибкуВЖурналРегистрации(
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СообщениеОбОшибке, ИмяСервера, 
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке)));
			СообщениеОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СообщениеОбОшибке, ИмяСервера, 
					КраткоеПредставлениеОшибки(ИнформацияОбОшибке));
			Возврат СформироватьРезультат(Ложь, СообщениеОбОшибке);
		КонецПопытки;
	КонецЕсли;
	
	Если НастройкаСохранения["Путь"] <> Неопределено Тогда
		ПутьДляСохранения = НастройкаСохранения["Путь"];
	Иначе
		#Если НЕ ВебКлиент Тогда
			ПутьДляСохранения = ПолучитьИмяВременногоФайла();
		#КонецЕсли
	КонецЕсли;
	
	Попытка
		Соединение.Получить(ПутьКФайлуНаСервере, ПутьДляСохранения);
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		СообщениеОбОшибке = НСтр("ru = 'Ошибка при получении файла с сервера %1:'") + Символы.ПС + "%2";
		ЗаписатьОшибкуВЖурналРегистрации(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СообщениеОбОшибке, ИмяСервера, 
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке)));
		СообщениеОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СообщениеОбОшибке, ИмяСервера, 
				КраткоеПредставлениеОшибки(ИнформацияОбОшибке));
		Возврат СформироватьРезультат(Ложь, СообщениеОбОшибке);
	КонецПопытки;
	
	// Если сохраняем файл в соответствии с настройкой 
	Если НастройкаСохранения["МестоХранения"] = "ВременноеХранилище" Тогда
		КлючУникальности = Новый УникальныйИдентификатор;
		Адрес = ПоместитьВоВременноеХранилище (Новый ДвоичныеДанные(ПутьДляСохранения), КлючУникальности);
		Возврат СформироватьРезультат(Истина, Адрес);
	ИначеЕсли НастройкаСохранения["МестоХранения"] = "Клиент"
	      ИЛИ НастройкаСохранения["МестоХранения"] = "Сервер" Тогда
		Возврат СформироватьРезультат(Истина, ПутьДляСохранения);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Функция формирует прокси по настройкам прокси (передаваемому параметру)
//
// Параметры:
// 
// НастройкаПроксиСервера - Соответствие:
//		ИспользоватьПрокси - использовать ли прокси-сервер
//		НеИспользоватьПроксиДляЛокальныхАдресов - использовать ли прокси-сервер для локальных адресов
//		ИспользоватьСистемныеНастройки - использовать ли системные настройки прокси-сервера
//		Сервер       - адрес прокси-сервера
//		Порт         - порт прокси-сервера
//		Пользователь - имя пользователя для авторизации на прокси-сервере
//		Пароль       - пароль пользователя
// Протокол - строка - протокол для которого устанавливаются параметры прокси сервера, например "http", "https", "ftp"
// 
Функция СформироватьПрокси(НастройкаПроксиСервера, Протокол)
	
	Если НастройкаПроксиСервера <> Неопределено Тогда
		ИспользоватьПрокси = НастройкаПроксиСервера.Получить("ИспользоватьПрокси");
		ИспользоватьСистемныеНастройки = НастройкаПроксиСервера.Получить("ИспользоватьСистемныеНастройки");
		Если ИспользоватьПрокси Тогда
			Если ИспользоватьСистемныеНастройки Тогда
				// Системные настройки прокси-сервера
				Прокси = Новый ИнтернетПрокси(Истина);
			Иначе
				
				// Настройки прокси-сервера, заданные вручную
				Прокси = Новый ИнтернетПрокси;
				
				// Определение адреса и порта прокси-сервера
				ДополнительныеНастройки = НастройкаПроксиСервера.Получить("ДополнительныеНастройкиПрокси");
				ПроксиПоПротоколу = Неопределено;
				Если ТипЗнч(ДополнительныеНастройки) = Тип("Соответствие") Тогда
					ПроксиПоПротоколу = ДополнительныеНастройки.Получить(Протокол);
				КонецЕсли;
				
				Если ТипЗнч(ПроксиПоПротоколу) = Тип("Структура") Тогда
					Прокси.Установить(Протокол, ПроксиПоПротоколу.Адрес, ПроксиПоПротоколу.Порт);
				Иначе
					Прокси.Установить(Протокол, НастройкаПроксиСервера["Сервер"], НастройкаПроксиСервера["Порт"]);
				КонецЕсли;
				
				Прокси.НеИспользоватьПроксиДляЛокальныхАдресов = НастройкаПроксиСервера["НеИспользоватьПроксиДляЛокальныхАдресов"];
				Прокси.Пользователь = НастройкаПроксиСервера["Пользователь"];
				Прокси.Пароль       = НастройкаПроксиСервера["Пароль"];
				
				АдресаИсключений = НастройкаПроксиСервера.Получить("НеИспользоватьПроксиДляАдресов");
				Если ТипЗнч(АдресаИсключений) = Тип("Массив") Тогда
					Для каждого АдресИсключения Из АдресаИсключений Цикл
						Прокси.НеИспользоватьПроксиДляАдресов.Добавить(АдресИсключения);
					КонецЦикла;
				КонецЕсли;
				
			КонецЕсли;
		Иначе
			// Не использовать прокси-сервер
			Прокси = Новый ИнтернетПрокси(Ложь);
		КонецЕсли;
	Иначе
		// Системные установки прокси-сервера
		Прокси = Неопределено;
	КонецЕсли;
	
	Возврат Прокси;
	
КонецФункции

// Функция, заполняющая структуру по параметрам.
//
// Параметры:
// УспехОперации - булево - успех или неуспех операции
// СообщениеПуть - строка - 
//
// Возвращаемое значение - структура:
//          поле успех - булево
//          поле путь  - строка
//
Функция СформироватьРезультат(знач Статус, знач СообщениеПуть)
	
	Результат = Новый Структура("Статус");
	
	Результат.Статус = Статус;

	Если Статус Тогда
		Результат.Вставить("Путь", СообщениеПуть);
	Иначе
		Результат.Вставить("СообщениеОбОшибке", СообщениеПуть);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Записывает событие-ошибку в журнал регистрации. Имя события
// "Получение файлов из Интернета".
// Параметры
//   СообщениеОбОшибке - строка сообщение об ошибке
// 
Процедура ЗаписатьОшибкуВЖурналРегистрации(знач СообщениеОбОшибке) Экспорт
	
#Если Сервер ИЛИ ВнешнееСоединение Тогда
	ЗаписьЖурналаРегистрации(
		СобытиеЖурналаРегистрации(),
		УровеньЖурналаРегистрации.Ошибка, , ,
		СообщениеОбОшибке);
#Иначе
	ОбщегоНазначенияКлиент.ДобавитьСообщениеДляЖурналаРегистрации(СобытиеЖурналаРегистрации(),
		"Ошибка", СообщениеОбОшибке,,Истина);
#КонецЕсли
	
КонецПроцедуры

Функция СобытиеЖурналаРегистрации()
	
	Возврат НСтр("ru = 'Получение файлов из Интернета'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
	
КонецФункции

