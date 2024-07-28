extends Control
class_name Card
@onready var card_area = get_parent().get_node("BG/Area2D/CollisionShape2D")
var selected = false
var card_id = {}
var flipped = false
var qlabel : Label



func _ready():



	draw_card()
	
	

	# Signal handler for mouse entered
func _on_mouse_entered():
	if not self in CardManager.mouseover:
		CardManager.mouseover[self]=self

# Signal handler for mouse exited
func _on_mouse_exited():
	if self in CardManager.mouseover:
		CardManager.mouseover.erase(self)
	if qlabel:
		qlabel.visible = false


func _physics_process(delta):
	if selected:
		var target_pos = get_global_mouse_position()
		var total =(get_viewport_rect().size.x - card_area.shape.extents.x*2)		
		target_pos.x = clamp(target_pos.x, card_area.shape.extents.x/4, card_area.shape.size.x)
		target_pos.y = clamp(target_pos.y, (card_area.shape.extents.y), card_area.shape.size.y)
		global_position = lerp(global_position, target_pos, 25 * delta)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if flipped == false:
				if self in CardManager.mouseover:
						if is_topmost():
							make_topmost()
							selected = true
			else:
				if not qlabel:
					qlabel = Label.new()
					
					qlabel.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
					qlabel.size = card_area.shape.size/6
					var new_sb = StyleBoxFlat.new()
					new_sb.bg_color = Color8(0,0,0,200)
					for i in card_id["Questions to Ask"]:
						
						qlabel.text += i + "    "
						qlabel.add_theme_stylebox_override("normal", new_sb)
					add_child(qlabel)
					qlabel.rotation = rotation
			
				else:
					qlabel.visible = true
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flip_card()
			print("rmb heard")
		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			if self in CardManager.mouseover:
						if is_topmost():
							rotate_card()


func rotate_card():
	if self.flipped == false:
		rotation += deg_to_rad(90)
		
	if deg_to_rad(rotation) >= 360:
		
		rotation = 0


func flip_card():
		if flipped == false:
			flipped = not flipped
			var front_texture = load("res://cards/" + card_id.img)
			var sprite = get_child(0) 
			sprite.texture = front_texture
			sprite.scale = Vector2(0.5, 0.5)
		else:
			pass
			
func make_topmost():
	var indexes = []
	for card in get_parent().get_children():
		if card is Card:
			indexes.append(card.z_index)
	self.z_index = indexes.max()+1
				
func is_topmost()->bool:

	var topmost_card = self
	for card in CardManager.mouseover:
		if card is Card and card.z_index > topmost_card.z_index:
			topmost_card = card
	return topmost_card == self


func draw_card():
	

	mouse_filter = Control.MOUSE_FILTER_PASS
	
	self.card_id = CardManager.data.cards[randi_range(0, CardManager.data.cards.size()-1)]
	
	var sprite = Sprite2D.new()
	sprite.texture = load("res://card_back.png")
	sprite.scale = Vector2(0.5,0.5)
	
	var sprite_size = sprite.texture.get_size()/2
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	var card_area = Area2D.new()
	card_area.mouse_entered.connect(_on_mouse_entered)
	card_area.mouse_exited.connect(_on_mouse_exited)
	
	
	
	if randi()%2 == 0:
		rotation = deg_to_rad(180)
	
	
	card_area.input_event.connect(_on_area_2d_input_event)
	
	
	
	shape.extents = sprite.texture.get_size() * 0.5
	collision.shape = shape
	
	card_area.add_child(collision)
	sprite.add_child(card_area)
	add_child(sprite)
	CardManager.drawn_cards +=1
	self.z_index = CardManager.drawn_cards
	
	
	

	
	for card in CardManager.data.cards:
		if card == card_id:
			CardManager.data.cards.erase(card)


