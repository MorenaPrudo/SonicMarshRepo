extends CharacterBody2D
@onready var animsprite = $AnimatedSprite2D
@onready var Uicontroller = $"../CanvasLayer/ActUIController"
@export_enum("Bloominator", "Cyclone", "Aiai", "Buzzer","PenPen", "Bubbles", "Star Pointer", "Pinchranha") var mob
@export var Position1 : Node2D
@export var Position2 : Node2D
@export var aggroRangeRadius : float = 0
@export var pihrana_distance = 200
@export var pihrana_time = 2
@export var AudioController : Node2D

var BloomBallScene = preload("res://bloominator_ball.tscn")
var CoconutScene = preload("res://coconut.tscn")
var BuzzerBallScene = preload("res://buzzer_ball.tscn")


var aiaicanshoot = true
var aggro = false
var aggroed = false
var savedposition = Vector2.ZERO
var player : CharacterBody2D
var prevxpos :float
var nextdirection:int = 1
var direction:int = 1
var pos2 
var pos1
var speed = 100
var beestart = false
var beecanshoot = true
var penpenjumping = false
var bubblescanhurt = false
var starpointerswitched = false

const mobs = ["Bloominator", "Cyclone","Aiai","Buzzer", "PenPen","Bubbles","Star Pointer","Pinchranha"]
const cycloneaggrospeed = 200
const cyclonebasespeed = 100
const cycloneturnspeed = 10 
const gravity = 2000
const BloomballShootCooldown = 3
const SecondBloomballBallCooldown = .2
const AiaiShootCooldown = 3
const BuzzerShootCooldown = 3
const BubblesCooldown = 2
const StarPointCooldown = 6
const aiaispeed = 62.5
const beespeed =  200
const penpenspeed = 200
const buzzershootdistance = 100
const mobkillboost = 600
const penpenjumpforce = 615
const mobscores= ["Bloominator", "Cyclone","Aiai","Buzzer", "PenPen","Bubbles","Star Pointer","Pinchranha"] 

func _ready():
	$AggroRange/CollisionShape2D.shape.radius = aggroRangeRadius
	pos2 = Position2.global_position
	pos1 = Position1.global_position - Vector2(1,0)
	for num in range(mobs.size()):
		if num == mob:
			$Hitbox.get_node(mobs[num]+"Hitbox").set_deferred("disabled",false)
			get_node(mobs[num]+"Collision").set_deferred("disabled",false)
			animsprite.play(mobs[num].to_lower()+"_idle")
			print(mobs[num].to_lower()+"_idle")
	if mob == 0:
		speed = 0
		$MobTimer.wait_time = BloomballShootCooldown 	
		$MobTimer.start()
	if mob == 2:
		$MobTimer.wait_time = AiaiShootCooldown 
		speed = aiaispeed
	if mob == 3:
		print("oooooh")
		$MobTimer.wait_time = BuzzerShootCooldown 
		speed = beespeed
		direction = -1
		set_collision_layer_value(2,false)
		set_collision_mask_value(2,false)
	if mob == 4:
		direction = -1
		speed = penpenspeed
	if mob == 5:
		speed = 0
		$MobTimer.wait_time = BubblesCooldown
		$MobTimer.start()
	if mob == 6:
		speed = 0
		$StarPointStars.visible = true
		$MobTimer.wait_time = StarPointCooldown
		$MobTimer.start()
	if mob == 7:
		rotation = PI/2
		speed= 0
		start_pihrana_tween()
	if mob == 1:
		speed = cyclonebasespeed
		direction = -1
func _process(delta):
	if aggro:
		if mob == 5:
			global_position += global_position.direction_to(player.global_position) * 0.5
			if player.global_position.x > global_position.x:
				if !animsprite.flip_h:
					animsprite.flip_h = true
			else:
				if animsprite.flip_h:
					animsprite.flip_h = false
		elif mob == 1:
			if player.global_position.x > global_position.x:
				if direction != 1:
						flip()
				nextdirection = 1 #1 is right -1 is left
			if player.global_position.x < global_position.x:
				if direction != -1:
						flip()
				nextdirection = -1
		elif mob == 2:
			if aiaicanshoot:
				aiaicanshoot = false
				$MobTimer.start()
				if !animsprite.animation == "smoke_explosion":
					animsprite.animation = "aiai_aggro"
					animsprite.play()
					await get_tree().create_timer(0.1).timeout
					var coconut = CoconutScene.instantiate()
					add_child(coconut) #get_parent()
					coconut.global_position = global_position
					coconut.shoot(player)
			if animsprite.animation == "aiai_idle":
				if global_position.y >= pos1.y-5 and global_position.y <= pos1.y:
					direction = -1
				elif ((global_position.y < pos2.y+5) and (global_position.y >= pos2.y)):
					direction = 1
				velocity.y = speed * direction
				move_and_slide()
		elif mob == 3:
			if beestart and beecanshoot:
				if((global_position.x- player.global_position.x) < buzzershootdistance and (global_position.x- player.global_position.x)>0):
					speed = 0
					beecanshoot = false
					if !animsprite.animation == "smoke_explosion":
						animsprite.animation = "buzzer_aggro"
						animsprite.play()
						var buzzerball = BuzzerBallScene.instantiate()
						add_child(buzzerball)
						$MobTimer.start()
						await get_tree().create_timer(1).timeout
						speed=beespeed
		elif mob == 4:
			#animsprite.rotation = get_floor_angle()
			if velocity.x == 0:
				direction *=-1
			if (not is_on_floor()) and  (not penpenjumping):
				global_position = savedposition
				direction *=-1
			else:
				savedposition = global_position	

	else:
		if mob == 0:
			pass
		if mob == 1:
			if global_position.x >= pos1.x-100 and global_position.x <= pos1.x:
				if direction != 1:
						flip()
				nextdirection = 1
			elif ((global_position.x < pos2.x+100) and (global_position.x >= pos2.x)):
				if direction != -1:
						flip()
				nextdirection = -1
			else:
				if global_position.x < pos1.x - 100:
					if direction != 1:
						flip()
					nextdirection = 1
				elif global_position.x > pos2.x+100:
					if direction != -1:
						flip()
					nextdirection = -1
		if mob == 2:
			if animsprite.animation == "aiai_idle":
				if global_position.y >= pos1.y-5 and global_position.y <= pos1.y:
					direction = -1
				elif ((global_position.y < pos2.y+5) and (global_position.y >= pos2.y)):
					direction = 1
				velocity.y = speed * direction
				move_and_slide()
		if mob == 4:
				#animsprite.rotation = get_floor_angle()
				if not aggroed:
					if global_position.x >= pos1.x-100 and global_position.x <= pos1.x:
						direction = 1
						animsprite.flip_h = true
					elif ((global_position.x < pos2.x+100) and (global_position.x >= pos2.x)):
						direction = -1
						animsprite.flip_h = false
					else:
						if global_position.x < pos1.x - 100:
							direction = 1
							animsprite.flip_h = true
						elif global_position.x > pos2.x+100:
							direction = -1
							animsprite.flip_h = false
				else:
					if velocity.x == 0:
						direction *=-1
						print("comon")
					if (not is_on_floor()) and (not penpenjumping):
						if savedposition != Vector2.ZERO:
							global_position = savedposition
						direction *=-1
						animsprite.flip_h = !animsprite.flip_h
						print("klksks")
					else:
						savedposition = global_position
	if!(mob==0 or mob==2 or mob==3 or mob==5 or mob==7): #list all mobs that cant move
		if not is_on_floor():
			print(self.name)
			velocity.y += gravity * delta
		else:
			if mob ==4:
				animsprite.rotation = get_floor_angle()

	if!(mob==2):
		velocity.x = speed * direction
		move_and_slide()



func _on_aggro_range_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		player = body
		aggro = true
		aggroed = true
		print("aggroed")
		if mob == 0:
			pass
		elif mob == 1:
			speed = cycloneaggrospeed
			if !animsprite.animation == "smoke_explosion":
				animsprite.animation = "cyclone_aggro"
				animsprite.play()
		elif mob == 2:
			if !animsprite.animation == "smoke_explosion":
				animsprite.animation = "aiai_aggro"
				animsprite.play()
		elif mob == 3:
			beestart = true
		elif mob == 4:
			if player.global_position.x > global_position.x:
				direction = 1
				animsprite.flip_h = true
			else:
				direction = false
			animsprite.animation = "penpen_jump"
			velocity.y -= penpenjumpforce
			penpenjumping = true
			$AggroRange.set_deferred("monitoring",false)
			await get_tree().create_timer(0.5).timeout
			animsprite.animation = "penpen_aggro"
			await get_tree().create_timer(0.3).timeout
			penpenjumping = false
		elif mob == 6:
			if player.global_position.x > global_position.x and not starpointerswitched:
				animsprite.flip_h = true
				$StarPointStars.switch()
				starpointerswitched = true

func flip():
	if mob == 5:
		if !(animsprite.animation == "bubbles_turn" or animsprite.animation == "smoke_explosion"):
			animsprite.play("bubbles_turn")
	elif mob == 1:
		if !(animsprite.animation == "cyclone_turn" or animsprite.animation == "smoke_explosion"):
			animsprite.animation = "cyclone_turn"
			animsprite.play()
			speed = cycloneturnspeed

func _on_animated_sprite_2d_animation_finished():
	if animsprite.animation == "cyclone_turn":
		direction = nextdirection
		animsprite.flip_h = direction == 1
		if aggro:
			speed = cycloneaggrospeed
			if !animsprite.animation == "smoke_explosion":
				animsprite.animation = "cyclone_aggro"
				animsprite.play()
		else:
			speed = cyclonebasespeed
			if !animsprite.animation == "smoke_explosion":
				animsprite.animation = "cyclone_idle"
				animsprite.play()
	if animsprite.animation == "smoke_explosion":
		Global.score += 100
		Uicontroller.change_score()
		queue_free()
		print("Great Enemy Felled!")
	if animsprite.animation == "bloominator_aggro":
		animsprite.animation = "bloominator_idle"
		animsprite.play()
	if animsprite.animation == "aiai_aggro":
		animsprite.animation = "aiai_idle"
		animsprite.play()
	if animsprite.animation == "buzzer_aggro":
		animsprite.animation = "buzzer_idle"
		animsprite.play()
	if animsprite.animation == "bubbles_turn":
		animsprite.flip_h = direction == 1
		if bubblescanhurt:
			print("switch")
			if animsprite.animation != "bubbles_turn":
				animsprite.animation = "bubbles_aggro"
		else:
			print("switchwe")
			if animsprite.animation != "bubbles_turn":
				animsprite.animation = "bubbles_idle"

func _on_aggro_range_body_exited(body):
	if body.name == "Marsh" or body.name == "Sonic":
		player = body
		aggro = false
		if mob == 0:
			pass
		elif mob == 1:
			speed = cyclonebasespeed
			if !animsprite.animation == "smoke_explosion":
				animsprite.animation = "cyclone_idle"
				animsprite.play()
		elif mob == 4:
			pass
func _on_hitbox_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		print("entered hitbox")
		if body.animsprite.animation == "jump" and (not bubblescanhurt):
			if !body.is_on_floor() and global_position.y>body.global_position.y+5:
				print("ssss jump")
				if !animsprite.animation == "smoke_explosion" and body.velocity.y > -500:
					body.velocity.y -= mobkillboost
			print(body.animsprite.animation)
			if !animsprite.animation == "smoke_explosion":
				animsprite.animation = "smoke_explosion"
				animsprite.play()
				$"../Audio/BadnikDefeat".play()
		else:
			if !animsprite.animation == "smoke_explosion":
				body.hurt(global_position)


func _on_mob_timer_timeout():
	if mob == 0:
		if !animsprite.animation == "smoke_explosion":
			if aggro:
				animsprite.animation = "bloominator_aggro"
				animsprite.play()
				await get_tree().create_timer(0.1).timeout
				var bloomball = BloomBallScene.instantiate()
				add_child(bloomball)
				await get_tree().create_timer(SecondBloomballBallCooldown).timeout
				if !animsprite.animation == "smoke_explosion":
					animsprite.animation = "bloominator_aggro"
					animsprite.play()
					await get_tree().create_timer(0.1).timeout
					var bloomball2 = BloomBallScene.instantiate()
					bloomball2.position += Vector2(-10,0)
					bloomball2.scale = Vector2(-1,1)
					add_child(bloomball2)
	if mob == 2:
		if aggro:
			aiaicanshoot = true
	if mob == 3:
		beecanshoot=true
	if mob == 5:
		if bubblescanhurt:
			if !animsprite.animation == "smoke_explosion":
				animsprite.play("bubbles_idle")
			bubblescanhurt = false
		else:
			if !animsprite.animation == "smoke_explosion":
				animsprite.play("bubbles_aggro")
			bubblescanhurt = true
	if mob == 6:
		if aggro:
			$StarPointStars.select_to_shoot()

func start_pihrana_tween():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", position - Vector2(0,pihrana_distance), pihrana_time)
	await tween.finished
	start_pihrana_second_tween()

func start_pihrana_second_tween():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", position + Vector2(0,pihrana_distance), pihrana_time)
	await tween.finished
	start_pihrana_tween()
