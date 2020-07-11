extends Node2D

onready var mechanism = get_parent().get_parent()
onready var mechanism_id = mechanism.ID

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_open):
		$Sprite.frame = 1
		$CollisionShape2D.disabled = true
	else:
		$Sprite.frame = 0
		$CollisionShape2D.disabled = false

func is_opened_by(node):
	if(mechanism_id == node.get_parent().mechanism_id):
		return true
	return false

func open():
	is_open = true

func close():
	is_open = false
