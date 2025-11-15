extends PlayerState


@export var Air_Control:PlayerState
@export var Ground_Control:PlayerState

func enter():
	super()
	if core.body.is_on_floor():
		_machine.set_state(Ground_Control)
	else:
		Ground_Control.complete()
		_machine.set_state(Air_Control)

func select_state():
	if Ground_Control.is_active():
		if Input.is_action_just_pressed("jump"):
			Ground_Control.complete()
			_machine.set_state(Air_Control)
			return
		if !core.body.is_on_floor():
			_machine.set_state(Air_Control)
			return
			
	if Air_Control.is_active() && Air_Control.is_complete:
		_machine.set_state(Ground_Control)

func do(delta):
	super(delta)
	select_state()
