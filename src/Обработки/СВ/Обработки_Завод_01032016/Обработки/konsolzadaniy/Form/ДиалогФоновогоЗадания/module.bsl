﻿
Процедура OK(Кнопка)
	Попытка	
		Если ЗначениеЗаполнено(Параметры) Тогда
		    ФоновоеЗадание = ФоновыеЗадания.Выполнить(ИмяМетода, Параметры.ВыгрузитьЗначения(), Ключ, Наименование);
		Иначе
		    ФоновоеЗадание = ФоновыеЗадания.Выполнить(ИмяМетода, , Ключ, Наименование);
		КонецЕсли;
		
		Закрыть(Истина);
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;
КонецПроцедуры

