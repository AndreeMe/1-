
&НаКлиенте
Процедура ПодключитьООбработку(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПодключитьЗавершение", ЭтаФорма); //ЭтотОбъект);
	
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
	ДиалогОткрытияФайла.Заголовок     	   = "Выберите файл: ";
	ДиалогОткрытияФайла.Фильтр 		 	   = "(*.epf)|*.epf";
	
    НачатьПомещениеФайла(ОписаниеОповещения, , ДиалогОткрытияФайла, Истина, ЭтаФорма.УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключитьЗавершение(Результат, Адрес, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
    Если НЕ Результат Тогда
        Возврат;
    КонецЕсли;
    АдресФайла = Адрес;
    Модифицированность = Истина;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если ЭтоАдресВременногоХранилища(АдресФайла) Тогда
		Данные = ПолучитьИзВременногоХранилища(АдресФайла); 
        ТекущийОбъект.ХранилищеОбработки = Новый ХранилищеЗначения(Данные);
		ИмяФайлаОбработки = РегистрыСведений.дкл_Обработки.ПолучитьИмяФайлаОбработки(Запись.ИмяОбработки);
		Данные.Записать(ИмяФайлаОбработки); 
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьОбработку(Команда)
	Режим = РежимДиалогаВыбораФайла.Сохранение;
	ДиалогСохраненияФайла = Новый ДиалогВыбораФайла(Режим);
	Фильтр = "Обработка(*.epf)|*.epf";
	ДиалогСохраненияФайла.Фильтр = Фильтр;
	ДиалогСохраненияФайла.МножественныйВыбор = Ложь;
	ДиалогСохраненияФайла.Заголовок = "Выберите файл для сохранения";
	ДиалогСохраненияФайла.Показать(Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтаФорма, Новый Структура("ДиалогСохраненияФайла", ДиалогСохраненияФайла)));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	ДиалогСохраненияФайла = ДополнительныеПараметры.ДиалогСохраненияФайла;
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		АдресВоВременномХранилище = ПоместитьВоВременноеХранилищеНаСервере(Запись.ТипСообщения, Запись.Направление);
		Если Не АдресВоВременномХранилище = Неопределено Тогда
			ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресВоВременномХранилище);
			ДвоичныеДанные.Записать(ДиалогСохраненияФайла.ПолноеИмяФайла);
		КонецЕсли; 
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПоместитьВоВременноеХранилищеНаСервере(ТипСообщения, Направление)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	дкл_Обработки.ХранилищеОбработки КАК ХранилищеОбработки
		|ИЗ
		|	РегистрСведений.дкл_Обработки КАК дкл_Обработки
		|ГДЕ
		|	дкл_Обработки.ТипСообщения = &ТипСообщения
		|	И дкл_Обработки.Направление = &Направление";
	
	Запрос.УстановитьПараметр("ТипСообщения", ТипСообщения);
	Запрос.УстановитьПараметр("Направление" , Направление);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли; 
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ВыборкаДетальныеЗаписи.Следующий();
	
	ДвоичныеДанные = ВыборкаДетальныеЗаписи.ХранилищеОбработки.Получить();
	
	АдресПомещения = Новый УникальныйИдентификатор;
	Возврат ПоместитьВоВременноеХранилище(ДвоичныеДанные, АдресПомещения);
	
КонецФункции
