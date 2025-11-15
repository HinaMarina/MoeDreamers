extends PlayerState
@export var Idle:PlayerState
@export var Walk:PlayerState
@export var Run:PlayerState

func enter():
	super()
	if _machine.last_state == Run && core.body.velocity.x != 0:
		_machine.set_state(Run)
	else:
		
		
		select_state()
		
func select_state():
	#if Run.is_active() && Run.is_complete:
		#_machine.set_state(Idle)
	if Run.is_active() && !Run.is_complete:
		return
	if core.player_core.xInput != 0:
		_machine.set_state(Walk)
	else:
		_machine.set_state(Idle)
		
func _unhandled_input(event: InputEvent) -> void:
	if !is_active():
		return
	if core.player_core.double_tapped_checker(event):
		_machine.set_state(Run)
		
func do(delta):
	select_state()
	super(delta)
	
func complete():
	_machine.last_state = _machine.current_state
