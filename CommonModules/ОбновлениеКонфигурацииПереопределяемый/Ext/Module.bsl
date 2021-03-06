﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Обновление конфигурации"
//  
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Получить короткое имя (идентификатор) конфигурации.
//
// Возвращаемое значение:
//   Строка   – короткое имя конфигурации.
Функция КороткоеИмяКонфигурации() Экспорт
	
	// _Демо начало примера
	Возврат "SSL";
	// _Демо конец примера
	
	Возврат "";
	
КонецФункции

// Получить адрес веб-сервера поставщика конфигурации, на котором находится
// информация о доступных обновлениях ("открытая" часть веб-сайта).
//
// Возвращаемое значение:
//   Строка   – адрес веб-сервера.
//
// Примеры реализации:
//	Возврат "localhost";  // локальный веб-сервер для тестирования
//	Возврат "downloads.1c.ru";  // сервер обновлений типовых конфигураций
//
Функция АдресСервераДляПроверкиНаличияОбновления() Экспорт
	
	// _Демо начало примера
	Возврат "downloads.1c.ru";
	// _Демо конец примера
	
	Возврат "";
	
КонецФункции

// Получить адрес ресурса на веб-сервере для проверки наличия обновлений
// (на "открытой" части веб-сайта).
//
// Например:
//  Возврат "/ipp/ITSREPV/V8Update/Configs/";
//
Функция АдресРесурсаДляПроверкиНаличияОбновления() Экспорт
	
	// _Демо начало примера
	Возврат "/ipp/ITSREPV/V8Update/Configs/";
	// _Демо конец примера
	
	Возврат "";
	
КонецФункции

// Получить адрес веб-сайта с каталогом обновлений ("закрытая" часть веб-сайта).
//
// Примеры реализации:
//  Возврат Метаданные.АдресКаталогаОбновлений; // из свойств конфигурации
//	Возврат "localhost/tmplts/"; // локальный веб-сервер для тестирования 
//
Функция КаталогОбновлений() Экспорт
	
	// _Демо начало примера
	Возврат Метаданные.АдресКаталогаОбновлений;
	// _Демо конец примера
	
	Возврат "";
	
КонецФункции

