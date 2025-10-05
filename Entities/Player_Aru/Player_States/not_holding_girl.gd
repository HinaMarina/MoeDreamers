extends State

@export var Ground_Control:State
@export var Air_Control:State

func select_state():
	if core.body.is_on_floor():
		_machine.set_state(Ground_Control)
		
	if Input.is_action_just_pressed("jump") || !core.body.is_on_floor():
		_machine.set_state(Air_Control)
		
	
	
func do(delta):
	super(delta)
	select_state()
