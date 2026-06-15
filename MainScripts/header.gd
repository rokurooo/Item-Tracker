extends PanelContainer

@onready var CurrentDateLabel: Label = $VBoxContainer/DateToday
@onready var addicon: Button = $VBoxContainer/HBoxContainer/Panel/Add
const BODY = preload("res://MainScene/body.tscn")
const ADDMENU = preload("res://MainScene/add_menu_input.tscn")

@onready var bodyContainer = get_parent().get_child(1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentDateLabel.text = GlobalScript.get_current_date()
	pass # Replace with function body.

var added: bool = false
func _on_add_pressed() -> void:
	var bodyins = BODY.instantiate()
	var addmenuins = ADDMENU.instantiate()
	if !added:
		addicon.text = '-'
		bodyContainer.get_child(0).queue_free()
		bodyContainer.add_child(addmenuins)
		added = true
	elif added:
		addicon.text = '+'
		bodyContainer.get_child(0).queue_free()
		bodyContainer.add_child(bodyins)
		added = false

	pass # Replace with function body.
