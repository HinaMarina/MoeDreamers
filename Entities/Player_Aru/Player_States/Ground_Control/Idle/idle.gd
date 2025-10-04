extends State
@export var friction:= 200
@export var state_sprite2d:Sprite2D

@export var no_blink_texture:Texture2D
@export var blink_texture:Texture2D
var blinked:bool = false

func do(delta):
	super(delta)
	sets_animation_direction()
	blink_update()
	
	

func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2.ZERO,friction)
	core.body.move_and_slide()


func sets_animation_direction():
	if core.player_core.input_vector.x>=0:
		core.animator.play("Not_Holding_Girl/Idle_E")
	else:
		core.animator.play("Not_Holding_Girl/Idle_W")

func blink_update():
	if int(lambda_time())%3 == 0 && !blinked:
		state_sprite2d.texture = blink_texture
		blinked = true
	else:
		blinked = false
		state_sprite2d.texture = no_blink_texture
