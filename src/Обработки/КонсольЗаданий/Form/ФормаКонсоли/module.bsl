﻿////////////////////////////////////////////////////////////////////////////////
// Переменные
//

// Соответствие по ключу идентификатор регламентного задания
Перем РегламентныеЗаданияСоответствие;
// Соответствие по ключу идентификатор фонового задания
Перем ФоновыеЗаданияСоответствие;
// Признак блокировки обновления фоновых и регламентных заданий при открытии модальных диалогов
Перем БлокироватьОбновление;

////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции
//

// Обновить список регламентных заданий
//
Процедура ОбновитьСписокРегламентныхЗаданий()
	Перем ТекущийИдентификатор;
	
	Если БлокироватьОбновление Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока = ЭлементыФормы.СписокРегламентныхЗаданий.ТекущаяСтрока;
	Если ТекущаяСтрока <> Неопределено Тогда
		ТекущийИдентификатор = ТекущаяСтрока.Идентификатор;
	КонецЕсли;
	
	Идентификаторы = Новый Массив;
	
	ВыделенныеСтроки = ЭлементыФормы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Для Каждого ВыделеннаяСтрока из ВыделенныеСтроки Цикл
		Идентификаторы.Добавить(ВыделеннаяСтрока.Идентификатор);
	КонецЦикла;
	
	СписокРегламентныхЗаданий.Очистить();
	
	Отбор = Неопределено;
	Если ОтборРегламентныхЗаданийВключен = Истина Тогда
		Отбор = ОтборРегламентныхЗаданий;
	КонецЕсли;
	Регламентные = РегламентныеЗадания.ПолучитьРегламентныеЗадания(Отбор);
	РегламентныеЗаданияСоответствие.Очистить();
	
	Для Каждого Регламентное из Регламентные Цикл
		НоваяСтрока = СписокРегламентныхЗаданий.Добавить();
		НоваяСтрока.Метаданные = Регламентное.Метаданные.Представление();
		НоваяСтрока.Наименование = Регламентное.Наименование;
		НоваяСтрока.Ключ = Регламентное.Ключ;
		НоваяСтрока.Расписание = Регламентное.Расписание;
		НоваяСтрока.Пользователь = Регламентное.ИмяПользователя;
		НоваяСтрока.Предопределенное = Регламентное.Предопределенное;
		НоваяСтрока.Использование = Регламентное.Использование;
		НоваяСтрока.Идентификатор = Регламентное.УникальныйИдентификатор;
		
		РегламентныеЗаданияСоответствие[Строка(Регламентное.УникальныйИдентификатор)] = Регламентное;
		
		ПоследнееЗадание = Регламентное.ПоследнееЗадание;
		Если ПоследнееЗадание <> Неопределено Тогда
			НоваяСтрока.Выполнялось = ПоследнееЗадание.Начало;
			НоваяСтрока.Состояние = ПоследнееЗадание.Состояние;
		КонецЕсли;
	КонецЦикла;
	
    Если ТекущийИдентификатор <> Неопределено Тогда
		Строка = СписокРегламентныхЗаданий.Найти(ТекущийИдентификатор, "Идентификатор");
		Если Строка <> Неопределено Тогда
			ЭлементыФормы.СписокРегламентныхЗаданий.ТекущаяСтрока = Строка;
		КонецЕсли;
	КонецЕсли;

	Если Идентификаторы.Количество() > 0 Тогда
		ВыделенныеСтроки.Очистить();
	КонецЕсли;
	
	Для Каждого Идентификатор из Идентификаторы Цикл
		Строка = СписокРегламентныхЗаданий.Найти(Идентификатор, "Идентификатор");
		Если Строка <> Неопределено Тогда
			ВыделенныеСтроки.Добавить(Строка);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Обновить список фоновых заданий
//
Процедура ОбновитьСписокФоновыхЗаданий()
	Перем ТекущийИдентификатор;
	
	Если БлокироватьОбновление Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока = ЭлементыФормы.СписокФоновыхЗаданий.ТекущаяСтрока;
	Если ТекущаяСтрока <> Неопределено Тогда
		ТекущийИдентификатор = ТекущаяСтрока.Идентификатор;
	КонецЕсли;
	
	Идентификаторы = Новый Массив;
	
	ВыделенныеСтроки = ЭлементыФормы.СписокФоновыхЗаданий.ВыделенныеСтроки;
	Для Каждого ВыделеннаяСтрока из ВыделенныеСтроки Цикл
		Идентификаторы.Добавить(ВыделеннаяСтрока.Идентификатор);
	КонецЦикла;
	
	СписокФоновыхЗаданий.Очистить();
	
	Отбор = Неопределено;
	Если ОтборФоновыхЗаданийВключен = Истина Тогда
		Отбор = ОтборФоновыхЗаданий;
	КонецЕсли;
		
	Фоновые = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);
	ФоновыеЗаданияСоответствие.Очистить();
	
	Для Каждого Фоновое из Фоновые Цикл
		НоваяСтрока = СписокФоновыхЗаданий.Добавить();
		
		РегламентноеЗадание = Фоновое.РегламентноеЗадание;
		Если РегламентноеЗадание <> Неопределено Тогда
			Строка = РегламентноеЗадание.Метаданные.Представление();
			Если РегламентноеЗадание.Наименование <> "" Тогда
				Строка = Строка + ":" +	РегламентноеЗадание.Наименование;
			КонецЕсли;
			
			НоваяСтрока.Регламентное = Строка;
		КонецЕсли;
			
		НоваяСтрока.Наименование = Фоновое.Наименование;
		НоваяСтрока.Ключ = Фоновое.Ключ;
		НоваяСтрока.Метод = Фоновое.ИмяМетода;
		НоваяСтрока.Состояние = Фоновое.Состояние;
		НоваяСтрока.Начало = Фоновое.Начало;
		НоваяСтрока.Конец = Фоновое.Конец;
		НоваяСтрока.Сервер = Фоновое.Расположение;
		
		Если Фоновое.ИнформацияОбОшибке <> Неопределено Тогда
			НоваяСтрока.Ошибки = Фоновое.ИнформацияОбОшибке.Описание;
		КонецЕсли;
		
		НоваяСтрока.Идентификатор = Фоновое.УникальныйИдентификатор;
		НоваяСтрока.СостояниеЗадания = Фоновое.Состояние;
		
		ФоновыеЗаданияСоответствие[Строка(Фоновое.УникальныйИдентификатор)] = Фоновое;
	КонецЦикла;
	
	Если ТекущийИдентификатор <> Неопределено Тогда
		Строка = СписокФоновыхЗаданий.Найти(ТекущийИдентификатор, "Идентификатор");
		Если Строка <> Неопределено Тогда
			ЭлементыФормы.СписокФоновыхЗаданий.ТекущаяСтрока = Строка;
		КонецЕсли;
	КонецЕсли;
	
	Если Идентификаторы.Количество() > 0 Тогда
		ВыделенныеСтроки.Очистить();
	КонецЕсли;
		
	Для Каждого Идентификатор из Идентификаторы Цикл
		Строка = СписокФоновыхЗаданий.Найти(Идентификатор, "Идентификатор");
		Если Строка <> Неопределено Тогда
			ВыделенныеСтроки.Добавить(Строка);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция ПреобразоватьОтборДляСохраненияЗначения(СтарыйОтбор)
	
	Если СтарыйОтбор = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НовыйОтбор = Новый Структура;
	Для Каждого Свойство Из СтарыйОтбор Цикл
		НовыйОтбор.Вставить(Свойство.Ключ, ?(Свойство.Ключ = "Метаданные", Свойство.Значение.Имя, Свойство.Значение));
	КонецЦикла;
	
	Возврат НовыйОтбор;
	
КонецФункции

Функция ПреобразоватьОтборПослеВосстановленияЗначений(СтарыйОтбор)
	
	Если СтарыйОтбор = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НовыйОтбор = Новый Структура;
	Для Каждого Свойство Из СтарыйОтбор Цикл
		Если (Свойство.Ключ = "Метаданные") И (ТипЗнч(Свойство.Значение) = Тип("Строка")) Тогда
			НовыйОтбор.Вставить(Свойство.Ключ, Метаданные.РегламентныеЗадания[Свойство.Значение]);
		Иначе
			НовыйОтбор.Вставить(Свойство.Ключ, Свойство.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Возврат НовыйОтбор;
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ
//

Процедура ОбновитьРегламентныеНажатие(Кнопка)
 	Попытка
		ОбновитьСписокРегламентныхЗаданий();
	Исключение	
	КонецПопытки;
КонецПроцедуры

Процедура РасписаниеНажатие(Кнопка)
	ВыделенныеСтроки = ЭлементыФормы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() > 0 Тогда
		
		БлокироватьОбновление = Истина;
		
		Строка = ВыделенныеСтроки.Получить(0);
		РегламентноеЗадание = РегламентныеЗаданияСоответствие.Получить(Строка.Идентификатор);
		Диалог = Новый ДиалогРасписанияРегламентногоЗадания(РегламентноеЗадание.Расписание);
		
		Если Диалог.ОткрытьМодально() Тогда
			РегламентноеЗадание.Расписание = Диалог.Расписание;
			РегламентноеЗадание.Записать();
			
			Строка.Расписание = РегламентноеЗадание.Расписание;
		КонецЕсли;
		
		БлокироватьОбновление = Ложь;
	КонецЕсли;
КонецПроцедуры

Процедура ПриОткрытии()
	Попытка
		ОтборФоновыхЗаданий = ВосстановитьЗначение("ФоновыеЗадания.Отбор");
		ОтборФоновыхЗаданийВключен = ВосстановитьЗначение("ФоновыеЗадания.ОтборВключен");
		ОтборРегламентныхЗаданий = ПреобразоватьОтборПослеВосстановленияЗначений(ВосстановитьЗначение("РегламентныеЗадания.Отбор"));
		ОтборРегламентныхЗаданийВключен = ВосстановитьЗначение("РегламентныеЗадания.ОтборВключен");
		
		АвтообновлениеСпискаРегламентныхЗаданий = ВосстановитьЗначение("РегламентныеЗадания.АвтообновлениеСписка");
		ПериодАвтообновленияСпискаРегламентныхЗаданий = ВосстановитьЗначение("РегламентныеЗадания.ПериодАвтообновленияСписка");
		
		АвтообновлениеСпискаФоновыхЗаданий = ВосстановитьЗначение("ФоновыеЗадания.АвтообновлениеСписка");
		ПериодАвтообновленияСпискаФоновыхЗаданий = ВосстановитьЗначение("ФоновыеЗадания.ПериодАвтообновленияСписка");
		
		Если АвтообновлениеСпискаРегламентныхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбновитьСписокРегламентныхЗаданий", ПериодАвтообновленияСпискаРегламентныхЗаданий);	
		КонецЕсли;		
		
		Если АвтообновлениеСпискаФоновыхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбновитьСписокФоновыхЗаданий", ПериодАвтообновленияСпискаФоновыхЗаданий);	
		КонецЕсли;		
		
		ОбновитьСписокРегламентныхЗаданий();
		ОбновитьСписокФоновыхЗаданий();
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;
КонецПроцедуры

Процедура СписокРегламентныхЗаданийПередУдалением(Элемент, Отказ)
	Попытка
		Отказ = Истина;
		ВыделенныеСтроки = ЭлементыФормы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
		Для Каждого Строка из ВыделенныеСтроки Цикл
			РегламентноеЗадание = РегламентныеЗаданияСоответствие.Получить(Строка.Идентификатор);
			Если РегламентноеЗадание.Предопределенное Тогда
				ВызватьИсключение("Нельзя удалить предопределенное задание: " + РегламентноеЗадание.Наименование);
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого Строка из ВыделенныеСтроки Цикл
			РегламентноеЗадание = РегламентныеЗаданияСоответствие.Получить(Строка.Идентификатор);
			РегламентноеЗадание.Удалить();
		КонецЦикла;
		
		ОбновитьСписокРегламентныхЗаданий();
	Исключение
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;
КонецПроцедуры

Процедура СписокРегламентныхЗаданийПередНачаломДобавления(Элемент, Отказ, Копирование)
	Отказ = Истина;
	Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогРегламентногоЗадания");
	Если Диалог.ОткрытьМодально() = Истина Тогда
		
		Строка = СписокРегламентныхЗаданий.Добавить();
		РегламентноеЗадание = Диалог.РегламентноеЗадание;
		
		Строка.Метаданные = РегламентноеЗадание.Метаданные.Представление();
		Строка.Предопределенное = РегламентноеЗадание.Предопределенное;
		Строка.Идентификатор = РегламентноеЗадание.УникальныйИдентификатор;
		
		Строка.Наименование = РегламентноеЗадание.Наименование;
		Строка.Ключ = РегламентноеЗадание.Ключ;
		Строка.Расписание = РегламентноеЗадание.Расписание;
		Строка.Пользователь = РегламентноеЗадание.ИмяПользователя;
		Строка.Предопределенное = РегламентноеЗадание.Предопределенное;
		Строка.Использование = РегламентноеЗадание.Использование;
		Строка.Идентификатор = РегламентноеЗадание.УникальныйИдентификатор;
		
		Если РегламентноеЗадание.ПоследнееЗадание <> Неопределено Тогда
			Строка.Выполнялось = РегламентноеЗадание.ПоследнееЗадание.Начало;
			Строка.Состояние = РегламентноеЗадание.ПоследнееЗадание.Состояние;
		КонецЕсли;
		
		РегламентныеЗаданияСоответствие[Строка(РегламентноеЗадание.УникальныйИдентификатор)] = РегламентноеЗадание;
	КонецЕсли;
КонецПроцедуры

Процедура СписокРегламентныхЗаданийПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	ВыделенныеСтроки = ЭлементыФормы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() > 0 Тогда
		
		БлокироватьОбновление = Истина;
		Строка = ВыделенныеСтроки.Получить(0);
		РегламентноеЗадание = РегламентныеЗаданияСоответствие.Получить(Строка.Идентификатор);
		Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогРегламентногоЗадания");
		Диалог.РегламентноеЗадание = РегламентноеЗадание;
		Диалог.ОткрытьМодально();
			
		Строка.Наименование = РегламентноеЗадание.Наименование;
		Строка.Ключ = РегламентноеЗадание.Ключ;
		Строка.Расписание = РегламентноеЗадание.Расписание;
		Строка.Пользователь = РегламентноеЗадание.ИмяПользователя;
		Строка.Предопределенное = РегламентноеЗадание.Предопределенное;
		Строка.Использование = РегламентноеЗадание.Использование;
		Строка.Идентификатор = РегламентноеЗадание.УникальныйИдентификатор;
		
		Если РегламентноеЗадание.ПоследнееЗадание <> Неопределено Тогда
			Строка.Выполнялось = РегламентноеЗадание.ПоследнееЗадание.Начало;
			Строка.Состояние = РегламентноеЗадание.ПоследнееЗадание.Состояние;
		КонецЕсли;
		БлокироватьОбновление = Ложь;
	КонецЕсли;
КонецПроцедуры

Процедура ОбновитьФоновыеНажатие(Кнопка)
	Попытка
		ОбновитьСписокФоновыхЗаданий();
	Исключение	
	КонецПопытки;
КонецПроцедуры

Процедура ОтменитьФоновоеНажатие(Кнопка)
	Отказ = Истина;
	Попытка
		ВыделенныеСтроки = ЭлементыФормы.СписокФоновыхЗаданий.ВыделенныеСтроки;
		Для Каждого Строка из ВыделенныеСтроки Цикл
			ФоновоеЗадание = ФоновыеЗаданияСоответствие.Получить(Строка.Идентификатор);
			ФоновоеЗадание.Отменить();
		КонецЦикла;
		
		ОбновитьСписокФоновыхЗаданий();
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;	
КонецПроцедуры

Процедура СписокФоновыхЗаданийПередНачаломДобавления(Элемент, Отказ, Копирование)
	Отказ = Истина;
	БлокироватьОбновление = Истина;
	Попытка
		Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогФоновогоЗадания");
		Если Диалог.ОткрытьМодально() = Истина Тогда
			Строка = СписокФоновыхЗаданий.Вставить(0);
			ФоновоеЗадание = Диалог.ФоновоеЗадание;
			
        	Строка.Регламентное = "";
			Строка.Наименование = ФоновоеЗадание.Наименование;
			Строка.Ключ = ФоновоеЗадание.Ключ;
			Строка.Метод = ФоновоеЗадание.ИмяМетода;
			Строка.Состояние = ФоновоеЗадание.Состояние;
			Строка.Начало = ФоновоеЗадание.Начало;
			Строка.Конец = ФоновоеЗадание.Конец;
			Строка.Сервер = ФоновоеЗадание.Расположение;
			
			Если ФоновоеЗадание.ИнформацияОбОшибке <> Неопределено Тогда
				Строка.Ошибки = ФоновоеЗадание.ИнформацияОбОшибке.Описание;
			КонецЕсли;
			
			Строка.Идентификатор = ФоновоеЗадание.УникальныйИдентификатор;
			Строка.СостояниеЗадания = ФоновоеЗадание.Состояние;
			
			ФоновыеЗаданияСоответствие[Строка(ФоновоеЗадание.УникальныйИдентификатор)] = ФоновоеЗадание;
		КонецЕсли;
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;	
	БлокироватьОбновление = Ложь;
КонецПроцедуры

Процедура СписокФоновыхЗаданийПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

Процедура СписокФоновыхЗаданийПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

Процедура ОтключитьОтборФоновыхЗаданий(Кнопка)
	ОтборФоновыхЗаданийВключен = Ложь;
	СохранитьЗначение("ФоновыеЗадания.ОтборВключен", ОтборФоновыхЗаданийВключен);
	ОбновитьСписокФоновыхЗаданий();
КонецПроцедуры

Процедура УстановитьОтборФоновыхЗаданий(Кнопка)
	Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогОтбораФоновогоЗадания");
	Диалог.Отбор = ОтборФоновыхЗаданий;
	Если Диалог.ОткрытьМодально() = Истина Тогда	
		ОтборФоновыхЗаданий = Диалог.Отбор;
		ОтборФоновыхзаданийВключен = Истина;
		СохранитьЗначение("ФоновыеЗадания.Отбор", ОтборФоновыхЗаданий);
		СохранитьЗначение("ФоновыеЗадания.ОтборВключен", ОтборФоновыхЗаданийВключен);
		ОбновитьСписокФоновыхЗаданий();
	КонецЕсли;
КонецПроцедуры

Процедура СписокФоновыхЗаданийПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки)
	Если ДанныеСтроки.СостояниеЗадания = СостояниеФоновогоЗадания.Активно Тогда
		ОформлениеСтроки.Шрифт = Новый Шрифт(ШрифтыСтиля.ШрифтТекста,,, Истина);
	ИначеЕсли ДанныеСтроки.СостояниеЗадания = СостояниеФоновогоЗадания.Завершено Тогда
	ИначеЕсли ДанныеСтроки.СостояниеЗадания = СостояниеФоновогоЗадания.ЗавершеноАварийно Тогда	
		ОформлениеСтроки.ЦветТекста = Новый Цвет(255, 0, 0);
	ИначеЕсли ДанныеСтроки.СостояниеЗадания = СостояниеФоновогоЗадания.Отменено Тогда	
		ОформлениеСтроки.ЦветТекста = Новый Цвет(128, 128, 128);
	КонецЕсли;
	
	Если ДанныеСтроки.Регламентное <> "" Тогда
		ОформлениеСтроки.Ячейки[0].Картинка = БиблиотекаКартинок.РегламентноеЗадание;
		ОформлениеСтроки.Ячейки[0].ОтображатьКартинку = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура УстановитьОтборРегламентныхЗаданий(Кнопка)
	Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогОтбораРегламентногоЗадания");
	Диалог.Отбор = ОтборРегламентныхЗаданий;
	Если Диалог.ОткрытьМодально() = Истина Тогда	
		ОтборРегламентныхЗаданий = Диалог.Отбор;
		ОтборРегламентныхЗаданийВключен = Истина;
		СохранитьЗначение("РегламентныеЗадания.Отбор", ПреобразоватьОтборДляСохраненияЗначения(ОтборРегламентныхЗаданий));
		СохранитьЗначение("РегламентныеЗадания.ОтборВключен", ОтборРегламентныхЗаданийВключен);
		ОбновитьСписокРегламентныхЗаданий();
	КонецЕсли;
КонецПроцедуры

Процедура ОтключитьОтборРегламентныхЗаданий(Кнопка)
	ОтборРегламентныхЗаданийВключен = Ложь;
	СохранитьЗначение("РегламентныеЗадания.ОтборВключен", ОтборРегламентныхЗаданийВключен);
	ОбновитьСписокРегламентныхЗаданий();
КонецПроцедуры

Процедура КоманднаяПанель4Действие3(Кнопка)
	Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогНастроекСписка");
	Диалог.Автообновление = АвтообновлениеСпискаРегламентныхЗаданий;
	Диалог.ПериодАвтообновления = ПериодАвтообновленияСпискаРегламентныхЗаданий;
	Если Диалог.ОткрытьМодально() = Истина Тогда	
		АвтообновлениеСпискаРегламентныхЗаданий = Диалог.Автообновление;
		ПериодАвтообновленияСпискаРегламентныхЗаданий = Диалог.ПериодАвтообновления;
		СохранитьЗначение("РегламентныеЗадания.АвтообновлениеСписка", 
			АвтообновлениеСпискаРегламентныхЗаданий);
		СохранитьЗначение("РегламентныеЗадания.ПериодАвтообновленияСписка", 
			ПериодАвтообновленияСпискаРегламентныхЗаданий);
			
		ОтключитьОбработчикОжидания("ОбновитьСписокРегламентныхЗаданий");
		Если АвтообновлениеСпискаРегламентныхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбновитьСписокРегламентныхЗаданий", ПериодАвтообновленияСпискаРегламентныхЗаданий);	
		КонецЕсли;		
	КонецЕсли;
	БлокироватьОбновление = Ложь;
КонецПроцедуры

Процедура КоманднаяПанель5Действие3(Кнопка)
	Диалог = ОбработкаОбъект.ПолучитьФорму("ДиалогНастроекСписка");
	Диалог.Автообновление = АвтообновлениеСпискаФоновыхЗаданий;
	Диалог.ПериодАвтообновления = ПериодАвтообновленияСпискаФоновыхЗаданий;
	Если Диалог.ОткрытьМодально() = Истина Тогда	
		АвтообновлениеСпискаФоновыхЗаданий = Диалог.Автообновление;
		ПериодАвтообновленияСпискаФоновыхЗаданий = Диалог.ПериодАвтообновления;
		СохранитьЗначение("ФоновыеЗадания.АвтообновлениеСписка", 
			АвтообновлениеСпискаФоновыхЗаданий);
		СохранитьЗначение("ФоновыеЗадания.ПериодАвтообновленияСписка", 
			ПериодАвтообновленияСпискаФоновыхЗаданий);
			
		ОтключитьОбработчикОжидания("ОбновитьСписокФоновыхЗаданий");
		Если АвтообновлениеСпискаФоновыхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбновитьСписокФоновыхЗаданий", ПериодАвтообновленияСпискаФоновыхЗаданий);	
		КонецЕсли;		
	КонецЕсли;
	БлокироватьОбновление = Ложь;
КонецПроцедуры

РегламентныеЗаданияСоответствие = Новый Соответствие;
ФоновыеЗаданияСоответствие = Новый Соответствие;
БлокироватьОбновление = Ложь;