extends StaticBody2D
@onready var MechaSnake = get_parent()
@onready var animsprite = $Sprite2D
@onready var deathsprite = $Death
@export var pathfollow:PathFollow2D
@export var bossbehind: StaticBody2D
@export var first:bool
@export var eggman:bool

var tween
const step = 4.5
# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if MechaSnake.DEFEATED:
		if eggman:
			position.x += step
		else:
			position.y += step * 2
	elif MechaSnake.arrived:
		if first and !MechaSnake.freeze:
			await get_tree().create_timer(0.4).timeout
			bossbehind.changenext(position)
			position = pathfollow.position
		else:
			pass


func changenext(newposition):
	if not MechaSnake.freeze:
		if !(bossbehind == null):
			await get_tree().create_timer(0.4).timeout
			bossbehind.changenext(position)
			position = newposition
		else:
			await get_tree().create_timer(0.4).timeout
			position = newposition

func arrive():
	tween = create_tween() 
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(pathfollow, "progress_ratio",1, 5) 
	MechaSnake.arrived = true
	MechaSnake.SNAKEATTACK = true
	await tween.finished
	for node in get_tree().get_nodes_in_group("snakebodies"):
		node.get_child(1).set_deferred("monitoring",true)

func hitboxhit(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if body.animsprite.animation == "jump":
			body.velocity.y = 200
			if eggman:
				MechaSnake.hp -= 1
				$"../../Audio/BossHurt".play()
				if MechaSnake.hp == 0:
					$"../../Audio/BossDefeat".play()
					var tween = create_tween()
					tween.set_ease(Tween.EASE_OUT)
					tween.set_trans(Tween.TRANS_LINEAR)
					tween.tween_property($"../../Audio/Act2Boss", "volume_db",-80, 2)
					print("dead")
					for node in get_tree().get_nodes_in_group("snakebodies"):
						node.get_child(1).set_deferred("monitoring",false)
					deathsprite.visible = true
					deathsprite.play()
					await get_tree().create_timer(1).timeout
					var tween2 = create_tween()
					tween2.set_ease(Tween.EASE_OUT)
					tween2.set_trans(Tween.TRANS_LINEAR)
					tween2.tween_property($"../../Audio/OceanPalace", "volume_db",0, 2)
					var tween3 = create_tween()
					tween3.set_ease(Tween.EASE_OUT)
					tween3.set_trans(Tween.TRANS_LINEAR)
					tween3.tween_property($"../../Audio/BossDefeat", "volume_db",-80, 2)
					MechaSnake.DEFEATED = true
					MechaSnake.freeze = true
					if eggman:
						body.atboss = false
						body.add_camera()
						tween = create_tween()  # - new tween
						tween.set_ease(Tween.EASE_OUT)
						tween.set_trans(Tween.TRANS_LINEAR)
						tween.tween_property(body.get_node("Camera2D"),"position",Vector2(0,-60),1)
						# body.get_node("Camera2D").position = Vector2.ZERO
						animsprite.play("eggburnt")
				MechaSnake.blink()
		else:
			body.hurt(global_position)


func snake_attack(alternate):
	if alternate:
		pathfollow.progress_ratio = 1
	else:
		pathfollow.progress_ratio = 0
	tween = create_tween() 
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	if alternate:
		tween.tween_property(pathfollow, "progress_ratio",0, 5)
	else:
		tween.tween_property(pathfollow, "progress_ratio",1, 5)
	await tween.finished
	await get_tree().create_timer(2).timeout
	MechaSnake.SPIKEATTACK = true
	


func _on_death_animation_finished():
	deathsprite.play()
	deathsprite.position = Vector2(randf_range(-25, 25), randf_range(-10, 5))

