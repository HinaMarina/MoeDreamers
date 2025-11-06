extends PlayerState
@export var Idle:PlayerState

func enter():
	super()
	_machine.set_state(Idle)
