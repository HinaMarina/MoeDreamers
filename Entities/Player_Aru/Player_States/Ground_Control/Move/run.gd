extends State

@export var max_speed:=125.0
@export var acceleration:=75.0


func sets_animation():
	if core.player_core.input_vector.x > 0:
		core.animator.play("Not_Holding_Girl/Run_E")
	else:
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
