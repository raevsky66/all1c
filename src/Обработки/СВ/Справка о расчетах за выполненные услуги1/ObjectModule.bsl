﻿// Функция формирует табличный документ с печатной формой акта об
// обказании услуг
//
// Возвращаемое значение:
//  Табличный документ - печатная форма акта
//
Перем мВалютаРегламентированногоУчета Экспорт;
Функция Печать(СуммыВРублях = Ложь) Экспорт

	ЗапросШапка = Новый Запрос;
	ЗапросШапка.УстановитьПараметр("ТекущийДокумент", СсылкаНаОбъект.Ссылка);
	ЗапросШапка.Текст =
	"ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Номер,
	|	РеализацияТоваровУслуг.Дата,
	|	РеализацияТоваровУслуг.ДоговорКонтрагента КАК Договор,
	|	РеализацияТоваровУслуг.АдресДоставки,
	|	РеализацияТоваровУслуг.Контрагент КАК Получатель,
	|	РеализацияТоваровУслуг.Организация КАК Поставщик,
	|	РеализацияТоваровУслуг.Организация,
	|	РеализацияТоваровУслуг.СуммаДокумента,
	|	РеализацияТоваровУслуг.ВалютаДокумента,
	|	РеализацияТоваровУслуг.КурсВзаиморасчетов КАК Курс,
	|	РеализацияТоваровУслуг.КратностьВзаиморасчетов КАК Кратность,
	|	РеализацияТоваровУслуг.УчитыватьНДС,
	|	РеализацияТоваровУслуг.СуммаВключаетНДС,
	|	РеализацияТоваровУслуг.НомерСправки,
	|	РеализацияТоваровУслуг.Контрагент.КодПоОКПО КАК КонтрагентКодПоОКПО,
	|	РеализацияТоваровУслуг.ОбъектРТУ КАК ОбъектРТУ
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Ссылка = &ТекущийДокумент";
	Шапка = ЗапросШапка.Выполнить().Выбрать();
	Шапка.Следующий();


	ЗапросУслуги = Новый Запрос;
	ЗапросУслуги.УстановитьПараметр("ТекущийДокумент", СсылкаНаОбъект.Ссылка);
	ЗапросУслуги.Текст =
	"ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Количество,
	|	РеализацияТоваровУслуг.Цена КАК Цена,
	|	РеализацияТоваровУслуг.Сумма КАК Сумма,
	|	РеализацияТоваровУслуг.Номенклатура,
	|	РеализацияТоваровУслуг.СуммаНДС
	|ИЗ
	|	Документ.РеализацияТоваровУслуг.Услуги КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Ссылка = &ТекущийДокумент
	|
	|УПОРЯДОЧИТЬ ПО
	|	РеализацияТоваровУслуг.НомерСтроки";

	ТаблицаУслуги = ЗапросУслуги.Выполнить().Выгрузить();

	ТабДокумент = Новый ТабличныйДокумент;
	ТабДокумент.ИмяПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_РеализацияТоваровУслуг_Справка";
	Макет       = ПолучитьМакет("Акт");

	ОбластьМакета = Макет.ПолучитьОбласть("Шапка");
	ПредставлениеПоставщика = ФормированиеПечатныхФорм.ОписаниеОрганизации(УправлениеКонтактнойИнформацией.СведенияОЮрФизЛице(Шапка.Организация, Шапка.Дата), "ПолноеНаименование,ЮридическийАдрес");
	ПредставлениеПолучателя = ФормированиеПечатныхФорм.ОписаниеОрганизации(УправлениеКонтактнойИнформацией.СведенияОЮрФизЛице(Шапка.Получатель, Шапка.Дата), "ПолноеНаименование,ЮридическийАдрес");
	
	ОбластьМакета.Параметры.Поставщик = ПредставлениеПоставщика;
	ОбластьМакета.Параметры.Получатель = ПредставлениеПолучателя;
	ОбластьМакета.Параметры.Дата = Шапка.Дата;
	ОбластьМакета.Параметры.НомерСправки = Шапка.НомерСправки;
	ОбластьМакета.Параметры.КонтрагентКодПоОКПО = Шапка.КонтрагентКодПоОКПО;
	ОбластьМакета.Параметры.Объект = Шапка.ОбъектРТУ;

	ТабДокумент.Вывести(ОбластьМакета);

	//ИтКоличество = 0;
	
	ОбластьСтроки = Макет.ПолучитьОбласть("Строка");

	Для Каждого СтрокаТабличнойЧасти Из ТаблицаУслуги Цикл	

		ОбластьСтроки.Параметры.Заполнить(СтрокаТабличнойЧасти);
		ТабДокумент.Вывести(ОбластьСтроки);
		//ИтКоличество = ИтКоличество + СтрокаТабличнойЧасти.Количество;
	КонецЦикла;
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	//Если ТаблицаУслуги <> Неопределено Тогда

	ОбластьПодвал.Параметры.Сумма    = ТаблицаУслуги.Итог("Сумма");
	ОбластьПодвал.Параметры.СуммаНДС = ТаблицаУслуги.Итог("СуммаНДС");
	ОбластьПодвал.Параметры.КоличествоПрописью = Сред(ЧислоПрописью(ТаблицаУслуги.Итог("Количество")),1,СтрДлина(ЧислоПрописью(ТаблицаУслуги.Итог("Количество")))-3);
	//Иначе

	//	Сумма    = 0;
	//	СуммаНДС = 0;

	//КонецЕсли;

	//ОбластьМакета = Макет.ПолучитьОбласть("Итого");
	//ОбластьМакета.Параметры.Всего = ОбщегоНазначения.ФорматСумм(Сумма);
	//ТабДокумент.Вывести(ОбластьМакета);

	//Если Шапка.УчитыватьНДС Тогда

	//	ОбластьМакета = Макет.ПолучитьОбласть("ИтогоНДС");
	//	ОбластьМакета.Параметры.ВсегоНДС = ОбщегоНазначения.ФорматСумм(СуммаНДС);
	//	ОбластьМакета.Параметры.НДС      = ?(Шапка.СуммаВключаетНДС, "В том числе НДС", " Сумма НДС");
	//	ТабДокумент.Вывести(ОбластьМакета);

	//КонецЕсли;

	//СуммаКПрописи = Сумма + ?(Шапка.СуммаВключаетНДС, 0, СуммаНДС);
	//ОбластьМакета = Макет.ПолучитьОбласть("СуммаПрописью");
	//ОбластьМакета.Параметры.ИтоговаяСтрока ="Всего оказано услуг " + НомерСтроки + ", на сумму " + ОбщегоНазначения.ФорматСумм(СуммаКПрописи, ВалютаПечати);
	//ОбластьМакета.Параметры.СуммаПрописью  = ОбщегоНазначения.СформироватьСуммуПрописью(СуммаКПрописи, ВалютаПечати);
	//ТабДокумент.Вывести(ОбластьМакета);
     ОбластьПодвал.Параметры.ИтКоличество = ТаблицаУслуги.Итог("Количество");
	//ОбластьМакета = Макет.ПолучитьОбласть("Подписи");
	ТабДокумент.Вывести(ОбластьПодвал);

	Возврат ТабДокумент;

КонецФункции // ПечатьАктаОбОказанииУслуг()
