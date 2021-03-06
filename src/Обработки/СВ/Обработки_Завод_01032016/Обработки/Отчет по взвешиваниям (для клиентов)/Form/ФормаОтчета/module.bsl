﻿
Процедура КнопкаСформироватьНажатие(Кнопка)
	Если ПолеВыбора1 = Неопределено Тогда 
		Предупреждение("Выберите вид операции (входящий или исходящий)!");
		Возврат;
	КонецЕсли;
	
	ТабДокумент = Новый ТабличныйДокумент;
	
	// Зададим параметры макета
	ТабДокумент.ПолеСверху         = 0;
	ТабДокумент.ПолеСлева          = 0;
	ТабДокумент.ПолеСнизу          = 0;
	ТабДокумент.ПолеСправа         = 0;
	ТабДокумент.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	
	Макет = ПолучитьМакет("Макет");
	
	ОбластьМакетаШапка            = Макет.ПолучитьОбласть("Шапка");
	ОбластьМакетаСтрока           = Макет.ПолучитьОбласть("Строка");
	ОбластьМакетаПодвал           = Макет.ПолучитьОбласть("Подвал");
	
	ОбластьМакетаШапка.Параметры.НачДата = НачДата;
	ОбластьМакетаШапка.Параметры.КонДата = КонДата;
	ОбластьМакетаШапка.Параметры.Организация = Организация;
	ОбластьМакетаШапка.Параметры.Контрагент = Контрагент;
	ОбластьМакетаШапка.Параметры.ТранспортноеСредство = ТранспортноеСредство;
	ОбластьМакетаШапка.Параметры.Номенклатура = Номенклатура;
	ОбластьМакетаШапка.Параметры["ВидОперации"] = ?(ПолеВыбора1 = 1,"Исходящий","Входящий");
	
	Если ПолеВыбора1 = 1 Тогда 
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	РеализацияТоваровУслугТовары.ВремяВзвешиванияГруженного КАК ДатаВремя,
		               |	РеализацияТоваровУслугТовары.ВесПустой КАК Тара,
		               |	РеализацияТоваровУслугТовары.КоличествоПоДокументу КАК НеттоПлюс,
		               |	РеализацияТоваровУслугТовары.Количество КАК Нетто,
		               |	РеализацияТоваровУслугТовары.Ссылка КАК Ссылка,
		               |	РеализацияТоваровУслугТовары.Номенклатура КАК Номенклатура,
		               |	РеализацияТоваровУслугТовары.Ссылка.Контрагент КАК Контрагент,
		               |	РеализацияТоваровУслугТовары.Ссылка.Грузоотправитель КАК Грузоотправитель,
		               |	РеализацияТоваровУслугТовары.Ссылка.Организация КАК Организация,
		               |	РеализацияТоваровУслугТовары.Ссылка.ТранспортноеСредство КАК ТранспортноеСредство,
		               |	РеализацияТоваровУслугТовары.Ссылка.Дата КАК Дата,
		               |	ЕСТЬNULL(СведенияОПроверкеДокументов.Проверен, ЛОЖЬ) КАК ДокументПроверен,
		               |	РеализацияТоваровУслугТовары.ВесПустой + РеализацияТоваровУслугТовары.КоличествоПоДокументу КАК Брутто
		               |ИЗ
		               |	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслугТовары
		               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СведенияОПроверкеДокументов КАК СведенияОПроверкеДокументов
		               |		ПО РеализацияТоваровУслугТовары.Ссылка = СведенияОПроверкеДокументов.Документ
		               |ГДЕ
		               |	РеализацияТоваровУслугТовары.Ссылка.ВнутреннийНомерНакладной > 0
		               |	И РеализацияТоваровУслугТовары.Ссылка.ПометкаУдаления = ЛОЖЬ
		               |	И РеализацияТоваровУслугТовары.Ссылка.Дата МЕЖДУ &НачДата И &КонДата";
		
		Если ЗначениеЗаполнено(ТранспортноеСредство) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И РеализацияТоваровУслугТовары.Ссылка.ТранспортноеСредство = &ТранспортноеСредство";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Контрагент) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И РеализацияТоваровУслугТовары.Ссылка.Контрагент = &Контрагент";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Грузоотправитель) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И РеализацияТоваровУслугТовары.Ссылка.Грузоотправитель = &Грузоотправитель";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Организация) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И РеализацияТоваровУслугТовары.Ссылка.Организация = &Организация";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Номенклатура) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И РеализацияТоваровУслугТовары.Номенклатура = &Номенклатура";
		КонецЕсли;
		
		Если ВыводитьТолькоПроверенные Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ЕСТЬNULL(СведенияОПроверкеДокументов.Проверен, ЛОЖЬ) = ИСТИНА";
		КонецЕсли;
		
		Запрос.Текст = Запрос.Текст + "
		|УПОРЯДОЧИТЬ ПО
		|	Дата
		|ИТОГИ
		|	СУММА(Брутто),
		|	СУММА(Тара),
		|	СУММА(НеттоПлюс),
		|	СУММА(Нетто)
		|ПО
		|	ОБЩИЕ";
		
		
		
	ИначеЕсли ПолеВыбора1 = 2 Тогда 
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	ПоступлениеТоваровУслуг.ВремяВзвешиванияГруженного КАК ДатаВремя,
		               |	ПоступлениеТоваровУслуг.ВесГруженный КАК Брутто,
		               |	ПоступлениеТоваровУслуг.ВесПустой КАК Тара,
		               |	0 КАК НеттоПлюс,
		               |	ПоступлениеТоваровУслуг.Количество КАК Нетто,
		               |	ПоступлениеТоваровУслуг.Ссылка КАК Ссылка,
		               |	ПоступлениеТоваровУслуг.Номенклатура КАК Номенклатура,
		               |	ПоступлениеТоваровУслуг.Ссылка.Контрагент КАК Контрагент,
		               |	ПоступлениеТоваровУслуг.Ссылка.Организация КАК Организация,
		               |	ПоступлениеТоваровУслуг.Ссылка.ТранспортноеСредство КАК ТранспортноеСредство,
		               |	ПоступлениеТоваровУслуг.Ссылка.Дата КАК Дата,
		               |	ЕСТЬNULL(СведенияОПроверкеДокументов.Проверен, ЛОЖЬ) КАК ДокументПроверен,
		               |	ПоступлениеТоваровУслуг.Ссылка.Грузоотправитель
		               |ИЗ
		               |	Документ.ПоступлениеТоваровУслуг.Товары КАК ПоступлениеТоваровУслуг
		               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СведенияОПроверкеДокументов КАК СведенияОПроверкеДокументов
		               |		ПО ПоступлениеТоваровУслуг.Ссылка = СведенияОПроверкеДокументов.Документ
		               |ГДЕ
		               |	ПоступлениеТоваровУслуг.Ссылка.ПометкаУдаления = ЛОЖЬ
		               |	И ПоступлениеТоваровУслуг.Ссылка.Дата МЕЖДУ &НачДата И &КонДата
		               |	И ПоступлениеТоваровУслуг.Ссылка.ЗагруженоИзОбработкиВесов = ИСТИНА";
		
		
		
		Если ЗначениеЗаполнено(ТранспортноеСредство) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ПоступлениеТоваровУслуг.Ссылка.ТранспортноеСредство = &ТранспортноеСредство";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Контрагент) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ПоступлениеТоваровУслуг.Ссылка.Контрагент = &Контрагент";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Грузоотправитель) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ПоступлениеТоваровУслуг.Ссылка.Грузоотправитель = &Грузоотправитель";
		КонецЕсли;

		
		Если ЗначениеЗаполнено(Организация) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ПоступлениеТоваровУслуг.Ссылка.Организация = &Организация";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Номенклатура) Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ПоступлениеТоваровУслуг.Номенклатура = &Номенклатура";
		КонецЕсли;
		
		Если ВыводитьТолькоПроверенные Тогда 
			Запрос.Текст = Запрос.Текст + "
			|И ЕСТЬNULL(СведенияОПроверкеДокументов.Проверен, ЛОЖЬ) = ИСТИНА";
		КонецЕсли;
		
		Запрос.Текст = Запрос.Текст + "
		|УПОРЯДОЧИТЬ ПО
		|	Дата
		|ИТОГИ
		|	СУММА(Брутто),
		|	СУММА(Тара),
		|	СУММА(НеттоПлюс),
		|	СУММА(Нетто)
		|ПО
		|	ОБЩИЕ";
		
		
	КонецЕсли;
	Запрос.УстановитьПараметр("НачДата", НачДата);
	Запрос.УстановитьПараметр("КонДата", КонецДня(КонДата));
	Запрос.УстановитьПараметр("ТранспортноеСредство", ТранспортноеСредство);
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	Запрос.УстановитьПараметр("Грузоотправитель", Грузоотправитель);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	ТабДокумент.Вывести(ОбластьМакетаШапка);
	
	Результат = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Результат.Следующий() Цикл 
		ДетальныеЗаписи = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		ОбластьМакетаПодвал.Параметры.Заполнить(Результат);
		ТабДокумент.Вывести(ОбластьМакетаПодвал);
		
		Пока ДетальныеЗаписи.Следующий() Цикл 
			ОбластьМакетаСтрока.Параметры.Заполнить(ДетальныеЗаписи);
			ТабДокумент.Вывести(ОбластьМакетаСтрока);
		КонецЦикла;
	КонецЦикла;
	
	
	ТабДокумент.ТолькоПросмотр = Истина;	
	ТабДокумент.Показать("Накладная");
	
КонецПроцедуры

Процедура ПриОткрытии()
	ЭлементыФормы.ПолеВыбора1.СписокВыбора.Добавить(1, "Исходящий");
	ЭлементыФормы.ПолеВыбора1.СписокВыбора.Добавить(2, "Входящий");
	ЭлементыФормы.ПолеВыбора1.Значение = 1;
КонецПроцедуры
