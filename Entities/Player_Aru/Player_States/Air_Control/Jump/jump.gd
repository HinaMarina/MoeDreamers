extends State

@export var Rise:State
@export var Fall:State
@export var coyote_time :=0.3
@export var jump_buffer:= 0.3

var already_jumped:bool = false
func enter():
	already_jumped = false
	set_jump_state()
	super()
	
func initialize():
	super()
	

func set_jump_state():
	if Input.is_action_just_pressed("jump") && core.body.is_on_floor():
		if !already_jumped:
			_machine.set_state(Rise)
		already_jumped = true
	else:
		_machine.set_state(Fall)

func do(delta):
	if lambda_time() <= coyote_time && Input.is_action_just_pressed("jump") && !already_jumped:
		_machine.set_state(Rise)
		already_jumped = true
	super(delta)
	if Rise.is_active() && Rise.is_complete:
	
		rise_to_fall_transition()
		await core.animator.transition_finished
		_machine.set_state(Fall)
	#if _machine.current_state == null:
		#return
	#if _machine.current_state.is_complete:
		#set_jump_state()

func rise_to_fall_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play_transition('Transitions/no_girl_Rise_to_Fall_E')
	else:
		core.animator.play_transition('Transitions/no_girl_Rise_to_Fall_W')

func transition_to_rise():
	if core.player_core.input_vector.x >=0:
		core.animator.play_transition("Transitions/No_girl_Jump_Anticipation_E")
	else:
		core.animator.play_transition("Transitions/No_girl_Jump_Anticipation_W")
