class_name MomoStateMachine extends Node

var current_state:MomoState
var last_state:MomoState
var machine_owner:Node

	
func set_state(new_state:MomoState,override:bool=false):

	if (new_state != current_state || override):
		last_state = current_state
		#print(machine_owner, ' is setting ', new_state)
		
		current_state = new_state
		current_state.initialize()
		current_state.enter()
	
