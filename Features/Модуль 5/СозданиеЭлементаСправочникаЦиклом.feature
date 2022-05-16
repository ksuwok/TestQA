#language: ru

@tree

Функционал: Создание элементов справочника при помощи цикла


Контекст:
	Дано Я открыл новый сеанс TestClient или подключил уже существующий
	

Сценарий: Создание элементов справочника Номенклатура

	И я закрываю все окна клиентского приложения
	
	И Я запоминаю значение выражения '1' в переменную "Шаг"
	И я делаю 10 раз
		И Я запоминаю значение выражения '"Номенклатура" + $Шаг$' в переменную "Номенклатура"
		И Я запоминаю значение выражения '"e1cib/data/Catalog.Items?ref=" + СтрЗаменить(Новый УникальныйИдентификатор,"-","")' в переменную "GUID"
		
		И Я проверяю или создаю для справочника "Items" объекты:

			| 'Ref'    | 'DeletionMark' | 'Code' | 'ItemType'                                                          | 'Unit'                                                          | 'MainPricture'                          | 'Vendor'                                                           | 'ItemID' | 'PackageUnit' | 'Description_en' | 'Description_hash' | 'Description_ru' | 'Description_tr' | 'Height' | 'Length' | 'Volume' | 'Weight' | 'Width' |
			| '$GUID$' | 'False'        |        | 'e1cib/data/Catalog.ItemTypes?ref=b762b13668d0905011eb76684b9f6878' | 'e1cib/data/Catalog.Units?ref=b762b13668d0905011eb76684b9f687b' | 'ValueStorage:AQEIAAAAAAAAAO+7v3siVSJ9' | 'e1cib/data/Catalog.Partners?ref=b762b13668d0905011eb7663e35d794d' | '58791'  | ''            | '$Номенклатура$' | ''                 | ''               | ''               |          |          |          | 0.21     |         |
			
		И Я запоминаю значение выражения '$Шаг$ + 1' в переменную "Шаг"
		
	
