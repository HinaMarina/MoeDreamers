extends State

@export var Ground_Control:State
@export var Air_Control:State
@export var Ground_to_Air:TransitionState
@export var Air_to_Ground:TransitionState

func enter():
	super()
	if core.body.is_on_floor():
		_machine.set_state(Ground_Control)
	else:
		_machine.set_state(Ground_to_Air)


func select_state():
	
	if Air_to_Ground.is_active() && !Air_to_Ground.is_complete:
		if core.player_core.is_inputting_jump():
			Air_to_Ground.complete()
			_machine.set_state(Ground_to_Air)
			return
		elif core.player_core.is_inputting_attack():
			Air_to_Ground.complete()
			_machine.set_state(Ground_Control)
			return
		else:
			return
	
		
	if Air_to_Ground.is_active() && Air_to_Ground.is_complete:
		
		_machine.set_state(Ground_Control)
		return
		
	if Ground_to_Air.is_active() && !Ground_to_Air.is_complete:
		return
		
	if Ground_to_Air.is_active() && Ground_to_Air.is_complete:
		_machine.set_state(Air_Control)
		return
	
	if Ground_Control.is_active() && !core.body.is_on_floor():
		Ground_Control.complete()
		_machine.set_state(Ground_to_Air)
		return
	
	if Ground_Control.is_active():
		if Input.is_action_just_pressed("jump"):
			Ground_Control.complete()
			_machine.set_state(Ground_to_Air)
			return	
	
	
	
		
	if Air_Control.is_complete && Air_Control.is_active():
		
		_machine.set_state(Air_to_Ground)
		
	
	
	
func do(delta):
	select_state()
	super(delta)
	
