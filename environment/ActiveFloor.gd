extends StaticBody2D

onready var mechanism = get_parent().get_parent()
onready var mechanism_id = mechanism.ID

var is_displayed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_displayed):
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false

func is_opened_by(node):
	if(mechanism_id == node.get_parent().mechanism_id):
		return true
	return false

func display():
	is_displayed = true
	Singleton.change_animation($AnimationPlayer, "fade_in")

func hide():
	is_displayed = false
	Singleton.change_animation($AnimationPlayer, "fade_out")
