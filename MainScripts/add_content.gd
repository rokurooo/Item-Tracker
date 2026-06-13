@tool
extends Button

var header: PanelContainer
var menu_toggled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.visible = false
	header = get_parent().get_parent().get_parent().get_parent()
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if header and !header.SHOWMENU:
		$Menu.visible = false
	else:
		$Menu.visible = true


func _on_pressed() -> void:
	if !menu_toggled:
		header.SHOWMENU = true
		$Menu.visible = true
		menu_toggled = true
	else:
		header.SHOWMENU = false
		$Menu.visible = false
		menu_toggled = false

	pass # Replace with function body.
