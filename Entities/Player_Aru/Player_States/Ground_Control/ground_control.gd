extends PlayerState

@export var Idle:PlayerState

@export var Run:PlayerState
@export var Walk:PlayerState
@export var On_Edge:PlayerState
@export var Ground_Attack:PlayerState

@export var Turning_Backwards:TransitionState
@export var Stop_Running:TransitionState
@export var Ground_Attack_Recover:TransitionState

var last_before_completing:PlayerState


func enter():
	super()
	if last_before_completing==Run && core.body.velocity.x != 0:
		_machine.set_state(Run)
		last_before_completing = null
	

func _ready():
	super()
	

	await tree_is_set ## Everything after this will be processed after PlayerState tree is set
	core.player_core.turned_backwards.connect(on_player_turned_backwards)

	

	
func select_state():
	if (_machine.current_state != null 
	&& _machine.last_state == Run 
	&& _machine.current_state.is_complete
	&& _machine.current_state!=Stop_Running
	):
		if _machine.current_state == Ground_Attack:
			if !Input.is_action_pressed("movement_action"):
				_machine.set_state(Ground_Attack_Recover)
				return
		_machine.set_state(Run)
		
	
		return
	if Idle.is_active() && core.player_core.xInput!=0:
		_machine.set_state(Walk)
	if Ground_Attack_Recover.is_active() && !Ground_Attack_Recover.is_complete:
		return
			
	if core.player_core.is_inputting_attack():
		if _machine.current_state == Ground_Attack:
			return
		if _machine.current_state == Stop_Running:
			return
		if _machine.current_state != null:
			_machine.current_state.complete()
		_machine.set_state(Ground_Attack)
		return
		
	if Stop_Running.is_active() && !Stop_Running.is_complete:
		return

	if Run.is_active() && !Run.is_complete:
		return
	if Run.is_active() && Run.is_complete:
		_machine.set_state(Stop_Running)
		return
	if Ground_Attack.is_active() && !Ground_Attack.is_complete:
		return
	if Ground_Attack.is_active() && Ground_Attack.is_complete:
		_machine.set_state(Ground_Attack_Recover)
		return
		
	if Turning_Backwards.is_active() && !Turning_Backwards.is_complete:
			if core.player_core.is_inputting_attack():
				Turning_Backwards.complete()
				_machine.set_state(Ground_Attack)
			return
	
	elif core.player_core.xInput!=0 && !_machine.current_state == Run:
		if _machine.current_state!=null:
			_machine.current_state.complete()
		
		_machine.set_state(Walk)
	elif !core.player_core.on_edge_raycast.is_colliding():
		_machine.set_state(On_Edge)
	else:
		_machine.set_state(Idle)
	
	

func do(delta):
	#print(_machine.current_state)
	#print(all_transition_states)
	super(delta)
	select_state()
	if !core.body.is_on_floor():
		complete()

func _unhandled_input(event: InputEvent) -> void:
	
	if _machine.current_state == Ground_Attack:
		return
	elif core.player_core.double_tapped_checker(event):
		_machine.set_state(Run)
	
func on_player_turned_backwards():
	if !is_active():
		return
	if Stop_Running.is_active():
		await Stop_Running.state_completed
		_machine.set_state(Turning_Backwards)
	if is_active():
		_machine.set_state(Turning_Backwards)
		
func complete():
	last_before_completing = _machine.current_state
	if !_machine.current_state == null:
		_machine.current_state = null
	super()
	
