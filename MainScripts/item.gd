@tool
extends VBoxContainer
signal boop

@export var need_confirm: bool = true
@export var rake_mode: bool = false

var options_toggled: bool = false
var edit_menu_toggled: bool = false
var delete_menu_toggled: bool = false

@onready var menu_array: Array = [
	$EditMenu,
	$DeleteMenu
]
@export_category("Contents Name")

@export var SHOPNAME: String:
	set(value):
		SHOPNAME = value
		update_label("SHOP")
@export var ITEMNAME: String:
	set(value):
		ITEMNAME = value
		update_label("ITEM")
@export var ITEMPRICE: String:
	set(value):
		ITEMPRICE = value
		update_label("PRICE")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in menu_array:
		i.visible = false
	update_label("")
	default_label("")

func update_label(labels):
	var Slabel: Label = $Labels/HBoxContainer/Shop
	var Ilabel: Label = $Labels/HBoxContainer/Item
	var Plabel: Label = $Labels/HBoxContainer/Price
	if is_node_ready() and Slabel and Ilabel and Plabel:
		match labels:
			"SHOP":
				Slabel.text = GlobalScript.to_sentenced_case(SHOPNAME)
				if SHOPNAME == "":
					default_label(labels)
			"ITEM":
				Ilabel.text = GlobalScript.to_sentenced_case(ITEMNAME)
				if ITEMNAME == "":
					default_label(labels)
			"PRICE":
				Plabel.text = GlobalScript.to_sentenced_case(ITEMPRICE)
				if ITEMPRICE == "":
					default_label(labels)
			"":
				Slabel.text = GlobalScript.to_sentenced_case(SHOPNAME)
				Ilabel.text = GlobalScript.to_sentenced_case(ITEMNAME)
				Plabel.text = GlobalScript.to_sentenced_case(ITEMPRICE)
	elif !is_node_ready():
		request_ready()
	_update_var()

func default_label(labels):
	var Slabel: Label = $Labels/HBoxContainer/Shop
	var Ilabel: Label = $Labels/HBoxContainer/Item
	var Plabel: Label = $Labels/HBoxContainer/Price
	match labels:
			"SHOP":
				Slabel.text = "SHOP"
			"ITEM":
				Ilabel.text = "ITEM"
			"PRICE":
				Plabel.text = "PRICE"
			"":
				Slabel.text = "SHOP"
				Ilabel.text = "ITEM"
				Plabel.text = "PRICE"

func _update_var():
	for i in menu_array:
		i.SHOPNAME = SHOPNAME
		i.ITEMNAME = ITEMNAME
		i.ITEMPRICE = ITEMPRICE
		
func _on_edit_pressed() -> void:
	if !edit_menu_toggled:
		$EditMenu._update_details()
		toggle_menus($EditMenu,edit_menu_toggled)
	else:
		toggle_menus($EditMenu,edit_menu_toggled)

func _on_delete_pressed() -> void:
	if need_confirm:
		if !delete_menu_toggled:
			toggle_menus($DeleteMenu,delete_menu_toggled)
		else:
			toggle_menus($DeleteMenu,delete_menu_toggled)
	else:
		_delete_confirm()

func _on_labels_pressed() -> void:
	if !options_toggled:
		emit_signal("boop")
		$TogglePlayer.speed_scale = 1
		$TogglePlayer.play("Open")
		options_toggled = true
	else:
		booped()
	pass # Replace with function body.

func booped():
	if options_toggled:
		$TogglePlayer.speed_scale = 5
		$TogglePlayer.play_backwards("Open")
		$HSeparator.visible = false
		$Buttons.visible = false
		options_toggled = false

func _delete_confirm():
	GlobalScript.remove_item(SHOPNAME,ITEMNAME)
	queue_free()

func _edit_confirm():
	var NEWPRICE = $EditMenu/BG/Panel3/VBoxContainer/Price.text
	GlobalScript.edit_item(SHOPNAME,ITEMNAME,NEWPRICE)
	_on_edit_pressed()
	get_parent().display_all_content()

func toggle_menus(menutabs,toggle) -> void:
	if !toggle:
		menutabs.visible = true
		toggle = true
	elif toggle:
		menutabs.visible = false
		toggle = false
