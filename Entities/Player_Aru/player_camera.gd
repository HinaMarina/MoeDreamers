class_name PlayerCamera extends Camera2D
@export var player_body:CharacterBody2D
@export var player_machine:PlayerCore

var _camera_machine:StateMachine
var tweening:bool = false

func _ready() -> void:
	_camera_machine = StateMachine.new()

func _process(delta: float) -> void:
	update_position()


func update_position():
	
	#var tween = create_tween()
	#var input_vector = player_state_machine.input_vector
	#tween.tween_property(self,"global_position",player_body.global_position+input_vector*15,0.1)
	#await tween.finished
	self.global_position = player_body.global_position
	#var distance = abs(player_body.global_position.y-global_position.y)
	#if distance >= 40:
		#global_position.y = player_body.global_position.y
	#else:
	#
		#if player_body.is_on_floor() && !tweening:
			#var current_y = player_body.global_position.y
			#tween_y(int(current_y))
			#tweening = true
		#
		#
#
#func tween_y(y_coord:int):
	#var distance = abs(y_coord-global_position.y)
	#var time = distance*0.01
	#var tween = create_tween()
	#tweening = true
	#tween.tween_property(self,'global_position:y',y_coord,time)
	#await  tween.finished
	#tweening = false
