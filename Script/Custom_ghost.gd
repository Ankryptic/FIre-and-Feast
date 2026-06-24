class_name CustomGhost
extends RichTextEffect

var bbcode = "cGhost"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("freq", 1.0)
	var span = char_fx.env.get("span", 1.0)

	var alpha = sin(char_fx.elapsed_time * speed + (char_fx.range.x / span)) * 0.5 + 0.5
	char_fx.color.a = alpha
	
	
	return true
