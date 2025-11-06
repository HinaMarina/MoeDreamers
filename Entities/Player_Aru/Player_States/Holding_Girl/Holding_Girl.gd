extends PlayerState


@export var Air_Control:PlayerState
@export var Ground_Control:PlayerState

func enter():
	super()
	if core.body.is_on_floor():
		_machine.set_state(Ground_Control)
