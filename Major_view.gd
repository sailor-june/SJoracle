extends Control
@export var Images : Array[Texture] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#doesnt seem to do anything
	for i in Images:
		var card = Button.new()
		var card_id = i.resource_path.substr(12,3)
		
		card.set_meta("card_name", card_id) 
		card.custom_minimum_size = Vector2i(175,300)
		card.expand_icon=true 
		card.size_flags_stretch_ratio=1
		card.size_flags_horizontal=Control.SIZE_EXPAND_FILL
		
		card.icon = i
		
		card.pressed.connect(_on_button_pressed.bind(card))
		
		$ScrollContainer/GridContainer.add_child(card)
	var box = get_node("ScrollContainer/GridContainer")
	var button = $Button
	remove_child(button)
	box.add_child(button)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass

func _on_button_pressed(button: Button) -> void:
	var card_name = button.get_meta("card_name")
	CardManager.current_card_id = card_name
	print("Button pressed for card: ", card_name)
	# use the card_name to fetch relevant card data

	get_tree().change_scene_to_file("res://card_view.tscn")


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://encyclopedia.tscn")
