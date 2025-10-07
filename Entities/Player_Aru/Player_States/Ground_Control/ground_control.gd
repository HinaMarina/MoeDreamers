extends State

@export var Idle:State
@export var Move:State
@export var On_Edge:State
@export var Ground_Attack:State


func _ready():
	super()
	
	
	await tree_is_set ## Everything after this will be processed after state tree is set
	
	core.player_core.turned_backwards.connect(on_player_turned_backwards)

	
func select_state():
	if Ground_Attack.is_active() && !Ground_Attack.is_complete:
		return
	
	if core.player_core.is_inputting_attack():
		_machine.set_state(Ground_Attack)
	
	elif core.player_core.xInput != 0:
		_machine.set_state(Move)
		
	elif !core.player_core.on_edge_raycast.is_colliding() && core.body.is_on_floor():
		_machine.set_state(On_Edge)
		return
	elif core.body.is_on_floor():
		_machine.set_state(Idle)
		Move.clear_machine()

func do(delta):
	super(delta)
	select_state()
	if !core.body.is_on_floor():
		complete()
	
func on_player_turned_backwards():
	if is_active():
		core.animator.play_transition("Transitions/W_to_E")
		
func complete():
	if !_machine.current_state == null:
		_machine.current_state = null
