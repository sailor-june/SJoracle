extends Node2D
@onready var area_node=  $BG/Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	CardManager.shuffle_deck()
	

#func _on_TextureRect_pressed() -> void:
	#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_deck_pressed():
	var new_card = Card.new()
	new_card.global_position = $deck.global_position
	new_card.global_position.y += 250

		
	add_child(new_card)


func _on_shuffler_pressed():
	for node in get_children():
		if node is Card:
			node.queue_free()
	CardManager.shuffle_deck()
	


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://title.tscn")
