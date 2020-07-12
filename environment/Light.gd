extends Node2D

var go_crazy = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, "on")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(go_crazy):
		var is_on = rand_range(0, 1) > 0.5
		
		if(is_on):
			Singleton.change_animation($AnimationPlayer, "on")
		else:
			Singleton.change_animation($AnimationPlayer, "off")

func _on_Area2D_area_entered(area):
	var body = area.get_parent()
	if(body.is_in_group("robot")):
		go_crazy = true
