extends KinematicBody2D

export var speed : = 300
export var direction_angle_in_radians : = 0.0
export var current : = false

const VECTOR_UP = Vector2(0, -1)
const VECTOR_UP_RIGHT = Vector2(1, -1)
const VECTOR_RIGHT = Vector2(1, 0)
const VECTOR_DOWN_RIGHT = Vector2(1, 1)
const VECTOR_DOWN = Vector2(0, 1)
const VECTOR_DOWN_LEFT = Vector2(-1, 1)
const VECTOR_LEFT = Vector2(-1, 0)
const VECTOR_UP_LEFT = Vector2(-1, -1)

var direction : = Vector2(0, 0);

var x_axis : = Vector2(1, 0)
var is_moving : = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.movement_system_nodes.append(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_moving = movement_process()
	if(is_moving and current): move_and_slide(Vector2(speed, 0).rotated(direction_angle_in_radians))

func movement_process():
	var moving : = false
	
	direction = Vector2(0, 0);
	
	if(Input.is_action_pressed("move_up")):
		direction.y -= 1
		moving = true
	elif(Input.is_action_pressed("move_down")):
		direction.y += 1
		moving = true
	
	if(Input.is_action_pressed("move_left")):
		direction.x -= 1
		moving = true
	elif(Input.is_action_pressed("move_right")):
		direction.x += 1
		moving = true
	
	match(direction):
		VECTOR_UP:
			direction_angle_in_radians = 3*PI/2
		VECTOR_UP_RIGHT:
			direction_angle_in_radians = 7*PI/4
		VECTOR_RIGHT:
			direction_angle_in_radians = 0
		VECTOR_DOWN_RIGHT:
			direction_angle_in_radians = PI/4
		VECTOR_DOWN:
			direction_angle_in_radians = PI/2
		VECTOR_DOWN_LEFT:
			direction_angle_in_radians = 3*PI/4
		VECTOR_LEFT:
			direction_angle_in_radians = PI
		VECTOR_UP_LEFT:
			direction_angle_in_radians = 5*PI/4
	
	return moving
