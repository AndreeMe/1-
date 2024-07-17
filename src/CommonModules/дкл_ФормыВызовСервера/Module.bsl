////////////////////////////////////////////////////////////////////////////////
// Общие методы форм, вызов сервера
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
Функция ВерсияПО(НастройкаСклада)  Экспорт
	//@skip-check wrong-string-literal-content
	Возврат Справочники.дкл_НастройкиСкладовЛифтов.ВерсияПО(НастройкаСклада);
КонецФункции // ()

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
Функция ПроверитьСтрокуСоединения(Знач НастройкаСклада) Экспорт
	Возврат Справочники.дкл_НастройкиСкладовЛифтов.ПроверитьСтрокуСоединения(НастройкаСклада, Истина);
КонецФункции

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
Функция ПроверитьСоединение(Знач НастройкаСкладаЛифта, НомерСтатусаЛифта = Неопределено, БуквенныйКод = Неопределено) Экспорт
    Возврат Справочники.дкл_НастройкиСкладовЛифтов.ПроверитьСоединение(НастройкаСкладаЛифта, НомерСтатусаЛифта, , БуквенныйКод);
КонецФункции 

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
//@skip-check bsl-variable-name-invalid
Функция ВыдачаПолкиНаСервере(Знач НастройкаСклада, Знач НомерПолки, requestId, feederId) Экспорт
	Возврат дкл_ОбменДаннымиСервер.ВыдатьПолку(НастройкаСклада, НомерПолки, requestId, feederId);
КонецФункции

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
//@skip-check bsl-variable-name-invalid
Функция ВозвратПолкиНаСервере(Знач НастройкаСклада, Знач НомерПолки, requestId) Экспорт
	Возврат дкл_ОбменДаннымиСервер.ВернутьПолку(НастройкаСклада, НомерПолки, requestId);
КонецФункции

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
//@skip-check bsl-variable-name-invalid
Функция СостояниеЗапросНаСервере(Знач  НастройкаСклада, requestId) Экспорт
	Возврат дкл_ОбменДаннымиСервер.СостояниеЗапроса(НастройкаСклада, requestId);
КонецФункции

//@skip-check export-procedure-missing-comment
//@skip-check doc-comment-export-function-return-section
//@skip-check doc-comment-parameter-section
Функция НомерСтатусаПоКодуСтатусаАСХ(Код) Экспорт
	
	// коды "здоровья" АСХ                       
	// === в работе ===
	// 0 - АСХ находится в состоянии покоя.
	// 1 - Выполняется операция. 
	// === ошибка ===
	// 2 - Есть неполадки, мешающие работе АСХ.
	// (теперь нужен код, т.к. надо отображать все состояния)
	
	// в коллекции картинок:
	// 1 - ничего
	// 2 - красный (ошибка)
	// 3 - желтый (в движении)
	// 4 - зеленый (в покое)
	
	Если Код = -1 Тогда
		НомерСтатуса = 3; // нет связи
	ИначеЕсли Код = 0 Тогда
		НомерСтатуса = 4; // в работе
	ИначеЕсли Код = 1 Тогда
		НомерСтатуса = 2; // выполняется операция
	ИначеЕсли Код = 2 Тогда
		НомерСтатуса = 1; // ошибка
	КонецЕсли;
	
	Возврат НомерСтатуса;
	
КонецФункции

#КонецОбласти

