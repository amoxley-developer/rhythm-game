class_name Composer
extends Node

var beats_to_hit: Array[int] = []
var current_hit := 0
var current_hit_idx := 0

func _ready() -> void:
	for i in range(0, 200, 4):
		if i == 0:
			beats_to_hit.append(i)
		else:
			beats_to_hit.append(i-1)
	current_hit = beats_to_hit[current_hit_idx]

func update_current_hit(current_beat: int) -> void:
	if current_beat > current_hit:
		current_hit_idx += 1
		current_hit = beats_to_hit[current_hit_idx]
