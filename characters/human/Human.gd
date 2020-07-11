extends "res://characters/movement_system.gd"

export var RobotNodePath : NodePath

signal win_level

var connected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, "animation_02")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.distance_to(get_node(RobotNodePath).position) >= get_node(RobotNodePath).control_range):
		connected = false
	else:
		connected = true
	
	if(connected):
		$Led.visible = true
	else:
		$Led.visible = false
	
	if(current):
		match(direction):
			VECTOR_UP:
				Singleton.change_animation($AnimationPlayer, "animation_02")
			VECTOR_UP_RIGHT:
				Singleton.change_animation($AnimationPlayer, "animation_03")
			VECTOR_RIGHT:
				Singleton.change_animation($AnimationPlayer, "animation_03")
			VECTOR_DOWN_RIGHT:
				Singleton.change_animation($AnimationPlayer, "animation_03")
			VECTOR_DOWN:
				Singleton.change_animation($AnimationPlayer, "animation_00")
			VECTOR_DOWN_LEFT:
				Singleton.change_animation($AnimationPlayer, "animation_01")
			VECTOR_LEFT:
				Singleton.change_animation($AnimationPlayer, "animation_01")
			VECTOR_UP_LEFT:
				Singleton.change_animation($AnimationPlayer, "animation_01")
			Vector2(0, 0):
				Singleton.change_animation($AnimationPlayer, "animation_00")
	else:
		Singleton.change_animation($AnimationPlayer, "animation_00")
	
	if(is_moving):
		$AnimationPlayer.playback_speed = 1.6
	else:
		$AnimationPlayer.playback_speed = 0.6

func _on_Area2D_area_entered(area):
	var body = area.get_parent()
	
	if(body.is_in_group("win_doors")):
		Singleton.next_level()
		emit_signal("win_level")

func _on_Area2D_area_exited(area):
	var body = area.get_parent()
	
	if(body.is_in_group("win_doors")):
		body.close()
