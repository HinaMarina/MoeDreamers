extends CameraState

func do(delta):
	super(delta)
	core.camera.global_position.x = core.player_core.body.global_position.x
	if core.player_core.body.is_on_floor():
		core.camera.global_position.y = core.player_core.body.global_position.y
	
