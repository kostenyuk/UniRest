﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Рассылка отчетов" (сервер, переопределяемый)
// 
// Выполняется на сервере, изменяется под специфику прикладной конфигурации, 
// но предназначен для использования только данной подсистемой.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Позволяет изменить форматы по умолчанию и установить картинки
// 
// Параметры:
//   СписокФорматов - (СписокЗначений) список форматов
//       |- Значение      - (ПеречислениеСсылка.ФорматыСохраненияОтчетов) Формат
//       |- Представление - (Строка) Представление формата
//       |- Пометка       - (Булево) Признак того, что формат используется по умолчанию
//       |- Картинка      - (Картинка) Картинка формата
//
// Изменить настройки формата можно при помощи процедуры "РассылкаОтчетов.УстановитьПараметрыФормата":
// 
// РассылкаОтчетов.УстановитьПараметрыФормата(СписокФорматов, ФорматСсылка, Картинка, ИспользоватьПоУмолчанию);
//   Обязательные параметры:
//       |- СписокФорматов (...) Передается из параметров процедуры "как есть"
//       |- ФорматСсылка   (Строка, ПеречислениеСсылка.ФорматыСохраненияОтчетов) Формат
//   Необязательные параметры:
//       |- Картинка                (Картинка) Картинка формата
//       |- ИспользоватьПоУмолчанию (Булево)   Признак того, что формат используется по умолчанию.
// 
// Например:
// 
//	РассылкаОтчетов.УстановитьПараметрыФормата(СписокФорматов, "HTML4", , Ложь);
//	РассылкаОтчетов.УстановитьПараметрыФормата(СписокФорматов, "XLS"  , , Истина);
//
// Пример использования - см. РассылкаОтчетовПовтИсп.СписокФорматов():
//
Процедура ПереопределитьПараметрыФорматов(СписокФорматов) Экспорт
	
	// _Демо начало примера
	
	РассылкаОтчетов.УстановитьПараметрыФормата(СписокФорматов, "_ДемоHTML3", БиблиотекаКартинок.ФорматHTML);
	
	// _Демо конец примера
	
КонецПроцедуры

// Позволяет добавить описание кросс объектной связи типов для получателей рассылки.
// 
// Использовать данный механизм требуется только в том случае, если:
// 1. Требуется описать и представить несколько типов как один (как в справочнике Пользователи и Группы пользователей).
// 2. Требуется изменить представление типа без изменения синонима метаданных.
// 3. Требуется указать вид контактной информации E-Mail по умолчанию.
// 4. Требуется определить группу контактной информации.
//
// Зарегистрировать тип можно при помощи процедуры:
//  
// РассылкаОтчетов.ДобавитьЭлементВТаблицуТиповПолучателей(ТаблицаТипов, ДоступныеТипы, Настройки);
//   Параметры:
//       ТаблицаТипов (ТаблицаЗначений) - Не меняется
//       ДоступныеТипы         (Массив) - Не меняется
//       Настройки          (Структура) - Предустановленные настройки основного типа
//         Обязательные параметры:
//           |- ОсновнойТип       - (Тип) Тип, который будет выступать как основной для 
//                                  описываемых получателей
//         Необязательные параметры:
//           |- ДополнительныйТип - (Тип) Дополнительный тип для описываемых получателей
//           |- Представление     - (Строка) Представление получателей
//           |- ВидКИ             - (СправочникСсылка.ВидыКонтактнойИнформации) Основной 
//                                  вид или группа контактной информации E-Mail
//           |- ПутьФормыВыбора   - (Строка) Путь к форме выбора
//
// Например:
//
//	РассылкаОтчетов.ДобавитьЭлементВТаблицуТиповПолучателей(ТаблицаТипов, ДоступныеТипы, 
//		Новый Структура("ОсновнойТип, ВидКИ", 
//			Тип("СправочникСсылка.Контрагенты"), Справочники.ВидыКонтактнойИнформации.EmailКонтрагента
//		)
//	);
//
// Пример использования - см. РассылкаОтчетовПовтИсп.ТаблицаТиповПолучателей():
//
Процедура ПереопределитьТаблицуТиповПолучателей(ТаблицаТипов, ДоступныеТипы) Экспорт
	
	
КонецПроцедуры

// Позволяет определить свой обработчик для сохранения табличного документа в формат
// 
// Параметры:
//   СтандартнаяОбработка - (Булево) Признак использования стандартных механизом подсистемы для сохранения в формат
//   ТабличныйДокумент    - (...)    Исходный табличный документ, который неоходимо сохранить
//   Формат - (ПеречислениеСсылка.ФорматыСохраненияОтчетов) Формат, в котором предполагается сохранение
//   ПолноеИмяФайла       - (Строка) Полное имя файла, передается БЕЗ расширения, если 
//
// Если используется нестандартная обработка (СтандартнаяОбработка меняется на Ложь), то 
//   ПолноеИмяФайла должно содержать полное имя файла с расширением
//
// Например:
//	
//	Если Формат = Перечисления.ФорматыСохраненияОтчетов.HTML4 Тогда
//		СтандартнаяОбработка = Ложь;
//		ПолноеИмяФайла = ПолноеИмяФайла +".html";
//		ТабличныйДокумент.Записать(ПолноеИмяФайла, ТипФайлаТабличногоДокумента.HTML4);
//	КонецЕсли;
// 
Процедура ПередСохранениемТабличногоДокументаВФормат(СтандартнаяОбработка, ТабличныйДокумент, Формат, ПолноеИмяФайла) Экспорт
	
	// _Демо начало примера
	
	Если Формат = Перечисления.ФорматыСохраненияОтчетов._ДемоHTML3 Тогда
		СтандартнаяОбработка = Ложь;
		ПолноеИмяФайла = ПолноеИмяФайла +".html";
		ТабличныйДокумент.Записать(ПолноеИмяФайла, ТипФайлаТабличногоДокумента.HTML3);
	КонецЕсли;
	
	// _Демо конец примера
	
КонецПроцедуры

// Позволяет определить свой обработчик разузлования списка получателей
// 
// Параметры:
//   ПараметрыПолучателей - (Структура) Параметры разузлования получателей рассылки
//   Запрос               - (Запрос) Запрос, который будет использован, если значение параметра СтандартнаяОбработка останется Истина
//   СтандартнаяОбработка - (Булево) Признак использования стандартных механизмов
//   Результат       - (Соответствие) Получатели с их E-mail адресами
//       |- Ключ     - (СправочникСсылка.*) Получатель
//       |- Значение - (Строка) Набор E-mail адресов в строке с разделителями
// 
Процедура ПередФормированиемСпискаПолучателейРассылки(ПараметрыПолучателей, Запрос, СтандартнаяОбработка, Результат) Экспорт
	
КонецПроцедуры
