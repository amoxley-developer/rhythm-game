class_name GameLevel
extends Node2D

@onready var NeonMarshPlayerScene: AudioStreamPlayer2D = $NeonMarshPlayer 
@onready var MetronomeScene: Metronome = $Metronome
# This is only temporary
@onready var LabelScene: RichTextLabel = $RichTextLabel
@onready var ComposerNode := $Composer

var current_beat: int

func _ready() -> void:
	current_beat = MetronomeScene.current_beat
	LabelScene.text = str(current_beat)
	MetronomeScene.beat_event.connect(_on_beat_event_signal);

func _process(_delta: float) -> void:
	var current_time := NeonMarshPlayerScene.get_playback_position()
	if Input.is_action_just_pressed('ui_select'):
		if !NeonMarshPlayerScene.playing:
			NeonMarshPlayerScene.play()
		else:
			print(judge(MetronomeScene.active_beat(current_time)))

	if NeonMarshPlayerScene.playing:
		MetronomeScene.update_beat(current_time)
 
func _on_beat_event_signal(new_current_beat: int) -> void:
	current_beat = new_current_beat
	ComposerNode.update_current_hit(current_beat)
	LabelScene.text = str(current_beat)

func judge(active_beat: int) -> bool:
	print('current hit: ', ComposerNode.current_hit)
	print('active beat: ', active_beat)
	print('Current beat: ', MetronomeScene.current_beat)
	return ComposerNode.current_hit == active_beat

	
