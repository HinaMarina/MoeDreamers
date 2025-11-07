extends PlayerState
@export var Idle:PlayerState
@export var Walk:PlayerState


func enter():
	super()
	select_state()
		
func select_state():
	if core.player_core.xInput != 0:
		_machine.set_state(Walk)
	else:
		_machine.set_state(Idle)

func do(delta):
	select_state()
	super(delta)
