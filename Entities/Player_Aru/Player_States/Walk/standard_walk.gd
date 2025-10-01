extends PlayerState

var max_speed := 75
var acceleration := 50

func input_to_handle(_event:InputEvent):
	
	if input_vector.x >=0 && Input.is_action_just_pressed("ui_left"):
		animation_player.transition_to('StandardWalk_E','StandardWalk_W')
		state_sprite.flip_h = true

	elif input_vector.x < 0 && Input.is_action_just_pressed("ui_right"):
		animation_player.transition_to('StandardWalk_W','StandardWalk_E')
		state_sprite.flip_h = false

		
func do(delta):
	super(delta)
	if animation_player.transitioning == true:
		return
	if input_vector.x >0:
		animation_player.play("Player_Aru_Animations/StandardWalk_E")
	else:
		animation_player.play("Player_Aru_Animations/StandardWalk_W")
