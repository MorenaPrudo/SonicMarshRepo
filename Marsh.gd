extends CharacterBody2D

var clown = "🤡"
const accelrate = 1.019 #1.031
const switchingdeaccelrate = 0.5
const startingspeed = 50 #20
const deaccelrate = 0.94
const springdeaccelrate = 0.994
const springdeaccelrate_if_not_stopping = 0.995
const maxspeed = 450 #500
const maxjumpspeed = 500
const gravity = 2000
const jumpforce = 615 #515
const jumpswitchspeed = 200
const startingjumpspeed = 200
const maxspeed_to_not_skid = 120
const jumpboostvalue = 10
const instashieldcooldown = 3
const instashieldwindow = 0.3
const DroppedRingScene = preload("res://dropped_ring.tscn")
const maxdroppedrings = 20
const drowntime = 30
# pressing arrow mid air but going opposite direction of arrow
# moving backwards without flipping sprite - jumping and pressing opposite direction of arrow
@onready var animsprite = $AnimatedSprite2D
@onready var deathsprite = $DieAnimation
@onready var camera = $Camera2D
@onready var WaterTimer = $WaterTimer
@export var hurtAnim : Path2D
@export var UiController : Control
@onready var instasprite
@onready var Over = $"../CanvasLayer/Over"
var onup = false
var inwater = false
var isonzipline = false
var caninstashield = true
var instashield = false
var switchingdirection = false
var direction = 0
var currentdirection :int = 1
var speed = 0
var jumping = false
var switchingjumpdirection = false
var flipped = false
var spring = false
var lockeddirection = false
var longdeccel = false
var canenterloop = true
var canincreasejump = true
var timerstarted = false
var jumpboost = 0
var spindashlevel = 0
var rolling = false
var atboss = false
var inhurt = false
var bossclampmin : Vector2
var bossclampmax : Vector2
var invulnerable = false
var canrotate = false
var shouldturnoffup = false
var currenttimeunderwater = 0
var hurttween
var timeddeath=false
var playing_sound = false

func _ready():
	global_position = Global.checkpointposition
	stopmovement(30)
	animsprite.animation = "idle"
	animsprite.play()
	if name == "Sonic":
		instasprite = $Instashieldsprite
func _physics_process(delta):
	camera.global_position.y = clamp(camera.global_position.y,Global.clampposmin,Global.clampposmax)
	
	if not inwater and $"../Audio/Drowning".playing:
		$"../Audio/Drowning".stop()
		
	if instashield:
		print("insta on")
	
	if atboss:
		position = position.clamp(bossclampmin,bossclampmax)
		#(Vector2(16450,-9000),Vector2(16875, 1348))
	
	direction = Input.get_axis("ui_left","ui_right")
	
	if Input.is_action_just_released("ui_down"):
		if animsprite.animation == "spindash":
				$"../Audio/SpindashBreak".play()
				lockeddirection = false
	if speed == 0:
		if !lockeddirection:
			if rolling:
				rolling = false
				$CollisionShape2D.change_size()
		if animsprite.animation == "run" or animsprite.animation == "fullspeed":
		#!(animsprite.animation == "idle" or animsprite.animation == "actclear" or animsprite.animation == "lookingdown" or animsprite.animation == "lookingdowntransition"or animsprite.animation == "spindash" or animsprite.animation == "jump" ):
			animsprite.animation = "idle"
			$IdleTimer.start()

	
	if !jumping:	
		if !lockeddirection:
			if direction !=0 and currentdirection != direction:
				if speed < maxspeed_to_not_skid and !switchingdirection:
					flip()
					currentdirection = direction
				else:
					switchingdirection = true
				
				if !animsprite.animation == "skidchange" and is_on_floor():
					animsprite.animation = "skidchange"
					if switchingdirection:
						$"../Audio/SkidChange".play()
					animsprite.play()
			else:
				switchingdirection = false
			
			if switchingdirection:
				speed = speed * switchingdeaccelrate
				
			if direction == 0:
				if speed != 0:
					if speed < maxspeed:
						if animsprite.animation == "fullspeed" and !rolling:
								animsprite.animation = "run"
					if longdeccel:
						speed = (int)(speed * springdeaccelrate)
					else:
						speed = (int)(speed * deaccelrate)
				else:
					if Input.is_action_pressed("ui_down"):
						if not (animsprite.animation == "lookingdowntransition" or animsprite.animation == "lookingdown" or animsprite.animation == "spindash"  ):
							animsprite.animation = "lookingdowntransition"
							$CollisionShape2D.change_size("lookingdown")
							animsprite.play()
					else:
						if (animsprite.animation == "lookingdowntransition" or animsprite.animation == "lookingdown"):
							if animsprite.animation != "idle":
								animsprite.animation = "idle"
								$CollisionShape2D.change_size()
								switchingdirection = false
								animsprite.play()
								$IdleTimer.start()
						elif(animsprite.animation == "spindash"):
							animsprite.speed_scale = 1
							lockdirection(false,0.1)
							speed = 1300 - (300*(2-spindashlevel))
							rolling = true
							animsprite.animation = "jump"
							animsprite.play()
							spindashlevel = 0
							
					if !(animsprite.animation == "idle" or animsprite.animation == "bored transition" or animsprite.animation == "bored" or  animsprite.animation == "lookingdown" or animsprite.animation == "lookingdowntransition" or animsprite.animation == "spindash" or rolling):
						animsprite.animation = "idle"
						
						switchingdirection = false
						animsprite.play()
						$IdleTimer.start()
				
			
			if !switchingdirection and direction != 0:
				if animsprite.animation == "skidchange":
					animsprite.animation = "run"
				if speed < startingspeed:
					speed = startingspeed
				else:
					if !(animsprite.animation == "run" or animsprite.animation == "fullspeed" or rolling  or animsprite.animation == "pushing" or animsprite.animation == "antigravitymotion" or animsprite.animation == "skateline" or animsprite.animation == "skatelineloop"):
						animsprite.animation = "run"
						animsprite.play()
					if speed < maxspeed:
						if animsprite.animation == "fullspeed":
							animsprite.animation = "run"
							print("run")
						speed = speed * accelrate
					else:
						if !(animsprite.animation == "fullspeed" or rolling or animsprite.animation == "antigravitymotion" or animsprite.animation == "skateline" or animsprite.animation == "skatelineloop" ):
							print(animsprite.animation)
							animsprite.animation = "fullspeed"
							animsprite.play()
	
	if animsprite.animation == "spindash":
		if Input.is_action_just_pressed("jump"):
			if animsprite.animation == "spindash":
				if spindashlevel == 0:
					spindashlevel+=1
					animsprite.speed_scale = 1.3
					print("should play lvel 2")
					$"../Audio/SpindashCharge2".play()
				elif spindashlevel >= 1:
					spindashlevel = 2
					print("spindash lvel 3")
					animsprite.speed_scale = 1.6
					$"../Audio/SpindashCharge3".play()
					print("should play lvel 3")
				
			
	if (animsprite.animation == "lookingdown" or animsprite.animation == "lookingdowntransition") :
		if Input.is_action_just_pressed("jump"):
			$CollisionShape2D.change_size("rolling")
			animsprite.animation = "spindash"
			lockdirection(false,0.1,true)
			animsprite.play()
			$"../Audio/SpindashCharge".play()
			
	if jumping:
		if !lockeddirection:
			if direction !=0 and currentdirection != direction:
				switchingjumpdirection = true
				print("yyy")
			if switchingjumpdirection:
				speed = jumpswitchspeed
				flipped  = false
				if !flipped:
					flip()
					print("jdjdjd")
					currentdirection = direction
					longdeccel = false
					flipped = true
					switchingjumpdirection = false

				
			else:
				if !(direction == 0):
					if speed < startingjumpspeed:
						speed = startingjumpspeed
					if speed < maxspeed:
						speed = speed * accelrate
					if speed>maxspeed+100:
						speed = speed * deaccelrate
			
			if direction == 0:
				if speed != 0:
					speed = (int)(speed * deaccelrate)
		if Input.is_action_just_pressed("jump"):
			if caninstashield and name == "Sonic":
				instasprite.visible = true
				instashield = true
				caninstashield = false
				instasprite.play("default")
				await get_tree().create_timer(instashieldwindow).timeout
				instasprite.visible = false
				instashield = false
	if is_on_floor():
		if shouldturnoffup:
			print("what")
			onup = false
			shouldturnoffup = false
			var tween = create_tween() # - new tween
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(self.animsprite, "rotation",0, 0.2)
		if inhurt:
			inhurt = false
			animsprite.play("idle")
			print("ddhjjdj cool")
		if jumping: #this used to be under the next if statement\
				jumping = false
				caninstashield = true
				$CollisionShape2D.change_size()
				animsprite.rotation = 0
				switchingjumpdirection = false
				rolling = false
				spring = false
				canincreasejump = true
				timerstarted = false
				print("touched fllor")
		if animsprite.animation == "jump" and !rolling:
			animsprite.animation = "run"
	
	
	if is_on_floor() and Input.is_action_just_pressed("jump")  and not lockeddirection:
		if !(animsprite.animation == "lookingdown" or animsprite.animation == "spindash"):	
			if switchingdirection:
				switchingdirection = false
				switchingjumpdirection = true
			animsprite.play("jump")
			$"../Audio/Jump".play()
			animsprite.rotation = 0
			if onup:
				velocity.x = -jumpforce
			elif not inwater:
				velocity.y = -jumpforce
			else:
				velocity.y = -jumpforce*1.5
			jumping = true
	
	if not is_on_floor():
		if animsprite.rotation != 0 and velocity.y > -200:
			if canrotate:
				canrotate = false
				var tween = create_tween() # - new tween
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(self.animsprite, "rotation",0, 0.2)
		if not isonzipline:
			if onup:
				velocity.x += gravity * delta - jumpboost
			elif not inwater:
				velocity.y += gravity * delta - jumpboost
			else:
				velocity.y += (gravity*0.5) * delta - (jumpboost * 0.9)
	if (not is_on_floor()) and Input.is_action_pressed("jump") and (not Input.is_action_just_pressed("jump")) :
		#animsprite.play("jump")
		jumpboost = jumpboostvalue
	else:
		jumpboost = 0
				
	if onup:
		velocity.y = speed * currentdirection * up_direction.x
	else:
		velocity.x = speed * currentdirection
	if inwater:
		velocity.x *= 0.3
		velocity.y *= 0.9

		
	
	if !lockeddirection:
		if is_on_wall() and speed > 0:
			if direction == 0:
				if (animsprite.animation != "jump" or animsprite.animation != "actclear") and is_on_floor() :
					animsprite.play("idle")
					print("here fl")
			if animsprite.animation != "pushing" and direction != 0 and  animsprite.animation != "jump" and animsprite.animation != "antigravitymotion":
				animsprite.play("pushing")
				print("help[ me now]")
			speed = 0
		else:
			if animsprite.animation == "pushing":
				if not is_on_wall():
					animsprite.play("run")
	
	
	if Input.is_action_just_pressed("ui_down") and abs(velocity.x) > 0 :
		if !rolling:
			$"../Audio/SpindashCharge".play()
		rolling = true
		$CollisionShape2D.change_size("rolling")
		animsprite.play("jump")		
				
	if speed < 10 and !rolling:
		if onup:
			print(speed)
			onup = false
			up_direction = Vector2(0,-1)
			animsprite.rotation = 0
			$CollisionShape2D.rotation = 0
	
	if Input.is_action_just_pressed("reset"):
		if self.name == "Sonic":
			Global.soniclives +=1
		else:
			Global.marshlives +=1
		die()
				
	move_and_slide()

func flip():
		if animsprite.animation == "pushing":
			animsprite.play("run")
		if currentdirection == 1:
			animsprite.flip_h = true
		if currentdirection == -1:
			animsprite.flip_h = false
			
			


func _on_animated_sprite_2d_animation_finished():
	if animsprite.animation == "skidchange":
		animsprite.animation = "run"
		animsprite.play()
		flip()
		rolling = false
		currentdirection = direction
		switchingdirection = false
	if animsprite.animation == "bored transition":
		animsprite.animation = "bored"
		animsprite.play()
	
	if animsprite.animation == "bounceup":
		animsprite.animation = "run"
		animsprite.play()
	if animsprite.animation == "antigravitymotion": 
		animsprite.animation = "run"
		animsprite.play()
	if animsprite.animation == "lookingdowntransition":
		animsprite.animation = "lookingdown"
		animsprite.play()	
	if animsprite.animation == "skateline":
		animsprite.play("skateline")	
		
func _on_idle_timer_timeout():
	print(animsprite.animation)
	if animsprite.animation == "idle":
		print("bored")
		animsprite.animation = "bored transition"
		animsprite.play()
		
func lockdirection(switchdirection:bool=false,time:float=0.5, forever:bool=false):
	if switchdirection:
		flip()
		currentdirection = currentdirection * -1
	lockeddirection = true
	longdeccel = true
	if !forever:
		await get_tree().create_timer(time).timeout
		lockeddirection = false
		print("hi")
		await get_tree().create_timer(2).timeout
		longdeccel = false

func stopmovement(time):
	lockdirection(false,time)
	speed = 0
	velocity = Vector2.ZERO

func startmovement(newspeed:float=0):
	lockeddirection = false
	longdeccel = false
	speed = newspeed
	print("changed speed !")

func die():
	hurtAnim.visible = false
	deathsprite.animation = "die"
	deathsprite.visible = true
	animsprite.visible = false
	var deathspritepos = deathsprite.position
	stopmovement(10)
	$"../Audio/Death".play()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(deathsprite, "position",deathspritepos - Vector2(0,300), 0.3)
	await tween.finished
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(deathsprite, "position",deathspritepos + Vector2(0,1200), 0.8)
	await tween.finished
	if self.name == "Sonic":
		if Global.soniclives == 1:
			Over.showtween()
			await get_tree().create_timer(9).timeout
			get_tree().change_scene_to_file("res://title_screen.tscn")
			Global.ttz1started = false
			Global.ttz2started = false
			Global.soniclives = 3
			Global.marshlives = 3
			Global.score = 0
		else:
			if timeddeath:
				await get_tree().create_timer(9).timeout
			get_tree().reload_current_scene()
			Global.soniclives -=1 
	else:
		if Global.marshlives == 1:
			Over.showtween()
			await get_tree().create_timer(9).timeout
			get_tree().change_scene_to_file("res://title_screen.tscn")
			Global.soniclives = 3
			Global.marshlives = 3
			Global.score = 0
			Global.ttz1started = false
			Global.ttz2started = false
		else:
			if timeddeath:
				await get_tree().create_timer(9).timeout
			get_tree().reload_current_scene()
			Global.marshlives -=1 

func drown():
	deathsprite.animation = "drown"
	deathsprite.visible = true
	animsprite.visible = false
	var deathspritepos = deathsprite.position
	stopmovement(10)
	$"../Audio/Drowned".play()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(deathsprite, "position",deathspritepos + Vector2(0,1200), 3)
	var tweenw = create_tween()
	tweenw.set_ease(Tween.EASE_IN)
	tweenw.set_trans(Tween.TRANS_QUAD)
	tweenw.tween_property($WaterLabel, "position",$WaterLabel.position + Vector2(0,1200), 3)

func remove_camera():
	print(camera.global_position)
	camera.reparent(get_parent(),true)
	print(camera.enabled)
func add_camera():
	get_parent().get_node("Camera2D").reparent(self,true)

func hurt(globalposofimpacter):
	if not (inhurt or invulnerable):
		if UiController.rings == 0:
			die()
		else:
			if self.name == "Sonic":
				hurtAnim.get_node("PathFollow2D/AnimatedSprite2D2").play("sonic")
			else:
				hurtAnim.get_node("PathFollow2D/AnimatedSprite2D2").play("default")
			invulnerable = true
			hurtAnim.visible = true
			hurtAnim.global_position = global_position
			hurtAnim.get_node("PathFollow2D/RemoteTransform2D").update_position = true
			stopmovement(30)
			loserings()
			inhurt = true
			#hurtAnim.collision.set_deferred("monitoring",true)
			animsprite.play("hurt")
			animsprite.visible = false
			hurttween = create_tween()
			hurttween.set_ease(Tween.EASE_IN)
			hurttween.set_trans(Tween.TRANS_LINEAR)
			if globalposofimpacter.x <= global_position.x:
				hurtAnim.scale.x = -1
			else:
				hurtAnim.scale.x= 1
			hurttween.tween_property(hurtAnim.get_node("PathFollow2D"), "progress_ratio", 1, 3)
func hurtend():
		hurttween.kill()
		hurtAnim.get_node("PathFollow2D/RemoteTransform2D").update_position = false
		startmovement(0)
		hurtAnim.get_node("PathFollow2D").progress_ratio =0
		hurtAnim.global_position = global_position
		hurtAnim.get_node("PathFollow2D/RemoteTransform2D").update_position = true
		hurtAnim.visible= false
		inhurt = true
		animsprite.visible = true
		blink(10)


func _on_instashield_area_entered(area):
	print(area)
	if area.is_in_group("instashield"):
		area.Ininstashield = true
		print("in insta")


func _on_instashield_area_exited(area):
	print(area)
	if area.is_in_group("instashield"):
		print("hsjhshhjikjk lflfl")
		area.Ininstashield = false
		print("not in insta")

func blink(times:int):
	for time in range(times):
		animsprite.modulate.a = 0
		await get_tree().create_timer(0.1).timeout
		animsprite.modulate.a = 1
		await get_tree().create_timer(0.1).timeout
	invulnerable = false

func loserings():
	var angle
	var worth
	var numofdroppedrings
	var rings = UiController.rings
	UiController.update_rings(0)
	if rings < maxdroppedrings:
		numofdroppedrings = rings
		worth = 1
	else:
		numofdroppedrings = maxdroppedrings
		worth = rings / maxdroppedrings
	for num in range(numofdroppedrings):
		angle = (PI/numofdroppedrings) * (num + 1)
		var droppedring = DroppedRingScene.instantiate()
		get_parent().get_node("Rings").add_child.call_deferred(droppedring)
		droppedring.global_position = global_position - Vector2(0,50)
		droppedring.shoot(angle,worth)
		$"../Audio/RingDrop".play()
		waittocollect(droppedring)


func waittocollect(ring):
	await get_tree().create_timer(0.7).timeout
	ring.disappear()
	ring.cancollect = true

func startwatertimer():
	WaterTimer.start()
	$WaterLabel.visible = false
	currenttimeunderwater = 0
	print("should start water timer")


func _on_water_timer_timeout():
	if inwater:
		$WaterParticles.emitting = true
		currenttimeunderwater+=1
	if currenttimeunderwater == drowntime:
		drown()
	if currenttimeunderwater >= drowntime - 10:
		if currenttimeunderwater - (drowntime - 10)<6:
			if not $"../Audio/Drowning".playing:
				$"../Audio/Drowning".play()
			if inwater:
				$WaterLabel.visible = true
				print((currenttimeunderwater - (drowntime - 10)/2)*16)
				print("v1")
				print((currenttimeunderwater - (drowntime - 10))/2*16)
				print("v1")
			$WaterLabel.texture.region.position.x = (currenttimeunderwater - (drowntime - 10))/2*16
			$WaterLabel.texture.region.position.y = 0
		else:
			$WaterLabel.texture.region.position.x = (currenttimeunderwater - (drowntime - 5))/2*16
			$WaterLabel.texture.region.position.y = 24
