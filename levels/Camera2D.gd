extends Camera2D

export var StartingLevel = "level0"

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, StartingLevel)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Human_win_level():
	Singleton.change_animation($AnimationPlayer, "level" + str(Singleton.current_level))
