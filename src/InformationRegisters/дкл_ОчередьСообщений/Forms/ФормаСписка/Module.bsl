&НаСервере
Перем МенеджерОбъекта;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени("РегистрыСведений.дкл_ОчередьСообщений");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбработатьЗаписи(Команда)
	ОбработатьЗаписиНаСервере();
	Элементы.Список.Обновить();
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьЗапись(Команда)
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если Не ТекущиеДанные = Неопределено Тогда
		ОбработатьЗаписьНаСервере(ТекущиеДанные.IDСообщения);
	КонецЕсли; 
	Элементы.Список.Обновить();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбработатьЗаписьНаСервере(IDСообщения)                  
	СообщениеОбОшибке = МенеджерОбъекта.ОбработатьСообщение(IDСообщения);
	Если ЗначениеЗаполнено(СообщениеОбОшибке) Тогда
		Сообщить(СообщениеОбОшибке);
	КонецЕсли; 
КонецПроцедуры

&НаСервере
Процедура ОбработатьЗаписиНаСервере()
	МенеджерОбъекта.ОбработкаОчередиСообщений();
КонецПроцедуры

#КонецОбласти
