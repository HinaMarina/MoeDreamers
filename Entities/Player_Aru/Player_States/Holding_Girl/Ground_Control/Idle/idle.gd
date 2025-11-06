extends PlayerState


func do(delta):
	super(delta)
	if core.player_core.input_vector.x>=0:
		
		core.animator.play("Holding_Girl/Momo_Idle_E")
	else:
		core.animator.play("Holding_Girl/Momo_Idle_W")
