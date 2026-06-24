class_name GhostReveal
extends RichTextEffect

var bbcode = "fadeIn"

func _process_custom_fx(char_fx):

	var speed = char_fx.env.get("speed", 5.0)
	var freq = char_fx.env.get("freq", 4.0)

	# When this character starts
	var start_time = char_fx.relative_index / speed
	# Hide before reveal
	if char_fx.elapsed_time < start_time:
		char_fx.visible = false
		return true

	# Time since reveal
	var t = char_fx.elapsed_time - start_time

	# Duration of ghost animation
	var ghost_duration = 0.5

	# Stop animation after duration
	if t > ghost_duration:
		char_fx.color.a = 1.0
		return true

	# Ghost fade animation
	var alpha = sin(t * freq) * 0.5 + 0.5

	char_fx.color.a = alpha

	return true
