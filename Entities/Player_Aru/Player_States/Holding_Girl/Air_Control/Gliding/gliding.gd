extends PlayerState

@export var jump_height:float
@export var fall_time:float

@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)
@export var max_speed_on_air:int =75
const speed_on_air:= 75

var current_horizontal_velocity:int
@export var max_fall_speed:int = 100
@export var state_sprite:Sprite2D

signal max_vel_achieved()

func initialize():
	super()
	state_sprite.flip_h = core.player_core.input_vector.x < 0
	state_sprite.frame = 3
	#max_speed_on_air = 85

func get_gravity():
	return fall_gravity
	
func _unhandled_input(event: InputEvent) -> void:
	if is_active() && Input.is_action_just_released("glide"):
		complete()
		
func enter():
	current_horizontal_velocity = abs(int(core.body.velocity.x))
	max_speed_on_air = max(current_horizontal_velocity,speed_on_air)
	super()
	if core.body.is_on_floor():
		complete()
	
func physics_do(delta):
	
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.y = clamp(core.body.velocity.y,-max_fall_speed,max_fall_speed)
	core.body.velocity.x = core.player_core.xInput*max_speed_on_air
	core.body.move_and_slide()
	
func do(delta):
	if core.body.velocity.y == max_fall_speed:
		max_vel_achieved.emit()
	if core.body.is_on_floor():
		complete()
	super(delta)
	sets_animation()
	
func sets_animation():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Holding_Girl/Momo_Gliding_E")
	else:
		core.animator.play("Holding_Girl/Momo_Gliding_W")
