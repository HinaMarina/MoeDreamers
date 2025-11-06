class_name TransitionState extends PlayerState

var condition_to_break:bool


## each key of the dictionary is the PlayerState were coming from, and the value is the next PlayerState we're going for
	

func enter():
	super()
	play_transition()
	



func play_transition():
	pass


func _unhandled_input(event: InputEvent) -> void:
	if !self.is_active():
		return	
