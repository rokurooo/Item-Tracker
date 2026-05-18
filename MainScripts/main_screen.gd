extends Control


@onready var CurrentDateLabel = $VBoxContainer/CurrentDate
@onready var StoreName : TextEdit = $VBoxContainer/Inputs/Shop
@onready var ItemName : TextEdit = $VBoxContainer/Inputs/Item
@onready var ItemPrice : TextEdit = $VBoxContainer/Inputs/Price

@onready var Storelist : RichTextLabel = $VBoxContainer/Contents/Shops
@onready var Itemlist : RichTextLabel = $VBoxContainer/Contents/Items
@onready var Pricelist : RichTextLabel = $VBoxContainer/Contents/Price

var data_list

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentDateLabel.text = GlobalScript.get_current_date()
	data_list = GlobalScript.load_file()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_submit_pressed() -> void:
	if StoreName.text.is_empty() and ItemName.text.is_empty() and ItemPrice.text.is_empty():
		return
	print (StoreName.text)
	
	GlobalScript.save_file(StoreName.text,ItemName.text,ItemPrice.text)
	

func _on_shop_text_changed() -> void:
	data_list = GlobalScript.load_file()
	var shop_name = StoreName.text

	if shop_name in data_list:
		print("Shop found: ", shop_name)
		display_shop_items(shop_name)
	else:
		print("Shop not found: ", shop_name)
		# Clear the lists if needed
		Itemlist.clear()
		Pricelist.clear()


func _on_item_text_changed() -> void:

	pass # Replace with function body.

func display_shop_items(shop_name: String) -> void:
	if shop_name in data_list:
		var items = data_list[shop_name]
		Itemlist.clear()
		Pricelist.clear()
		
		for item in items:
			Itemlist.append_text(item["Item_Name"] + "\n")
			Pricelist.append_text(str(item["Item_Price"]) + "\n")
