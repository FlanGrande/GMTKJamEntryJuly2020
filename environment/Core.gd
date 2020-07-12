extends Node2D

onready var mechanism = get_parent().get_parent()
onready var mechanism_id = mechanism.ID

var is_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, "idle")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_opened_by(node):
	if(mechanism_id == node.get_parent().mechanism_id):
		return true
	return false

func explode():
	is_destroyed = true
	$AudioStreamPlayerEx.play()
	$AudioStreamPlayerSciEx.play()
	$AnimationPlayer.set_speed_scale(6.0)
	Singleton.change_animation($AnimationPlayer, "explode")
	$Timer.start(4.5)

func _on_Timer_timeout():
	Singleton.win_game()
