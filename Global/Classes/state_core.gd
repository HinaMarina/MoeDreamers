class_name StateCore extends Node

@export var body:CharacterBody2D
@export var animator:PlayerAnimator
@export var player_core:PlayerCore
@export var player_gaze:RayCast2D

func set_instances():
	for each in self.get_children():
		if each is State:
			each.set_tree(self)
