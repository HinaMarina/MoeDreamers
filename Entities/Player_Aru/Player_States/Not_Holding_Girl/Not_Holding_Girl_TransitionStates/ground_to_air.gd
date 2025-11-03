extends TransitionState
var body_side_velocity:float


func enter():
	body_side_velocity= core.body.velocity.x
	super()

func play_transition():
	if core.body.is_on_floor():
		play_jump_anticipation()
		
	else:
		play_rise_to_fall()
		
	await core.animator.animation_finished
	complete()
		
func play_jump_anticipation():
	if core.player_core.input_vector.x >= 0:
		core.animator.play("Transitions/No_Girl_Jump_Anticipation_E")
	else:
		core.animator.play("Transitions/No_Girl_Jump_Anticipation_W")

func play_rise_to_fall():
	if core.player_core.input_vector.x >=0:
		core.animator.play("Transitions/No_Girl_Rise_To_Fall_E")
	else:
		core.animator.play("Transitions/No_Girl_Rise_To_Fall_W")


func complete():
	super()

func do(delta):
	super(delta)
	condition_to_break = !core.body.is_on_floor() && core.player_core.is_inputting_jump()

func physics_do(delta):
	super(delta)
	core.body.velocity.x = body_side_velocity/3
	#core.body.velocity.y = 0
	core.body.move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if condition_to_break:
		complete()
