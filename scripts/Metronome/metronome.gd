class_name Metronome
extends Node2D

signal beat_event(current_beat: float)
const BPM := 132
const SECONDS_PER_BEAT := 60.0/BPM 
const ACTIVE_WINDOW := 0.08
var current_beat := 0
var time_until_next_beat := SECONDS_PER_BEAT

func update_beat(current_time: float) -> void:
  if time_until_next_beat - current_time <= 0:
    current_beat += 1
    beat_event.emit(current_beat)
    time_until_next_beat += SECONDS_PER_BEAT

func active_beat(current_time: float) -> int:
  if current_time - (time_until_next_beat - SECONDS_PER_BEAT) <= ACTIVE_WINDOW or time_until_next_beat - current_time <= ACTIVE_WINDOW:
    return current_beat
  # returning negative 1 because of typing reasons and the current beat can't be -1
  return -1 
