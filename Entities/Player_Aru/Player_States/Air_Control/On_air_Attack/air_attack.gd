extends State

@export var jump_height:float
@export var fall_time:float

@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)
@export var max_speed_on_air:int =100

@export var state_sprite:Sprite2D

func enter():
	if core.body.velocity.y<0:
		core.body.velocity.y = 0.0
	core.player_core.pause_movement()
	super()
	set_animation()
	await core.animator.animation_finished
	complete()

func get_gravity():
	return fall_gravity
	
	
func do(delta):
	super(delta)
	if core.body.is_on_floor():
		complete()
		
func physics_do(delta):
	
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.x = core.player_core.xInput*max_speed_on_air
	core.body.move_and_slide()
	
func initialize():
	super()
	state_sprite.frame = 0
	state_sprite.flip_h = core.player_core.input_vector.x<0
	
func set_animation():
	if core.player_core.input_vector.x >= 0:
		core.animator.play("Not_Holding_Girl/On_Air_Attack_E")
	else:
		core.animator.play("Not_Holding_Girl/On_Air_Attack_W")



func complete():
	core.player_core.release_movement()
	super()
	
