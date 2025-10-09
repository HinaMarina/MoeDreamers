extends State




func physics_do(delta):
	super(delta)
	core.body.velocity.x = 0
	core.body.move_and_slide()
	
func do(delta):
	super(delta)
	play_animation()
	
func play_animation():
	if core.player_core.input_vector.x>=0:
		core.animator.play('Not_Holding_Girl/On_Edge_E')
	else:
		core.animator.play('Not_Holding_Girl/On_Edge_W')
