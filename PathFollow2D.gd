extends PathFollow2D
var tween
var loopdistance
var canenterleftloop = false
var loopstart : bool
@onready var sprite = $AnimatedSprite2D
@export var remotetransform : RemoteTransform2D
var speed : float
var currentdirection : int
var charbody
var leavingright : bool = true

const deccelrate = 0.96
const accelrate = 1.05
const maxspeed = 500
const speed_for_full_loop = 400
const speed_to_stop_loop = 300
const levelsofspeed = 8
const LEFT = -1
const RIGHT = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if loopstart:
		if speed < speed_to_stop_loop:
			return_to_marsh()
		var direction = Input.get_axis("ui_left","ui_right")
		#if (currentdirection != direction or direction == 0) and progress_ratio < 0.38:
			#speed = speed * deccelrate
			##matchtweentospeed()
			#if speed < maxspeed:
				#if !(sprite.animation == "marshrun" or sprite.animation == "marshjump"):
					#sprite.animation = "marshrun"
			#else:
				#if  sprite.animation != "marshjump":
					#sprite.animation = "marshfullspeed"
					#sprite.play()
		#else:
			#if speed < maxspeed:
				#if !(sprite.animation == "marshrun" or sprite.animation == "marshjump") :
					#sprite.animation = "marshrun"
				#speed = speed * accelrate
				##matchtweentospeed()
			#else:
				#if sprite.animation != "marshjump":
					#sprite.animation = "marshfullspeed"
					#sprite.play()
		if Input.is_action_just_pressed("jump"):	
			return_to_marsh()

func _on_area_2d_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic"  :
		charbody = body
		if body.currentdirection == RIGHT:
			if body.speed>speed_for_full_loop:
				leavingright = true
				print("karate")
				print("wait a minute")
				progress_ratio = 0.27
				currentdirection = body.currentdirection
				speed = body.speed
				loopstart = true
				sprite.flip_h = false
				if body.name == "Marsh":
					sprite.animation = "marsh" + body.animsprite.animation
					print( "marsh" + body.animsprite.animation )
				else:
					sprite.animation = "sonic" + body.animsprite.animation
				sprite.visible = true
				body.animsprite.visible = false
				sprite.play()
				remotetransform.update_position = true
				body.stopmovement(15)
				tween = create_tween()
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(self, "progress_ratio",1, 1)
				await tween.finished
				if loopstart:
					return_to_marsh()
					

func matchtweentospeed():
	var step = (speed_for_full_loop-speed_to_stop_loop)/levelsofspeed
	for level in range(levelsofspeed):
		if speed > speed_for_full_loop - (step * (level + 1.5)):
			tween.pause()
			tween.set_speed_scale((10.0-level)/10.0)
			tween.play() 
			break


func _on_startpoint_2_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic"  :
		if body.currentdirection == LEFT:
				charbody = body
				if body.speed>speed_for_full_loop:
					leavingright = false
					print("holup")
					print("huhh")
					progress_ratio = 0.66
					currentdirection = body.currentdirection
					speed = body.speed
					loopstart = true
					sprite.flip_h = true
					if body.name == "Marsh":
						print("y00000000eas")
						sprite.animation = "marsh" + body.animsprite.animation
					else:
						print("yeas")
						sprite.animation = "sonic" + body.animsprite.animation
					sprite.visible = true
					body.animsprite.visible = false
					sprite.play()
					remotetransform.update_position = true
					#sprite.get_node("Camera2D").enabled = true
					#body.get_node("Camera2D").enabled = false
					body.stopmovement(15)
					tween = create_tween()  
					tween.set_ease(Tween.EASE_IN)
					tween.set_trans(Tween.TRANS_LINEAR)
					tween.tween_property(self, "progress_ratio",0, 1)
					await tween.finished
					if loopstart:
						return_to_marsh()
					

func return_to_marsh():
	print("returned tp marsh")
	#charbody.global_position = sprite.global_position
	if charbody.name == "Marsh":
		charbody.animsprite.animation = sprite.animation.replace("marsh","")
		print(sprite.animation.replace("marsh",""))
		print(charbody.rolling)
	
	remotetransform.update_position = false
	charbody.animsprite.visible = true
	sprite.visible = false
	charbody.startmovement(speed - 50)
	loopstart = false

