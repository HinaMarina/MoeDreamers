class_name MomoCore extends MomoStateCore

@onready var input_vector:= Vector2.RIGHT

func _physics_process(delta: float) -> void:
	body.velocity.y += 200*delta
	body.move_and_slide()
