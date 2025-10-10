extends TransitionState


func play_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Transitions/Air_Attack_To_Fall_E")
	else:
		core.animator.play("Transitions/Air_Attack_To_Fall_W")
	await core.animator.animation_finished
	complete()
	
func physics_do(delta):
	super(delta)
	core.body.move_and_slide()
