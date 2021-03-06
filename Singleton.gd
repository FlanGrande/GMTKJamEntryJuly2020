extends Node

var movement_system_nodes : = []
var current_character_index : = 0
var current_level = 0
var current_scene_path = "res://MainMenu.tscn" #"MainMenu" "TestingGrounds" "Ending"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()
	
	if(Input.is_action_just_pressed("swap_characters") and current_scene_path == "res://levels/TestingGrounds.tscn"):
		current_character_index += 1
		current_character_index = current_character_index % movement_system_nodes.size()
		select_character(current_character_index)

func select_character(index : int):
	current_character_index = index
	
	for node in movement_system_nodes:
		node.get_node("Arrow").stop_display()
		node.current = false
	
	movement_system_nodes[index].current = true
	movement_system_nodes[index].get_node("Arrow").display()

func change_animation(animation_player : AnimationPlayer, new_animation : String):
	if(animation_player.current_animation != new_animation):
		animation_player.play(new_animation)

func next_level():
	current_level += 1

func win_game():
	current_level = 0
	change_scene("res://Ending.tscn")

func change_scene(new_scene_path):
	if(current_scene_path != new_scene_path):
		current_scene_path = new_scene_path
		get_tree().change_scene(new_scene_path)
	else:
		print("Scene could not be changed")
