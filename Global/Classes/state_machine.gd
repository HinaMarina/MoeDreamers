class_name StateMachine extends Node2D

var current_state:State
var last_state:State
var machine_owner:Node

func set_state(new_state:State,override:bool=false):
	
	
	
	if new_state == null:
		return
	if new_state != current_state || override:
		if current_state != null:
			current_state.is_complete = true
			last_state = current_state
			
			if current_state.clear_before_override:
				current_state.clear_machine()
		
		if new_state.clear_before_override:
			new_state.clear_machine()
			
		current_state = new_state
		current_state.initialize()
		current_state.enter()
		print(machine_owner, ' is setting ', new_state)
