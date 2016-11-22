﻿
////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

Процедура ПриОткрытии()
	
	Для Каждого Метаданное из Метаданные.РегламентныеЗадания Цикл
		ЭлементыФормы.МетаданныеВыбор.СписокВыбора.Добавить(Метаданное, Метаданное.Представление());
	КонецЦикла;
	
	Пользователи = ПользователиИнформационнойБазы.ПолучитьПользователей();
    Для Каждого Пользователь из Пользователи Цикл
		ЭлементыФормы.ПользователиВыбор.СписокВыбора.Добавить(Пользователь.Имя, Пользователь.ПолноеИмя);
	КонецЦикла;
    ЭлементыФормы.ПользователиВыбор.СписокВыбора.СортироватьПоПредставлению();
	
	Если РегламентноеЗадание <> Неопределено Тогда
		МетаданныеВыбор = РегламентноеЗадание.Метаданные;
		ЭлементыФормы.МетаданныеВыбор.Доступность = Ложь;
		Наименование = РегламентноеЗадание.Наименование;
		Ключ = РегламентноеЗадание.Ключ;
		Использование = РегламентноеЗадание.Использование;
		ПользователиВыбор = РегламентноеЗадание.ИмяПользователя;
		КоличествоПовторовПриАварийномЗавершении = РегламентноеЗадание.КоличествоПовторовПриАварийномЗавершении;
		ИнтервалПовтораПриАварийномЗавершении = РегламентноеЗадание.ИнтервалПовтораПриАварийномЗавершении;
		Расписание = РегламентноеЗадание.Расписание;
		Параметры.ЗагрузитьЗначения(РегламентноеЗадание.Параметры);
	Иначе
		Расписание = Новый РасписаниеРегламентногоЗадания;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ РЕКВИЗИТОВ ШАПКИ

Процедура РасписаниеНажатие(Элемент)
	
	Диалог = Новый ДиалогРасписанияРегламентногоЗадания(Расписание);
		
	Если Диалог.ОткрытьМодально() Тогда
		Расписание = Диалог.Расписание;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура OK(Кнопка)
	
	Попытка
		Если МетаданныеВыбор = Неопределено Тогда
			ВызватьИсключение("Не выбраны метаданные регламентного задания.");
		КонецЕсли;
		
		Если РегламентноеЗадание = Неопределено Тогда
			РегламентноеЗадание = РегламентныеЗадания.СоздатьРегламентноеЗадание(МетаданныеВыбор);
		КонецЕсли;
		
		РегламентноеЗадание.Наименование = Наименование;
		РегламентноеЗадание.Ключ = Ключ;
		РегламентноеЗадание.Использование = Использование;
		РегламентноеЗадание.ИмяПользователя = ПользователиВыбор;
		РегламентноеЗадание.КоличествоПовторовПриАварийномЗавершении = КоличествоПовторовПриАварийномЗавершении;
		РегламентноеЗадание.ИнтервалПовтораПриАварийномЗавершении = ИнтервалПовтораПриАварийномЗавершении;
		РегламентноеЗадание.Расписание = Расписание;
		Если ЗначениеЗаполнено(Параметры) Тогда
			РегламентноеЗадание.Параметры = Параметры.ВыгрузитьЗначения();
		Иначе
			РегламентноеЗадание.Параметры = Новый Массив;
		КонецЕсли;	
		РегламентноеЗадание.Записать();
		
		Закрыть(Истина);
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());	
	КонецПопытки;
	
КонецПроцедуры






