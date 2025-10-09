extends TransitionState



func play_transition():
	core.animator.play("Transitions/W_to_E")
	await core.animator.animation_finished
	complete()
	
	#if (core.animator.get_current_animation() == "Not_Holding_Girl/Idle_E"
	#&& core.player_core.input_vector.x < 0):
		#core.animator.play("Transitions/W_to_E")
		#await core.animator.animation_finished
		#complete()
		#return
	#elif (core.animator.get_current_animation() == "Not_Holding_Girl/Idle_W"
	#&& core.player_core.input_vector.x > 0):
		#core.animator.play("Transitions/W_to_E")
		#await core.animator.animation_finished
		#complete()
		#return
	#else:
		#complete()
		#return
	#
		


func do(delta):
	super(delta)
	condition_to_break = (core.player_core.is_inputting_jump() || core.player_core.is_inputting_attack())
	

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	if condition_to_break:
		complete()

func complete():
	super()

	
