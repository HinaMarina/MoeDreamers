extends PlayerState

var max_speed := 200
var acceleration := 75

func enter():
	super()
	sets_animation()
	
#func input_to_handle(_event:InputEvent):
	#
	#if input_vector.x >=0 && Input.is_action_just_pressed("ui_left"):
		#animation_player.transition_to("Player_Aru_Animations/Run_E")
		#state_sprite.flip_h = true
#
	#elif input_vector.x < 0 && Input.is_action_just_pressed("ui_right"):
		#animation_player.transition_to("Player_Aru_Animations/Run_W")
		#state_sprite.flip_h = false

		
func do(delta):
	sets_animation()
	super(delta)
	

func physics_do(delta):
	super(delta)
	body.velocity = body.velocity.move_toward(Vector2(input_vector.x,0)*max_speed,acceleration)
	body.move_and_slide()
	
func sets_animation():
	if input_vector.x >0:
		animation_player.transition_to("Player_Aru_Animations/Run_E")
	else:
		animation_player.transition_to("Player_Aru_Animations/Run_W")
