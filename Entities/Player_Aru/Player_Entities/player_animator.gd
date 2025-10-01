class_name PlayerAnimator extends AnimationPlayer

@export var sprite1:Sprite2D
@export var sprite2:Sprite2D

## For a transition animation to work, the transition animation name need to be in the format "FirstState to SecondState"
## If the state name must be written in PascalCase

signal transition_finished
var transitioning:bool = false
var transition_sprite:Sprite2D
var all_animated_sprites:Array[Sprite2D]


func transition_to(new_anim:StringName,last_anim:StringName = ''):
	print(new_anim)
	if last_anim != '':
		for each in self.get_animation_library("Player_Transitions").get_animation_list():
			if each == last_anim + "_to_" + new_anim:
				transitioning = true
				self.play("Player_Transitions/" + each)
				return
	if transitioning:
		await transition_finished
		
	play(new_anim)	

func _ready() -> void:
	for each in get_animation_list():
		var animation = get_animation(each)
		var path = animation.track_get_path(0)
		var sprite = get_parent().get_parent().get_node(path)
		if !all_animated_sprites.has(sprite):
			all_animated_sprites.append(sprite)

func check_for_transition(from:StringName,to:StringName,input_vector:Vector2):
	
	for each in self.get_animation_library("Player_Transitions").get_animation_list():
		if ( (each == from + "_to_" + to + "_E" && input_vector.x >= 0)
		|| (each == from + "_to_" + to + "_W" && input_vector.x<=0)
		|| each == from + "_to_" + to +"_General"
		):
			transitioning = true
			self.play("Player_Transitions/" + each)
			return
	
	if !transitioning:
		transition_finished.emit()


func _on_animation_finished(anim_name: StringName) -> void:
	
	if transitioning == true:
		transition_finished.emit()
		transitioning = false


func _on_animation_started(anim_name: StringName) -> void:
		var animation = get_animation(anim_name)
		var path = animation.track_get_path(0)
		var sprite = get_parent().get_parent().get_node(path)
		for each in all_animated_sprites:
			if each == sprite:
				each.visible = true
			else:
				each.visible = false
		
