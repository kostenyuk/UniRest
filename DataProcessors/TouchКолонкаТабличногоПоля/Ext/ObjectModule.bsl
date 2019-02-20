﻿
//	1С:Touch. Touch-ориентированные элементы управления и диалоговые формы, 
//	построенные с использованием только стандартных элементов управления платформы.
//	Copyright (C) 2008-2010 Переверзев Александр Владимирович.
//
//	Это программа является свободным программным обеспечением. Вы можете 
//	распространять и/или модифицировать её согласно условиям Стандартной 
//	Общественной Лицензии GNU, опубликованной Фондом Свободного Программного 
//	Обеспечения, версии 3 или, по Вашему желанию, любой более поздней версии. 
//
//	Эта программа распространяется в надежде, что она будет полезной, но БЕЗ 
//	ВСЯКИХ ГАРАНТИЙ, в том числе подразумеваемых гарантий ТОВАРНОГО СОСТОЯНИЯ ПРИ 
//	ПРОДАЖЕ и ГОДНОСТИ ДЛЯ ОПРЕДЕЛЁННОГО ПРИМЕНЕНИЯ. Смотрите Стандартную 
//	Общественную Лицензию GNU для получения дополнительной информации. 
//
//	Вы должны были получить копию Стандартной Общественной Лицензии GNU вместе 
//	с программой. В случае её отсутствия, посмотрите <http://www.gnu.org/licenses/>.


#Если Клиент Тогда

Перем мИдентификатор, мИмя;

Перем мИменаКолонок, мИндексыКолонок;

Перем мТипСтруктуры;


Функция Имя(Имя = Неопределено) Экспорт
	
	// Проверка входных параметров.
	
	// TODO: Проверка входных параметров.
	
	// Инициализация кнопки.
	Если (мИменаКолонок = Неопределено) И (ТипЗнч(Имя) = мТипСтруктуры) Тогда
		Параметры = Имя;
		
		мИмя = Строка(Параметры.Имя);
		
		мИменаКолонок = Параметры.ИменаКолонок;
		мИндексыКолонок = Параметры.ИндексыКолонок;

		Параметры.Идентификатор = мИдентификатор;
		
		Возврат Неопределено;
	КонецЕсли;
	
	// Проверка инициализации.
	Если (мИменаКолонок = Неопределено) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	// Получение имени кнопки или изменение имени.
	Если (Имя = Неопределено) Тогда
		
		Возврат мИмя;
		
	Иначе
		
		мИменаКолонок.Удалить(мИмя);
		
		мИмя = Строка(Имя);
		
		мИменаКолонок.Вставить(мИмя, мИдентификатор);
		
		Возврат мИмя;
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция Индекс(Индекс = Неопределено) Экспорт
	
	// Проверка входных параметров.
	
	// TODO: Проверка входных параметров.
	
	// Проверка инициализации.
	Если (мИндексыКолонок = Неопределено) Тогда
		
		// TODO: Исключение.

		Возврат Неопределено;
	КонецЕсли;
	
	// Смещение кнопки.
	Если (Не Индекс = Неопределено) Тогда
		Элемент = мИндексыКолонок.НайтиПоЗначению(мИдентификатор);
		мИндексыКолонок.Сдвинуть(Элемент, Индекс - мИндексыКолонок.Индекс(Элемент));	
	КонецЕсли;
	
	// Получение индекса кнопки.
	Возврат мИндексыКолонок.Индекс(мИндексыКолонок.НайтиПоЗначению(мИдентификатор));
	
КонецФункции


Процедура Высвободить() Экспорт
	
	// Высвобождение ссылок.
	мИменаКолонок = Неопределено;
	мИндексыКолонок = Неопределено;
	
КонецПроцедуры // Высвободить()


// Инициализация переменных.
мИдентификатор = Строка(Новый УникальныйИдентификатор);

мТипСтруктуры = Тип("Структура");


// Инициализация значений по умолчанию.
Видимость = Истина;
ГоризонтальноеПоложениеВКолонке = ГоризонтальноеПоложение.Авто;
ГоризонтальноеПоложениеВПодвале = ГоризонтальноеПоложение.Лево;
ГоризонтальноеПоложениеВШапке = ГоризонтальноеПоложение.Лево;
Доступность = Истина;
ИзменениеРазмера = ИзменениеРазмераКолонки.Изменять;
КартинкаПодвала = Новый Картинка;
КартинкаШапки = КартинкаПодвала;
КартинкиСтрок = КартинкаПодвала;
ОтображатьВПодвале = Истина;
ОтображатьВШапке = Истина;
Положение = ПоложениеКолонки.НоваяКолонка;
ЦветТекстаПодвала = ЦветаСтиля.ЦветТекстаФормы;
ЦветТекстаПоля = ЦветаСтиля.ЦветТекстаФормы;
ЦветТекстаШапки = ЦветаСтиля.ЦветТекстаФормы;
ЦветФонаПодвала = ЦветаСтиля.ЦветФонаКнопки;
ЦветФонаПоля = ЦветаСтиля.ЦветФонаПоля;
ЦветФонаШапки = ЦветаСтиля.ЦветФонаКнопки;
Ширина = 20;
ШиринаЭлементаВложенногоСпискаЗначений = 20;
ШрифтПодвала = ШрифтыСтиля.ШрифтТекста;
ШрифтТекста = ШрифтыСтиля.ШрифтТекста;
ШрифтШапки = ШрифтыСтиля.ШрифтТекста;

#КонецЕсли
