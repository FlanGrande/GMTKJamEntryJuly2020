extends "res://characters/movement_system.gd"

export var HumanNodePath : NodePath

var lock : = false
var saved_direction_angle_in_radians : = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, "idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(lock):
		retrieve_robot_check()
	
	saved_direction_angle_in_radians = direction_angle_in_radians
	
	#if(lock):
	#	Singleton.select_character(0) #Select Human/Alien.

func movement_process():
	var moving = .movement_process()
	
	if(lock):
		moving = true
		direction_angle_in_radians = saved_direction_angle_in_radians
		$Led.visible = false
		$Led2.visible = false
	else:
		$Led.visible = true
		$Led2.visible = true
	
	if(not lock):
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
	
	return moving

func retrieve_robot_check():
	if(Input.is_action_just_pressed("swap_characters")):
		var spawn_offset : = 32
		position = get_node(HumanNodePath).position + Vector2(spawn_offset, -spawn_offset)
		Singleton.select_character(0)

func _on_Area2D_area_entered(area):
	var node = area.get_parent()
	
	if(node.is_in_group("pressure_buttons")):
		node.use()
