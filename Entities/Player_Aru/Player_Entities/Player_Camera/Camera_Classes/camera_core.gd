class_name CameraCore extends Node

@export var camera:Camera2D
@export var player_core:PlayerCore
@onready var _camera_machine:CameraStateMachine


@export var Idle:CameraState
@export var Tracking:CameraState
@export var Follow:CameraState


func _process(delta: float) -> void:
	#select_camera_state()
	#print(_camera_machine.current_state)
	
	if _camera_machine.current_state!=null:
		_camera_machine.current_state.do(delta)
	
func _physics_process(delta: float) -> void:
	
	
	if _camera_machine.current_state!=null:
		_camera_machine.current_state.physics_do(delta)
	
func _ready() -> void:
	
	_camera_machine = CameraStateMachine.new()
	_camera_machine.machine_owner = self
	set_instances()
	_camera_machine.set_state(Follow)

func select_camera_state():
	if player_core.main_machine.current_state == player_core.Not_Holding_Girl:
		if player_core.Not_Holding_Girl._machine.current_state == player_core.Not_Holding_Girl.Ground_Control:
			if player_core.Not_Holding_Girl.Ground_Control._machine.current_state == player_core.Not_Holding_Girl.Ground_Control.Idle:
				_camera_machine.set_state(Idle)
			else:
				_camera_machine.set_state(Follow)
		else:
			_camera_machine.set_state(Tracking)
	else:
		return



func set_instances():
	for each in self.get_children():
		if each is CameraState:
			each.set_tree(self)
