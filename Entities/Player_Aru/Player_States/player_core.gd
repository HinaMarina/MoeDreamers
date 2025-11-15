class_name PlayerCore extends PlayerStateCore
var is_holding_girl:bool = false
var current_girl_being_hold:String

@onready var main_machine:PlayerStateMachine

@export var Holding_Girl:PlayerState
@export var Not_Holding_Girl:PlayerState
@export var Camera:PlayerCamera
@export var on_edge_raycast:RayCast2D

var can_player_move:bool= true

var input_vector:Vector2
var last_xInput:float
var xInput:float
var yInput:float

var last_action:String
var double_tap_time_limit:float = 0.3
var double_tap_time:float



signal turned_backwards()

func _ready():
	PlayerManager.girl_picked.connect(hold_girl)
	PlayerManager.girl_released.connect(drop_girl)
	
	input_vector = Vector2(0,1)
	main_machine = PlayerStateMachine.new()
	main_machine.machine_owner = self
	set_instances()
	
	
	if is_holding_girl:
		main_machine.set_state(Holding_Girl,true)
	else:
		main_machine.set_state(Not_Holding_Girl,true)
		
func updates_input_vector():
	#print(can_player_move)
	if !can_player_move:
		return
	
	xInput = Input.get_axis("ui_left","ui_right")
	yInput = Input.get_axis("ui_down","ui_up")
	
	if xInput!= 0:
		
		last_xInput = input_vector.x
		input_vector = Vector2(xInput,yInput)
		
		player_gaze.target_position.x = 35*xInput
		on_edge_raycast.position.x = 4*xInput
		if sign(input_vector.x) == - sign(last_xInput):
			turned_backwards.emit()


	
func _process(delta: float) -> void:
	#print(body.velocity)
	#print(animator.transitioning)
	double_tap_time -= delta
	updates_input_vector()
		
	

		
	if main_machine.current_state != null:
		main_machine.current_state.do(delta)
		
func _physics_process(delta: float) -> void:
	
	if main_machine.current_state != null:
		main_machine.current_state.physics_do(delta)

func is_inputting_jump():
	return Input.is_action_pressed("jump")
	
func is_inputting_attack():
	return Input.is_action_just_pressed("attack")
	
func double_tapped_checker(event:InputEvent):
	if event.is_echo():
		return
	if event.is_action("movement_action") && event.is_pressed():
		var action:String
		if event.is_action("ui_right"):
			action = "ui_right"
		elif event.is_action("ui_left"):
			action = "ui_left"
		else:
			return
		if last_action == action && double_tap_time>=0:
			return true
		else:
			last_action = action
		double_tap_time = double_tap_time_limit
		


func pause_movement():
	can_player_move = false
	
func release_movement():
	can_player_move = true
	

func hold_girl(girl_name:String):
	#print('holdou ' + girl_name)
	current_girl_being_hold = girl_name
	is_holding_girl = true
	#Not_Holding_Girl.complete()
	main_machine.set_state(Holding_Girl,true)

func drop_girl():
	is_holding_girl = false
	main_machine.set_state(Not_Holding_Girl,true)
	LilGirlsManager.drop_girl(current_girl_being_hold,body.global_position - input_vector*20)
	current_girl_being_hold = ""

func _input(event: InputEvent) -> void:
	if is_holding_girl:
		if Input.is_action_just_pressed("pick_girl"):
			drop_girl()
