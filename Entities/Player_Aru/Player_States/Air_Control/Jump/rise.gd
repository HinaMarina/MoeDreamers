extends State

@export var jump_height:float
@export var peak_time:float

@onready var jump_velocity:float =(-1)*(2*jump_height)/peak_time
@onready var jump_gravity:float = (-1)*(-2*jump_height)/(peak_time*peak_time)
@export var max_speed_on_air:int =100
@export var state_sprite:Sprite2D
@export var transition_to_rise_sprite:Sprite2D

func initialize():
	super()
	state_sprite.flip_h = core.player_core.input_vector.x < 0
	transition_to_rise_sprite.flip_h = core.player_core.input_vector.x < 0
	state_sprite.frame = 0
	core.body.velocity.y = 0
	
func enter():
	super()
	jump()

func _unhandled_input(_event: InputEvent) -> void:
	
	if Input.is_action_just_released("jump"):
		core.body.velocity.y = 0
		complete()
		return
	
		
func get_gravity():
	return jump_gravity

	
func do(delta):
	
	super(delta)
	if !Input.is_action_pressed('jump'):
		complete()
	if lambda_time()>peak_time && is_active():
		complete()
		
func jump():
	core.body.velocity.y = jump_velocity
	sets_animation()

func physics_do(delta):
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.x = core.player_core.xInput*max_speed_on_air
	core.body.move_and_slide()
	
		
func sets_animation():
	if core.player_core.input_vector.x >=0:
		#core.animator.play_transition("Transitions/No_girl_Jump_Anticipation_E")
		#await core.animator.transition_finished
		core.animator.play("Not_Holding_Girl/Jump_Rise_E")
	else:
		#core.animator.play_transition("Transitions/No_girl_Jump_Anticipation_W")
		#await core.animator.transition_finished
		core.animator.play("Not_Holding_Girl/Jump_Rise_W")
