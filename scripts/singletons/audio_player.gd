extends AudioStreamPlayer

var ost_player = AudioStreamPlayer.new()

## Music
# Main Theme
const main_theme_intro = preload("res://audios/ost/collector_intro.mp3")
const main_theme_mid = preload("res://audios/ost/collector_mid.mp3")

## SFX
# Collectors Effects
const collector_clickeds = preload("res://audios/sfx/collectors/collector_clicked.mp3")
const collector_released = preload("res://audios/sfx/collectors/collector_free.mp3")

# Shop effects
const open_shopping = preload("res://audios/sfx/shop_effects/open_shop.mp3")
const close_shopping = preload("res://audios/sfx/shop_effects/close_shop.mp3")
const cant_open_any = preload("res://audios/sfx/shop_effects/cant_open.mp3")
const coin_1 = preload("res://audios/sfx/shop_effects/shop_coins/clink1.wav")
const coin_2 = preload("res://audios/sfx/shop_effects/shop_coins/clink2.wav")
const coin_3 = preload("res://audios/sfx/shop_effects/shop_coins/clink3.wav")
const coin_4 = preload("res://audios/sfx/shop_effects/shop_coins/clink4.wav")

# Attributes Effects
const not_enough = preload("res://audios/sfx/attributes/not_enough.mp3")
const upgraded = preload("res://audios/sfx/attributes/stat_upgraded.mp3")

func _play_music(music: AudioStream, volume = -9.0, actualTime = 0.0):
	ost_player.stream = music
	ost_player.name = "OST_PLAYER"
	ost_player.volume_db = volume
	ost_player.bus = "OST"
	add_child(ost_player)
	if stream == music:
		return
	ost_player.play()
	ost_player.seek(actualTime)

## Music
func main_theme():
	_play_music(main_theme_intro)
	await ost_player.finished
	_play_music(main_theme_mid)

#------------------------------
func play_FX(stream: AudioStream, volume = 0.0, pitch = 1.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	fx_player.bus = "SFX" 
	fx_player.pitch_scale = pitch
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()

## SFX
# Collectors
func collector_clicked():
	play_FX(collector_clickeds, 3, randf_range(0.96, 1.04))

func collector_free():
	play_FX(collector_released, 3, randf_range(0.96, 1.04))

# Shop
func open_gui():
	play_FX(open_shopping, 3, randf_range(0.98, 1.02))

func close_gui():
	play_FX(close_shopping, 3, randf_range(0.98, 1.02))

func cant_open_gui():
	play_FX(cant_open_any, 3, randf_range(0.98, 1.02))

func item_sold():
	var rng = randi_range(1,4)
	match rng:
		1: play_FX(coin_1)
		2: play_FX(coin_2)
		3: play_FX(coin_3)
		4: play_FX(coin_4)

# Attributes
func not_allowed():
	play_FX(not_enough, 3, randf_range(0.98,1.02))

func stat_upgraded():
	play_FX(upgraded, 3, randf_range(0.96, 1.04))
	
func fade_to_music(fade_time := 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -80, fade_time) # fade out

func music_reduce(new_volume := -18.0, fade_time := 0.5, pitch = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", new_volume, fade_time) # fade out
	tween.tween_property(self, "pitch_scale", pitch, fade_time)

func music_normal(old_volume := -5.0, fade_time := 0.5, pitch = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "volume_db", old_volume, fade_time) # fade out
	tween.tween_property(self, "pitch_scale", pitch, fade_time)
