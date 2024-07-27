extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_go_home_pressed():
	get_tree().change_scene_to_file("res://title.tscn")
	







func _on_suit_pressed(suit):
	get_tree().change_scene_to_file("res://"+suit+"_view.tscn")
	


