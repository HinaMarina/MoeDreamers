extends TransitionState


func play_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Transitions/Stop_Running_E")
	else:
		core.animator.play("Transitions/Stop_Running_W")
		
	await core.animator.animation_finished
	complete()


func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2(0,core.body.velocity.y),10)
	core.body.move_and_slide()
