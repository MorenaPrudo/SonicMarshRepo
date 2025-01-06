extends StaticBody2D
@onready var MechaSnake = get_parent()

const leftstartingpos = Vector2(38800,-725)
const rightstartingpos = Vector2(38100,-650)
const movetime = 5
var step = 3
var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		position.x += step


func start(direction):
	started = true
	visible = true
	if !get_child(2).monitoring:
		get_child(2).set_deferred("monitoring", true)
	if direction == 0:
		direction = -1
	step *= direction
	if step > 0:
		global_position.x = rightstartingpos.x
	else:
		global_position.x = leftstartingpos.x
	await get_tree().create_timer(movetime).timeout
	started = false
	
func stop():
	visible = false
	if get_child(2).monitoring:
		get_child(2).set_deferred("monitoring", false)

func _on_area_2d_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		body.hurt(global_position)

