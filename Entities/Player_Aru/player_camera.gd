class_name PlayerCamera extends Camera2D
@export var player_body:CharacterBody2D
@export var player_state_machine:PlayerStateMachine

func _process(delta: float) -> void:
	update_position()


func update_position():
	#var tween = create_tween()
	#var input_vector = player_state_machine.input_vector
	#tween.tween_property(self,"global_position",player_body.global_position+input_vector*15,0.1)
	#await tween.finished
	self.global_position = player_body.global_position
