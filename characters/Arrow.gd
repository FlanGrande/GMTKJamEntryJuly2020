extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display():
	Singleton.change_animation($AnimationPlayer, "arrow_in")

func stop_display():
	Singleton.change_animation($AnimationPlayer, "hidden")
