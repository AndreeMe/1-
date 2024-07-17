#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ИзменениеНоменклатурыСкладаЛифта" Тогда 
		Элементы.НоменклатураСклада.Обновить();
		// обязательно надо отправить именения в лифт, иначе 
		// 	могут отправить ордер, ошибок не будет,
		// 	но на стороне лифта он не обработается... 
		ВыгрузитьНоменклатуруСклада();		
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЛинииСтеллажиСклада = ЛинииСтеллажиСклада(Объект.Ссылка, Объект.Склад, Объект.Линия);
	
	Элементы.Стеллаж.СписокВыбора.ЗагрузитьЗначения(ЛинииСтеллажиСклада.Стеллажи);
	Элементы.Линия.СписокВыбора.ЗагрузитьЗначения(ЛинииСтеллажиСклада.Линии);
		
	УстановитьОтбор();     

	//@skip-check using-isinrole
	Если НЕ РольДоступна(Метаданные.Роли.дкл_Администратор) 
			И НЕ РольДоступна(Метаданные.Роли.ПолныеПрава) Тогда
		ТолькоПросмотр = Истина;
		Элементы.ПолкиОбновитьСписокПолок.Доступность = Ложь;
		Элементы.СтрокаСоединенияКнопка.Доступность = Ложь;
		Элементы.СкладскиеЯчейкиОбновитьСписокСкладскихЯчеек.Доступность = Ложь;
		Элементы.СкладскиеЯчейкиОтправитьВАСХСписокЯчеек.Доступность = Ложь;
		Элементы.СкладскиеЯчейкиУдалитьИзАСХ.Доступность = Ложь;
	КонецЕсли;
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьДекорациюПодСтрокойСоединения();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтрокаСоединенияПриИзменении(Элемент)
	УстановитьДекорациюПодСтрокойСоединения();
КонецПроцедуры

&НаКлиенте
Процедура СкладПриИзменении(Элемент)                 
	ЛинииСтеллажиСклада = ЛинииСтеллажиСклада(Объект.Ссылка, Объект.Склад, Объект.Линия);
	Элементы.Стеллаж.СписокВыбора.ЗагрузитьЗначения(ЛинииСтеллажиСклада.Стеллажи);
	Элементы.Линия.СписокВыбора.ЗагрузитьЗначения(ЛинииСтеллажиСклада.Линии);
	УстановитьОтбор();       
	УстановитьНаименование();
	УстановитьВидимостьДоступность();
КонецПроцедуры

&НаКлиенте
Процедура СтеллажПриИзменении(Элемент)
	УстановитьНаименование();
КонецПроцедуры

&НаКлиенте
Процедура СтеллажНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ДанныеВыбора = Новый СписокЗначений;
	ЛинииСтеллажиСклада = ЛинииСтеллажиСклада(Объект.Ссылка, Объект.Склад, Объект.Линия);
	ДанныеВыбора.ЗагрузитьЗначения(ЛинииСтеллажиСклада.Стеллажи);
КонецПроцедуры

&НаКлиенте
Процедура ЛинияПриИзменении(Элемент)
	УстановитьНаименование();
КонецПроцедуры

&НаКлиенте
Процедура ЛинияНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ДанныеВыбора = Новый СписокЗначений;
	ЛинииСтеллажиСклада = ЛинииСтеллажиСклада(Объект.Ссылка, Объект.Склад, Объект.Линия);
	ДанныеВыбора.ЗагрузитьЗначения(ЛинииСтеллажиСклада.Линии);
КонецПроцедуры

&НаКлиенте
Процедура АдресПриИзменении(Элемент)                   
	Если НЕ Лев(Объект.Адрес, 7) = "http://" Тогда 
		Объект.Адрес = "http://" + Объект.Адрес;
	КонецЕсли;                             
	Если Прав(Объект.Адрес, 1) = "/" Тогда 
		Объект.Адрес = Лев(Объект.Адрес, СтрДлина(Объект.Адрес) - 1);
	КонецЕсли;                             
	Объект.МестоположениеWSDL = Объект.Адрес + "/lift/integration/services/externalIntegration.wsdl";
КонецПроцедуры

&НаКлиенте
Процедура ВерсияПОПриИзменении(Элемент)
	УстановитьВидимостьДоступность();
КонецПроцедуры

&НаКлиенте
Процедура СпособПодключенияПриИзменении(Элемент)
	УстановитьВидимостьДоступность();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПолки

&НаКлиенте
Процедура ПолкиПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Полки.ТекущиеДанные;

	Если ТекущиеДанные = Неопределено Тогда
		СостояниеПолки = Неопределено;
		Возврат;
	КонецЕсли;
	
	СостояниеПолки = ПолкиПриАктивизацииСтрокиНаСервере(Объект.Ссылка, ТекущиеДанные.trayNumber);    
	
КонецПроцедуры

&НаКлиенте
Процедура ПолкиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СтрокаСоединения(Команда)
	Объект.СтрокаСоединения = СтрокаСоединенияИнформационнойБазы();
	УстановитьДекорациюПодСтрокойСоединения();	
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)

	ПараметрыФормы = Новый Структура("УникальныйИдентификатор", УникальныйИдентификатор);
	ПараметрыФормы.Вставить("ОтключитьХарактеристики", НЕ ИспользоватьХарактеристки());
	ОписаниеОповещенияОЗакрытии = Новый ОписаниеОповещения("ДобавитьТоварыПоОтборуЗавершение", ЭтотОбъект);
	ОткрытьФорму("Обработка.ПодборТоваровПоОтбору.Форма", ПараметрыФормы, ЭтотОбъект,,,,ОписаниеОповещенияОЗакрытии);
	
КонецПроцедуры

&НаКлиенте
Процедура СостояниеПолки(Команда)

	ТекущиеДанные = Элементы.Полки.ТекущиеДанные;

	Если ТекущиеДанные = Неопределено Тогда
		СостояниеПолки = Неопределено;
		Возврат;
	КонецЕсли;
	
//	СостояниеПолкиНаСервере(Объект.Ссылка, ТекущиеДанные.trayNumber);    
	
КонецПроцедуры

&НаКлиенте
Процедура ВыдачаПолки(Команда)
	
	ТекущиеДанные = Элементы.Полки.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	//@skip-check bsl-variable-name-invalid
	requestId = Неопределено;
	
	Ответ = ВыдачаПолкиНаСервере(Объект.Ссылка, ТекущиеДанные.trayNumber, requestId);

	Если НЕ Ответ.Статус = 0 ИЛИ Ответ.Текст = "Операция выполняется" Тогда
		
		//@skip-check bsl-variable-name-invalid
		Сч = 0;
		Пока (НЕ Ответ.Статус = 0 ИЛИ Ответ.Текст = "Операция выполняется") И Сч < 60 Цикл

			Ответ = СостояниеЗапросНаСервере(Объект.Ссылка, requestId);
			Сч = Сч + 1;               

			Если Ответ.Статус = 2 Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;

	ОбщегоНазначенияКлиент.СообщитьПользователю(Ответ.Текст);

КонецПроцедуры

&НаКлиенте
Процедура ВозвратПолки(Команда)
	
	ТекущиеДанные = Элементы.Полки.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	//@skip-check bsl-variable-name-invalid
	requestId = Неопределено;

	Ответ = ВозвратПолкиНаСервере(Объект.Ссылка, ТекущиеДанные.trayNumber, requestId);
	
	Если НЕ Ответ.Статус = 0  ИЛИ Ответ.Текст = "Операция выполняется" Тогда
		
		//@skip-check bsl-variable-name-invalid
		Сч = 0;
		Пока (НЕ Ответ.Статус = 0 ИЛИ Ответ.Текст = "Операция выполняется") И Сч < 60 Цикл

			Ответ = СостояниеЗапросНаСервере(Объект.Ссылка, requestId);
			Сч = Сч + 1;
			
			Если Ответ.Статус = 2 Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;

	ОбщегоНазначенияКлиент.СообщитьПользователю(Ответ.Текст);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписокПолок(Команда) 
	
	Если Объект.Ссылка.Пустая() Тогда
		
		//@skip-check bsl-nstr-string-literal-format
		ТекстВопроса = НСтр("ru = 'Необходимо записать настройку склада. Продолжить?';
							|en = 'It needs to record this warehouse setup. Continue?'");
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗаписатьНастройкуСкладаЗавершение", ЭтотОбъект);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Возврат;
		
	Иначе
		ОбновитьСписокПолокНаСервере();
		Элементы.Полки.Обновить();
	КонецЕсли;
	
КонецПроцедуры                  

&НаКлиенте
Процедура ОбновитьСписокСкладскихЯчеек(Команда)
	
	Если Объект.Ссылка.Пустая() Тогда
		
		//@skip-check bsl-nstr-string-literal-format
		ТекстВопроса = НСтр("ru = 'Необходимо записать настройку склада. Продолжить?';
							|en = 'It needs to record this warehouse setup. Continue?'");
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗаписатьНастройкуСкладаЗавершение", ЭтотОбъект);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Возврат;
		
	Иначе
		ОбновитьСписокСкладскихЯчеекНаСервере();
		Элементы.СкладскиеЯчейкиПоказатьВсе.Пометка = Истина;
		УстановитьОтбор();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьВАСХСписокЯчекк(Команда)

	Если Модифицированность Тогда
		Записать();
	КонецЕсли;
	
	ОтправитьВАСХСписокЯчеекНаСервере();
	
	Элементы.СкладскиеЯчейки.Обновить();
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьИзАСХ(Команда)
	
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;
	
	МассивСкладскиеЯчейки = Новый Массив;
	Для Каждого ТекущаяСтрока Из Элементы.СкладскиеЯчейки.ВыделенныеСтроки Цикл   
		Элементы.СкладскиеЯчейки.ТекущаяСтрока = ТекущаяСтрока;   
		СкладскаяЯчейка = Элементы.СкладскиеЯчейки.ДанныеСтроки(ТекущаяСтрока).СкладскаяЯчейка;
		МассивСкладскиеЯчейки.Добавить(СкладскаяЯчейка);
	КонецЦикла;
	УдалитьИзАСХНаСервере(Объект.Ссылка, МассивСкладскиеЯчейки);	
	
	Элементы.СкладскиеЯчейки.Обновить();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ИспользоватьХарактеристки() 
	ПараметрыОпции = Новый Структура("НастройкаСклада", Объект.Ссылка); 
	Возврат ПолучитьФункциональнуюОпцию("дкл_ИспользоватьХарактеристики", ПараметрыОпции);
КонецФункции

&НаКлиенте
Процедура ДобавитьТоварыПоОтборуЗавершение(Результат, ДополнительныеПараметры) Экспорт 

	Если НЕ ЭтоАдресВременногоХранилища(Результат) Тогда
		Возврат;
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(Результат) Тогда
		ДобавитьТоварыИзВременногоХранилищаНаСервере(Результат, Истина);
	КонецЕсли;

КонецПроцедуры                                                                

&НаСервере
Процедура УстановитьОтбор()

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		НоменклатураСклада, "НастройкаСклада", Объект.Ссылка, ВидСравненияКомпоновкиДанных.Равно, Истина);

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		ПользователиСклада, "НастройкаСклада", Объект.Ссылка, ВидСравненияКомпоновкиДанных.Равно, Истина);

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Полки, "НастройкаСклада", Объект.Ссылка, ВидСравненияКомпоновкиДанных.Равно, Истина);

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		СкладскиеЯчейки, "НастройкаСклада", Объект.Ссылка, ВидСравненияКомпоновкиДанных.Равно, Истина); 
		
	Если Элементы.СкладскиеЯчейкиПоказатьВсе.Пометка Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СкладскиеЯчейки, "ПараметрыЗаполнены", Истина, ВидСравненияКомпоновкиДанных.Равно, , Ложь); 
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			СкладскиеЯчейки, "ПараметрыЗаполнены", Истина, ВидСравненияКомпоновкиДанных.Равно, , Истина); 
	КонецЕсли;		
	
	Элементы.НоменклатураСклада.Обновить();
	Элементы.ПользователиСклада.Обновить();
	Элементы.СкладскиеЯчейки.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность()
	Если Лев(Объект.ВерсияПО, 1) = "2" И ЗначениеЗаполнено(Объект.Склад) Тогда
		Элементы.ГруппаСкладскиеЯчейки.Видимость = Истина;
	Иначе
		Элементы.ГруппаСкладскиеЯчейки.Видимость = Ложь;
	КонецЕсли;
	Если Объект.СпособПодключения = Перечисления.дкл_СпособПодключения.HTTP Тогда
		Элементы.МестоположениеWSDL.Видимость = Ложь;
	Иначе
		Элементы.МестоположениеWSDL.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДекорациюПодСтрокойСоединения()
	
	Если НЕ Объект.СтрокаСоединения = СтрокаСоединенияИнформационнойБазы() Тогда 
		Элементы.СтрокаСоединенияДекорация.Заголовок = 
		 "Строки соединения не совпадают, обмена данными с лифтом не будет.";
	Иначе 
		Элементы.СтрокаСоединенияДекорация.Заголовок = ""; 		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЛинииСтеллажиСклада(НастройкаСклада, Склад, Линия = Неопределено)
	
	//2.2) При пустом значении в Линии, 
	//	Стеллажи выводим из ячеек, где пустая  линия
	//
	//2.3) Если выбрана значение в Линии, 
	//   то в Стеллаже даем выбирать только те варианты, которые относятся к этой Линии. 
	
	Результат = Новый Структура("Линии, Стеллажи", Новый Массив, Новый Массив); 
	
	//@skip-check wrong-string-literal-content
	Если НЕ ЗначениеЗаполнено(Склад) 
			ИЛИ НЕ ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Склад, "ИспользоватьАдресноеХранение") Тогда
		Возврат Результат;
	КонецЕсли;
	
	Если Линия = Неопределено Тогда
		Линия = "";
	КонецЕсли;
	
	Запрос = Новый Запрос;           
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка"			, НастройкаСклада);
	Запрос.УстановитьПараметр("Склад" 			, Склад);          
	Запрос.УстановитьПараметр("ЛинияДляОтбора"	, Линия); // ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НастройкаСклада, "Линия"));
	//Запрос.УстановитьПараметр("СтеллажДляОтбора", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НастройкаСклада, "Стеллаж"));
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	дкл_НастройкиСкладовЛифтов.Линия КАК Линия,
	|	дкл_НастройкиСкладовЛифтов.Стеллаж КАК Стеллаж
	|ПОМЕСТИТЬ ЗанятыеЯчейкиСклада
	|ИЗ
	|	Справочник.дкл_НастройкиСкладовЛифтов КАК дкл_НастройкиСкладовЛифтов
	|ГДЕ
	|	дкл_НастройкиСкладовЛифтов.Ссылка <> &Ссылка
	|	И НЕ дкл_НастройкиСкладовЛифтов.ПометкаУдаления
	|	И дкл_НастройкиСкладовЛифтов.Склад = &Склад
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СкладскиеЯчейки.Линия КАК Линия,
	|	СкладскиеЯчейки.Стеллаж КАК Стеллаж
	|ПОМЕСТИТЬ СвободныеЯчейкиСклада
	|ИЗ
	|	Справочник.СкладскиеЯчейки КАК СкладскиеЯчейки
	|ГДЕ
	|	НЕ (СкладскиеЯчейки.Линия, СкладскиеЯчейки.Стеллаж) В
	|				(ВЫБРАТЬ
	|					ЗанятыеЯчейкиСклада.Линия,
	|					ЗанятыеЯчейкиСклада.Стеллаж
	|				ИЗ
	|					ЗанятыеЯчейкиСклада КАК ЗанятыеЯчейкиСклада)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ 
	|	СвободныеЯчейкиСклада.Стеллаж КАК Стеллаж
	|ИЗ
	|	СвободныеЯчейкиСклада КАК СвободныеЯчейкиСклада
	|ГДЕ
	|	СвободныеЯчейкиСклада.Линия = &ЛинияДляОтбора
	|
	|УПОРЯДОЧИТЬ ПО
	|	Стеллаж
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ 
	|	СвободныеЯчейкиСклада.Линия КАК Линия
	|ИЗ
	|	СвободныеЯчейкиСклада КАК СвободныеЯчейкиСклада
	|
	|УПОРЯДОЧИТЬ ПО
	|	Линия";             
	
	РезультатЗапроса   = Запрос.ВыполнитьПакет();                             
	Результат.Линии    = РезультатЗапроса[РезультатЗапроса.Количество() - 1].Выгрузить().ВыгрузитьКолонку("Линия");
	Результат.Стеллажи = РезультатЗапроса[РезультатЗапроса.Количество() - 2].Выгрузить().ВыгрузитьКолонку("Стеллаж");
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура УстановитьНаименование()                         
	
	Если ЗначениеЗаполнено(Объект.Наименование) Тогда
		Возврат;
	КонецЕсли;

	Если ЗначениеЗаполнено(Объект.Склад) И ЗначениеЗаполнено(Объект.Стеллаж) Тогда
		Объект.Наименование = Строка(Объект.Склад) + ", стеллаж " + Строка(Объект.Стеллаж);
	ИначеЕсли ЗначениеЗаполнено(Объект.Склад) И ЗначениеЗаполнено(Объект.Линия) Тогда
		Объект.Наименование = Строка(Объект.Склад) + ", линия " + Строка(Объект.Линия);
	КонецЕсли;                           
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТоварыИзВременногоХранилищаНаСервере(АдресВоВременномХранилище, ДополнятьТаблицуТоваров)
	
	ТаблицаТоваров = ПолучитьИзВременногоХранилища(АдресВоВременномХранилище);
	ДанныеНастройкиСклада = Справочники.дкл_НастройкиСкладовЛифтов.ДанныеНастройкиСклада(Объект.Ссылка);
	Справочники.дкл_НастройкиСкладовЛифтов.ДобавитьНоменклатуруВНастройкуСклада(ТаблицаТоваров, ДанныеНастройкиСклада);
	
КонецПроцедуры

&НаСервере
Процедура ВыгрузитьНоменклатуруСклада()
	дкл_ОбменДаннымиСервер.ВыгрузитьНоменклатуруСклада(Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьНастройкуСкладаЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ = РезультатВопроса;
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ОчиститьСообщения();
		ЭлементЗаписан = Записать();
	Иначе 
		Возврат
	КонецЕсли;
	
	Если Не ЭлементЗаписан Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьСписокПолокНаСервере();
	Элементы.Полки.Обновить();
	
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
&НаСервереБезКонтекста
Функция ВыдачаПолкиНаСервере(НастройкаСклада, НомерПолки, requestId)
	Возврат дкл_ОбменДаннымиСервер.ВыдатьПолку(НастройкаСклада, НомерПолки, requestId);
КонецФункции

//@skip-check bsl-variable-name-invalid
&НаСервереБезКонтекста
Функция ВозвратПолкиНаСервере(НастройкаСклада, НомерПолки, requestId)
	Возврат дкл_ОбменДаннымиСервер.ВернутьПолку(НастройкаСклада, НомерПолки, requestId);
КонецФункции

//@skip-check bsl-variable-name-invalid
&НаСервереБезКонтекста
Функция СостояниеЗапросНаСервере(НастройкаСклада, requestId)

	Возврат дкл_ОбменДаннымиСервер.СостояниеЗапроса(НастройкаСклада, requestId);
	
КонецФункции

&НаСервере
Процедура ОбновитьСписокПолокНаСервере()
	
	Результат = дкл_ОбменДаннымиСервер.ПолучитьСписокПолокСкладаЛифта(Объект.Ссылка); 
	
	trayNumber = Новый Массив;
	
	Если ТипЗнч(Результат) = Тип("Структура") И Результат.Свойство("tray") Тогда
		trays = Результат.tray;
	ИначеЕсли ТипЗнч(Результат) = Тип("Массив") Тогда
		trays = Результат;        
	Иначе
		Возврат;
	КонецЕсли;   
	
	Для каждого Стр Из trays Цикл
		
		trayNumber.Добавить(Стр.trayNumber);
		
		НаборЗаписей = РегистрыСведений.дкл_Полки.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.НастройкаСклада.Установить(Объект.Ссылка);
		НаборЗаписей.Отбор.trayNumber.Установить(Стр.trayNumber);
		НаборЗаписей.Прочитать();
		Если НЕ НаборЗаписей.Количество() = 0 Тогда
			ТекущаяЗапись = НаборЗаписей[0];
		Иначе
			ТекущаяЗапись = НаборЗаписей.Добавить();
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ТекущаяЗапись, Стр);
		ТекущаяЗапись.НастройкаСклада = Объект.Ссылка;
		НаборЗаписей.Записать();
	
	КонецЦикла;
	
	// удалить полки, которых нет в лифте...
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	дкл_Полки.НастройкаСклада КАК НастройкаСклада,
		|	дкл_Полки.trayNumber КАК trayNumber
		|ИЗ
		|	РегистрСведений.дкл_Полки КАК дкл_Полки
		|ГДЕ
		|	дкл_Полки.НастройкаСклада = &НастройкаСклада
		|	И НЕ дкл_Полки.trayNumber В(&trayNumber)";
	
	Запрос.УстановитьПараметр("trayNumber", trayNumber);
	Запрос.УстановитьПараметр("НастройкаСклада", Объект.Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		НаборЗаписей = РегистрыСведений.дкл_Полки.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.НастройкаСклада.Установить(Выборка.НастройкаСклада);
		НаборЗаписей.Отбор.trayNumber.Установить(Выборка.trayNumber);
		НаборЗаписей.Записать();
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСписокСкладскихЯчеекНаСервере()
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Возврат;
	КонецЕсли;
	//Результат = дкл_ОбменДаннымиСервер.ПолучитьСписокМестХраненияСкладаЛифта(Объект.Ссылка); 
	//
	//Если НЕ ТипЗнч(Результат) = Тип("Структура") ИЛИ НЕ Результат.Свойство("storage") Тогда
	//	Возврат;	
	//КонецЕсли;
	//
	//Для каждого Стр Из Результат.storage Цикл
	//	
	//	НаборЗаписей = РегистрыСведений.дкл_СкладскиеЯчейки.СоздатьНаборЗаписей();
	//	НаборЗаписей.Отбор.НастройкаСклада.Установить(Объект.Ссылка);
	//	НаборЗаписей.Отбор.storageId.Установить(Стр.storageId);
	//	НаборЗаписей.Прочитать();
	//	Если НЕ НаборЗаписей.Количество() = 0 Тогда
	//		ТекущаяЗапись = НаборЗаписей[0];
	//	Иначе
	//		ТекущаяЗапись = НаборЗаписей.Добавить();
	//	КонецЕсли;
	//	
	//	ЗаполнитьЗначенияСвойств(ТекущаяЗапись, Стр);
	//	ТекущаяЗапись.НастройкаСклада = Объект.Ссылка;
	//	НаборЗаписей.Записать();
	//
	//КонецЦикла;

	Выборка = РегистрыСведений.дкл_СкладскиеЯчейки.СкладскиеЯчейкиСклада(Объект.Склад);
	
	Пока Выборка.Следующий()  Цикл

		НаборЗаписей = РегистрыСведений.дкл_СкладскиеЯчейки.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.НастройкаСклада.Установить(Объект.Ссылка);
		НаборЗаписей.Отбор.СкладскаяЯчейка.Установить(Выборка.Ссылка);
		НаборЗаписей.Прочитать();
		Если НЕ НаборЗаписей.Количество() = 0 Тогда
			ТекущаяЗапись = НаборЗаписей[0];
		Иначе
			ТекущаяЗапись = НаборЗаписей.Добавить();
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ТекущаяЗапись, Выборка);
		ТекущаяЗапись.НастройкаСклада = Объект.Ссылка;
		
		Если НЕ ЗначениеЗаполнено(ТекущаяЗапись.storageId) Тогда
			ТекущаяЗапись.storageId = Новый УникальныйИдентификатор;	
		КонецЕсли;                 
		
		НаборЗаписей.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолкиПриАктивизацииСтрокиНаСервере(НастройкаСклада, НомерПолки)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	дкл_СостояниеПолки.Состояние КАК Состояние
		|ИЗ
		|	РегистрСведений.дкл_СостояниеПолки КАК дкл_СостояниеПолки
		|ГДЕ
		|	дкл_СостояниеПолки.НастройкаСклада = &НастройкаСклада
		|	И дкл_СостояниеПолки.НомерПолки = &НомерПолки";
	
	Запрос.УстановитьПараметр("НастройкаСклада", НастройкаСклада);
	Запрос.УстановитьПараметр("НомерПолки", НомерПолки);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ВыборкаДетальныеЗаписи.Следующий();

	Возврат ВыборкаДетальныеЗаписи.Состояние;
	
КонецФункции

&НаСервере
Процедура ОтправитьВАСХСписокЯчеекНаСервере()
	
	МассивСкладскиеЯчейки = Новый Массив;
	
	Для Каждого ТекущиеДанные Из Элементы.СкладскиеЯчейки.ВыделенныеСтроки Цикл
		Если НЕ ПроверитьЗаполнениеЯчейки(Объект.Ссылка, ТекущиеДанные.СкладскаяЯчейка) Тогда
			Текст = "Не заполнены обязательные парамеры ячейки %1 (номер полки, размеры или положение)";
			Текст = СтрШаблон(Текст, Строка(ТекущиеДанные.СкладскаяЯчейка));
			ОбщегоНазначения.СообщитьПользователю(Текст);
			Продолжить;
		КонецЕсли;
		МассивСкладскиеЯчейки.Добавить(ТекущиеДанные.СкладскаяЯчейка);
	КонецЦикла;
	
	РегистрыСведений.дкл_СкладскиеЯчейки.ОтправитьВАСХ(Объект.Ссылка, МассивСкладскиеЯчейки);  
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УдалитьИзАСХНаСервере(Знач НастройкаСклада, Знач МассивСкладскиеЯчейки)
	РегистрыСведений.дкл_СкладскиеЯчейки.УдалитьИзАСХ(НастройкаСклада, МассивСкладскиеЯчейки);  
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроверитьЗаполнениеЯчейки(Знач НастройкаСклада, Знач СкладскаяЯчейка)
	Возврат РегистрыСведений.дкл_СкладскиеЯчейки.ПроверитьЗаполение(НастройкаСклада, СкладскаяЯчейка);
КонецФункции

&НаКлиенте
Процедура ПоказатьВсе(Команда)
	Элементы.СкладскиеЯчейкиПоказатьВсе.Пометка = НЕ Элементы.СкладскиеЯчейкиПоказатьВсе.Пометка;
	УстановитьОтбор();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СравнитьСЭталономНаСервере(ИмяСервиса, МестоположениеWSDL)
	Обработки.дкл_СравнитьВебСервисы.СравнитьВебСервисы(ИмяСервиса, МестоположениеWSDL);
КонецПроцедуры

&НаКлиенте
Процедура СравнитьСЭталоном(Команда)    
	Если Объект.ВерсияПО = "1.6" Тогда	  
		ИмяСервиса = "ExternalIntegration_16";
	ИначеЕсли Лев(Объект.ВерсияПО, 2) = "2." Тогда
		ИмяСервиса = "ExternalIntegration_21";
	КонецЕсли;
	СравнитьСЭталономНаСервере(ИмяСервиса, Объект.МестоположениеWSDL);
КонецПроцедуры

#КонецОбласти    
