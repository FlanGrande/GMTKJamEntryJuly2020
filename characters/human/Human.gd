extends "res://characters/movement_system.gd"

export var RobotNodePath : NodePath
export var AudioInsideRange : AudioStream
export var AudioOutOfRange : AudioStream

signal win_level

var connected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.change_animation($AnimationPlayer, "animation_02")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_node(RobotNodePath).lock):
		connected = false
	else:
		connected = true
	
	if(connected):
		$Led.visible = true
	else:
		$Led.visible = false
	
	if(current):
		match(direction):
			VECTOR_UP:
				Singleton.change_animation($AnimationPlayer, "animation_02")
			VECTOR_UP_RIGHT:
				Singleton.change_animation($AnimationPlayer, "animation_03")
			VECTOR_RIGHT:
				Singleton.change_animation($AnimationPlayer, "animation_03")
			VECTOR_DOWN_RIGHT:
				Singleton.change_animation($AnimationPlayer, "animation_03")
			VECTOR_DOWN:
				Singleton.change_animation($AnimationPlayer, "animation_00")
			VECTOR_DOWN_LEFT:
				Singleton.change_animation($AnimationPlayer, "animation_01")
			VECTOR_LEFT:
				Singleton.change_animation($AnimationPlayer, "animation_01")
			VECTOR_UP_LEFT:
				Singleton.change_animation($AnimationPlayer, "animation_01")
			Vector2(0, 0):
				Singleton.change_animation($AnimationPlayer, "animation_00")
	else:
		Singleton.change_animation($AnimationPlayer, "animation_00")
	
	if(is_moving):
		$AnimationPlayer.playback_speed = 1.6
	else:
		$AnimationPlayer.playback_speed = 0.6

func _on_Area2D_area_entered(area):
	var body = area.get_parent()
	
	if(body.is_in_group("win_doors")):
		Singleton.next_level()
		emit_signal("win_level")

func _on_Area2D_area_exited(area):
	var body = area.get_parent()
	
	if(body.is_in_group("win_doors")):
		body.close()

func _on_Timer_timeout():
	Singleton.select_character(0) #Select Human/Alien.

func _on_Area2DControl_range_body_entered(body):
	if(body.is_in_group("robot")):
		body.lock = false
		var current_music_time = $MusicPlayer.get_playback_position()
		$MusicPlayer.stream = AudioInsideRange
		$MusicPlayer.play(current_music_time)
		$Timer.stop()

func _on_Area2DControl_range_body_exited(body):
	if(body.is_in_group("robot")):
		body.lock = true
		var current_music_time = $MusicPlayer.get_playback_position()
		$MusicPlayer.stream = AudioOutOfRange
		$MusicPlayer.play(current_music_time)
		#$Timer.start(0.2)
