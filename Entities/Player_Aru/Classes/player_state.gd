class_name PlayerState extends Node

var core:PlayerStateCore
var _machine:PlayerStateMachine
var is_complete:bool
var start_time:float

var all_child_states:Array[PlayerState]
var all_transition_states:Array[TransitionState]
var all_non_transitional_states : Array[PlayerState]
var parent_state:PlayerState

signal tree_is_set()
signal state_completed(PlayerState:PlayerState)

func _ready():
	_machine = PlayerStateMachine.new()
	_machine.machine_owner = self
	
	for each in get_children():
		if each is PlayerState:
			all_child_states.append(each)
			each.set_parent(self)
			if each is TransitionState:
				all_transition_states.append(each)
			else:
				all_non_transitional_states.append(each)
	
func set_core(_core:PlayerStateCore):
	core = _core
	
func set_parent(parent:PlayerState):
	parent_state = parent
	
func set_tree(new_core:PlayerStateCore):
	set_core(new_core)
	for each in all_child_states:
		each.set_core(new_core)
		each.set_tree(new_core)
	tree_is_set.emit()
		
func lambda_time():
	return (Time.get_ticks_msec() - start_time)/1000
	
func enter():
	if _machine.current_state!=null:
		_machine.current_state=null
	is_complete = false
	start_time = Time.get_ticks_msec()
	#if _machine.current_state!= null:
		#_machine.current_state.enter()

func initialize():
	pass

	
func complete():
	_machine.last_state = _machine.current_state
	if _machine.current_state != null:
		_machine.current_state.complete()
		await _machine.current_state.state_completed
		
	self.is_complete = true
	state_completed.emit(self)
	
func do(delta):
	
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
	if parent_state == null:
		return (core.player_core.main_machine.current_state == self)
	if parent_state != null:
		return (parent_state._machine.current_state == self && parent_state.is_active())
		
func clear_machine():
	_machine.current_state = null

##
#func _process(delta: float) -> void:
	#print(self, _machine.current_state)
	##print(self, ' ',self.is_active())
	#pass
