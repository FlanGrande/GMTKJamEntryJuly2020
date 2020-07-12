extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(ev):
	if ev is InputEventKey:
		#(print(OS.get_scancode_string(ev.scancode)))
		Singleton.change_scene("res://levels/TestingGrounds.tscn")
