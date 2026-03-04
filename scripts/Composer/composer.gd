class_name Composer
extends Node

var beats_to_hit: Array[int] = []
var current_hit := 0
var current_hit_idx := 0

func _ready() -> void:
	for i in range(0, 600, 4):
		beats_to_hit.append(i)
	current_hit = beats_to_hit[current_hit_idx]

func update_current_hit(current_beat: int) -> void:
	if current_beat > current_hit:
		current_hit_idx += 1
		current_hit = beats_to_hit[current_hit_idx]
