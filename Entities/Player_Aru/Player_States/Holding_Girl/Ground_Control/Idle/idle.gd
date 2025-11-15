extends PlayerState
@export var friction := 200


func enter():
	super()
	sets_animation_direction()


func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2.ZERO,friction)
	core.body.move_and_slide()


func sets_animation_direction():
	if core.player_core.input_vector.x>=0:
		
		core.animator.play("Holding_Girl/Momo_Idle_E")
	else:
		core.animator.play("Holding_Girl/Momo_Idle_W")
