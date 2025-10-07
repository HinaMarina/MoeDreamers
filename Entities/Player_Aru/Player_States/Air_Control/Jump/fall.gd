extends State

@export var jump_height:float
@export var fall_time:float

@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)
@export var max_speed_on_air:int =100

@export var state_sprite:Sprite2D

func initialize():
	super()
	state_sprite.flip_h = core.player_core.input_vector.x < 0
	state_sprite.frame = 3

func get_gravity():
	return fall_gravity

func enter():
	super()
	if core.body.is_on_floor():
		complete()
	
func physics_do(delta):
	
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.x = core.player_core.xInput*max_speed_on_air
	core.body.move_and_slide()
	
func do(delta):
	if core.body.is_on_floor():
		complete()
	super(delta)
	sets_animation()
	
func sets_animation():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Not_Holding_Girl/Jump_Fall_E")
	else:
		core.animator.play("Not_Holding_Girl/Jump_Fall_W")

func play_fall_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play_transition("Transitions/Fall_Transition_E")
	else:
		core.animator.play_transition("Transitions/Fall_Transition_W")

func complete():
	play_fall_transition()
	await core.animator.transition_finished
	super()
