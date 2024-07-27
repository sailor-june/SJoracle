extends Node2D
var display_card = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for card in CardManager.library.cards:
		if card.img == CardManager.current_card_id+".jpg":
			$DisplayCard.texture = load("res://cards/"+card.img)
			display_card = card
			var single_props = ["name","number","suit", "Archetype", "Hebrew Alphabet", "Numerology", "Elemental"]
			var arr_props = ["fortune_telling", "keywords", "Questions to Ask"]
			var dict_props = ["meanings"]
			for prop in single_props:
				if prop in display_card.keys():
					var new_prop = Label.new()
					new_prop.autowrap_mode=true
					new_prop.size_flags_horizontal=Control.SIZE_EXPAND_FILL
					new_prop.anchor_left = 0 
					new_prop.anchor_right = 1
					var prop_text =  prop + " : " + display_card[prop]
					new_prop.text = prop_text
					$ScrollContainer/GridContainer.add_child(new_prop)
				else: print(prop, " property not found on card ", display_card.name )
			
			for p in arr_props:
				var new_prop = Label.new()
				new_prop.autowrap_mode=true
				new_prop.add_theme_color_override("font_color", Color(1, 0.25, 0))
				new_prop.size_flags_horizontal=Control.SIZE_EXPAND_FILL
				new_prop.anchor_left = 0 
				new_prop.anchor_right = 1
				var prop_text =  p + " : " 
				new_prop.text = prop_text
				$ScrollContainer/GridContainer.add_child(new_prop)
				prop_text = ""
				var prop_element = Label.new()
				prop_element.autowrap_mode=true
				prop_element.size_flags_horizontal=Control.SIZE_EXPAND_FILL
				prop_element.anchor_left = 0 
				prop_element.anchor_right = 1
				for i in range (display_card[p].size()):
					prop_text += display_card[p][i]
					if i < display_card[p].size()-1 and not display_card[p][i].ends_with("?"):
						prop_text += ", "
					else: prop_text +=" "
					 
				prop_element.text = prop_text
				$ScrollContainer/GridContainer.add_child(prop_element)
				
			for x in display_card["meanings"].keys():
				var prop_text = x
				var prop_element = Label.new()
				prop_element.add_theme_color_override("font_color", Color(1, 0.25, 0))
				prop_element.autowrap_mode=true
				prop_element.size_flags_horizontal=Control.SIZE_EXPAND_FILL
				prop_element.anchor_left = 0 
				prop_element.anchor_right = 1
				prop_element.text=x
				$ScrollContainer/GridContainer.add_child(prop_element)
				for line in display_card["meanings"][x]:
					var meaning_ele = Label.new()
					meaning_ele.autowrap_mode=true
					meaning_ele.size_flags_horizontal=Control.SIZE_EXPAND_FILL
					meaning_ele.anchor_left = 0 
					meaning_ele.anchor_right = 1
					prop_text = line
					meaning_ele.text = prop_text
					$ScrollContainer/GridContainer.add_child(meaning_ele)
					

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://"+display_card.suit+"_view.tscn")
