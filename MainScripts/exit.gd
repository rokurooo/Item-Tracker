extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("pressed",exit)
	pass # Replace with function body.

func exit():
	get_tree().quit()