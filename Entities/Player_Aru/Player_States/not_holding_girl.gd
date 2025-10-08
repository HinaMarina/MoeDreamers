extends State

@export var Ground_Control:State
@export var Air_Control:State

func select_state():
	#if _machine.current_state!= null && _machine.current_state.is_complete == false:
		#return
	if Input.is_action_just_pressed("jump") && core.player_core.can_player_move && core.body.is_on_floor():
		
		_machine.set_state(Air_Control)
		return
		
	elif !core.body.is_on_floor():
		
		_machine.set_state(Air_Control)
		return
		
	elif Air_Control.is_complete && Air_Control.is_active():
		
		_machine.set_state(Ground_Control)
		
	
	
	
func do(delta):
	select_state()
	super(delta)
	
