extends TransitionState


var side_velocity:int

func enter():
	side_velocity = int(core.body.velocity.x)
	super()
	
func play_transition():
	if core.player_core.input_vector.x>0:
		core.animator.play("Transitions/No_Girl_Fall_Transition_E")
	else:
		core.animator.play("Transitions/No_Girl_Fall_Transition_W")
	await core.animator.animation_finished
	complete()
	
func physics_do(delta):
	super(delta)
	core.body.velocity.x = side_velocity*0.3
	core.body.move_and_slide()

func on_turning_backwards():
	side_velocity = 0
	core.body.velocity = Vector2.ZERO
