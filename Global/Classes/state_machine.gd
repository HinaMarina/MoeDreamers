class_name StateMachine extends Node2D

var current_state:State
var last_state:State


func set_state(new_state:State,override:bool=false):
	if new_state == null:
		return
	if new_state != current_state || override:
		if current_state != null:
			last_state = current_state
		current_state = new_state
		current_state.initialize()
		current_state.enter()
