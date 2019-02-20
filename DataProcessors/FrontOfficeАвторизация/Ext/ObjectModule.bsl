﻿


// Процедура завершает сеанс текущего пользователя.
//
Процедура ЗавершениеСеанса() Экспорт
	
	// Завершение сеанса пользователя.
	ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(Справочники.Пользователи.ПустаяСсылка(), Справочники.ГруппыПользователей.ПустаяСсылка(), глЗначениеПеременной("глТекущийРежимРаботы"));
	
	// Изменение заголовка системы.
	#Если Клиент Тогда
		УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
	#КонецЕсли
	
КонецПроцедуры // ЗавершениеСеанса()

#Если Клиент Тогда
	
	// Действия при авторизациии
	//
	Функция ЕслиПользовательАвторезирован(Авторизирован = Неопределено, ВыбранныйПользователь, ВыбраннаяГруппаПользователей, Неполная) 	
		Если Авторизирован  = Неопределено Тогда
			ВыбранныйПользователь = ЭтотОбъект.Пользователь;
			ВыбраннаяГруппаПользователей = ЭтотОбъект.ГруппаПользователей;	
			Если Не Неполная Тогда
				ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));	
				// ---- Изменение заголовка системы.
				//#Если Клиент Тогда
				УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
				//#КонецЕсли
			КонецЕсли;	
			Возврат Истина;			
		ИначеЕсли  Авторизирован Тогда 		
			ЭтотОбъект.Пользователь = ВыбранныйПользователь;
			ЭтотОбъект.ГруппаПользователей = ВыбраннаяГруппаПользователей;	
			// -- Авторизация.
			Если Не Неполная Тогда
				ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));	
				// ---- Изменение заголовка системы.
				//#Если Клиент Тогда
				УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
				//#КонецЕсли
			КонецЕсли;	
			Возврат Истина;	
		Иначе 
			Возврат Ложь;			
		КонецЕсли;		
	КонецФункции
	
	// Функция авторизации пользователя.
	//
	// Параметры:
	//	ТребуемыеПолномочия, ПланыВидовХарактеристик.НастройкиПользователей или СписокЗначений, 
	//		минимально требуемые полномочия для авторицации;
	//	Неполная, Булево, флаг выполнения неполного цикла авторизации.
	//
	// Возвращаемое значение:
	//	Булево, Истина - если был осуществления выбор даты;
	//  ВыбираемаяДата, Дата, выбранная дата.
	//  ЭтоРегистрацияНаСмену - Тип: Булево, признак того что нажата кнопка регистрации сотрудника на смену
	//
	//Функция Авторизация(ТребуемыеПолномочия = Неопределено, Неполная = Ложь, ВыбранныйПользователь = Неопределено, ВыбраннаяГруппаПользователей = Неопределено, ИнформационнаяКарта = Неопределено, ДействиеПользователя = Неопределено) Экспорт	
	//Костенюк Александр-Старт 20.07.2012
	Функция Авторизация(ТребуемыеПолномочия = Неопределено, Неполная = Ложь, ВыбранныйПользователь = Неопределено, ВыбраннаяГруппаПользователей = Неопределено, ИнформационнаяКарта = Неопределено, ДействиеПользователя = Неопределено, ЭтоРегистрацияНаСмену = Ложь) Экспорт	
	//Костенюк Александр-Финиш 20.07.2012
		// Открываем форму выбора.
		ЭтотОбъект.ТребуемыеПолномочия = ТребуемыеПолномочия;
		ЭтотОбъект.Пользователь = ВыбранныйПользователь;
		ЭтотОбъект.ГруппаПользователей = ВыбраннаяГруппаПользователей;
		
		Если ДействиеПользователя = "Вход" Тогда
			Если (Не ИнформационнаяКарта = Неопределено) Тогда                  	
				Авторизирован = УправлениеПользователями.ОпределитьПользователяПоИнформационнойКарте(ИнформационнаяКарта, ВыбранныйПользователь, ВыбраннаяГруппаПользователей) И
				УправлениеПользователями.ПроверитьПолномочияПользователя(ТребуемыеПолномочия, ВыбранныйПользователь, ВыбраннаяГруппаПользователей);		
				Если ЕслиПользовательАвторезирован(Авторизирован, ВыбранныйПользователь, ВыбраннаяГруппаПользователей, Неполная) Тогда 
					Возврат Истина;	
				КонецЕсли;		
				Возврат Ложь;
			Иначе 		
				Форма = ЭтотОбъект.ПолучитьФорму("Форма");	
				// Выбор значения.
				ПараметрЗакрытия = Форма.ОткрытьМодально();
				Если (ТипЗнч(ПараметрЗакрытия) = Тип("Булево")) Тогда
					Если ЕслиПользовательАвторезирован( , ВыбранныйПользователь, ВыбраннаяГруппаПользователей, Неполная) Тогда 
						Возврат Истина;	
					КонецЕсли;		
				КонецЕсли;	
				Возврат Ложь;
			КонецЕсли;	
			
		ИначеЕсли  ДействиеПользователя = "Выход" Тогда			
			Если (Не ИнформационнаяКарта = Неопределено) Тогда                  	
				Авторизирован = УправлениеПользователями.ОпределитьПользователяПоИнформационнойКарте(ИнформационнаяКарта, ВыбранныйПользователь, ВыбраннаяГруппаПользователей) И
				УправлениеПользователями.ПроверитьПолномочияПользователя(ТребуемыеПолномочия, ВыбранныйПользователь, ВыбраннаяГруппаПользователей);		
				Если ЕслиПользовательАвторезирован(Авторизирован, ВыбранныйПользователь, ВыбраннаяГруппаПользователей, не Неполная) Тогда 
					Возврат Истина;	
				КонецЕсли;	
				Возврат Ложь;
			Иначе 		
				Форма = ЭтотОбъект.ПолучитьФорму("Форма");	
				// Выбор значения.
				ПараметрЗакрытия = Форма.ОткрытьМодально();
				Если (ТипЗнч(ПараметрЗакрытия) = Тип("Булево")) Тогда
					Если ЕслиПользовательАвторезирован( , ВыбранныйПользователь, ВыбраннаяГруппаПользователей, не Неполная) Тогда 
						Возврат Истина;	
					КонецЕсли;		
				КонецЕсли;		
				Возврат Ложь;
			КонецЕсли;	
			
		Иначе 
			Если (Не ИнформационнаяКарта = Неопределено) Тогда                  	
				Авторизирован = УправлениеПользователями.ОпределитьПользователяПоИнформационнойКарте(ИнформационнаяКарта, ВыбранныйПользователь, ВыбраннаяГруппаПользователей) И
				УправлениеПользователями.ПроверитьПолномочияПользователя(ТребуемыеПолномочия, ВыбранныйПользователь, ВыбраннаяГруппаПользователей);
				
				Если Авторизирован Тогда 
					ЭтотОбъект.Пользователь = ВыбранныйПользователь;
					ЭтотОбъект.ГруппаПользователей = ВыбраннаяГруппаПользователей;	
					//Если УправлениеПользователями.ПолучитьЗначениеПраваДляТекущегоПользователя(ПланыВидовХарактеристик.ПраваПользователей.FrontOfficeИгнорироватьТребованиеПрисутсвияСотрудникаНаСменеПриАвторизации,, ВыбранныйПользователь, ГруппаПользователей)  Тогда		
					//Костенюк Александр-Старт 27.06.2012
					Если УправлениеПользователями.ПолучитьЗначениеПрава(ПланыВидовХарактеристик.ПраваПользователей.FrontOfficeИгнорироватьТребованиеПрисутсвияСотрудникаНаСменеПриАвторизации)  Тогда		
						//Костенюк Александр-Финиш 27.06.2012
						// -- Авторизация.
						Если Не Неполная Тогда
							ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));	
							// ---- Изменение заголовка системы.
							//#Если Клиент Тогда
							УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
							//#КонецЕсли
						КонецЕсли;	
						Возврат Истина;
					Иначе		
						Документ = Неопределено;
						Если не УправлениеПользователями.ПолучитьЗначениеНастройкиДляТекущегоПользователя(ПланыВидовХарактеристик.НастройкиПользователей.FrontOfficeТребоватьПрисутсвиеСотрудникаНаСменеПриАвторизации, , ВыбранныйПользователь, ВыбраннаяГруппаПользователей ) Тогда
							// -- Авторизация.
							Если Не Неполная Тогда
								ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));		
								// ---- Изменение заголовка системы.
								//#Если Клиент Тогда
								УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
								//#КонецЕсли
							КонецЕсли;	
							Возврат Истина;	
						Иначе
							Если ПолучитьСерверFrontOffice().МенеджерУчетаРабочегоВремени.НайтиДокументУчетаРабочегоВремени(Документ) Тогда
								ЭтотОбъект.Пользователь = ВыбранныйПользователь;
								ЭтотОбъект.ГруппаПользователей = ВыбраннаяГруппаПользователей;	
								Если ПолучитьСерверFrontOffice().МенеджерУчетаРабочегоВремени.СотрудникПолучить(Документ, ВыбранныйПользователь.Сотрудник) <> Неопределено Тогда 		
									// -- Авторизация.
									Если Не Неполная Тогда
										ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));		
										// ---- Изменение заголовка системы.
										//#Если Клиент Тогда
										УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
										//#КонецЕсли
									КонецЕсли;	
									Возврат Истина;		
								Иначе
									//#Если Клиент Тогда		
									FrontOffice.ВывестиПредупреждение(НСтр("ru='У сотрудника "+ ВыбранныйПользователь.Сотрудник +" нет права входа без регистрациии на смене!';uk='У співробітника "+ ВыбранныйПользователь.Сотрудник +" немає права входу без регистрациии на зміні!'"));
									//#КонецЕсли
									Возврат Ложь;
								КонецЕсли;
							КонецЕсли;	
						КонецЕсли;	
					КонецЕсли;			
				КонецЕсли;
				
				Возврат Ложь;
			Иначе 		
				Форма = ЭтотОбъект.ПолучитьФорму("Форма");	
				// Выбор значения.
				ПараметрЗакрытия = Форма.ОткрытьМодально();
				Если (ТипЗнч(ПараметрЗакрытия) = Тип("Булево")) Тогда
					ВыбранныйПользователь = ЭтотОбъект.Пользователь;
					ВыбраннаяГруппаПользователей = ЭтотОбъект.ГруппаПользователей;	
					//УправлениеПользователями.ПолучитьЗначениеНастройки(ПланыВидовХарактеристик.НастройкиПользователей.FrontOfficeПечатьПречекаПоОрганизациям)
					//Костенюк Александр-Старт 20.07.2012
					Если НЕ ЭтоРегистрацияНаСмену Тогда
					//Костенюк Александр-Финиш 20.07.2012
						Если УправлениеПользователями.ПолучитьЗначениеПраваДляТекущегоПользователя(ПланыВидовХарактеристик.ПраваПользователей.FrontOfficeИгнорироватьТребованиеПрисутсвияСотрудникаНаСменеПриАвторизации,, ВыбранныйПользователь, ГруппаПользователей) Тогда		
							// -- Авторизация.
							Если Не Неполная Тогда
								ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));		
								// ---- Изменение заголовка системы.
								//#Если Клиент Тогда
								УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
								//#КонецЕсли
							КонецЕсли;		
							Возврат Истина;
						Иначе		
							Документ = Неопределено;	
							Если НЕ УправлениеПользователями.ПолучитьЗначениеНастройкиДляТекущегоПользователя(ПланыВидовХарактеристик.НастройкиПользователей.FrontOfficeТребоватьПрисутсвиеСотрудникаНаСменеПриАвторизации, , ВыбранныйПользователь, ВыбраннаяГруппаПользователей )  Тогда
								// -- Авторизация.
								Если Не Неполная Тогда
									ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));	
									// ---- Изменение заголовка системы.
									//#Если Клиент Тогда
									УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
									//#КонецЕсли
								КонецЕсли;		
								Возврат Истина;
							Иначе
								Если ПолучитьСерверFrontOffice().МенеджерУчетаРабочегоВремени.НайтиДокументУчетаРабочегоВремени(Документ) Тогда
									Если ПолучитьСерверFrontOffice().МенеджерУчетаРабочегоВремени.СотрудникПолучить(Документ, ВыбранныйПользователь.Сотрудник) <> Неопределено Тогда 					
										// -- Авторизация.
										Если Не Неполная Тогда
											ПолныеПрава.УстановитьИзменяемыеПараметрыСеансаПользователя(ВыбранныйПользователь, ВыбраннаяГруппаПользователей, глЗначениеПеременной("глТекущийРежимРаботы"));			
											// ---- Изменение заголовка системы.
											//#Если Клиент Тогда
											УстановитьЗаголовокСистемы(УправлениеПользователями.ЗаголовокСистемы());
											//#КонецЕсли
										КонецЕсли;			
										Возврат Истина;							
									Иначе
										//#Если Клиент Тогда		
										FrontOffice.ВывестиПредупреждение(НСтр("ru='У сотрудника "+ ВыбранныйПользователь.Сотрудник +" нет права входа без регистрациии на смене!';uk='У співробітника "+ ВыбранныйПользователь.Сотрудник +" немає права входу без регистрациии на зміні!'"));
										//#КонецЕсли
										Возврат Ложь;		
									КонецЕсли;
								КонецЕсли;
							КонецЕсли;	
						КонецЕсли;
					//Костенюк Александр-Старт 20.07.2012
					Иначе
						Возврат Истина;
					КонецЕсли;
					//Костенюк Александр-Финиш 20.07.2012
				КонецЕсли;
				
				Возврат Ложь;
			КонецЕсли;	
			
		КонецЕсли;
	
	
КонецФункции

// Функция ввода пароля через числовую экранную клавиатура.
//
// Параметры:
//	Подсказка - Строка. Текст заголовка окна диалога ввода числа.
//
// Возвращаемое значение:
//	Булево. Истина - если был осуществления ввода значения;
//	Пароль - Строка, СправочникСсылка.ИнформационныеКарты. Введенный пароль или регистрационная карта.
//
Функция ВводПароля(Пароль, Подсказка = "") Экспорт
	
	// Перенаправление.
	Возврат Touch.__ВвестиПароль(Пароль, Подсказка);
	
КонецФункции // ВводПароля()

#КонецЕсли
