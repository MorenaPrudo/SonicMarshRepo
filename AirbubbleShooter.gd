extends Node2D
var AirBubbleScene = preload("res://airbubble.tscn")
@onready var animsprite = $AnimatedSprite2D
const Cooldown = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	animsprite.play("default")
	await get_tree().create_timer(Cooldown).timeout
	shoot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	var airbubble = AirBubbleScene.instantiate()
	get_parent().add_child(airbubble)
	airbubble.global_position = global_position
	await get_tree().create_timer(Cooldown).timeout
	shoot()
