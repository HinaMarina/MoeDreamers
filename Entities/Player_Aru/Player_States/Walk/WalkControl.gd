extends PlayerState

@export var StandardWalk:PlayerState
@export var RunWalk:PlayerState

func _ready() -> void:
	super()
	
func enter():
	super()
	set_state(StandardWalk)
