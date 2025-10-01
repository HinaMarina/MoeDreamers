class_name PlayerState extends Node2D

@export_category("State Assets") 
@export var state_name:StringName
@export var state_sprite :Sprite2D
@export var sound_fx :AudioStream

@export var animation_player:PlayerAnimator
@export var body: CharacterBody2D
@export var player_gaze : RayCast2D
@export var camera : Camera2D


var current_state : PlayerState
var last_state : PlayerState
var parent_state: PlayerState
var all_children_states: Array[PlayerState]

var is_holding_girl : bool = false

var is_complete:bool
var start_time : float = 0.0

var input_vector:Vector2
var grounded:=true
var can_player_move:= true:
	set(new_value):
		if new_value != can_player_move:
			can_player_move = new_value
			for child in all_children_states:
				if child != null:
					child.can_player_move = new_value



#### Here is all lambda functions or functions that are responsible for setting state variables like input_vector, etc
func pause_player_movement():
	can_player_move = false
	
func release_player_movement():
	can_player_move = true
	
func lambda_time(): #return how much time since entered this state
	return (Time.get_ticks_msec() - start_time)/1000

func set_input_vector(new_value:Vector2):
	if input_vector != new_value:
		input_vector = new_value
		for state in all_children_states:
			if state != null:
				state.set_input_vector(input_vector)

func set_grounded(new_value:bool):
	if new_value != grounded:
		grounded = new_value
		for child in all_children_states:
			child.grounded = new_value

func hold_girl():
	is_holding_girl = true

func drop_girl():
	is_holding_girl = false

func set_state_assets():
	for child in self.get_children():
		if child is Sprite2D:
			state_sprite = child
		elif child is PlayerState:
			all_children_states.append(child)
	#if animation_player != null:
		#animation_player.animation_started.connect(on_animation_started)

func set_state(new_state:PlayerState,force_reset:bool = false):
	if new_state == null:
		return
	if new_state != current_state || force_reset:
		if current_state != null:			
			current_state.complete()
			
			animation_player.check_for_transition(current_state.state_name,new_state.state_name,input_vector)
			await animation_player.transition_finished
		
		current_state = new_state
		#current_state.initialize()
		current_state.enter()
		#hide_other_state_sprites()
		
		
########################################################################################
### This section holds all functions related to the state functionality ################

func _ready() -> void:
	set_state_assets()
	var parent_node = self.get_parent()
	if parent_node is PlayerState:
		parent_state = parent_node
		
func enter():
	start_time = Time.get_ticks_msec()
	is_complete = false	
	if current_state != null:
		current_state.enter()
		
func do(delta:float):
	if current_state != null and current_state.is_complete == false:
		current_state.do(delta)
	
func physics_do(delta):
	if current_state!= null and current_state.is_complete == false:
		current_state.physics_do(delta)
		
func complete():
	if current_state != null:
		current_state.complete()
	is_complete = true
	
func input_to_handle(event:InputEvent):
	if current_state!= null and current_state.is_complete == false:
		current_state.input_to_handle(event)

###################################################################################################
### This section is where all functions that are called by signals are ############################
#func on_animation_started(_anim_name:StringName):
	### This piece of the code handles finding which animation is playing,
	### and hiding the sprite of the states that are not playing
	##if animation_player.transitioning:
		##return
	##var animation = animation_player.get_animation(animation_player.get_current_animation())
	##var path = animation.track_get_path(0)
##
	##
	##var sprite_node = body.get_parent().get_node(path) #this is needed 'cause the StateMachine is a child of the player body
	##for each in all_children_states:
		##if !is_instance_valid(each):
			##continue
		##if each.state_sprite == null:
			##continue
		##if each.state_sprite != sprite_node:
			##each.state_sprite.visible = false
		##else:
			##each.state_sprite.visible = true
