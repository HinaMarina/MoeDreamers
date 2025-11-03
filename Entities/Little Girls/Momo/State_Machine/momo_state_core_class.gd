class_name MomoStateCore extends Node

@export var body:CharacterBody2D
@export var animator:MomoAnimator
@export var momo_core:MomoCore


func set_instances():
	for each in self.get_children():
		if each is PlayerState:
			each.set_tree(self)
