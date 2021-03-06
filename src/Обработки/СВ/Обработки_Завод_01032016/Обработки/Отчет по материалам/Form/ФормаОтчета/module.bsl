﻿
Процедура КнопкаСформироватьНажатие(Кнопка)
	
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
	ОбластьМакетаИтогПоНоменклатуре           = Макет.ПолучитьОбласть("Строка1");
	
	ОбластьМакетаШапка.Параметры.НачДата = НачДата;
	ОбластьМакетаШапка.Параметры.КонДата = КонДата;
	ОбластьМакетаШапка.Параметры.Организация = Организация;
	ОбластьМакетаШапка.Параметры.Контрагент = Контрагент;
	ОбластьМакетаШапка.Параметры.ТранспортноеСредство = ТранспортноеСредство;
	ОбластьМакетаШапка.Параметры.Номенклатура = Номенклатура;
	
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	ПоступлениеТоваровУслуг.ВремяВзвешиванияГруженного КАК ДатаВремя,
		               |	ПоступлениеТоваровУслуг.Количество КАК Нетто,
		               |	ПоступлениеТоваровУслуг.КоличествоПоДокументу КАК НеттоПлюс,
		               |	ПоступлениеТоваровУслуг.Ссылка КАК Ссылка,
		               |	ПоступлениеТоваровУслуг.Номенклатура КАК Номенклатура,
		               |	ПоступлениеТоваровУслуг.Ссылка.Контрагент КАК Контрагент,
		               |	ПоступлениеТоваровУслуг.Ссылка.Организация КАК Организация,
		               |	ПоступлениеТоваровУслуг.Ссылка.ТранспортноеСредство КАК ТранспортноеСредство,
		               |	ПоступлениеТоваровУслуг.Ссылка.Дата КАК Дата,
		               |	ЕСТЬNULL(СведенияОПроверкеДокументов.Проверен, ЛОЖЬ) КАК ДокументПроверен,
		               |	ПоступлениеТоваровУслуг.Ссылка.Грузоотправитель,
		               |	ПоступлениеТоваровУслуг.Цена,
		               |	ПоступлениеТоваровУслуг.Сумма КАК Сумма,
		               |	ПоступлениеТоваровУслуг.СуммаПоДокументу КАК СуммаПоДокументу,
		               |	ПоступлениеТоваровУслуг.Сумма - ПоступлениеТоваровУслуг.СуммаПоДокументу КАК РазницаСумма,
		               |	ПоступлениеТоваровУслуг.Количество - ПоступлениеТоваровУслуг.КоличествоПоДокументу КАК РазницаКоличество
		               |ИЗ
		               |	Документ.ПоступлениеТоваровУслуг.Товары КАК ПоступлениеТоваровУслуг
		               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СведенияОПроверкеДокументов КАК СведенияОПроверкеДокументов
		               |		ПО ПоступлениеТоваровУслуг.Ссылка = СведенияОПроверкеДокументов.Документ
		               |ГДЕ
		               |	ПоступлениеТоваровУслуг.Ссылка.ПометкаУдаления = ЛОЖЬ
		               |	И ПоступлениеТоваровУслуг.Ссылка.Дата МЕЖДУ &НачДата И &КонДата";
					   
					   Если ВыводитьТолькоПоВесам Тогда 
						   Запрос.Текст = Запрос.Текст + "
						   |И ПоступлениеТоваровУслуг.Ссылка.ЗагруженоИзОбработкиВесов = ИСТИНА";
					   КонецЕсли;
					   

		
		
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
		|СУММА(Нетто),
		|СУММА(НеттоПлюс),
		|СУММА(Сумма),
		|СУММА(СуммаПоДокументу),
		|СУММА(РазницаСумма),
		|СУММА(РазницаКоличество)
		|ПО
		|	ОБЩИЕ,
		|Номенклатура";
		
		
	Запрос.УстановитьПараметр("НачДата", НачДата);
	Запрос.УстановитьПараметр("КонДата", КонецДня(КонДата));
	Запрос.УстановитьПараметр("ТранспортноеСредство", ТранспортноеСредство);
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	Запрос.УстановитьПараметр("Грузоотправитель", Грузоотправитель);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	ТабДокумент.Вывести(ОбластьМакетаШапка);
	
	ТабДокумент.НачатьАвтогруппировкуСтрок();

	Результат = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Результат.Следующий() Цикл 
		ДетальныеЗаписи = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		ОбластьМакетаПодвал.Параметры.Заполнить(Результат);
		ТабДокумент.Вывести(ОбластьМакетаПодвал,Результат.Уровень());
		
		Пока ДетальныеЗаписи.Следующий() Цикл 
			ОбластьМакетаИтогПоНоменклатуре.Параметры.Заполнить(ДетальныеЗаписи);
			ТабДокумент.Вывести(ОбластьМакетаИтогПоНоменклатуре,ДетальныеЗаписи.Уровень());
			ДетальныеЗаписи1 = ДетальныеЗаписи.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
			Пока ДетальныеЗаписи1.Следующий() Цикл 
				ОбластьМакетаСтрока.Параметры.Заполнить(ДетальныеЗаписи1);
				ТабДокумент.Вывести(ОбластьМакетаСтрока,ДетальныеЗаписи1.Уровень());
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
	
	ТабДокумент.ЗакончитьАвтогруппировкуСтрок();
	ТабДокумент.ПоказатьУровеньГруппировокСтрок(1);
	ТабДокумент.ТолькоПросмотр = Истина;	
	ТабДокумент.Показать("Накладная");
	
КонецПроцедуры

