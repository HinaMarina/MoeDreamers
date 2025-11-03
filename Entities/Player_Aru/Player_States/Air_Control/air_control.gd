extends PlayerState


@export var Air_Attack:PlayerState
@export var Jump:PlayerState
@export var Fall:PlayerState
@export var Fast_Fall:PlayerState

@export var coyote_time :=0.1
@export var jump_buffer:= 0.1
@export var jump_pressed:float = 0.0

@export var Rise_to_Fall:TransitionState
@export var Air_Attack_to_Fall:TransitionState
@export var Fast_Fall_Recovery:TransitionState
var already_jumped:bool = true

var was_running:bool

signal max_fall_vel_achieved()

func _ready():
	super()
	Fall.max_vel_achieved.connect(on_fall_max_vell)
	


func enter():
	
	if was_running:
		Jump.max_speed_on_air = Jump.speed_on_air + 20
		Fall.max_speed_on_air = Fall.speed_on_air + 20
	else:
		Jump.max_speed_on_air = Jump.speed_on_air
		Fall.max_speed_on_air = Fall.speed_on_air
		
	super()
	already_jumped = false
	set_air_state()
	
	
func initialize():
	super()
	#
func _unhandled_input(event: InputEvent) -> void:
	#this piece of code handles overriding the fall transition if you wanna jump again
	#if (core.animator.get_current_animation() == "Transitions/Fall_Transition_E"
	#|| core.animator.get_current_animation() == "Transitions/Fall_Transition_W"):
		#if Input.is_action_just_pressed("jump"):
			#Fall.is_complete = true
			##transition_to_jump()
			##await core.animator.transition_finished
			#_machine.set_state(Jump)
	if (core.animator.get_current_animation() == "Transitions/no_girl_Rise_to_Fall_E"
	|| core.animator.get_current_animation() == "Transitions/no_girl_Rise_to_Fall_W"):
		if Input.is_action_just_pressed("attack"):
			await core.animator.transition_finished
			
			_machine.set_state(Air_Attack)
		
		
func set_air_state():
	
	if core.body.is_on_floor():
		_machine.set_state(Jump)
		already_jumped = true

		
	if Input.is_action_just_pressed("jump") && core.body.is_on_floor():
		if !already_jumped:
			
			_machine.set_state(Jump)
			
		already_jumped = true
	elif !core.body.is_on_floor() && _machine.current_state!= Jump:
		_machine.set_state(Fall)
		
func coyote_time_checker():
	if !Fall.is_active():
		return
	if lambda_time() < coyote_time && Input.is_action_just_pressed("jump") && !already_jumped:
		_machine.set_state(Jump)
		already_jumped = true

func jump_buffer_checker():
	
	if Input.is_action_just_pressed("jump"):
		jump_pressed = jump_buffer ## Resets the value when jump pressed when falling
		
	if core.body.is_on_floor() && jump_pressed > 0 && core.player_core.is_inputting_jump(): 
		## verifies if is grounded before jump_buffer amount
	

		_machine.set_state(Jump)
		return
			
	elif core.body.is_on_floor():
		complete()

func do(delta):
	#if Fall.is_active():
		#already_jumped = true
	#print("my machine is set to " + _machine.current_state.name)
	#if Jump.is_active():
		#Fall.is_complete = true
	
	jump_pressed -= delta #decreases the value in the amount of time since pressed

	if Fast_Fall_Recovery.is_active() && !Fast_Fall_Recovery.is_complete:
		return
	if Fast_Fall_Recovery.is_active() && Fast_Fall_Recovery.is_complete:
		complete()
	
	if Fast_Fall.is_active() && Fast_Fall.is_complete:
		_machine.set_state(Fast_Fall_Recovery)

	if Air_Attack_to_Fall.is_active() && !Air_Attack_to_Fall.is_complete:
		return
	if Air_Attack_to_Fall.is_active() && Air_Attack_to_Fall.is_complete:
		_machine.set_state(Fall)
	if Rise_to_Fall.is_active() && !Rise_to_Fall.is_complete:
		if core.player_core.is_inputting_attack():
			_machine.set_state(Air_Attack)
		else:
			return
	if Rise_to_Fall.is_active() && Rise_to_Fall.is_complete:
		_machine.set_state(Fall)
	if Air_Attack.is_active() && !Air_Attack.is_complete:
		return
	
	if Air_Attack.is_active() && Air_Attack.is_complete:

		_machine.set_state(Air_Attack_to_Fall)
	
	
	if core.player_core.is_inputting_attack(): #handles overriding the jump PlayerState with the attack
		if Fast_Fall.is_active() || Fast_Fall_Recovery.is_active():
			return
		if Jump.is_active() && !Jump.can_be_override_checker():
			await Jump.can_be_override
		_machine.set_state(Air_Attack)
		
	if Jump.is_active() && Jump.is_complete:
		
		_machine.set_state(Rise_to_Fall)
	
	if Fall.is_active():
		coyote_time_checker()
		jump_buffer_checker()
	#

	super(delta)
	
	if Fast_Fall.is_active() && !Fast_Fall.is_complete:
		return
	

func on_fall_max_vell():
	_machine.set_state(Fast_Fall)

func complete():
	super()
	#clear_machine()
