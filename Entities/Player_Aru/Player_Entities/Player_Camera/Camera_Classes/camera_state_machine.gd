class_name CameraStateMachine extends Node

var current_state:CameraState
var last_state:CameraState
var machine_owner:Node

	
func set_state(new_state:CameraState,override:bool=false):

	if (new_state != current_state || override):
		last_state = current_state
		#print(machine_owner, ' is setting ', new_state)
		
		current_state = new_state
		current_state.initialize()
		current_state.enter()
	
			
	
