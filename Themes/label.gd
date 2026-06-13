@tool
extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = get_parent().name
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER