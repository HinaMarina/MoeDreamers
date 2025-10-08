class_name StateMachine extends Node2D

var current_state:State
var last_state:State
var machine_owner:Node


func set_state(new_state:State,override:bool=false):
	if machine_owner is State:
		if machine_owner.core.animator.transitioning:
			print(machine_owner.core.animator.get_current_animation())
			await machine_owner.core.animator.transition_finished
	#print(machine_owner, ' is setting ', new_state)

	
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
		
		#print(machine_owner, ' is setting ', new_state)
		current_state = new_state
		current_state.initialize()
		current_state.enter()
	
