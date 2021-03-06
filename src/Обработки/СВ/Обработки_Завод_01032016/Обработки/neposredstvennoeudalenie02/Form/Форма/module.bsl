﻿Перем л_Менеджер;

Процедура ПриОткрытии()
	заполнитьТипыОбъекта();                                              
	ПроверятьСсылки=Истина;
	Доступность();
КонецПроцедуры

Процедура Доступность()
	ЭлементыФормы.Ссылка_.Видимость=Ложь;
	ЭлементыФормы.КоманднаяПанель1.Кнопки.УдалитьРСПолностью.доступность=Ложь;
	ЭлементыФормы.КоманднаяПанель1.Кнопки.ОткрытьРегистрСвдеений.доступность=Ложь;
	если СписокМетаданных=4 тогда // документы
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьБезвозвратно.доступность=Истина;
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьВсеПомеченныеНаУдаление.доступность=Истина;
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьГруппу.доступность=Ложь;
		
		ЭлементыФормы.НеУдаленный.Видимость=Ложь;
		ЭлементыФормы.ПроверятьСсылки.Видимость= Истина;
	иначеесли СписокМетаданных=5 тогда // регистр сведений
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьБезвозвратно.доступность=Ложь;
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьВсеПомеченныеНаУдаление.доступность=Ложь;
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьГруппу.доступность=Ложь;
		
		ЭлементыФормы.НеУдаленный.Видимость= Ложь;
		ЭлементыФормы.ПроверятьСсылки.Видимость= Ложь;
	иначе
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьБезвозвратно.доступность=Истина;
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьВсеПомеченныеНаУдаление.доступность=Истина;
		ЭлементыФормы.ОсновныеДействияФормы.Кнопки.УдалитьГруппу.доступность=Истина;
		
		ЭлементыФормы.НеУдаленный.Видимость= Истина;
		ЭлементыФормы.ПроверятьСсылки.Видимость= Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура СписокМетаданныхПриИзменении(Элемент)
	заполнитьТипыОбъекта();
	
	ТипОбъекта=Неопределено;
	л_ТипОбъектаПриИзменении();
	
	Доступность();
	если СписокМетаданных=4 тогда
		НеУдаленный=Ложь;
	КонецЕсли;
КонецПроцедуры
                      

Процедура заполнитьТипыОбъекта()
	СписокВыбора = ЭлементыФормы.ТипОбъекта.СписокВыбора;
	СписокВыбора.Очистить();
	если СписокМетаданных=1 тогда
		Для каждого ОбъектМетаданных Из Метаданные.ПланыСчетов Цикл
			СписокВыбора.Добавить(ПланыСчетов[ОбъектМетаданных.Имя].ПустаяСсылка(), ОбъектМетаданных.Представление());
		КонецЦикла;
	иначеесли СписокМетаданных=0 тогда
		Для каждого ОбъектМетаданных Из Метаданные.Справочники Цикл
			СписокВыбора.Добавить(Справочники[ОбъектМетаданных.Имя].ПустаяСсылка(), ОбъектМетаданных.Представление());
		КонецЦикла;                           
	иначеесли СписокМетаданных=2 тогда
		Для каждого ОбъектМетаданных Из Метаданные.ПланыВидовХарактеристик Цикл
			СписокВыбора.Добавить(ПланыВидовХарактеристик[ОбъектМетаданных.Имя].ПустаяСсылка(), ОбъектМетаданных.Представление());
		КонецЦикла;
	иначеесли СписокМетаданных=3 тогда
		Для каждого ОбъектМетаданных Из Метаданные.ПланыВидовРасчета Цикл
			СписокВыбора.Добавить(ПланыВидовРасчета[ОбъектМетаданных.Имя].ПустаяСсылка(), ОбъектМетаданных.Представление());
		КонецЦикла;
	иначеесли СписокМетаданных=4 тогда
		Для каждого ОбъектМетаданных Из Метаданные.Документы Цикл
			СписокВыбора.Добавить(Документы[ОбъектМетаданных.Имя].ПустаяСсылка(), ОбъектМетаданных.Представление());
		КонецЦикла;
	иначеесли СписокМетаданных=5 тогда
	Для каждого ОбъектМетаданных Из Метаданные.РегистрыСведений Цикл
		СписокВыбора.Добавить(РегистрыСведений[ОбъектМетаданных.Имя], ОбъектМетаданных.Представление());
	КонецЦикла;
	КонецЕсли;
КонецПроцедуры
                    
Процедура ТипОбъектаПриИзменении(Элемент)
	л_ТипОбъектаПриИзменении();
КонецПроцедуры


Процедура л_ТипОбъектаПриИзменении()
	
	ТипОбъектаЗначение=ЭлементыФормы.ТипОбъекта.Значение;
	
	если ЭлементыФормы.ТипОбъекта.Значение=Неопределено тогда
		ЭлементыФормы.Ссылка_.Видимость=Ложь;
	иначе
		ЭлементыФормы.Ссылка_.Видимость=Истина;
	КонецЕсли;	
	
	Ссылка_=ЭлементыФормы.ТипОбъекта.Значение;
	л_СсылкаПриИзменении();
	
	
	если СписокМетаданных=5 тогда
		ЭлементыФормы.КоманднаяПанель1.Кнопки.УдалитьРСПолностью.доступность=Истина;
		ЭлементыФормы.КоманднаяПанель1.Кнопки.ОткрытьРегистрСвдеений.доступность=Истина;
		ЭлементыФормы.Ссылка_.Видимость=Ложь;
		л_Менеджер=ЭлементыФормы.ТипОбъекта.Значение;
	иначе	
		ЭлементыФормы.КоманднаяПанель1.Кнопки.УдалитьРСПолностью.доступность=Ложь;
		ЭлементыФормы.КоманднаяПанель1.Кнопки.ОткрытьРегистрСвдеений.доступность=Ложь;
	КонецЕсли;	
	
	
КонецПроцедуры


Процедура ОсновныеДействияФормыУдалитьБезвозвратно(Кнопка)
	если не ЗначениеЗаполнено(Ссылка_) тогда
		Возврат;
	КонецЕсли;	
	
	если ПроверятьСсылки тогда
		ТаблицаСсылок=НайтиСсылки();
		если ТаблицаСсылок.Количество()>0 тогда
			если Вопрос("На объект "+Ссылка_+" есть ссылки: "+ТаблицаСсылок.Количество()+" шт. Продолжить?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
				Возврат;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Попытка
		л_Объект=Ссылка_.ПолучитьОбъект();
		Сообщить("Удаляем объект "+л_Объект);
		л_Объект.Удалить();
		Ссылка_=Неопределено;
		л_СсылкаПриИзменении();
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры


Процедура СсылкаНачалоВыбора(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	а=ЭлементыФормы.СписокМетаданных.СписокВыбора.НайтиПоЗначению(СписокМетаданных).Представление;
	если а="Справочник" тогда
		форма=Справочники[ТипОбъектаЗначение.метаданные().Имя].ПолучитьФормуВыбора(,ЭлементыФормы.Ссылка_);
	иначеесли а="ПланыСчетов" тогда
		форма=ПланыСчетов[ТипОбъектаЗначение.метаданные().Имя].ПолучитьФормуВыбора(,ЭлементыФормы.Ссылка_);
	иначеесли а="ПланыВидовХарактеристик" тогда
		форма=ПланыВидовХарактеристик[ТипОбъектаЗначение.метаданные().Имя].ПолучитьФормуВыбора(,ЭлементыФормы.Ссылка_);
	иначеесли а="ПланыВидовРасчета" тогда
		форма=ПланыВидовРасчета[ТипОбъектаЗначение.метаданные().Имя].ПолучитьФормуВыбора(,ЭлементыФормы.Ссылка_);
	иначеесли а="Документы" тогда
		форма=Документы[ТипОбъектаЗначение.метаданные().Имя].ПолучитьФормуВыбора(,ЭлементыФормы.Ссылка_);
	КонецЕсли;
	Форма.ЗакрыватьПриВыборе			= ЗакрыватьПриВыборе;
	Попытка
		Форма.ПараметрТекущаяСтрока		= Ссылка_;
		
		отбор=форма.отбор;
		
		Если Отбор.Найти("ПометкаУдаления") = Неопределено Тогда
			Отбор.Добавить("ПометкаУдаления");
		КонецЕсли;
		Отбор["ПометкаУдаления"].Значение      = истина;
		Отбор["ПометкаУдаления"].ВидСравнения  = ВидСравнения.Равно; 
		если не НеУдаленный тогда
			Отбор["ПометкаУдаления"].Использование = Истина;
		КонецЕсли;
		
		//если а<>"Документы" тогда
		//	Если Отбор.Найти("Предопределенный") = Неопределено Тогда
		//		Отбор.Добавить("Предопределенный");
		//	КонецЕсли;
		//	Отбор["Предопределенный"].Значение      = Ложь;
		//	Отбор["Предопределенный"].ВидСравнения  = ВидСравнения.Равно; 
		//	Отбор["Предопределенный"].Использование = Истина;
		//КонецЕсли;
		
	Исключение
	КонецПопытки;
	форма.Открыть();
КонецПроцедуры


Процедура СсылкаПриИзменении(Элемент)
	л_СсылкаПриИзменении();
КонецПроцедуры

Процедура л_СсылкаПриИзменении()
	Если ЗначениеЗаполнено(Ссылка_) тогда
		ЭлементыФормы.Объект.Значение=Ссылка_;
	иначе
		ЭлементыФормы.Объект.Значение="";
	КонецЕсли;	
КонецПроцедуры


                           


Функция  НайтиСсылки(сс_=Неопределено)
	Если ТипЗнч(сс_)=тип("Массив") тогда
		Возврат НайтиПоСсылкам(сс_);
	КонецЕсли;	
	
	масс=новый Массив;
	если сс_=Неопределено тогда
		масс.Добавить(Ссылка_);
	иначе
		масс.Добавить(сс_);
	КонецЕсли;	
	
	возврат НайтиПоСсылкам(масс); 
КонецФункции





Процедура ОсновныеДействияФормыУдалитьВсеПомеченныеНаУдаление(Кнопка)
	если ТипОбъектаЗначение=Неопределено тогда
		Возврат;
	КонецЕсли;	
	
	ТИПП=ТипОбъектаЗначение.метаданные().Полноеимя();
	
	Ссылка_=Неопределено;
	л_СсылкаПриИзменении();

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Спр.Ссылка как Ссылка
		|ИЗ
		|	"+ТИПП+" КАК Спр
		|ГДЕ
		|	Спр.ПометкаУдаления = ИСТИНА";

	Результат = Запрос.Выполнить();

	если Результат.Пустой() тогда
		Предупреждение("Нет помеченных на удаление объектов", 5);
		Возврат;
	КонецЕсли;	
	
	ВыборкаДетальныеЗаписи = Результат.Выгрузить();

	
	если ПроверятьСсылки тогда
		если Вопрос(""+ВыборкаДетальныеЗаписи.Количество()+" элементов объекта "+ТИПП+" Будут удалены непосредственно. Продолжить? ", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
			Возврат;
		КонецЕсли;
		ТаблицаВсехСсылок=НайтиСсылки(ВыборкаДетальныеЗаписи.ВыгрузитьКолонку("Ссылка"));
	иначе
		если Вопрос(""+ВыборкаДетальныеЗаписи.Количество()+" элементов объекта "+ТИПП+" Будут удалены непосредственно без проверки ссылок!!! Продолжить? ", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	для каждого стр из ВыборкаДетальныеЗаписи Цикл
		
		если ПроверятьСсылки тогда
			Отбор = Новый Структура();
			Отбор.Вставить("Ссылка",стр.Ссылка);
			ТаблицаСсылок=ТаблицаВсехСсылок.НайтиСтроки(Отбор);
			если ТаблицаСсылок.Количество()>0 тогда
				если Вопрос("На объект "+стр.Ссылка+" есть ссылки: "+ТаблицаСсылок.Количество()+" шт. Продолжить?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
					ОбработкаПрерыванияПользователя();
					Продолжить;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Попытка
			Объект=стр.ссылка.ПолучитьОбъект();
			Сообщить("Удаляем объект "+Объект);
			Объект.Удалить();
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
		ОбработкаПрерыванияПользователя();
	КонецЦикла;

КонецПроцедуры

Процедура ОсновныеДействияФормыУдалитьГруппу(Кнопка)
	если ТипОбъектаЗначение=Неопределено тогда
		Возврат;
	КонецЕсли;	
	
	Попытка
		если не Ссылка_.этогруппа тогда
			Возврат;
		КонецЕсли;	
	Исключение
		Возврат;
	КонецПопытки;
	
	
	ТИПП=ТипОбъектаЗначение.метаданные().Полноеимя();
	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Спр.Ссылка как Ссылка
		|ИЗ
		|	"+ТИПП+" КАК Спр
		|ГДЕ
		|	Спр.ПометкаУдаления = ИСТИНА
		|	И Спр.Родитель В ИЕРАРХИИ(&Родитель)";

	Запрос.Параметры.Вставить("Родитель",Ссылка_);	
	Результат = Запрос.Выполнить();

	если Результат.Пустой() тогда
		Предупреждение("Нет помеченных на удаление объектов", 5);
		Возврат;
	КонецЕсли;	
	
	ВыборкаДетальныеЗаписи = Результат.Выгрузить();

	
	если ПроверятьСсылки тогда
		если Вопрос(""+ВыборкаДетальныеЗаписи.Количество()+" элементов объекта "+ТИПП+" Будут удалены непосредственно. Продолжить? ", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
			Возврат;
		КонецЕсли;
		ТаблицаВсехСсылок=НайтиСсылки(ВыборкаДетальныеЗаписи.ВыгрузитьКолонку("Ссылка"));
	иначе
		если Вопрос(""+ВыборкаДетальныеЗаписи.Количество()+" элементов объекта "+ТИПП+" Будут удалены непосредственно без проверки ссылок!!! Продолжить? ", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	для каждого стр из ВыборкаДетальныеЗаписи Цикл
		
		если ПроверятьСсылки тогда
			Отбор = Новый Структура();
			Отбор.Вставить("Ссылка",стр.Ссылка);
			ТаблицаСсылок=ТаблицаВсехСсылок.НайтиСтроки(Отбор);
			если ТаблицаСсылок.Количество()>0 тогда
				если Вопрос("На объект "+стр.Ссылка+" есть ссылки: "+ТаблицаСсылок.Количество()+" шт. Продолжить?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
					ОбработкаПрерыванияПользователя();
					Продолжить;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Попытка
			Объект=стр.ссылка.ПолучитьОбъект();
			Сообщить("Удаляем объект "+Объект);
			Объект.Удалить();
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
		ОбработкаПрерыванияПользователя();
	КонецЦикла;
	
КонецПроцедуры



Процедура ПроверятьСсылкиПриИзменении(Элемент)
	если не ПроверятьСсылки тогда
		если Вопрос("Если отлючить проверку ссылок на объект при непосредственном удалении, то могут возникнуть битые ссылки в других объектах. Продолжить? ", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
			ПроверятьСсылки=Истина;
		КонецЕсли;
	КонецЕсли;	
КонецПроцедуры

Процедура КоманднаяПанель1ОткрытьРегистрСвдеений(Кнопка)
	если СписокМетаданных=5 тогда
		СтандартнаяОбработка=Ложь;
		л_Менеджер.ПолучитьФормуСписка().Открыть();
	КонецЕсли;
КонецПроцедуры

Процедура КоманднаяПанель1УдалитьРСПолностью(Кнопка)
	если СписокМетаданных=5 тогда
		проводки=л_Менеджер.СоздатьНаборЗаписей();
		если Вопрос("Весь список "+проводки.Метаданные().ПолноеИмя()+" будет очищен полностью. Продолжить?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет тогда
			Возврат;
		КонецЕсли;
		//проводки.Отбор.Организация.Установить(л_Организация);
		
		Попытка
			проводки.Записать(Истина);
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры

