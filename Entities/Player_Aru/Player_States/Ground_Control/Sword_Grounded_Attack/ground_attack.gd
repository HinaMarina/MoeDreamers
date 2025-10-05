extends State

@export var state_sprite:Sprite2D

func enter():
	super()
	set_animation()
	await core.animator.animation_finished
	complete()
	
func initialize():
	super()
	state_sprite.frame = 0
	state_sprite.flip_h = core.player_core.input_vector.x<0
	
func set_animation():
	if core.player_core.input_vector.x >= 0:
		core.animator.play("Not_Holding_Girl/Sword_Grounded_Attack1_E")
	else:
		core.animator.play("Not_Holding_Girl/Sword_Grounded_Attack1_W")
