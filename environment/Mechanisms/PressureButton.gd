extends Node2D

onready var mechanism = get_parent().get_parent()
onready var mechanism_id = mechanism.ID

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = 1 # red

func use():
	$AudioStreamPlayer2D.play()
	get_parent().use()
	var frame = $Sprite.frame

	match frame:
		0:
			$Sprite.frame = 1
		
		1:
			$Sprite.frame = 2
		
		2:
			$Sprite.frame = 1
