extends State

@export var jump_height:float
@export var peak_time:float

@onready var jump_velocity:float =(-1)*(2*jump_height)/peak_time
@onready var jump_gravity:float = (-1)*(-2*jump_height)/(peak_time*peak_time)
@export var max_speed_on_air:int =100
func enter():
	super()
	jump()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("jump"):
		core.body.velocity.y = 0
		complete()
		
func get_gravity():
	if core.body.velocity.y>0:
		complete()
	return jump_gravity

	
	
func jump():
	core.body.velocity.y = jump_velocity
	sets_animation()

func physics_do(delta):
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.x = core.player_core.xInput*max_speed_on_air
	core.body.move_and_slide()

func sets_animation():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Not_Holding_Girl/Jump_Rise_E")
	else:
		core.animator.play("Not_Holding_Girl/Jump_Rise_W")
