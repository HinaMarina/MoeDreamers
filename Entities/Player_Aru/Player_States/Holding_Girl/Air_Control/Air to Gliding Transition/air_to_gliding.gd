extends TransitionState



func play_transition():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Transitions/Momo-Air_To_Gliding_E")
	else:
		core.animator.play("Transitions/Momo-Air_To_Gliding_W")
	await core.animator.animation_finished
	complete()
	
func physics_do(delta):
	super(delta)
	if core.body.velocity.y >=0:
		core.body.velocity = core.body.velocity.move_toward(Vector2(core.body.velocity.x,0),30)
	else:
		core.body.velocity = core.body.velocity.move_toward(Vector2(core.body.velocity.x,-4),10)
	core.body.move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_released("glide"):
		complete()
