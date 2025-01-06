extends Node2D

@onready var blackbar = $"BlackBar(mainMenu)-SonicAndMarsh"
@onready var whitebar = $"WhiteBar(mainMenu)-SonicAndMarsh"
@onready var bgbar = $"Background(mainMenu)-SonicAndMarsh(3)"
@onready var mainmenutext = $"MainMenuText-SonicAndMarsh"
@onready var mainmenutextshadow = $"MainMenuTextShadow-SonicAndMarsh2"
@onready var tb1 = $"TextBarStory(mainMenu)-SonicAndMarsh"
@onready var tb2 = $"TextBarOptions(mainMenu)-SonicAndMarsh2"
@onready var tb3 = $"TextBarCredits(mainMenu)-SonicAndMarsh3"
@onready var stb1 = $"TextBarStoryShadow(mainMenu)-SonicAndMarsh2"
@onready var stb2 = $"TextBarOptionsShadow(mainMenu)-SonicAndMarsh3"
@onready var stb3 = $"TextBarCreditsShadow(mainMenu)-SonicAndMarsh4"
@onready var storymodetext = $"StoryMode-SonicAndMarsh"
@onready var optionstext = $"optionstext"
@onready var creditstext = $"CreditsText-SonicAndMarsh"
@onready var storymodetextshadow = $"StoryModeShadow-SonicAndMarsh2"
@onready var optionstextshadow = $"optionstextshadow"
@onready var creditstextshadow = $"CreditsTextShadow-SonicAndMarsh2"
@onready var activebar = $"ActiveBar(mainMenu)-SonicAndMarsh(2)"
@onready var crect2 = $"ColorRect2"
@onready var vmzbg = $"VibrantMeadowBackground-1"
@onready var vmzmmbg = $"MainMenuMeadowBackground-2"
@onready var rect1 = $"ColorRect"
@onready var marsh = $"marshhh"
@onready var sonic = $"sonikku"
@onready var smbutt = $"StoryMode-SonicAndMarsh/storymodebutton"
@onready var optionsbutt = $"optionstext/optionsbutton"
@onready var creditsbutt = $"CreditsText-SonicAndMarsh/creditbutton"
@onready var volume = $"Volume(options)-SonicAndMarsh"
@onready var sfx = $"SfxVolume(options)-SonicAndMarsh"
@onready var backoptions = $"Back(options)-SonicAndMarsh"
@onready var volumesha = $"VolumeShadow(options)-SonicAndMarsh2"
@onready var sfxsha = $"SfxVolumeShadow(options)-SonicAndMarsh2"
@onready var backoptionssha = $"BackShadow(options)-SonicAndMarsh2"
@onready var backcredits = $"Back(credits)-SonicAndMarsh2"
@onready var backcreditssha = $"BackShadow(credits)-SonicAndMarsh3"
@onready var onv = $"On(volume, options)-SonicAndMarsh"
@onready var onsfxv = $"On(sfxvolume, options)-SonicAndMarsh2"
@onready var onvsha = $"OnShadow(volume, options)-SonicAndMarsh2"
@onready var onsfxvsha = $"OnShadow(sfxvolume, options)-SonicAndMarsh3"
@onready var galaxy = $"Galaxy(credits)-SonicAndMarsh"
@onready var galaxysha = $"GalaxyShadow(credits)-SonicAndMarsh2"
@onready var slime = $"Slimette(credits)-SonicAndMarsh"
@onready var slimesha = $"SlimetteShadow(credits)-SonicAndMarsh2"
@onready var sega = $"Sega(credits)"
@onready var segasha = $"SegaShadow(credits)"
@onready var st = $"SonicTeam(credits)-SonicAndMarsh"
@onready var stsha = $"SonicTeamShadow(credits)-SonicAndMarsh2"
@onready var onvbutt = $"On(volume, options)-SonicAndMarsh/onvolumebutton"
@onready var onsfxbutt = $"On(sfxvolume, options)-SonicAndMarsh2/onsfxbutton"
@onready var backbuttopt = $"Back(options)-SonicAndMarsh/backbutt(opt)"
@onready var backbuttcred = $"Back(credits)-SonicAndMarsh2/backbutt(credits)"
@onready var playa = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
var notclickedoption = true
var notclickedcredit = true

func _ready():
	pass # Replace with function body.
	# black bar final location - 795x 324y
	# white bar final location - 856x 324y
	# background final location - 613x 324y
	playa.play()
	marsh.play("default")
	sonic.play("default")
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(blackbar, "position",Vector2(795,324), 1)
	await get_tree().create_timer(0.2).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(whitebar, "position",Vector2(856,324), 1)
	await get_tree().create_timer(0.2).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(bgbar, "position",Vector2(613,324), 1)
	await get_tree().create_timer(0.7).timeout
	activebartween()
	# main menu text (shadow) final location - 480x 345y
	# tb1  final location - 1150x 324y
	# tb2  final location - 1125x 454y
	# tb3 final location - 1100x 584y
	# story mode text final location - 547x 374y
	# active bar initial location - 459x 826y
	basicsappear()
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(rect1, "modulate",Color(1,1,1,0), 1)
	
func activebartween():
	var neg = create_tween()  # - new tween
	neg.set_ease(Tween.EASE_IN)
	neg.set_trans(Tween.TRANS_LINEAR)
	neg.tween_property(activebar, "position",Vector2(730,-171), 4)
	await neg.finished
	activebar.position = Vector2(459,826)
	activebartween()
	
func basicsappear():
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb1, "position",Vector2(1150,324), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(515,374), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(mainmenutext, "position",Vector2(480,345), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb2, "position",Vector2(1125,454), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "position",Vector2(515,200), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb3, "position",Vector2(1100,584), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "position",Vector2(515,483), 1)
	await get_tree().create_timer(0.5).timeout
	mainmenutextshadow.modulate.a = 1
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(mainmenutext, "position",Vector2(460,325), 0.09)
	backbuttopt.disabled = true
	backbuttcred.disabled = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vmzbg.region_rect.position += Vector2(4, 0)
	vmzmmbg.region_rect.position += Vector2(7, 0)
	
func _on_storymodebutton_mouse_entered():
	storymodetextshadow.modulate.a = 1
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(495,354), 0.2)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(tb1, "position",Vector2(1225,324), 0.09)
	await get_tree().create_timer(0.09).timeout
	stb1.modulate.a = 1
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb1, "position",Vector2(1250,354), 0.05)


func _on_storymodebutton_mouse_exited():
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(515,374), 0.2)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(tb1, "position",Vector2(1150,324), 0.09)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb1, "position",Vector2(1225,324), 0.05)
	await get_tree().create_timer(0.05).timeout
	stb1.modulate.a = 0
	await get_tree().create_timer(0.15).timeout


func _on_storymodebutton_pressed():
	creditsbutt.disabled = true
	creditsbutt.visible = false
	optionsbutt.disabled = true
	optionsbutt.visible = false
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(crect2, "modulate",Color(1,1,1,1), 1)
	await tween.finished
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($"AudioStreamPlayer", "volume_db",-80, 3)
	await tween.finished
	get_tree().change_scene_to_file("res://vmza1cutscene.tscn")

func _on_optionsbutton_mouse_entered():
	optionstextshadow.modulate.a = 1
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "position",Vector2(495,180), 0.2)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(tb2, "position",Vector2(1200,454), 0.09)
	await get_tree().create_timer(0.09).timeout
	stb2.modulate.a = 1
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb2, "position",Vector2(1225,484), 0.05)


func _on_optionsbutton_mouse_exited():
	if notclickedoption:
		var tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_SPRING)
		tween.tween_property(optionstext, "position",Vector2(515,200), 0.2)
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(tb2, "position",Vector2(1125,454), 0.09)
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(stb2, "position",Vector2(1200,454), 0.05)
		await get_tree().create_timer(0.05).timeout
		stb2.modulate.a = 0
		await get_tree().create_timer(0.15).timeout


func _on_optionsbutton_pressed():
	smbutt.disabled = true
	smbutt.visible = false
	creditsbutt.disabled = true
	creditsbutt.visible = false
	onvbutt.disabled = false
	onsfxbutt.disabled = false
	backbuttopt.visible = true
	backbuttopt.disabled = false
	notclickedcredit=false
	notclickedoption=false
	creditstextshadow.modulate.a = 0
	storymodetextshadow.modulate.a = 0
	stb1.modulate.a = 0
	stb2.modulate.a = 0
	stb3.modulate.a = 0
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb1, "position",Vector2(1115,324), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(1647,374), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(mainmenutext, "position",Vector2(480,345), 0.09)
	mainmenutextshadow.modulate.a = 0
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(mainmenutext, "position",Vector2(480,150), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb2, "position",Vector2(1115,454), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "position",Vector2(350,-250), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstextshadow, "position",Vector2(370,-230), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "scale",Vector2(3.5,3.5), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstextshadow, "scale",Vector2(3.5,3.5), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb3, "position",Vector2(1115,584), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "position",Vector2(1647,483), 1)
	optionsbutt.disabled = true
	optionsbutt.visible = false
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(volume, "position",Vector2(675,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sfx, "position",Vector2(736,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptions, "position",Vector2(641,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(volumesha, "position",Vector2(675,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sfxsha, "position",Vector2(736,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptionssha, "position",Vector2(641,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onv, "position",Vector2(1075,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onsfxv, "position",Vector2(1075,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onvsha, "position",Vector2(1075,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onsfxvsha, "position",Vector2(1075,411), 1)
	await get_tree().create_timer(0.5).timeout
	volumesha.modulate.a = 1
	sfxsha.modulate.a = 1
	backoptionssha.modulate.a = 1
	onvsha.modulate.a = 1
	onsfxvsha.modulate.a = 1
	await get_tree().create_timer(0.4).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(volume, "position",Vector2(661,271), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sfx, "position",Vector2(721,396), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onv, "position",Vector2(1060,271), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onsfxv, "position",Vector2(1060,396), 0.5)

func _on_creditbutton_mouse_entered():
	creditstextshadow.modulate.a = 1
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "position",Vector2(495,463), 0.2)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(tb3, "position",Vector2(1175,584), 0.09)
	await get_tree().create_timer(0.09).timeout
	stb3.modulate.a = 1
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb3, "position",Vector2(1200,614), 0.05)


func _on_creditbutton_mouse_exited():
	if notclickedcredit:
		var tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_SPRING)
		tween.tween_property(creditstext, "position",Vector2(515,483), 0.2)
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(tb3, "position",Vector2(1100,584), 0.09)
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(stb3, "position",Vector2(1175,584), 0.05)
		await get_tree().create_timer(0.05).timeout
		stb3.modulate.a = 0
		await get_tree().create_timer(0.15).timeout


func _on_creditbutton_pressed():
	backbuttcred.visible = true
	backbuttcred.disabled = false
	smbutt.disabled = true
	smbutt.visible = false
	optionsbutt.disabled = true
	optionsbutt.visible = false
	notclickedcredit = false
	optionstextshadow.modulate.a = 0
	storymodetextshadow.modulate.a = 0
	stb1.modulate.a = 0
	stb2.modulate.a = 0
	stb3.modulate.a = 0
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb1, "position",Vector2(2100,324), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(1647,374), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(mainmenutext, "position",Vector2(480,345), 0.09)
	mainmenutextshadow.modulate.a = 0
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(mainmenutext, "position",Vector2(480,150), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb2, "position",Vector2(2125,454), 1)
	tween =create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "position",Vector2(350,-10), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstextshadow, "position",Vector2(370,15), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "scale",Vector2(3.5,3.5), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstextshadow, "scale",Vector2(3.5,3.5), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb3, "position",Vector2(1115,584), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "position",Vector2(1647,200), 1)
	creditsbutt.disabled = true
	creditsbutt.visible = false
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcredits, "position",Vector2(641,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcreditssha, "position",Vector2(641,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(galaxy, "position",Vector2(695,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(galaxysha, "position",Vector2(695,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(slime, "position",Vector2(954,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(slimesha, "position",Vector2(954,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(st, "position",Vector2(990,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(stsha, "position",Vector2(990,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sega, "position",Vector2(666,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(segasha, "position",Vector2(666,390), 1)
	await get_tree().create_timer(0.5).timeout
	backcreditssha.modulate.a = 1
	await get_tree().create_timer(0.4).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(slime, "position",Vector2(939,243), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(galaxy, "position",Vector2(680,243), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(st, "position",Vector2(975,375), 0.5)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sega, "position",Vector2(651,375), 0.5)
	
func _on_backbuttcredits_pressed():
	backbuttcred.visible = false
	backbuttcred.disabled = true
	stb1.modulate.a = 0
	stb2.modulate.a = 0
	stb3.modulate.a = 0
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcredits, "position",Vector2(641,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(galaxy, "position",Vector2(695,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(slime, "position",Vector2(954,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(st, "position",Vector2(990,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sega, "position",Vector2(666,390), 1)
	await get_tree().create_timer(0.8).timeout
	backcreditssha.modulate.a = 0
	stb3.modulate = Color(0.643, 0.643, 0.643)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(galaxy, "position",Vector2(1616,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(galaxysha, "position",Vector2(1616,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(slime, "position",Vector2(1875,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(slimesha, "position",Vector2(1875,258), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sega, "position",Vector2(1587,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(segasha, "position",Vector2(1587,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(st, "position",Vector2(1911,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(stsha, "position",Vector2(1911,390), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcredits, "position",Vector2(1291,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcreditssha, "position",Vector2(1291,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb1, "position",Vector2(1150,324), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(515,374), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb2, "position",Vector2(1125,454), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb3, "position",Vector2(1100,584), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "position",Vector2(515,200), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "scale",Vector2(2.3,2.3), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstextshadow, "scale",Vector2(2.3,2.3), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "position",Vector2(515,483), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstextshadow, "position",Vector2(515,483), 1)
	await tween.finished
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(mainmenutext, "position",Vector2(480,345), 0.5)
	await get_tree().create_timer(0.5).timeout
	mainmenutextshadow.modulate.a = 1
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(mainmenutext, "position",Vector2(460,325), 0.09)
	optionsbutt.visible = true
	optionsbutt.disabled = false
	creditsbutt.visible = true
	creditsbutt.disabled = false
	smbutt.disabled = false
	smbutt.visible = true
	notclickedcredit = true
	notclickedoption = true

func _on_backbuttopt_pressed():
	backbuttopt.visible = false
	backbuttopt.disabled = true
	stb1.modulate.a = 0
	stb2.modulate.a = 0
	stb3.modulate.a = 0
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onv, "position",Vector2(1075,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptions, "position",Vector2(641,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onsfxv, "position",Vector2(1075,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(volume, "position",Vector2(675,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sfx, "position",Vector2(736,411), 1)
	await get_tree().create_timer(0.8).timeout
	stb3.modulate = Color(0.643, 0.643, 0.643)
	backoptionssha.modulate.a = 0
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onv, "position",Vector2(1669,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onvsha, "position",Vector2(1669,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onsfxv, "position",Vector2(1669,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(onsfxvsha, "position",Vector2(1669,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(volume, "position",Vector2(1325,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(volumesha, "position",Vector2(1325,286), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sfx, "position",Vector2(1386,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sfxsha, "position",Vector2(1386,411), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptions, "position",Vector2(1291,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptionssha, "position",Vector2(1291,536), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb1, "position",Vector2(1150,324), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(storymodetext, "position",Vector2(515,374), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb2, "position",Vector2(1125,454), 1)
	await get_tree().create_timer(0.1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(tb3, "position",Vector2(1100,584), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(creditstext, "position",Vector2(515,483), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "scale",Vector2(2.3,2.3), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstextshadow, "scale",Vector2(2.3,2.3), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstext, "position",Vector2(515,200), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(optionstextshadow, "position",Vector2(515,200), 1)
	await tween.finished
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(mainmenutext, "position",Vector2(480,345), 0.5)
	await get_tree().create_timer(0.5).timeout
	mainmenutextshadow.modulate.a = 1
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(mainmenutext, "position",Vector2(460,325), 0.09)
	optionsbutt.visible = true
	optionsbutt.disabled = false
	creditsbutt.visible = true
	creditsbutt.disabled = false
	onvbutt.disabled = true
	onsfxbutt.disabled = true
	smbutt.disabled = false
	smbutt.visible = true
	notclickedcredit = true
	notclickedoption = true

func _on_onvolumebutton_pressed():
	pass # Replace with function body.

func _on_onsfxbutton_pressed():
	pass # Replace with function body.


func _on_backbuttopt_mouse_entered():
	stb3.modulate = Color(0.67, 0.619, 0.043)
	var tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptions, "position",Vector2(626,521), 0.2)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb3, "position",Vector2(1150,609), 0.09)

func _on_backbuttopt_mouse_exited():
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backoptions, "position",Vector2(641,536), 0.5)
	await get_tree().create_timer(0.2).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb3, "position",Vector2(1115,584), 0.09)

func _on_backbuttcredits_mouse_entered():
	stb3.modulate = Color(0.67, 0.619, 0.043)
	var tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcredits, "position",Vector2(626,521), 0.2)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb3, "position",Vector2(1150,609), 0.09)


func _on_backbuttcredits_mouse_exited():
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(backcredits, "position",Vector2(641,536), 0.5)
	await get_tree().create_timer(0.2).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(stb3, "position",Vector2(1115,584), 0.09)
