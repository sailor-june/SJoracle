extends Node2D

@export var front_textures: Array[Texture] 
@export var back_texture = Texture
@onready var the_card = get_node("Spinning_card")

var is_flipped = false


func _ready():
	the_card.texture = front_textures[randi_range(0,front_textures.size()-1)]
	spin_card()


func spin_card():
	var tween = create_tween()
	tween.set_loops()
	tween.bind_node(the_card)
	tween.set_speed_scale(0.5)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(the_card, "scale:x", 0.05, 0.5)
	tween.chain().tween_callback(Callable(self, "_switch_texture"))
	tween.chain().tween_property(the_card, "scale:x", 1, 0.5)
	tween.play()




func _switch_texture():
	if is_flipped:
		the_card.texture = front_textures[randi_range(0,front_textures.size()-1)]
	else:
		the_card.texture = back_texture
	is_flipped = not is_flipped


func _on_go_encyclopedia_pressed():
	get_tree().change_scene_to_file("res://encyclopedia.tscn")


func _on_drawing_button_pressed():
	get_tree().change_scene_to_file("res://Drawing.tscn")
