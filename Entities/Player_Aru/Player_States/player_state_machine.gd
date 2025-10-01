class_name PlayerStateMachine extends PlayerState

@export_category("Player States")

@export var Idle_State:PlayerState
@export var Walk_State:PlayerState
@export var Air_State:PlayerState
@export var Fall_State:PlayerState
@export var Sword_Attack_State:PlayerState

signal input_vector_updated (new_input_vector:Vector2)

func _unhandled_input(event: InputEvent) -> void:
	if current_state!= null and current_state.is_complete == false:
		current_state.input_to_handle(event)
		
		
func _ready() -> void:
	super()
	set_state(Idle_State)

func _process(delta: float) -> void:
	if animation_player.transitioning:
		return

	
	set_grounded(body.is_on_floor())
	_update_input_vector()
	_select_state()
	
	if is_instance_valid(current_state):
		current_state.do(delta)
		
func _update_input_vector():
	if Input.is_action_pressed("movement_action"):
		if can_player_move:
			var playerinput :Vector2
			playerinput.x = Input.get_axis("ui_left","ui_right")
			playerinput.y = Input.get_axis("ui_up","ui_down")
			if playerinput != Vector2.ZERO:
				set_input_vector(playerinput.normalized())
				input_vector_updated.emit(playerinput.normalized())
				

func _physics_process(delta: float) -> void:
	body.velocity.y+=10
	body.move_and_slide()
	if is_instance_valid(current_state):
		current_state.physics_do(delta)
		
func _select_state():
	if !can_player_move:
		return
	
	if grounded && !Input.is_action_pressed("movement_action"):
		set_state(Idle_State)
		
	if Input.is_action_pressed("movement_action"):
		set_state(Walk_State)

	if Input.is_action_just_pressed("jump"):
		set_state(Air_State)
