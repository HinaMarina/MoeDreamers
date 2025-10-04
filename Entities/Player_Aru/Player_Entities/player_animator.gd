class_name PlayerAnimator extends AnimationPlayer

var all_animated_sprites:Array[Sprite2D]
@onready var animator_root:= get_node(root_node)



func _ready() -> void:
	for each in get_animation_list():
		var animation = get_animation(each)
		var path = animation.track_get_path(0)
		var sprite = animator_root.get_node(path)
		if !all_animated_sprites.has(sprite):
			all_animated_sprites.append(sprite)


func _on_animation_started(anim_name: StringName) -> void:
		var animation = get_animation(anim_name)
		var path = animation.track_get_path(0)
		var sprite = animator_root.get_node(path)
		for each in all_animated_sprites:
			if each == sprite:
				each.visible = true
			else:
				each.visible = false
		
