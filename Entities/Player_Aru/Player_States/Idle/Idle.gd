extends PlayerState
@export var no_blink_sprite:Texture2D
@export var blink_sprite:Texture2D


func _ready() -> void:
	super()
	state_sprite.texture = no_blink_sprite

func do(delta:float):
	super(delta)
	sets_animation()
	if int(lambda_time())%5 == 0:
		state_sprite.texture = blink_sprite
	else:
		state_sprite.texture = no_blink_sprite

func sets_animation():
	if !is_holding_girl:
		if input_vector.x>0:
			animation_player.transition_to("Player_Aru_Animations/Idle_E")
		else:
			animation_player.transition_to("Player_Aru_Animations/Idle_W")
