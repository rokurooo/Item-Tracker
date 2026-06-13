@tool
extends VBoxContainer

@export var edit_toggled: bool = false
var options_toggled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EditMenu.visible = false
	pass # Replace with function body.
	
func _process(_delta: float) -> void:
	if edit_toggled:
		$EditMenu.visible = true
	else:
		$EditMenu.visible = false

func _on_edit_pressed() -> void:
	if !edit_toggled:
		edit_toggled = true
		$EditMenu.visible = true
	else:
		edit_toggled = false
		$EditMenu.visible = false
	pass # Replace with function body.

func _on_delete_pressed() -> void:
	queue_free()
	pass # Replace with function body.

func _on_labels_pressed() -> void:
	if !options_toggled:
		$TogglePlayer.play("Open")
		options_toggled = true
	else:
		$TogglePlayer.play_backwards("Open")
		options_toggled = false
	pass # Replace with function body.

