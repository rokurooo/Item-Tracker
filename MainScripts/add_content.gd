@tool
extends Panel

@onready var warninglabel = $Container/VBoxContainer2/Warning
var menu_toggled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	warninglabel.visible = false
	pass # Replace with function body.

func _warn(item, shop, empty: bool):
	if !empty:
		item = GlobalScript.to_sentenced_case(item)
		shop = GlobalScript.to_sentenced_case(shop)
		warninglabel.text = "%s already have \n [ %s ] \n Can't add existing item!" %[shop.to_upper(),item]
	elif empty:
		warninglabel.text = "The price can't be empty"
	warninglabel.visible = true

@onready var shop_name_input = $Container/MatchedShop/Shop

func _matched_shop(enteredshop: String):
	warninglabel.visible = false
	var shopcontainer = $Container/MatchedShop
	if enteredshop.is_empty():
		_clearing_child(shopcontainer)
		return
	_clearing_child(shopcontainer)
	
	var data_list = GlobalScript.load_file()
	for shop in data_list:
		if GlobalScript.search_chars(shop.to_lower(), enteredshop.to_lower()):
			var shopholder = Button.new()
			_custom_param(shopholder,shop)
			shopholder.connect("pressed",replaceinput.bind(shop_name_input,shop,shopcontainer))
			shopcontainer.add_child(shopholder)


@onready var item_name_input = $Container/MatchedItems/Item

func _matched_item(entereditem: String):
	warninglabel.visible = false
	var itemcontainer = $Container/MatchedItems
	if entereditem.is_empty():
		_clearing_child(itemcontainer)
		return
	_clearing_child(itemcontainer)
	
	var data_list = GlobalScript.load_file()
	for shop in data_list:
		if GlobalScript.search_chars(shop.to_lower(), shop_name_input.text.to_lower()):
			var items = data_list[shop]
			for item in items:
				if GlobalScript.search_chars(item["Item_Name"].to_lower(), entereditem.to_lower()):
					var itemholder = Button.new()
					_custom_param(itemholder,item["Item_Name"])
					itemholder.connect("pressed",replaceinput.bind(item_name_input,item["Item_Name"],itemcontainer))
					itemcontainer.add_child(itemholder)

func _price_input(price_amount):
	warninglabel.visible = false

func _submit_items():
	var data_list = GlobalScript.load_file()
	var price_input = $Container/Price
	if price_input.text.is_empty():
		_warn("none","none",true)
		return
	for shop in data_list:
		if shop.to_lower() == shop_name_input.text.to_lower():
			print("shopwarn")
			for item in data_list[shop]:
				if item["Item_Name"].to_lower() == item_name_input.text.to_lower():
					print("itemwarn")
					_warn(item_name_input.text, shop_name_input.text, false)
	

func replaceinput(rawinput, tochange, container):
	rawinput.text = GlobalScript.to_sentenced_case(tochange)
	_clearing_child(container)

func _clearing_child(currentcontainer):
	for i in currentcontainer.get_child_count():
		if i > 0:
			currentcontainer.get_child(i).queue_free()

func _custom_param(btn: Button, stext: String):
	stext = GlobalScript.to_sentenced_case(stext)
	btn.custom_minimum_size.y = 30
	btn.text = stext

# func matched_shops(shop_name_input: String) -> void:
# 	data_list = GlobalScript.load_file()
# 	itemList.clear()
# 	priceList.clear()
# 	shopList.clear()
	
# 	var search_shop = shop_name_input.to_lower()
	
# 	for shop in data_list:
# 		if contains_all_chars(shop.to_lower(), search_shop):
# 			shops_found = true
# 			var items = data_list[shop]
# 			shopList.append_text(shop + "\n")
			
# 			for item in items:
# 				itemList.append_text(item["Item_Name"] + "\n")
# 				priceList.append_text(str(item["Item_Price"]) + "\n")

# func matched_items(shop_name_input: String, item_name_input: String) -> void:
# 	data_list = GlobalScript.load_file()
# 	itemList.clear()
# 	priceList.clear()
# 	shopList.clear()
	
# 	var search_shop = shop_name_input.to_lower()
# 	var search_item = item_name_input.to_lower()
	
# 	for shop in data_list:
# 		var items = data_list[shop]
		
# 		for item in items:
# 			var shop_match = contains_all_chars(shop.to_lower(), search_shop)
# 			var item_match = contains_all_chars(item["Item_Name"].to_lower(), search_item)
			
# 			if shop_match and item_match:
# 				shopList.append_text(shop + "\n")
# 				itemList.append_text(item["Item_Name"] + "\n")
# 				priceList.append_text(str(item["Item_Price"]) + "\n")

# func contains_all_chars(text: String, search: String) -> bool:
# 	for i in search:
# 		if i not in text:
# 			return false
# 	return true