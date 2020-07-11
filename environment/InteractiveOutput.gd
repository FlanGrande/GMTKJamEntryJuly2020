extends Node2D

export var active = false # Is it active? Can it be used? E.g.: it's broken?
export(String, "Door") var type = "Door" # Is it a door, a traffic light...?

onready var mechanism_id# = get_parent().ID

var door_node = preload("res://environment/Mechanisms/Door.tscn")

var output_instance # Instance that contains an interactive output instance. E.g. a Door instance.
var is_activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.queue_free()
	
	match type:
		"Door":
			output_instance = door_node.instance()
			mechanism_id = get_parent().ID
			add_child(output_instance)

func _process(delta):
	match type:
		"Door":
			pass

func activate():
	# Open door, etc.
	is_activated = true
	
	match type:
		"Door":
			output_instance.open()

func deactivate():
	# Close door, etc.
	is_activated = false
	
	match type:
		"Door":
			output_instance.close()

func _on_Use():
	if(is_activated):
		deactivate()
	else:
		activate()

