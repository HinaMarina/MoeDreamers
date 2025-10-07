extends State

@export var max_speed:=125.0
@export var acceleration:=75.0
@export var state_sprite:Sprite2D

func sets_animation():
	if core.player_core.input_vector.x > 0:
		state_sprite.flip_h = false
		core.animator.play("Not_Holding_Girl/Run_E")
	else:
		state_sprite.flip_h = true
		core.animator.play("Not_Holding_Girl/Run_W")

func do(delta):
	super(delta)
	sets_animation()
	if core.player_core.xInput==0:
		complete()

func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2(core.player_core.input_vector.x,0)*max_speed,acceleration)
	core.body.move_and_slide()

func play_stop_transition():
	if core.player_core.input_vector.x >0:
		core.animator.play_transition("Transitions/Stop_Running_E")
	else:
		core.animator.play_transition("Transitions/Stop_Running_W")

func complete():
	core.player_core.pause_movement()
	play_stop_transition()
	await core.animator.transition_finished
	core.player_core.release_movement()
	super()
