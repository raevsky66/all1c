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
	ЗапросШапка.УстановитьПараметр("Контрагент",   СсылкаНаОбъект.Контрагент);
	ЗапросШапка.УстановитьПараметр("Тип", Перечисления.ТипыКонтактнойИнформации.Адрес);
	ЗапросШапка.УстановитьПараметр("Вид", Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента);
	ЗапросШапка.Текст =
	"ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Номер,
	|	РеализацияТоваровУслуг.Дата,
	|	РеализацияТоваровУслуг.Контрагент КАК Получатель,
	|	ВложенныйЗапрос.Представление КАК Адрес
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Контрагенты КАК Контрагенты
	|			ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|				КонтактнаяИнформация.Представление КАК Представление,
	|				КонтактнаяИнформация.Объект КАК Объект
	|			ИЗ
	|				РегистрСведений.КонтактнаяИнформация КАК КонтактнаяИнформация
	|			ГДЕ
	|				КонтактнаяИнформация.Тип = &Тип
	|				И КонтактнаяИнформация.Объект = &Контрагент
	|				И КонтактнаяИнформация.Вид = &Вид) КАК ВложенныйЗапрос
	|			ПО Контрагенты.Ссылка = ВложенныйЗапрос.Объект
	|		ПО РеализацияТоваровУслуг.Контрагент = Контрагенты.Ссылка
	|ГДЕ
	|	РеализацияТоваровУслуг.Ссылка = &ТекущийДокумент";
	
	
	Шапка1 = ЗапросШапка.Выполнить().Выбрать();
	Шапка1.Следующий();
   	
	Шапка = Новый Структура;
	Шапка.Вставить("Дата",Шапка1.Дата);
	Шапка.Вставить("Номер",Шапка1.Номер);
	Шапка.Вставить("Адрес",Шапка1["Получатель"].Наименование+", " + Шапка1["Адрес"]);
	
	ЗапросТовары = Новый Запрос;
	ЗапросТовары.УстановитьПараметр("ТекущийДокумент", СсылкаНаОбъект.Ссылка);
	ЗапросТовары.Текст =
	"ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Количество,
	|	РеализацияТоваровУслуг.Номенклатура,
	|	ПаспортаПродукции.Путь
	|ИЗ
	|	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслуг
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПаспортаПродукции КАК ПаспортаПродукции
	|		ПО РеализацияТоваровУслуг.Номенклатура = ПаспортаПродукции.Номенклатура
	|ГДЕ
	|	РеализацияТоваровУслуг.Ссылка = &ТекущийДокумент
	|
	|УПОРЯДОЧИТЬ ПО
	|	РеализацияТоваровУслуг.НомерСтроки";

	ТаблицаУслуги = ЗапросТовары.Выполнить().Выгрузить();
	
	MSWord_Ссылка_на_Документ_1С = "Документ.";

	Для Каждого СтрокаТабличнойЧасти Из ТаблицаУслуги Цикл	
		
		Попытка
			Word = ПолучитьCOMОбъект(,"Word.Application");
		Исключение
			Word = Новый COMОбъект("Word.Application");
		КонецПопытки;	
		
		Word.Application.Visible = 1;
		Word.Application.Activate();
		
		ФайлПроверкаСуществования = Новый Файл(СтрокаТабличнойЧасти.Путь);
		Если ФайлПроверкаСуществования.Существует() Тогда
			Word.Application.Documents.Add(СтрокаТабличнойЧасти.Путь);
			сч1 = 1;
			Пока сч1 <= Word.Application.ActiveDocument.Fields.Count Цикл
				Если Word.Application.ActiveDocument.Fields(сч1).Type = 64 Тогда // 64 = wdFieldDocVariable
					
					ДокВар = СокрЛП(
					Сред(СокрЛП(Word.Application.ActiveDocument.Fields(сч1).Code.Text)
					, Найти(Word.Application.ActiveDocument.Fields(сч1).Code.Text, "DOCVARIABLE ")+СтрДлина("DOCVARIABLE ")-1
					, (Найти(Word.Application.ActiveDocument.Fields(сч1).Code.Text, "\*")-1) - (Найти(Word.Application.ActiveDocument.Fields(сч1).Code.Text, "DOCVARIABLE ")+СтрДлина("DOCVARIABLE ")-1)
					)
					);
					Если Лев(ДокВар,1) = """" Тогда
						ДокВар = Прав(ДокВар, СтрДлина(ДокВар)-1);
					КонецЕсли;	
					Если Прав(ДокВар,1) = """" Тогда 
						ДокВар = Лев(ДокВар, СтрДлина(ДокВар)-1);
					КонецЕсли;	
					ДокВар = СтрЗаменить(ДокВар,"\\\","\\");
					ДокВар = СтрЗаменить(ДокВар,"\\","\");
					//Сообщить("Переменная Word = "+ДокВар);
					Если Word.Application.ActiveDocument.Variables.Item(ДокВар) = Неопределено Тогда
						Word.Application.ActiveDocument.Variables.Add(ДокВар);
					КонецЕсли;
					
					ДокВар_Выражение1С = ДокВар;
					ДокВар_Выражение1С = СтрЗаменить(ДокВар_Выражение1С,"\\\","\\");
					ДокВар_Выражение1С = СтрЗаменить(ДокВар_Выражение1С,"\\","\");
					
					ДокВар_Выражение1С = СтрЗаменить(ДокВар_Выражение1С,"\""","""");
					Если Лев(ДокВар_Выражение1С,1) = """" Тогда
						ДокВар_Выражение1С = Прав(ДокВар_Выражение1С, СтрДлина(ДокВар_Выражение1С)-1);
					КонецЕсли;	
					Если Прав(ДокВар_Выражение1С,1) = """" Тогда 
						ДокВар_Выражение1С = Лев(ДокВар_Выражение1С, СтрДлина(ДокВар_Выражение1С)-1);
					КонецЕсли;
					
					//Если Лев(ДокВар_Выражение1С, СтрДлина(MSWord_Ссылка_на_Документ_1С)) = MSWord_Ссылка_на_Документ_1С Тогда
						Если ТипЗнч(Вычислить(ДокВар_Выражение1С)) = Тип("Дата") Тогда 
							ДокВар_Выражение1С = "Формат("+ДокВар_Выражение1С+",""ДФ=dd.MM.yyyy"")";
						КонецЕсли;
						Word.Application.ActiveDocument.Variables.Item(ДокВар).Value = Вычислить(ДокВар_Выражение1С);
					КонецЕсли;//Если Лев(ДокВар_Выражение1С, СтрДлина(MSWord_Ссылка_на_Документ_1С)) = MSWord_Ссылка_на_Документ_1С Тогда
				//КонецЕсли;	//Если Word.Application.ActiveDocument.Fields(сч1).Type = 64 Тогда 
				сч1 = сч1 + 1;
			КонецЦикла;//Пока сч1 <= Word.Application.ActiveDocument.Fields.Count Цикл
			Word.Application.ActiveDocument.Fields.Update();
		Иначе //Если ФайлПроверкаСуществования.Существует() Тогда
			Сообщить("Файл шаблона("+ФайлПроверкаСуществования.ПолноеИмя+") не обнаружен!", СтатусСообщения.Важное);
			Предупреждение("Файл шаблона("+ФайлПроверкаСуществования.ПолноеИмя+") не обнаружен!", 10, "Ошибка!");
		КонецЕсли;	//Если ФайлПроверкаСуществования.Существует() Тогда
		
		
		
		
		
	КонецЦикла;
	
	
	
КонецФункции // ПечатьАктаОбОказанииУслуг()
