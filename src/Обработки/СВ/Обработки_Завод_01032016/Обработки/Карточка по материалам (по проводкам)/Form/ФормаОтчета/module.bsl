﻿
Процедура КнопкаСформироватьНажатие(Кнопка)
	ЭлементыФормы.ПолеТабличногоДокумента1.Очистить();
	Макет = ПолучитьМакет("Макет");
	ОбластьМакета = Макет.ПолучитьОбласть("Шапка");

	ОбластьМакета.Параметры["НачПериода"] = Формат(НачПериода, "ДФ=dd.MM.yyyy");
	ОбластьМакета.Параметры["КонПериода"] = Формат(КонПериода,"ДФ=dd.MM.yyyy");
	ЭлементыФормы.ПолеТабличногоДокумента1.Вывести(ОбластьМакета);
	Запрос = Новый Запрос;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ХозрасчетныйОстаткиИОбороты.Субконто1 КАК Материал,
	               |	ХозрасчетныйОстаткиИОбороты.КоличествоНачальныйОстаток КАК НачальныйОстаток,
	               |	ХозрасчетныйОстаткиИОбороты.КоличествоОборотДт КАК Приход,
	               |	ХозрасчетныйОстаткиИОбороты.КоличествоОборотКт КАК Расход,
	               |	ХозрасчетныйОстаткиИОбороты.КоличествоКонечныйОстаток КАК КонечныйОстаток,
	               |	ХозрасчетныйОстаткиИОбороты.Субконто1.Наименование КАК Субконто1Наименование
	               |ИЗ
	               |	РегистрБухгалтерии.Хозрасчетный.ОстаткиИОбороты(&НачДата, &КонДата, Авто, , Счет В ИЕРАРХИИ (&Счет), , Организация = &Организация) КАК ХозрасчетныйОстаткиИОбороты
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Субконто1Наименование
	               |ИТОГИ
	               |	СУММА(НачальныйОстаток),
	               |	СУММА(Приход),
	               |	СУММА(Расход),
	               |	СУММА(КонечныйОстаток)
	               |ПО
	               |	ОБЩИЕ,
	               |	Материал";
	
		
	Запрос.УстановитьПараметр("НачДата", НачалоДня(НачПериода));
	Запрос.УстановитьПараметр("КонДата", КонецДня(КонПериода));
	Запрос.УстановитьПараметр("Счет", ПланыСчетов.Хозрасчетный.НайтиПоКоду("10"));
	Запрос.УстановитьПараметр("Организация", Организация);
	
	Результат = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Результат.Следующий() Цикл 
		ОбластьМакета = Макет.ПолучитьОбласть("Строка1");
		ОбластьМакета.Параметры.Заполнить(Результат);
		ЭлементыФормы.ПолеТабличногоДокумента1.Вывести(ОбластьМакета);
		Строка = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока Строка.Следующий() Цикл 
			ОбластьМакета = Макет.ПолучитьОбласть("Строка");
			ОбластьМакета.Параметры.Заполнить(Строка);
			ЭлементыФормы.ПолеТабличногоДокумента1.Вывести(ОбластьМакета);
		КонецЦикла;
	КонецЦикла;
	            
	ЭлементыФормы.ПолеТабличногоДокумента1.ТолькоПросмотр = Истина;
	
КонецПроцедуры

Процедура ВыбПериодНажатие(Элемент)
	НастройкаПериода = Новый НастройкаПериода;
	НастройкаПериода.УстановитьПериод(НачПериода, ?(КонПериода='0001-01-01', КонПериода, КонецДня(КонПериода)));
	НастройкаПериода.РедактироватьКакИнтервал = Истина;
	НастройкаПериода.РедактироватьКакПериод = Истина;
	НастройкаПериода.ВариантНастройки = ВариантНастройкиПериода.Период;
	Если НастройкаПериода.Редактировать() Тогда
		НачПериода = НастройкаПериода.ПолучитьДатуНачала();
		КонПериода = НастройкаПериода.ПолучитьДатуОкончания();
	КонецЕсли;
КонецПроцедуры

