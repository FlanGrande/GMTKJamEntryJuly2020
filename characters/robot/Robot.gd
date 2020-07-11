extends "res://characters/movement_system.gd"

export var HumanNodePath : NodePath
export var control_range : = 300

var lock : = false
var saved_direction_angle_in_radians : = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, "idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.distance_to(get_node(HumanNodePath).position) >= control_range):
		lock = true
		retrieve_robot_check()
	else:
		lock = false
	
	saved_direction_angle_in_radians = direction_angle_in_radians

func movement_process():
	var moving = .movement_process()
	
	if(lock):
		moving = true
		direction_angle_in_radians = saved_direction_angle_in_radians
	
	if(current and Input.is_action_pressed("move_left")):
		$Sprite.flip_h = false
	elif(current and Input.is_action_pressed("move_right")):
		$Sprite.flip_h = true
	
	return moving

func swap_check():
	if(Input.is_action_just_pressed("swap_characters") and position.distance_to(get_node(HumanNodePath).position) < control_range):
		current = not current #This only works for two characters. Should be fine for this project... probably will need refinement.

func retrieve_robot_check():
	if(Input.is_action_just_pressed("swap_characters")):
		position = get_node(HumanNodePath).position
		get_node(HumanNodePath).current = true
		current = false
