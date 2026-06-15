@tool
extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for i in find_children("Label"):
		i.text = i.get_parent().name
		i.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		i.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pass
