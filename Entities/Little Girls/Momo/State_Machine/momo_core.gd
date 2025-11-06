class_name MomoCore extends MomoStateCore

@export_category("States")
@export var Idle:MomoState


@onready var input_vector:= Vector2.RIGHT
@onready var _main_machine:MomoStateMachine

@export var player_interaction_area:Area2D
@export var Momo_Node:Node2D

var can_pick:bool

func _ready() -> void:
	_main_machine = MomoStateMachine.new()
	_main_machine.set_state(Idle)

func _physics_process(delta: float) -> void:
	body.velocity.y += 200*delta
	body.move_and_slide()
	
	
	if _main_machine.current_state != null:
		_main_machine.current_state.physics_do(delta)
		
		
func _process(delta: float) -> void:
	
	
	if _main_machine.current_state != null:
		_main_machine.current_state.do(delta)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if _body is PlayerBody:
		can_pick = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	if _body is PlayerBody:
		can_pick = false


func _unhandled_input(_event: InputEvent) -> void:
	if can_pick:
		if Input.is_action_just_pressed("pick_girl"):
			PlayerManager.girl_picked.emit("Momo")
			Momo_Node.queue_free()
		
