extends PlayerState

@export var StandardWalk:PlayerState
@export var RunWalk:PlayerState
var started_running:bool = false
func _ready() -> void:
	super()
	
func enter():
	super()
	set_state(StandardWalk)
	started_running = false
	
func do(delta:float):
	super(delta)
	#if lambda_time() <= 0.3 && Input.is_action_just_pressed("movement_action"):
		#set_state(RunWalk)


func input_to_handle(event:InputEvent):
	if !Input.is_action_pressed("movement_action"):
		complete()
			
	if Input.is_action_just_pressed("movement_action") && lambda_time()<=0.3:
		if((Input.is_action_just_pressed("ui_right") && input_vector.x >0)
		|| (Input.is_action_just_pressed("ui_left") && input_vector.x<0)
		):
			set_state(RunWalk)
			started_running = true
			return
	
			
