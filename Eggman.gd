extends StaticBody2D
var flying = false
@onready var deathsprite = $Death
const step = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flying:
		position.x += step

func fly():
	flying = true
	position.y = position.y + 100

func _on_death_animation_finished():
	deathsprite.play()
	deathsprite.position = Vector2(randf_range(-25, 25), randf_range(-10, 5))
