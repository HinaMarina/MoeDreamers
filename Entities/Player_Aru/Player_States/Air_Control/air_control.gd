extends State

@export var Jump:State
@export var Air_Attack:State

func enter():
	super()

func do(delta):
	super(delta)
	if core.player_core.is_inputting_attack():
		_machine.set_state(Air_Attack)
	else:
		_machine.set_state(Jump)
	
