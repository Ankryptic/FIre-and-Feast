extends Node

# This is Audio Manager Script

var bg_music: String = "uid://bb3rd0v8xqrak";
var def_volume: float = 1
var curr_music: String
var playing: AudioStreamPlayer

func _ready() -> void:
	play_bg(true)
	set_volume(def_volume)



func play_bg(active: bool) -> void:
	if not active:
		return
	
	var new_music := ResourceLoader.load(bg_music, "PackedScene") as PackedScene
	
	if new_music:
		var music := new_music.instantiate()
		playing = music
		curr_music = music.get_bus()
		add_child(music)


## Sets the music Volume
func set_volume(volume: float) -> void:
	if playing:
		playing.volume_db = linear_to_db(volume)


## For debugging
#func get_current_vol() -> void:
	#if playing:
		#print(db_to_linear(playing.volume_db))
	#var bus_index = AudioServer.get_bus_index(curr_music)
	#var vol := AudioServer.get_bus_volume_linear(bus_index)
	#print(vol)

func _exit_tree() -> void:
	print("Music is freed")
