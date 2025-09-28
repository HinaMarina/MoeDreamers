class_name PlayerStateMachine extends PlayerState

@export_category("Player States")
@export var Idle_State:PlayerState
@export var Walk_State:PlayerState
@export var Run_State:PlayerState
@export var Jump_State:PlayerState
@export var Fall_State:PlayerState
@export var Sword_Attack_State:PlayerState

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("movement_action"):
		if can_player_move:
			var playerinput :Vector2
			playerinput.x = Input.get_axis("ui_left","ui_right")
			playerinput.y = Input.get_axis("ui_up","ui_down")
			if playerinput != Vector2.ZERO:
				set_input_vector(playerinput.normalized())
				
				
				
	select_state()
	
	if is_instance_valid(current_state):
		current_state.do(delta)
		


func _physics_process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.physics_do(delta)
		
func select_state():
	pass
