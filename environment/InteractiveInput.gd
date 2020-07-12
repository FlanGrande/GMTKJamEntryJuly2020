extends Node2D

signal use

export var active = false # Is it active? Can it be used? E.g.: it's broken?
export(String, "PressureButton", "ActiveLight") var type = "PressureButton" # Is it a door, a traffic light...?

#onready var mechanism_id = get_parent().ID

var pressure_button_node = preload("res://environment/Mechanisms/PressureButton.tscn")
var active_light_node = preload("res://environment/Mechanisms/ActiveLight.tscn")

var input_instance # Instance that interacts with the output (e.g. a Key instance)
var is_activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.queue_free()
	initialize()

func _process(delta):
	pass

# This function is used to reset the input_instance or initialize it exactly when we need it, to avoid Null.
func initialize():
	match type:
		"PressureButton":
			input_instance = pressure_button_node.instance()
			add_child(input_instance)
		
		"ActiveLight":
			input_instance = active_light_node.instance()
			add_child(input_instance)

func use():
	is_activated = not is_activated
	emit_signal("use")
