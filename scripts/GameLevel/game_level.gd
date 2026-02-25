class_name GameLevel
extends Node2D

@onready var NeonMarshPlayerScene: AudioStreamPlayer2D = $NeonMarshPlayer; 

func _process(delta: float) -> void:
  if Input.is_action_just_pressed('ui_select'):
    if !NeonMarshPlayerScene.playing:
      NeonMarshPlayerScene.play()
    else:
      print(NeonMarshPlayerScene.get_playback_position())
      NeonMarshPlayerScene.stop()
      