
class_name CustomEffect
extends RichTextEffect

var bbcode = "akki"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var t = char_fx.elapsed_time
	var i = char_fx.relative_index
	
	char_fx.env[{"font_size": 50}]
	
	char_fx.offset.y = sin(5.0 + i) * 10.0


	return true
