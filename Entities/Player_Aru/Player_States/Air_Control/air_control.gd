extends State

@export var Jump:State
@export var Air_Attack:State

func enter():
	super()

func do(delta):
	super(delta)
	if Jump.is_active() && Jump.is_complete:
		complete()
	if core.player_core.is_inputting_attack():
		_machine.set_state(Air_Attack)
	elif _machine.current_state == null || _machine.current_state.is_complete:
		_machine.set_state(Jump)
	
