extends PlayerState

@export var Ground_Control:PlayerState
@export var Air_Control:PlayerState
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
		if Input.is_action_just_pressed('jump'):
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
		if core.player_core.is_inputting_attack():
			if !core.body.is_on_floor():
				_machine.set_state(Air_Control)
				Air_Control._machine.set_state(Air_Control.Air_Attack)
				return
			else:
				_machine.set_state(Ground_Control)
				Ground_Control._machine.set_state(Ground_Control.Ground_Attack)
				return
		if Ground_to_Air.lambda_time() > Air_Control.coyote_time:
			return
		if Input.is_action_just_pressed("jump") && !core.body.is_on_floor():
			_machine.set_state(Air_Control)
			Air_Control._machine.set_state(Air_Control.Jump)
			return
		
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
		if Air_Control._machine.last_state == Air_Control.Fast_Fall:
			#this piece of the code will make Ground Control forget if it was Running Before the Fast Fall
			Ground_Control.last_before_completing = null
			Ground_Control._machine.last_state = null
			Ground_Control._machine.set_state(Ground_Control.Idle)
			core.body.velocity.x = 0
			
			_machine.set_state(Ground_Control)
			
			return
		_machine.set_state(Air_to_Ground)
		
	
	
	
func do(delta):
	select_state()
	super(delta)
	
