extends State

@export var Walk:State
@export var Run:State


func select_state():
	if abs(core.player_core.xInput)>0 && _machine.current_state!=Run:
		_machine.set_state(Walk)
	elif abs(core.player_core.xInput)==0:
		complete()

func _unhandled_input(event: InputEvent) -> void:
	if core.player_core.double_tapped_checker(event):
		_machine.set_state(Run)

func do(delta):
	super(delta)
	select_state()

func initialize():
	super()
	#_machine.set_state(Walk)

func complete():
	super()
	_machine.set_state(Walk)
