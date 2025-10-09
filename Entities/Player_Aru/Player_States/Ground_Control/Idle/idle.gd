extends State
@export var friction:= 25
@export var state_sprite:Sprite2D

@export var no_blink_texture:Texture2D
@export var blink_texture:Texture2D
var blinked:bool = false

func enter():
	sets_animation_direction()

func do(delta):
	super(delta)
	blink_update()
	
	
	
	

func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2.ZERO,friction)
	core.body.move_and_slide()


func sets_animation_direction():
	if core.player_core.input_vector.x>=0:
		state_sprite.flip_h = false
		core.animator.play("Not_Holding_Girl/Idle_E")
	else:
		state_sprite.flip_h = true
		core.animator.play("Not_Holding_Girl/Idle_W")

func blink_update():
	if int(lambda_time())%3 == 0:
		state_sprite.texture = blink_texture
		await get_tree().create_timer(0.7).timeout
		state_sprite.texture = no_blink_texture
