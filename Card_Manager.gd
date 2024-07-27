extends Node
@onready var filePath ="res://tarot-images.json"
var data = {}
var current_suit: String
var current_card_id: String
@onready var rando = RandomNumberGenerator.new()
var library = {}
var mouseover = {}
var drawn_cards : int = 0



func _ready() -> void:
	
	library = load_card_data(filePath)
	data = library

		



func shuffle_deck():
	data = load_card_data(filePath)
		




func load_card_data(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsed_data = JSON.parse_string(dataFile.get_as_text())
		if parsed_data is Dictionary:
			print("cards loaded successfully")
			return parsed_data
			
		else:
			print("Error reading file")
	else:
		print("JSON file error")
