extends TransitionState


func play_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Transitions/No_Girl_Rise_To_Fall_E")
	else:
		core.animator.play("Transitions/No_Girl_Rise_To_Fall_W")
	await core.animator.animation_finished
	complete()
	
func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2(core.body.velocity.x,0),20)
	core.body.move_and_slide()
