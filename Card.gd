extends Control
class_name Card
@onready var card_area = get_parent().get_child(0).get_child(0)
var selected = false
var card_id = {}
var flipped = false
var area_bounds : Rect2


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


func _physics_process(delta):
	if selected:

		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if flipped == false:
				if self in CardManager.mouseover:
						if is_topmost():
							make_topmost()
							selected = true
			else:
				#display related questions
				pass
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
	area_bounds = card_area.get_child(0).shape.get_rect()
	
	

	
	for card in CardManager.data.cards:
		if card == card_id:
			CardManager.data.cards.erase(card)


