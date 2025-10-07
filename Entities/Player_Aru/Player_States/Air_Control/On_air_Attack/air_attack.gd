extends State

@export var jump_height:float
@export var fall_time:float

@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)
@export var max_speed_on_air:int =100

@export var state_sprite:Sprite2D

func enter():
	core.body.velocity.y = 0.0
	core.player_core.pause_movement()
	super()
	set_animation()
	#await core.animator.animation_finished
	#complete()

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

func play_recover_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play_transition("Transitions/Fall_Transition_E")
	else:
		core.animator.play_transition("Transitions/Fall_Transition_W")

func complete():
	if core.body.is_on_floor():
		play_recover_transition()
		await core.animator.transition_finished
	
	super()
	core.player_core.release_movement()
