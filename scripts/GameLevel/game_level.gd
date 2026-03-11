class_name GameLevel
extends Node2D

@onready var NeonMarshPlayerScene: AudioStreamPlayer2D = $NeonMarshPlayer 
@onready var MetronomeScene: Metronome = $Metronome
@onready var ComposerNode := $Composer
@onready var BeatTargetSpriteScene := $BeatTargetSprite
var ActiveBeatScene := preload("res://scenes/active_beat_sprite.tscn")


const TIME_TO_BEAT_TARGET := 2.0
var current_beat: int
var beat_target_sprite_pos: Vector2
var active_beat_sprites: Array

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
	# get the next active beat
	# FIX THIS: handle first beat edge case/ probably just set these variables in the ready function 
	var last_active_beat_sprite = active_beat_sprites[-1]
	var last_active_beat_index = last_active_beat_sprite.last_active_beat_index
	var next_active_beat: int
	if last_active_beat_index+1 in ComposerNode.beats_to_hit:
		next_active_beat = ComposerNode.beats_to_hit[last_active_beat_index+1]

	# check to see if it is time to create an active beat sprite
	if next_active_beat != null:
		var time_until_next_beat := next_active_beat * MetronomeScene.SECONDS_PER_BEAT
		if time_until_next_beat <= TIME_TO_BEAT_TARGET:
			var active_beat_sprite := ActiveBeatScene.instantiate()
			active_beat_sprite.active_beat = next_active_beat
			active_beat_sprite.active_beat_index = last_active_beat_index+1
			# create the active beat sprite node
				# set the y pos to beat target sprite
				# set the x pos to ? off screen

	# set the sprite to move to be in the center of target sprite at active beat \
		# movement time should use the time_until_next beat

	return

func judge(active_beat: int) -> bool:
	print('current hit: ', ComposerNode.current_hit)
	print('active beat: ', active_beat)
	print('Current beat: ', MetronomeScene.current_beat)
	return ComposerNode.current_hit == active_beat

	
