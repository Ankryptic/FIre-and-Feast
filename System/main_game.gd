class_name MainGame
extends Node

# TODO: Give Enemy HitBox
# TODO: Animate Player Exit

signal health_Changed(curr_health: float, max_health: float)
signal coin_changed(amount: int)
signal update_weapon_collection(weapons: Array[Weapon])
signal active_weapon_changed(res: Weapon)

# main game script

@export var pause_menu_canvas: CanvasLayer
@export var player_hud_canvas: CanvasLayer
@export var player_hud: Control

var player_path: String = "uid://dsd45eb3073we"
var next_level: String = "uid://bkpes4wn5yval"
var current_level: int
var current_level_scene: Node2D
var player: Player
var player_health_component: HealthComponent
var player_weappon_component: WeaponComponent

@onready var level_root: Node2D = $World/LevelRoot
@onready var entity_root: Node2D = $World/EntityRoot
@onready var global_animation_player: AnimationPlayer = $GlobalAnimationPlayer

func _ready() -> void:
	_init_player();
	load_level(next_level)
	
	pause_menu_canvas.visible = false
	get_tree().paused = false
	SceneManager.main_game = self
	
	player_hud.active_weapon_changed.connect(_emit_weapon_changed)


func _process(_delta) -> void:
	toggle_pause_menu()


## Pause Menu Control
func toggle_pause_menu() -> void:
	if Input.is_action_just_pressed("togglePause"):
		if pause_menu_canvas.visible == true:
			pause_menu_canvas.visible = false
			get_tree().paused = false
		else:
			pause_menu_canvas.visible = true
			get_tree().paused = true


## Load new Level
func load_level(new_level: String) -> void:
	# Make Sure to Load Scene When its Idle
	_deferred_load_level.call_deferred(new_level)


## Loads the Player 
func _init_player() -> void:
	var player_scene = ResourceLoader.load(player_path, "PackedScene") as PackedScene
	if player_scene == null:
		print("Unable to load Player Scene, ", player_path)
		return
	
	player = player_scene.instantiate()
	
	if player == null:
		print("Unable to Instantiate")
		return 
	
	# Making Signal connection b/w player and main
	player_health_component = player.get_node("HealthComponent") as HealthComponent
	player_weappon_component = player.get_node("WeaponComponent") as WeaponComponent
	
	player_health_component.health_changed.connect(update_health_in_hud)
	player_weappon_component.weapon_collected.connect(update_weapon_in_hud)
	
	player.coin_changed.connect(_emit_coin_changed)
	SceneManager.player = player


## Load Level When System is Idle
func _deferred_load_level(new_level: String) -> void:
	# Check for Save level data
	if current_level_scene != null:
		current_level_scene.queue_free()
		current_level_scene = null
	
	await get_tree().process_frame
	
	var level = ResourceLoader.load(new_level, "PackedScene") as PackedScene
	
	if level == null:
		print("Level Not Found: %d" % new_level)
	
	current_level_scene = level.instantiate()
	level_root.add_child(current_level_scene)
	
	await get_tree().process_frame
	
	set_player_in_level()
	#setup_animation_player()

## Setting up the Player in current level
func set_player_in_level() -> void:
	if current_level == null:
		print("Level_not_foound!")
		return;
	if player == null:
		print("Player Not Found!")
		return;
	
	entity_root.add_child(player)


## Connects player health component to HUD Health bar
func update_health_in_hud(curr_health: float, max_health: float) -> void:
	health_Changed.emit(curr_health, max_health)

## Connects player weapon component to HUD weapon collection
func update_weapon_in_hud(weapons: Array[Weapon]) -> void:
	update_weapon_collection.emit(weapons)

## Connects player Coin Collection in HUD
func _emit_coin_changed(amount: int) -> void:
	coin_changed.emit(amount)

## Pass Weapon Selected by Player
func _emit_weapon_changed(res: Weapon) -> void:
	active_weapon_changed.emit(res)


func update_player_coin_collection(coins: Array) -> void:
	if player == null:
		printerr("No Player Found");
	
	player.coin_collection = coins
	player.coin_collected = coins.size()
	coin_changed.emit(coins.size())


func setup_animation_player() -> void:
	if not player:
		printerr("Player not Found")
		return;
	
	if not current_level_scene:
		printerr("Level not found")
		return;
	
	var exit_animation: Animation = global_animation_player.get_animation("exit_walk");
	
	var animation_root = global_animation_player.get_node(global_animation_player.get_root())
	
	# Give Player Path MainGame/EntityRoot/Player
	var player_loc := animation_root.get_path_to(player);
	
	
	print("PlayerPath: ", player_loc)
	print("GlobalAnimationPlayer Path: ", get_path_to(global_animation_player))
	print("Animation Root: ", animation_root)
	
	var track_index := exit_animation.add_track(Animation.TYPE_VALUE)
	
	exit_animation.track_set_path(
		track_index,
		NodePath(str(player_loc) + ':position')
	)
	
	exit_animation.track_insert_key(
		track_index, 
		0.0,
		player.position
	)
	
	exit_animation.track_insert_key(
		track_index,
		2.0,
		Vector2(500, 200)
	)
	
	print("Track Count: ", exit_animation.get_track_count())
	
	global_animation_player.clear_caches()
