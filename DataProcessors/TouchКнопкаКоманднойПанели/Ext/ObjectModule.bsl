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

Перем мИменаКнопок, мИндексыКнопок;

Перем мТипСтруктуры;


// Функция возвращает/устанавливает уникальное имя объекта в коллекции.
//
// Параметры:
//	Имя - Строка. Новое уникальное имя объекта.
//
// Возвращаемое значение:
//	Число. Имя объекта в коллекции.
//
Функция Имя(Имя = Неопределено) Экспорт
	
	// Проверка входных параметров.
	
	// TODO: Проверка входных параметров.
	
	// Инициализация кнопки.
	Если (мИменаКнопок = Неопределено) И (ТипЗнч(Имя) = мТипСтруктуры) Тогда
		Параметры = Имя;
		
		мИмя = Строка(Параметры.Имя);
		
		мИменаКнопок = Параметры.ИменаКнопок;
		мИндексыКнопок = Параметры.ИндексыКнопок;

		Параметры.Идентификатор = мИдентификатор;
		
		Возврат Неопределено;
	КонецЕсли;
	
	// Проверка инициализации.
	Если (мИменаКнопок = Неопределено) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	// Получение имени кнопки или изменение имени.
	Если (Имя = Неопределено) Тогда
		
		Возврат мИмя;
		
	Иначе
		
		мИменаКнопок.Удалить(мИмя);
		
		мИмя = Строка(Имя);
		
		мИменаКнопок.Вставить(мИмя, мИдентификатор);
		
		Возврат мИмя;
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции // Имя()

// Функция возвращает/устанавливает порядковый индекс объекта в коллекции.
//
// Параметры:
//	Индекс - Число. Новый порядковый индекс объекта.
//
// Возвращаемое значение:
//	Число. Порядковый индекс объекта в коллекции.
//
Функция Индекс(Индекс = Неопределено) Экспорт
	
	// Проверка входных параметров.
	
	// TODO: Проверка входных параметров.
	
	// Проверка инициализации.
	Если (мИндексыКнопок = Неопределено) Тогда
		
		// TODO: Исключение.

		Возврат Неопределено;
	КонецЕсли;
	
	// Смещение кнопки.
	Если (Не Индекс = Неопределено) Тогда
		Элемент = мИндексыКнопок.НайтиПоЗначению(мИдентификатор);
		мИндексыКнопок.Сдвинуть(Элемент, Индекс - мИндексыКнопок.Индекс(Элемент));	
	КонецЕсли;
	
	// Получение индекса кнопки.
	Возврат мИндексыКнопок.Индекс(мИндексыКнопок.НайтиПоЗначению(мИдентификатор));
	
КонецФункции // Индекс()


Процедура Высвободить() Экспорт
	
	// Высвобождение ссылок.
	мИменаКнопок = Неопределено;
	мИндексыКнопок = Неопределено;
	
КонецПроцедуры // Высвободить()


// Инициализация переменных.
мИдентификатор = Строка(Новый УникальныйИдентификатор);

мТипСтруктуры = Тип("Структура");


// Инициализация значений по умолчанию.
Доступность = Истина;
Картинка = Новый Картинка;
Отображение = ОтображениеКнопкиКоманднойПанели.Авто;
ЦветРамки = ЦветаСтиля.ЦветРамки;
ЦветТекстаКнопки = ЦветаСтиля.ЦветТекстаКнопки;
ЦветФонаКнопки = ЦветаСтиля.ЦветФонаКнопки;
Шрифт = ШрифтыСтиля.ШрифтТекста;

#КонецЕсли
