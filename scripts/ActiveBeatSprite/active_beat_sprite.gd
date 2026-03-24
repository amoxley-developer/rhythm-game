class_name ActiveBeatSprite
extends CharacterBody2D

var active_beat: int
var active_beat_index: int
var can_move := false

func _physics_process(_delta: float) -> void:
	if can_move:
		move_and_slide()
