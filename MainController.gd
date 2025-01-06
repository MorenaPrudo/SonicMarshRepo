extends Node2D
@onready var cutscenesprite = get_child(1).get_child(0)
@onready var cameraA = get_child(1).get_child(1)
@onready var titlescreen = $World/CanvasLayer.get_child(1)
@onready var storage = get_child(1)
# Called when the node enters the scene tree for the first time.
func _ready():
	if storage.name.contains("1"):
		if !Global.ttz1started:
			start_ttzact1()
			print("stop")
			Global.ttz1started = true
	else:
		if !Global.ttz2started:
			start_ttzact2()
			Global.ttz2started = true
			print("hshsh non")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_ttzact1():
	var player = get_node("World/Sonic")
	player.visible = false
	player.get_node("Camera2D").enabled = false
	cutscenesprite.play("jump")
	var tweenc = create_tween()  
	tweenc.set_ease(Tween.EASE_IN)
	tweenc.set_trans(Tween.TRANS_LINEAR)
	tweenc.tween_property(cutscenesprite, "position",Vector2(687,57), 3) # 663 x, 40 y
	await get_tree().create_timer(0.3).timeout
	var tween = create_tween()  
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(cameraA, "position",Vector2(699,-117), 2.5) # 111 x, 2 y
	await tweenc.finished
	await get_tree().create_timer(1).timeout
	player.get_node("Camera2D").enabled = true
	player.visible = true
	cameraA.enabled = false
	cutscenesprite.visible = false
	tweenc.kill()
	tween.kill()

func start_ttzact2():
	var player = get_node("World/Marsh")
	player.visible = false
	player.get_node("Camera2D").enabled = false
	cutscenesprite.play("waterglide")
	var tween = create_tween()  
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(cutscenesprite, "position",Vector2(605,0), 3) # 663 x, 40 y
	await get_tree().create_timer(0.3).timeout
	tween = create_tween()  
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(cameraA, "position",Vector2(600,-42), 2.5) # 111 x, 2 y
	await get_tree().create_timer(3).timeout
	cutscenesprite.visible = false
	player.visible = true
	player.get_node("Camera2D").enabled = true
	cameraA.enabled = false
	



func _on_goal_body_entered(body):
	pass # Replace with function body.
