extends TransitionState


func play_transition():
	if core.player_core.input_vector.x>=0:
		core.animator.play("Transitions/Attack_Recover_E")
	else:
		core.animator.play("Transitions/Attack_Recover_W")
	await core.animator.animation_finished
	complete()
