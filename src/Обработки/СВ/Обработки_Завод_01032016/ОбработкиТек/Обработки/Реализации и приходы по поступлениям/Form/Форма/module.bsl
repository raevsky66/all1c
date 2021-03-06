﻿
Процедура КнопкаВыполнитьНажатие(Кнопка)
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	СобственныеКонтрагенты.Организация,
	|	СобственныеКонтрагенты.Контрагент
	|ИЗ
	|	РегистрСведений.СобственныеКонтрагенты КАК СобственныеКонтрагенты
	|ГДЕ
	|	СобственныеКонтрагенты.Организация = &Организация";
	Запрос.УстановитьПараметр("Организация", Организация);
	РЕзультат = Запрос.Выполнить().Выбрать();
	КонтрагентПоступление = "";
	Пока РЕзультат.Следующий() Цикл 
		КонтрагентПоступление = РЕзультат.Контрагент	
	КонецЦикла;
	Если КонтрагентПоступление = "" Тогда 
		Предупреждение("Не найден собственный контрагент для организации "+ Организация.Наименование);
		Возврат;
	КонецЕсли;
	
	КонтрагентРеализация = "";
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	СобственныеКонтрагенты.Организация,
	|	СобственныеКонтрагенты.Контрагент
	|ИЗ
	|	РегистрСведений.СобственныеКонтрагенты КАК СобственныеКонтрагенты
	|ГДЕ
	|	СобственныеКонтрагенты.Организация = &Организация";
	Запрос.УстановитьПараметр("Организация", Организация2);
	РЕзультат = Запрос.Выполнить().Выбрать();
	КонтрагентРеализация = "";
	Пока РЕзультат.Следующий() Цикл 
		КонтрагентРеализация = РЕзультат.Контрагент	
	КонецЦикла;
	Если КонтрагентРеализация = "" Тогда 
		Предупреждение("Не найден собственный контрагент для организации "+ Организация2.Наименование);
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрТЧ Из ТабличнаяЧасть1 Цикл 
		ТекПоступление = СтрТЧ.ПоступлениеТоваров;
		ТекРеализация = СтрТЧ.РеализацияТоваров;
		ТекПоступлениеПоРеализации = СтрТЧ.ПоступлениеПоРеализации;
		Сумма = СтрТЧ.Сумма;
		Количество = СтрТЧ.Количество;
		
		Если ЗначениеЗаполнено(Сумма) И ЗначениеЗаполнено(Количество) Тогда 
			Цена = (Сумма/Количество);
			Если ТипНаценки = Перечисления.ТипНаценки.СуммаНаценки Тогда 
				Цена = Цена + СуммаНаценки;
			Иначе 
				Цена = СуммаНаценки;
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(ТекРеализация) Тогда 
				Док = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
				Док.Дата = ТекПоступление.Дата+1;
				Док.Организация = Организация;
				Док.ВидОперации = Перечисления.ВидыОперацийРеализацияТоваров.ПродажаКомиссия;
				Док.СуммаВключаетНДС = Истина;
				Док.УчитыватьНДС = Истина;
				Док.Склад = ТекПоступление.Склад;
				Док.Контрагент = КонтрагентРеализация;
				Док.ДоговорКонтрагента = Контрагент.ОсновнойДоговорКонтрагента;
				Док.ВалютаДокумента = Док.ДоговорКонтрагента.ВалютаВзаиморасчетов;
				Док.СпособЗачетаАвансов = Перечисления.СпособыЗачетаАвансов.Автоматически;
				Док.Ответственный		= ПараметрыСеанса.ТекущийПользователь;
				
				СчетаУчета = БухгалтерскийУчетРасчетовСКонтрагентами.ПолучитьСчетаРасчетовСКонтрагентом(Организация , Контрагент, Контрагент.ОсновнойДоговорКонтрагента);
				
				СтрДок = Док.ЭтотОбъект.Товары.Добавить();
				СтрДок.Номенклатура = Номенклатура;
				СтрДок.Количество = Количество;
				СтрДок.ЕдиницаИзмерения = Номенклатура.БазоваяЕдиницаИзмерения;
				СтрДок.Цена = Цена;
				ОбработкаТабличныхЧастей.ЗаполнитьСтавкуНДСТабЧасти(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуТабЧасти(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуНДСТабЧасти(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуТабЧастиПоДокументу(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуНДСТабЧастиПоДокументу(СтрДок, Док);
				Док.ЗаполнитьСчетаУчетаВСтрокеТабЧасти(СтрДок, "Товары", Истина);
				Док.ЗаполнитьСчетаУчетаРасчетов(СчетаУчета);		
				Док.Комментарий = "Занесено автоматически из обработки формирование внутренних перемещений.";
				Док.ДокументОснование = ТекПоступление;
				
				Док.Записать();
				ТекРеализация = Док.Ссылка;
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(ТекПоступлениеПоРеализации) Тогда 
				Док = Документы.ПоступлениеТоваровУслуг.СоздатьДокумент();
				Док.Дата = ТекПоступление.Дата + 2;
				Док.Организация = Организация2;
				Док.ВидОперации = Перечисления.ВидыОперацийПоступлениеТоваровУслуг.ПокупкаКомиссия;
				Док.СуммаВключаетНДС = Истина;
				Док.УчитыватьНДС = Истина;
				Док.Склад = ТекПоступление.Склад;
				Док.Контрагент = КонтрагентПоступление;
				Док.ДоговорКонтрагента = КонтрагентПоступление.ОсновнойДоговорКонтрагента;
				Док.ВалютаДокумента = КонтрагентПоступление.ОсновнойДоговорКонтрагента.ВалютаВзаиморасчетов;
				Док.СпособЗачетаАвансов = Перечисления.СпособыЗачетаАвансов.Автоматически;
				Док.Ответственный		= ПараметрыСеанса.ТекущийПользователь;
				
				СчетаУчета = БухгалтерскийУчетРасчетовСКонтрагентами.ПолучитьСчетаРасчетовСКонтрагентом(Организация2, КонтрагентПоступление, КонтрагентПоступление.ОсновнойДоговорКонтрагента);
				
				СтрДок = Док.ЭтотОбъект.Товары.Добавить();
				СтрДок.Номенклатура = Номенклатура;
				СтрДок.Количество = Количество;
				СтрДок.ЕдиницаИзмерения = Номенклатура.БазоваяЕдиницаИзмерения;
				СтрДок.Цена = Цена;
				ОбработкаТабличныхЧастей.ЗаполнитьСтавкуНДСТабЧасти(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуТабЧасти(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуНДСТабЧасти(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуТабЧастиПоДокументу(СтрДок, Док);
				ОбработкаТабличныхЧастей.РассчитатьСуммуНДСТабЧастиПоДокументу(СтрДок, Док);
				Док.ЗаполнитьСчетаУчетаВТабЧасти(Док.Товары        , "Товары"        , Истина, Истина);
				Док.ЗаполнитьСчетаУчетаРасчетов(СчетаУчета);	
				Док.Комментарий = "Занесено автоматически из обработки.";
				Док.ДокументОснование = ТекРеализация.Ссылка;
				
				Док.Записать();
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	КоманднаяПанель1Заполнить("");
КонецПроцедуры

Процедура КоманднаяПанель1Заполнить(Кнопка)
	ТабличнаяЧасть1.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПоступлениеТоваровУслугТовары.Ссылка КАК ПоступлениеТоваров,
	               |	СУММА(ПоступлениеТоваровУслугТовары.Количество) КАК Количество,
	               |	СУММА(ПоступлениеТоваровУслугТовары.Сумма) КАК Сумма
	               |ПОМЕСТИТЬ Поступления
	               |ИЗ
	               |	Документ.ПоступлениеТоваровУслуг.Товары КАК ПоступлениеТоваровУслугТовары
	               |ГДЕ
	               |	ПоступлениеТоваровУслугТовары.Ссылка.Организация = &Организация
	               |	И ПоступлениеТоваровУслугТовары.Номенклатура = &Номенклатура
	               |	И ПоступлениеТоваровУслугТовары.Ссылка.Дата МЕЖДУ &НачДата И &КонДата
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ПоступлениеТоваровУслугТовары.Ссылка
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	Поступления.ПоступлениеТоваров,
	               |	Поступления.Количество,
	               |	Поступления.Сумма,
	               |	РеализацияТоваровУслуг.Ссылка
	               |ПОМЕСТИТЬ Реализации
	               |ИЗ
	               |	Поступления КАК Поступления
	               |		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	               |		ПО Поступления.ПоступлениеТоваров = РеализацияТоваровУслуг.ДокументОснование
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	Реализации.ПоступлениеТоваров,
	               |	Реализации.Количество,
	               |	Реализации.Сумма,
	               |	Реализации.Ссылка КАК РеализацияТоваров,
	               |	ПоступлениеТоваровУслуг.Ссылка КАК ПоступлениеПоРеализации
	               |ИЗ
	               |	Реализации КАК Реализации
	               |		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПоступлениеТоваровУслуг КАК ПоступлениеТоваровУслуг
	               |		ПО Реализации.Ссылка.Ссылка = ПоступлениеТоваровУслуг.ДокументОснование
	               |			И ((НЕ Реализации.Ссылка ЕСТЬ NULL ))
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Реализации.ПоступлениеТоваров.Дата";
	
	Запрос.УстановитьПараметр("Организация",Организация);
	Запрос.УстановитьПараметр("Номенклатура",Номенклатура);
	Запрос.УстановитьПараметр("НачДата",НачДата);
	Запрос.УстановитьПараметр("КонДата",КонецДня(КонДата));
	
	Результат = Запрос.Выполнить().Выбрать();
	Пока Результат.Следующий() Цикл 
		НовСтрока = ТабличнаяЧасть1.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтрока,Результат);
	КонецЦикла;

КонецПроцедуры

Процедура КоманднаяПанель1УдалитьСформированные(Кнопка)
	Для Каждого СтрТЧ Из ТабличнаяЧасть1 Цикл 
		ТекПоступление = СтрТЧ.ПоступлениеТоваров;
		ТекРеализация = СтрТЧ.РеализацияТоваров;
		ТекПоступлениеПоРеализации = СтрТЧ.ПоступлениеПоРеализации;
		
		Если ЗначениеЗаполнено(ТекРеализация) Тогда 
			Док = ТекРеализация.ПолучитьОбъект();
			Док.ДокументОснование = "";
			Док.ПометкаУдаления = Истина;
			Док.Записать();
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ТекПоступлениеПоРеализации) Тогда 
			Док = ТекПоступлениеПоРеализации.ПолучитьОбъект();
			Док.ДокументОснование = "";
			Док.ПометкаУдаления = Истина;
			Док.Записать();
		КонецЕсли;
	КонецЦикла;
	КоманднаяПанель1Заполнить("");
КонецПроцедуры
