class_name Metronome
extends Node2D

signal beat_event(current_beat: float)
const BPM := 132 * 2
const SECONDS_PER_BEAT := 60.0/BPM 
var current_beat := 0
var time_until_next_beat := SECONDS_PER_BEAT

func update_beat(current_time: float) -> void:
  if time_until_next_beat - current_time <= 0:
    current_beat += 1
    beat_event.emit(current_beat)
    time_until_next_beat += SECONDS_PER_BEAT


