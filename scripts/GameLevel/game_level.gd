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
var last_active_beat_sprite: Node
var last_active_beat_index: int
var next_active_beat: int

func _ready() -> void:
	current_beat = MetronomeScene.current_beat
	MetronomeScene.beat_event.connect(_on_beat_event_signal);
	beat_target_sprite_pos = BeatTargetSpriteScene.position
	# set last_active_beat_sprite, last_active_beat_index, and next_active_beat
	next_active_beat = ComposerNode.beats_to_hit[0]
	last_active_beat_index = -1

func _process(_delta: float) -> void:
	var current_time := NeonMarshPlayerScene.get_playback_position()
	if Input.is_action_just_pressed('ui_select'):
		if !NeonMarshPlayerScene.playing:
			NeonMarshPlayerScene.play()
		else:
			print(judge(MetronomeScene.active_beat(current_time)))
			# if judge is true destroy the active beat sprite
			# also destroy if the sprite is outside of viewport

	if NeonMarshPlayerScene.playing:
		MetronomeScene.update_beat(current_time)

	if next_active_beat != null:
		var time_until_next_beat := next_active_beat * MetronomeScene.SECONDS_PER_BEAT
		if time_until_next_beat - current_time <= TIME_TO_BEAT_TARGET:
				handle_create_active_beat_sprite(time_until_next_beat)
 
func _on_beat_event_signal(new_current_beat: int) -> void:
	current_beat = new_current_beat
	# update the current active beat sprite
	ComposerNode.update_current_hit(current_beat)

func handle_create_active_beat_sprite(time_until_next_beat: float) -> void:
	var active_beat_sprite :ActiveBeatSprite = ActiveBeatScene.instantiate()
	active_beat_sprite.active_beat = next_active_beat
	active_beat_sprite.active_beat_index = last_active_beat_index+1
	active_beat_sprite.position = Vector2(1100, BeatTargetSpriteScene.position.y)
	add_child(active_beat_sprite)
	active_beat_sprites.append(active_beat_sprite)

	# set the last and next active beats
	last_active_beat_sprite = active_beat_sprites[-1]
	last_active_beat_index = last_active_beat_sprite.active_beat_index
	if last_active_beat_index+1 in ComposerNode.beats_to_hit:
		next_active_beat = ComposerNode.beats_to_hit[last_active_beat_index+1]

	# set the sprite to move to be in the center of target sprite at active beat \
	var x_distance: float = active_beat_sprite.position.x - BeatTargetSpriteScene.position.x
	var speed := x_distance/time_until_next_beat
	active_beat_sprite.velocity = Vector2.LEFT * speed
	active_beat_sprite.can_move = true
	return

func judge(active_beat: int) -> bool:
	print('current hit: ', ComposerNode.current_hit)
	print('active beat: ', active_beat)
	print('Current beat: ', MetronomeScene.current_beat)
	return ComposerNode.current_hit == active_beat

	
