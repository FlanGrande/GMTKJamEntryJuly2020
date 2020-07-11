extends KinematicBody2D

export var speed : = 300
export var direction_angle_in_radians : = 0.0
export var current : = false

var x_axis : = Vector2(1, 0)
var is_moving : = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.movement_system_nodes.append(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_moving = movement_process()
	if(is_moving and current): move_and_collide(Vector2(speed*delta, 0).rotated(direction_angle_in_radians))
	
	#swap_check()

func movement_process():
	var moving : = false
	
	if(Input.is_action_pressed("move_up")):
		direction_angle_in_radians = 3*PI/2
		moving = true
	elif(Input.is_action_pressed("move_down")):
		direction_angle_in_radians = PI/2
		moving = true
	
	if(Input.is_action_pressed("move_left")):
		direction_angle_in_radians = PI
		moving = true
	elif(Input.is_action_pressed("move_right")):
		direction_angle_in_radians = 0
		moving = true
	
	return moving

func swap_check():
	if(Input.is_action_just_pressed("swap_characters")):
		current = not current #This only works for two characters. Should be fine for this project... probably will need refinement.
