extends CameraState

func do(delta):
	super(delta)
	update_position()
	

func update_position():
	core.camera.global_position.x = core.player_core.body.global_position.x
	core.camera.global_position.y = core.player_core.body.global_position.y -30
	
