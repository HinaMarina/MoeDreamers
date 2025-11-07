extends PlayerState

@export var Jump:PlayerState
@export var Fall:PlayerState

func enter():
	super()
	if core.body.is_on_floor():
		_machine.set_state(Jump)
	else:
		_machine.set_state(Fall)
	
	
func select_state():
	if Jump.is_active() && Jump.is_complete:
		_machine.set_state(Fall)
	if Fall.is_active() && Fall.is_complete:
		complete()
	
func do(delta):
	super(delta)
	select_state()
