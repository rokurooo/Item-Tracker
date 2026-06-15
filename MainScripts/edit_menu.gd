extends CanvasLayer
signal edited

var SHOPNAME: String
var ITEMNAME: String
var ITEMPRICE: String

@onready var shoplabel = $BG/Panel3/VBoxContainer/Itemsname/Shop
@onready var itemname = $BG/Panel3/VBoxContainer/Itemsname/Item
@onready var priceinput = $BG/Panel3/VBoxContainer/Price


func _update_details():
	shoplabel.text = SHOPNAME
	itemname.text = ITEMNAME
	priceinput.placeholder_text = ITEMPRICE


func _on_cancel_pressed() -> void:
	visible = false
	pass # Replace with function body.


func _on_confirm_pressed() -> void:
	emit_signal("edited")
	visible = false
	pass # Replace with function body.
