extends StaticBody2D
@onready var deathsprite = $Death

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_sprite_animation_finished():
		deathsprite.play()
		deathsprite.position = Vector2(randf_range(-25, 25), randf_range(-10, 5))
