extends State

@export var Ground_Control:State
@export var Air_Control:State

func select_state():
	if core.player_core.is_inputting_jump():
		_machine.set_state(Air_Control)
		
	if core.body.is_on_floor():
		_machine.set_state(Ground_Control)
	
func do(delta):
	super(delta)
	select_state()
