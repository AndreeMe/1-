
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПроверитьСоединение(ПараметрКоманды);
	Оповестить("дкл_СписокНастроекСкладовЛифтов");
КонецПроцедуры

&НаСервере
Процедура ПроверитьСоединение(НастройкаСклада)

	Если Справочники.дкл_НастройкиСкладовЛифтов.ПроверитьСоединение(НастройкаСклада) Тогда
		Сообщить("Соединение установлено");
	Иначе 		
		//Сообщить("Соединение не установлено");	
	КонецЕсли;		
	
КонецПроцедуры

	

