extends Node

@onready var MomoPackedScene:PackedScene = preload("res://Entities/Little Girls/Momo/momo.tscn")


func drop_girl(name:String,position:Vector2):
	if name == "Momo":
		var momo = MomoPackedScene.instantiate()
		var current_scene = get_tree().current_scene
		current_scene.add_child(momo)
		momo.global_position = position
		
