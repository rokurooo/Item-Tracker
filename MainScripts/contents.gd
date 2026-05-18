extends HBoxContainer

@onready var shopList = $Shops
@onready var itemList = $Items
@onready var priceList = $Price

var data_list
var shops_found: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() != null:
		data_list = get_parent().data_list
	pass # Replace with function body.

var shop_name
var item_name

var search_shop = shop_name.to_upper()
var search_item = item_name.to_upper()

func matched_shops(shop_name_input: String) -> void:
	data_list = GlobalScript.load_file()
	
	if shop_name_input in data_list:
		shops_found = true
		var items = data_list[shop_name_input]
		itemList.clear()
		priceList.clear()
		
		for item in items:
			itemList.append_text(item["Item_Name"] + "\n")
			priceList.append_text(str(item["Item_Price"]) + "\n")
	else:
		shops_found = false

func matched_items(shop_name_input: String, item_name_input: String) -> void:
	data_list = GlobalScript.load_file()
	itemList.clear()
	priceList.clear()
	shopList.clear()
	
	
	for shop in data_list:
		var items = data_list[shop]
		
		for item in items:
			shopList.append_text(shop + "\n")
			itemList.append_text(item["Item_Name"] + "\n")
			priceList.append_text(str(item["Item_Price"]) + "\n")
