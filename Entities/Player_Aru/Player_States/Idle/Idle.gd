extends PlayerState
@export var no_blink_sprite:Texture2D
@export var blink_sprite:Texture2D


func _ready() -> void:
	super()
	state_sprite.texture = no_blink_sprite

func enter():
	super()
	sets_animation()

func do(delta:float):
	super(delta)
	if int(lambda_time())%5 == 0:
		state_sprite.texture = blink_sprite
	else:
		state_sprite.texture = no_blink_sprite
		
func physics_do(delta):
	super(delta)
	body.velocity = body.velocity.move_toward(Vector2.ZERO,200)
	body.move_and_slide()
	
func sets_animation():
	if !is_holding_girl:
		if input_vector.x>0:
			animation_player.transition_to("Player_Aru_Animations/Idle_E")
		else:
			animation_player.transition_to("Player_Aru_Animations/Idle_W")
func input_to_handle(event:InputEvent):
	if event.is_action("movement_action"):
		complete()
