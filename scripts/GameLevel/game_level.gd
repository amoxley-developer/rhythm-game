class_name GameLevel
extends Node2D

@onready var NeonMarshPlayerScene: AudioStreamPlayer2D = $NeonMarshPlayer; 
@onready var MetronomeScene: Metronome = $Metronome;

var current_beat: int

func _ready() -> void:
	current_beat = MetronomeScene.current_beat
	MetronomeScene.beat_event.connect(_on_beat_event_signal);

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
		if !NeonMarshPlayerScene.playing:
			NeonMarshPlayerScene.play()

	if NeonMarshPlayerScene.playing:
		MetronomeScene.update_beat(NeonMarshPlayerScene.get_playback_position())

func _on_beat_event_signal(new_current_beat: int) -> void:
	current_beat = new_current_beat
	print(current_beat)
	
