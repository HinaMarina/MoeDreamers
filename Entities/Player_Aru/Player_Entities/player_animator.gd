class_name PlayerAnimator extends AnimationPlayer

var all_animated_sprites:Array[Sprite2D]
@onready var animator_root:= get_node(root_node)
signal transition_finished()
var transitioning:bool=false

@export var player_core:PlayerCore

var transitions_playlist:Array[String]

func play_transition(transition:String):
	
	
	if transition == get_current_animation():
		return
	transitions_playlist.append(transition)
		
		
		
	
		
func play_after_transition(anim_name:String):
	if transitioning:
		await transition_finished
	play(anim_name)

func _ready() -> void:
	for each in get_animation_list():
		var animation = get_animation(each)
		var path = animation.track_get_path(0)
		var sprite = animator_root.get_node(path)
		if !all_animated_sprites.has(sprite):
			all_animated_sprites.append(sprite)


func _on_animation_started(anim_name: StringName) -> void:
	#print(anim_name + ' started')
	var animation = get_animation(anim_name)
	var path = animation.track_get_path(0)
	var sprite = animator_root.get_node(path) as Sprite2D
	sprite.flip_h = player_core.input_vector.x<0 ## handle godot problems of playing anim before flip_h
	
	for each in all_animated_sprites:
		if each == sprite:
			each.visible = true
		else:
			each.visible = false


#
#func _on_animation_finished(anim_name: StringName) -> void:
	#print(anim_name, ' finished')
	#var animation = anim_name.get_slice("/",1)
	#if get_animation_library("Transitions").has_animation(animation):
		#transitioning = false
		#transition_finished.emit()

func _process(delta: float) -> void:
	if !transitions_playlist.is_empty():
		transitioning = true
		for each in transitions_playlist:
			play(each)
			await animation_finished
			transitions_playlist.erase(each)
			
	if transitions_playlist.is_empty() && transitioning:
		transitioning = false
		transition_finished.emit()
