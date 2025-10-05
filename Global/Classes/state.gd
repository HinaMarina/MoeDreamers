class_name State extends Node

var core:StateCore
var _machine:StateMachine
var is_complete:bool
var start_time:float

var all_child_states:Array[State]
var parent_state:State
signal tree_is_set()
func _ready():
	_machine = StateMachine.new()
	for each in get_children():
		if each is State:
			all_child_states.append(each)
			each.set_parent(self)
	
func set_core(_core:StateCore):
	core = _core
	
func set_parent(parent:State):
	parent_state = parent
	
func set_tree(new_core:StateCore):
	set_core(new_core)
	for each in all_child_states:
		each.set_core(new_core)
		each.set_tree(new_core)
	tree_is_set.emit()
		
func lambda_time():
	return (Time.get_ticks_msec() - start_time)/1000
	
func enter():
	start_time = Time.get_ticks_msec()
	if _machine.current_state!= null:
		_machine.current_state.enter()

func initialize():
	is_complete = false

	
func complete():
	self.is_complete = true
	if _machine.current_state != null:
		_machine.current_state.complete()
	
func do(delta):
	#print(self,' ',_machine.current_state)
	if is_complete:
		return
	if _machine.current_state != null:
		_machine.current_state.do(delta)
	

func physics_do(delta):
	if is_complete:
		return
	if _machine.current_state != null:
		_machine.current_state.physics_do(delta)

func exit():
	if !is_complete:
		complete()
	
func is_active():
	if parent_state != null:
		return (parent_state._machine.current_state == self)
