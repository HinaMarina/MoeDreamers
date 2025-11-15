extends PlayerState

@export var Jump:PlayerState
@export var Fall:PlayerState
@export var Gliding:PlayerState

@export var Air_To_Gliding:TransitionState
func enter():
	super()
	if core.body.is_on_floor():
		_machine.set_state(Jump)
	else:
		_machine.set_state(Fall)
	
	
func select_state():
	
	if Gliding.is_active() && Gliding.is_complete:
		if core.body.is_on_floor():
			complete()
		else:
			_machine.set_state(Fall)
	
	if Air_To_Gliding.is_active() && Air_To_Gliding.is_complete:
		if Input.is_action_pressed("glide"):
			_machine.set_state(Gliding)
		else:
			_machine.set_state(Fall)
		
	if Jump.is_active() && Jump.is_complete:
		_machine.set_state(Fall)
		
	elif !Jump.is_complete:
		if Input.is_action_just_pressed("glide"):
			_machine.set_state(Air_To_Gliding)
			
	if Fall.is_active() && Fall.is_complete:
		complete()
	elif !Fall.is_complete:
		if Input.is_action_just_pressed("glide"):
			_machine.set_state(Air_To_Gliding)
	
func do(delta):
	super(delta)
	select_state()
