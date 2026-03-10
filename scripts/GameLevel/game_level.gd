class_name GameLevel
extends Node2D

@onready var NeonMarshPlayerScene: AudioStreamPlayer2D = $NeonMarshPlayer 
@onready var MetronomeScene: Metronome = $Metronome
@onready var ComposerNode := $Composer
@onready var BeatTargetSpriteScene := $BeatTargetSprite

var current_beat: int
var beat_target_sprite_pos: Vector2

func _ready() -> void:
	current_beat = MetronomeScene.current_beat
	MetronomeScene.beat_event.connect(_on_beat_event_signal);
	beat_target_sprite_pos = BeatTargetSpriteScene.position

func _process(_delta: float) -> void:
	var current_time := NeonMarshPlayerScene.get_playback_position()
	if Input.is_action_just_pressed('ui_select'):
		if !NeonMarshPlayerScene.playing:
			NeonMarshPlayerScene.play()
		else:
			print(judge(MetronomeScene.active_beat(current_time)))
			# if judge is true destroy the active beat sprite

	if NeonMarshPlayerScene.playing:
		MetronomeScene.update_beat(current_time)
 
func _on_beat_event_signal(new_current_beat: int) -> void:
	current_beat = new_current_beat
	# update the current active beat sprite
	ComposerNode.update_current_hit(current_beat)

func handle_active_beat_sprite() -> void:
	# SEPARATE: Add property in the active beat sprite to record the active beat it is associated with
	# check to see if it is time to create an active beat sprite
		# look at the composer
	# create the active beat sprite node
		# set the y pos to beat target sprite
		# set the x pos to ?

	# set the sprite to move to be in the center of target sprite at active beat 

	return

func judge(active_beat: int) -> bool:
	print('current hit: ', ComposerNode.current_hit)
	print('active beat: ', active_beat)
	print('Current beat: ', MetronomeScene.current_beat)
	return ComposerNode.current_hit == active_beat

	
