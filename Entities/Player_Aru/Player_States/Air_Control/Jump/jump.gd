extends State

@export var Rise:State
@export var Fall:State

func enter():
	super()
	set_jump_state()

func set_jump_state():
	if Input.is_action_just_pressed("jump"):
		_machine.set_state(Rise)
	else:
		_machine.set_state(Fall)

func do(delta):
	super(delta)
	if Rise.is_active() && Rise.is_complete:
		rise_to_fall_transition()
		await core.animator.transition_finished
		
	if _machine.current_state.is_complete:
		set_jump_state()

func rise_to_fall_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play_transition('Transitions/no_girl_Rise_to_Fall_E')
	else:
		core.animator.play_transition('Transitions/no_girl_Rise_to_Fall_W')
