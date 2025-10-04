extends State

@export var Idle:State
@export var Move:State
@export var Ground_Attack:State

func select_state():
	if core.player_core.is_inputting_attack():
		_machine.set_state(Ground_Attack)
	elif core.player_core.xInput != 0:
		_machine.set_state(Move)
	elif core.body.is_on_floor():
		_machine.set_state(Idle)

func do(delta):
	super(delta)
	select_state()
	if !core.body.is_on_floor():
		complete()
	
