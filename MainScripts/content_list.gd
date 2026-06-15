extends VBoxContainer

var contents : PackedScene = preload('res://MainScene/content_holder.tscn')

var data_list
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	data_list = GlobalScript.load_file()
	display_all_content()

func clear_content():
	for i in get_child_count():
		get_child(i).queue_free()

func display_all_content():
	data_list = GlobalScript.load_file()
	clear_content()
	for shops in data_list:
		for items in data_list[shops]:
			var content_instance = contents.instantiate()
			content_instance.name = shops
			add_child(content_instance)
			content_instance.SHOPNAME = shops
			content_instance.ITEMNAME = items["Item_Name"]
			content_instance.ITEMPRICE = str(items["Item_Price"])
			content_instance.connect("boop",booped)

func booped():
	for i in get_child_count():
		get_child(i).booped()

