extends State

@export var max_speed:=75.0
@export var acceleration:=45.0
@export var state_sprite:Sprite2D

func sets_animation():
		
	if core.player_core.input_vector.x > 0:
		state_sprite.flip_h = false
			
		core.animator.play_after_transition("Not_Holding_Girl/Walk_E")
	else:
		state_sprite.flip_h = true
		core.animator.play_after_transition("Not_Holding_Girl/Walk_W")

func do(delta):
	super(delta)
	sets_animation()
	if core.player_core.xInput==0:
		complete()

func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2(core.player_core.input_vector.x,0)*max_speed,acceleration)
	core.body.move_and_slide()
