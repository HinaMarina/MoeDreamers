extends State

@export var jump_height:float
@export var fall_time:float

@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)
@export var max_speed_on_air:int =100


func get_gravity():
	return fall_gravity


func physics_do(delta):
	if core.body.is_on_floor():
		complete()
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.x = core.player_core.xInput*max_speed_on_air
	core.body.move_and_slide()
	
func do(delta):
	super(delta)
	sets_animation()
	
func sets_animation():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Not_Holding_Girl/Jump_Fall_E")
	else:
		core.animator.play("Not_Holding_Girl/Jump_Fall_W")
