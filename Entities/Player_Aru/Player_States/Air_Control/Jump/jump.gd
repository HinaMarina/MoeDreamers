extends State

@export var jump_height:float
@export var peak_time:float

@onready var jump_velocity:float =(-1)*(2*jump_height)/peak_time
@onready var jump_gravity:float = (-1)*(-2*jump_height)/(peak_time*peak_time)

@export var max_speed_on_air:int =100
@export var state_sprite:Sprite2D

var difference_waiting:bool = false
@onready var min_height = jump_height/3
@onready var full_time = peak_time
signal can_be_override

func initialize():
	super()
	
	state_sprite.frame = 0
	core.body.velocity.y = 0
	
	difference_waiting = false
	jump_height = min_height*3
	peak_time = full_time

func can_be_override_checker():
	return !lambda_time()<full_time/3
	
func enter():
	super()
	jump()
	is_jump_already_released()




func get_gravity():
	return jump_gravity

	
func do(delta):
	if lambda_time() > full_time/3:
		can_be_override.emit()
	if lambda_time()< full_time/3:
		is_jump_already_released()

	super(delta)
	if lambda_time()>peak_time && is_active():
		core.body.velocity.y = 0
		complete()

func is_jump_already_released():
	if !Input.is_action_pressed('jump'):
		if !difference_waiting:
			peak_time = full_time/3
			jump_height = min_height/3
			difference_waiting = true

			
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

		core.animator.play("Not_Holding_Girl/Jump_Rise_E")
	else:
		
		core.animator.play("Not_Holding_Girl/Jump_Rise_W")
