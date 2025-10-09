extends TransitionState



func play_transition():
	if core.player_core.input_vector.x>0:
		core.animator.play("Transitions/No_Girl_Fall_Transition_E")
	else:
		core.animator.play("Transitions/No_Girl_Fall_Transition_W")
	await core.animator.animation_finished
	complete()
	
