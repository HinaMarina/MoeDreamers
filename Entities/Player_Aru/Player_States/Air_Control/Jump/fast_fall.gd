extends PlayerState


func physics_do(delta):
	super(delta)
	core.body.velocity.y =350
	core.body.move_and_slide()

func do(delta):
	super(delta)
	if core.body.is_on_floor():
		complete()
	if core.player_core.input_vector.x >= 0:
		core.animator.play('Not_Holding_Girl/Fast_Fall_E')
	else:
		core.animator.play('Not_Holding_Girl/Fast_Fall_W')
