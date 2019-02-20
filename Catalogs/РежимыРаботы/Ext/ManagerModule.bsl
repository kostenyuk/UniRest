﻿
Функция ОсновнойРежимРаботы() Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	                      |	РежимыРаботы.Ссылка
	                      |ИЗ
	                      |	(ВЫБРАТЬ ПЕРВЫЕ 1
	                      |		РежимыРаботы.Ссылка КАК Ссылка,
	                      |		РежимыРаботы.Ранг КАК Ранг
	                      |	ИЗ
	                      |		(ВЫБРАТЬ
	                      |			Компьютеры.РежимРаботы КАК Ссылка,
	                      |			КОЛИЧЕСТВО(Компьютеры.Ссылка) КАК Ранг
	                      |		ИЗ
	                      |			Справочник.Компьютеры КАК Компьютеры
	                      |		ГДЕ
	                      |			НЕ Компьютеры.ЭтоГруппа
	                      |		
	                      |		СГРУППИРОВАТЬ ПО
	                      |			Компьютеры.РежимРаботы) КАК РежимыРаботы
	                      |	
	                      |	ОБЪЕДИНИТЬ ВСЕ
	                      |	
	                      |	ВЫБРАТЬ ПЕРВЫЕ 1
	                      |		РежимыРаботы.Ссылка,
	                      |		-1
	                      |	ИЗ
	                      |		Справочник.РежимыРаботы КАК РежимыРаботы
	                      |	
	                      |	УПОРЯДОЧИТЬ ПО
	                      |		Ранг УБЫВ,
	                      |		Ссылка) КАК РежимыРаботы
	                      |
	                      |УПОРЯДОЧИТЬ ПО
	                      |	РежимыРаботы.Ранг УБЫВ,
	                      |	РежимыРаботы.Ссылка.ПометкаУдаления,
	                      |	РежимыРаботы.Ссылка.Наименование");
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Справочники.РежимыРаботы.ПустаяСсылка();

КонецФункции // ОсновнойРежимРаботы()
