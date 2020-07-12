extends Node2D

onready var EmptyFloorScene = preload("res://environment/EmptyFloor.tscn")

var is_broken : = false
var human_on_top # Human on top, if any.
var initial_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	is_broken = false
	initial_position = global_position

func _process(delta):
	if(not $TimerBreak.is_stopped()):
		$Sprite.global_position = Vector2(initial_position.x + rand_range(-4, 4), initial_position.y + rand_range(-4, 4))

func _on_Area2D_body_entered(body):
	if(body.is_in_group("human")):
		human_on_top = body
		$TimerBreak.start()
	
	if(body.is_in_group("robot")):
		$Sprite.set_modulate(Color(1, 0, 0, 1))

func _on_Area2D_body_exited(body):
	if(body.is_in_group("human")):
		human_on_top = null

func _on_TimerBreak_timeout():
	var instance = EmptyFloorScene.instance()
	instance.position = position
	instance.scale = scale
	
	if(human_on_top != null and (abs(human_on_top.position.x - position.x) < 16 or abs(human_on_top.position.y - position.y) < 16)):
		human_on_top.position = get_parent().get_parent().get_node("Spawn").position
	
	get_parent().add_child(instance)
	is_broken = true
	queue_free()
