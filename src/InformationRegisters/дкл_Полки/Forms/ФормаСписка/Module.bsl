#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "дкл_СписокНастроекСкладовЛифтов" Тогда
		 ОбновитьСтатусЛифта();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	НомерСтатусаЛифта = 0;
	БлокироватьКнопки = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)  

	дкл_ФормыКлиент.ЗаблокироватьКнопки(ЭтотОбъект);    

	УстановитьВидимостьДоступность();
	УстановитьОтбор();         
	УстановитьЗоныВыбораИВидАСХ(); 
	
	Если НЕ дкл_ФормыВызовСервера.ПроверитьСтрокуСоединения(НастройкаСкладаЛифта) Тогда
		Возврат;	
	КонецЕсли;

	ВерсияПО = дкл_ФормыВызовСервера.ВерсияПО(НастройкаСкладаЛифта);
	
	Если ВерсияПО = "1.6" ИЛИ Лев(ВерсияПО, 2) = "2." Тогда
		
		ОбновлениеСтатусов();
		
		СлучайноеЧисло = 15;
		
		#Если НЕ ВебКлиент Тогда 
			ГСЧ = Новый ГенераторСлучайныхЧисел();
			СлучайноеЧисло = ГСЧ.СлучайноеЧисло(1500, 2500) / 100;
		#КонецЕсли  
		
		Если дкл_ФормыВызовСервера.ПроверитьСоединение(НастройкаСкладаЛифта) Тогда
			ЕстьСоединение = Истина;
			ПодключитьОбработчикОжидания("ОбновлениеСтатусов", СлучайноеЧисло, Ложь);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НастройкаСкладаЛифтаПриИзменении(Элемент)
	
	НомерСтатусаЛифта = 0;
	
	дкл_ФормыКлиент.ЗаблокироватьКнопки(ЭтотОбъект);
	
	ВерсияПО = дкл_ФормыВызовСервера.ВерсияПО(НастройкаСкладаЛифта);

	Возвращена.Очистить();
	Выдана.Очистить();
	Ошибка.Очистить();

	ОбновлениеСтатусов();
	
	УстановитьВидимостьДоступность();
	УстановитьОтбор();
	УстановитьЗоныВыбораИВидАСХ();  
	
	дкл_ФормыКлиент.УстановитьДоступностьКнопокДляТекущейПолки(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	дкл_ФормыКлиент.УстановитьДоступностьКнопокДляТекущейПолки(ЭтотОбъект);
	ТекушаяСтрока = Элементы.Список.ТекущиеДанные;
	Если НЕ ТекушаяСтрока = Неопределено Тогда
		Элементы.ТекущийНомерПолки.Заголовок = "№ полки: " + ТекушаяСтрока.trayNumber;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьСтатусы(Команда)
	ОбновлениеСтатусов();
КонецПроцедуры

&НаКлиенте
Процедура ВозвратПолки(Команда)

	дкл_ФормыКлиент.ЗаблокироватьКнопки(ЭтотОбъект);
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;

	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;      
	
	trayNumber = ТекущиеДанные.trayNumber;
	
	ПоместитьНомерПолкиВСписок(trayNumber, "Перемещается");
	Элементы.Список.Обновить();   

	ПодключитьОбработчикОжидания("ВозвратПолкиПродолжение", 1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыдачаПолки(Команда)

	дкл_ФормыКлиент.ЗаблокироватьКнопки(ЭтотОбъект);
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;

	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;      

	trayNumber = ТекущиеДанные.trayNumber;
	
	ПоместитьНомерПолкиВСписок(trayNumber, "Перемещается");
	Элементы.Список.Обновить();   
	
	ПодключитьОбработчикОжидания("ВыдачаПолкиПродолжение", 1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновлениеСтатусов() Экспорт
	
	дкл_ФормыКлиент.ЗаблокироватьКнопки(ЭтотОбъект);

	ОбновитьСтатусЛифта(); 
	
	ОбновитьСтатусаПолокНаСервере(НастройкаСкладаЛифта);  
	
	дкл_ФормыКлиент.РазблокироватьКнопки(ЭтотОбъект);
	
	дкл_ФормыКлиент.УстановитьДоступностьКнопокДляТекущейПолки(ЭтотОбъект);
	
	Элементы.Список.Обновить();

КонецПроцедуры

&НаСервере
Процедура ОбновитьСтатусаПолокНаСервере(НастройкаСкладаЛифта)
	
	Если ВерсияПО = "1.6" ИЛИ Лев(ВерсияПО, 2) = "2." Тогда
		Выдана.ЗагрузитьЗначения(
			РегистрыСведений.дкл_Полки.НомераВыданныхПолок(НастройкаСкладаЛифта));
	КонецЕсли;

	Ошибка.Очистить();
	Перемещается.Очистить();
	УстановитьОтбор();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтатусЛифта()         
	дкл_ФормыКлиент.ОбновитьСтатусЛифта(ЭтотОбъект);
КонецПроцедуры  

&НаКлиенте
Процедура ВыдачаПолкиПродолжение() Экспорт

	requestId = Неопределено;
	
	Ответ = дкл_ФормыВызовСервера.ВыдачаПолкиНаСервере(НастройкаСкладаЛифта, trayNumber, requestId, ЗонаВыдачи);
	
	Если Ответ = Неопределено Тогда
		Возврат;	
	КонецЕсли;

	Если Ответ.Статус = 0 Тогда // выполняется, 1 - выполнено, 2 и больше - ошибка
		
		Сч = 0;
		
		Пока Ответ.Статус = 0 И Сч < 100 Цикл

			Ответ = дкл_ФормыВызовСервера.СостояниеЗапросНаСервере(НастройкаСкладаЛифта, requestId);
			
			Сч = Сч + 1;               

		КонецЦикла;
		
	КонецЕсли;
	
	Если Ответ = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Если Ответ.Статус = 1 Тогда
		Выдана.Очистить();
		Ошибка.Очистить();
		ПоместитьНомерПолкиВСписок(trayNumber, "Выдана");
		// подкрасить лифт зеленым...            
		НомерСтатуса = 2;
		УстановитьКартинкуБезПроверкиСкладаЛифта(НомерСтатуса)         
	Иначе
		ОбщегоНазначенияКлиент.СообщитьПользователю(Ответ.Текст);     
		ПоместитьНомерПолкиВСписок(trayNumber, "Ошибка");
		// подкрасить лифт желтым...
		НомерСтатуса = 3;
		УстановитьКартинкуБезПроверкиСкладаЛифта(НомерСтатуса)         
	КонецЕсли;

	Элементы.Список.Обновить();   
	
	дкл_ФормыКлиент.РазблокироватьКнопки(ЭтотОбъект);
	
	дкл_ФормыКлиент.УстановитьДоступностьКнопокДляТекущейПолки(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ВозвратПолкиПродолжение() Экспорт

	requestId = Неопределено;

	Ответ = дкл_ФормыВызовСервера.ВозвратПолкиНаСервере(НастройкаСкладаЛифта, trayNumber, requestId);
	
	Если Ответ = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Если Ответ.Статус = 0 Тогда // выполняется
		
		Сч = 0;
		
		Пока НЕ Ответ.Статус = 0 И Сч < 60 Цикл

			Ответ = дкл_ФормыВызовСервера.СостояниеЗапросНаСервере(НастройкаСкладаЛифта, requestId);
			
			Сч = Сч + 1;               

			Если Ответ.Статус = 2 Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Если Ответ = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	Если НЕ Ответ.Статус = 0 И НЕ Ответ.Статус = 1 Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(Ответ.Текст);     
		ПоместитьНомерПолкиВСписок(trayNumber, "Ошибка");
	Иначе                                                             
		ПоместитьНомерПолкиВСписок(trayNumber, "Возвращена");
	КонецЕсли;
	
	дкл_ФормыКлиент.РазблокироватьКнопки(ЭтотОбъект);
	
	дкл_ФормыКлиент.УстановитьДоступностьКнопокДляТекущейПолки(ЭтотОбъект);

	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность()         

	Если ВерсияПО = "1.4" Тогда
		Элементы.ФормаВозвратПолки.Видимость = Ложь;
	Иначе
		Элементы.ФормаВозвратПолки.Видимость = Истина;
	КонецЕсли;

	// Добавляем чек-бокс "Управление через 1с". 
	// Если он включен, 
	// то тогда пользователь из 1с может вызывать 
	// и возвращать полки на данном Лифте.
	
	дкл_ФормыСервер.УстановитьВидимостьДоступностьДляПользователя(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтбор()         
	
	Отбор = Список.КомпоновщикНастроек.Настройки.Отбор;
	
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Отбор, "НастройкаСклада");

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, "НастройкаСклада", НастройкаСкладаЛифта, ВидСравненияКомпоновкиДанных.Равно, Истина);   

	Список.Параметры.УстановитьЗначениеПараметра("Ошибка"		, Ошибка);
	Список.Параметры.УстановитьЗначениеПараметра("Выдана"		, Выдана);
	Список.Параметры.УстановитьЗначениеПараметра("Перемещается"	, Перемещается);
		
КонецПроцедуры

&НаСервере
Процедура УстановитьЗоныВыбораИВидАСХ()         
	
	КоличествоЗонВыдачи = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НастройкаСкладаЛифта, "КоличествоЗонВыдачи");		
	КоличествоЗонВыдачи = ?(НЕ ЗначениеЗаполнено(КоличествоЗонВыдачи), 1, КоличествоЗонВыдачи);   

	ЗонаВыдачи = 1;
	
	Если КоличествоЗонВыдачи = 1 Тогда
		Элементы.ЗонаВыдачи.Видимость = Ложь;
	Иначе
		Элементы.ЗонаВыдачи.Видимость = Истина;
	КонецЕсли;

	ВидАСХ = Справочники.дкл_НастройкиСкладовЛифтов.ВидАСХ(НастройкаСкладаЛифта);
	
	Если ВидАСХ = Перечисления.дкл_ВидыАСХ.Карусель Тогда
		ДоступнаТолькоВыдачаПолки = Истина;
	Иначе
		ДоступнаТолькоВыдачаПолки = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьКартинкуБезПроверкиСкладаЛифта(НомерСтатуса)         

	Если НомерСтатуса = 2 Тогда
		Элементы.Картинка.Картинка = БиблиотекаКартинок.ОформлениеКругЗеленый;
	ИначеЕсли НомерСтатуса = 3 Тогда
		Элементы.Картинка.Картинка = БиблиотекаКартинок.ОформлениеКругЖелтый;
	Иначе
		Элементы.Картинка.Картинка = БиблиотекаКартинок.ОформлениеКругКрасный;
	КонецЕсли;            
	
КонецПроцедуры        

&НаСервере
Процедура ПоместитьНомерПолкиВСписок(НомерПолки, ИмяСписка)

	МассивИмяСписков = Новый Массив;
	МассивИмяСписков.Добавить("Ошибка");
	МассивИмяСписков.Добавить("Выдана");
	МассивИмяСписков.Добавить("Перемещается");
	
	Для каждого ИмяИзМассива Из МассивИмяСписков Цикл
		Если ИмяИзМассива = ИмяСписка Тогда
			Если ЭтотОбъект[ИмяСписка].НайтиПоЗначению(НомерПолки) = Неопределено Тогда
				ЭтотОбъект[ИмяСписка].Добавить(НомерПолки);
			КонецЕсли;
		Иначе			                                             
			НайденныйЭлементСписка = ЭтотОбъект[ИмяИзМассива].НайтиПоЗначению(НомерПолки);
			Если НЕ НайденныйЭлементСписка = Неопределено Тогда
				ЭтотОбъект[ИмяИзМассива].Удалить(НайденныйЭлементСписка);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;

	УстановитьОтбор();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

#КонецОбласти




