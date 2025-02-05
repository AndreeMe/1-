#Область СлужебныйПрограммныйИнтерфейс

Функция АдресАСХ(НастройкаСклада) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НастройкаСклада, "Адрес");
	
КонецФункции // ()

Функция СоздатьПрокси(Интерфейс, МестоположениеWSDL, Адрес, Таймаут) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Попытка
		Определение = Новый WSОпределения(МестоположениеWSDL, , , ,Таймаут);  
	Исключение                                                                
		// почему-то не срабатывает с 1-го раза...
		Попытка
			Определение = Новый WSОпределения(МестоположениеWSDL, , , ,Таймаут);  
		Исключение
			Возврат ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		КонецПопытки;
		
	КонецПопытки;
	
	Попытка
		
		Сервис = Определение.Сервисы.Получить("http://www.dikom.ru/lift/integration/services/", Интерфейс);
		ИмяТочкиПодключения = Сервис.ТочкиПодключения[0].Имя;       
		
		Прокси = Новый WSПрокси(Определение, 
		"http://www.dikom.ru/lift/integration/services/",
		Интерфейс, ИмяТочкиПодключения,,Таймаут,,
		Адрес + "/lift/integration/services/" + Интерфейс);         
		
		
	Исключение                                                   
		
		Возврат ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Ложь);
		
	Возврат Прокси;
	
КонецФункции // ()

Функция Перевод(Текст) Экспорт 
	
	Результат = "";
	
	Если Текст = "PRELOADING" Тогда
		Результат = "предварительная загрузка";	
	ИначеЕсли Текст = "READY_TO_LOAD" Тогда
		Результат = "готово к загрузке"; 
	ИначеЕсли Текст = "LOADING" Тогда
		Результат = "загрузка"; 
	ИначеЕсли Текст = "READY_TO_UNLOAD" Тогда      
		Результат = "готово к выгрузке"; 
	ИначеЕсли Текст = "UNLOADING" Тогда
		Результат = "выгрузка"; 
	ИначеЕсли Текст = "PAUSE" Тогда
		Результат = "пауза"; 
	ИначеЕсли Текст = "COMPLETED" Тогда
		Результат = "выполнено"; 
	ИначеЕсли Текст = "NOT_STARTED" Тогда         
		Результат = "не начато"; 
	ИначеЕсли Текст = "PARTLY_DONE" Тогда      
		Результат = "частично выполнено"; 
	ИначеЕсли Текст = "INSUFFICIENCY" Тогда         
		Результат = "недостаточно"; 
	ИначеЕсли Текст = "NO_SPACE" Тогда
		Результат = "нет места";
	КонецЕсли;	
	
	Возврат Результат;
	
КонецФункции // ()

Функция ЭтоСкладЛифт(Склад) Экспорт
	// может вызываться из основной конфигурации для условной настройки форм...
	Возврат Справочники.дкл_НастройкиСкладовЛифтов.ЭтоСкладЛифт(Склад);
КонецФункции // ()

Функция БуквенныйКодСтатусаЛифта(Код) Экспорт
	
	// коды                         
	// === в работе ===
	// 0 - АСХ находится в состоянии покоя.
	// 1 - Выполняется операция. 
	// === в работе ===
	// 2 - Есть неполадки, мешающие работе АСХ.
	// (теперь нужен код, т.к. надо отображать все состояния)

	Если Код = 0 Тогда
		Возврат "RDY";
	ИначеЕсли Код = 1 Тогда
		Возврат "MOV";
	ИначеЕсли Код > 1 Тогда
		Возврат "ERR";
	КонецЕсли;
	
КонецФункции

Функция БуквенныйКодСтатусаОперациииСПолкой(Код) Экспорт
	
	// 0- выполнено.
	// 1- выполняется.
	// 2 - Техническая ошибка (поломка) в Лифте.
	// 3 - Ошибка в API и передаваемых запросах.
	// 4. АСХ занят выполнением другой операции.
	// 5- Превышены допустимые характеристики груза (вес, высота).
	// 6- Тайм-аут. Подвисший запрос.	
	
	Если Код = 0 Тогда
		Возврат "RDY";
	ИначеЕсли Код = 1 Тогда
		Возврат "MOV";
	ИначеЕсли Код > 1 Тогда
		Возврат "ERR";
	КонецЕсли;
	
КонецФункции


#КонецОбласти

