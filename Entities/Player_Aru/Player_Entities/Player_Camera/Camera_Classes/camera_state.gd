class_name CameraState extends Node

@onready var core:CameraCore
@onready var _machine:CameraStateMachine
var is_complete:bool
var start_time:float

var all_child_states:Array[CameraState]
var parent_state:CameraState
@export var clear_before_override:bool=false

signal tree_is_set()
signal state_completed(Camera_State:CameraState)



func _ready():
	_machine = CameraStateMachine.new()
	_machine.machine_owner = self
	
	for each in get_children():
		if each is CameraState:
			all_child_states.append(each)
			each.set_parent(self)

func set_core(_core:CameraCore):
	core = _core
	
func set_parent(parent:CameraState):
	parent_state = parent
	
func set_tree(new_core:CameraCore):
	set_core(new_core)
	for each in all_child_states:
		each.set_core(new_core)
		each.set_tree(new_core)
	tree_is_set.emit()

func lambda_time():
	return (Time.get_ticks_msec() - start_time)/1000
	
func enter():

	#print(self)
	is_complete = false
	start_time = Time.get_ticks_msec()
	#if _machine.current_state!= null:
		#_machine.current_state.enter()

func initialize():
	pass

	
func complete():
			
	if _machine.current_state != null:
		_machine.current_state.complete()
		await _machine.current_state.state_completed
		
	self.is_complete = true
	state_completed.emit(self)
	
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
