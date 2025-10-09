class_name StateMachine extends Node2D

var current_state:State
var last_state:State
var machine_owner:Node

	
func set_state(new_state:State,override:bool=false):

	if (new_state != current_state || override):
		last_state = current_state
		#print(machine_owner, ' is setting ', new_state)
		
		current_state = new_state
		current_state.initialize()
		current_state.enter()
	
			
	
