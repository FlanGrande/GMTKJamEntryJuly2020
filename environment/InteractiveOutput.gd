extends Node2D

export var active = false # Is it active? Can it be used? E.g.: it's broken?
export(String, "Door", "ActiveFloor", "Core") var type = "Door" # Is it a door, a traffic light...?

onready var mechanism_id# = get_parent().ID

var door_node = preload("res://environment/Mechanisms/Door.tscn")
var active_floor_node = preload("res://environment/ActiveFloor.tscn")
var core_node = preload("res://environment/Core.tscn")

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
		
		"ActiveFloor":
			output_instance = active_floor_node.instance()
			mechanism_id = get_parent().ID
			add_child(output_instance)
		
		"Core":
			output_instance = core_node.instance()
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
		
		"ActiveFloor":
			output_instance.display()
		
		"Core":
			output_instance.explode()

func deactivate():
	# Close door, etc.
	is_activated = false
	
	match type:
		"Door":
			output_instance.close()
		
		"ActiveFloor":
			output_instance.hide()

func _on_Use():
	if(is_activated):
		deactivate()
	else:
		var mechanism = get_parent()
		var open = true
		
		for input in mechanism.input_instances:
			if(not input.is_activated):
				open = false
		
		if(open): activate()

