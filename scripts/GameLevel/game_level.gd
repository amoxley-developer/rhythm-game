class_name GameLevel
extends Node2D

func _process(delta: float) -> void:
  if Input.is_action_just_pressed('ui_select'):
    print('starting music')   