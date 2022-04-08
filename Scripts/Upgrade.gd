extends Button

var resource1 = preload("res://style_unlocked.tres")
var resource2 = preload("res://style_disabled_unlocked.tres")
onready var Main = get_node("/root/Main")
onready var N = self.name
var K
var unlocked = false

func _ready():
	_text("1x")
	
	self.connect("pressed",self,"_button_pressed")
	Main.connect("update",self,"_update")
	Main.connect("viewupdate",self,"_view_update")
	self.connect("mouse_entered",self,"_hover")
	
	if N in Main.view:
		self.visible = Main.view[N]

func _button_pressed():
	var rmats = Main.rmats
	var amnt = Main.Upgrades[N].amnt
	var cost = _calc(K,amnt)
	
	if (Main._comp(rmats,Main._conv(cost))):
		Main.rmats = Main._sub(rmats,Main._conv(cost))
		
		match K:
			"x10":
				Main.Upgrades[N].amnt += 10
			"x25":
				Main.Upgrades[N].amnt += 25
			"x100":
				Main.Upgrades[N].amnt += 100
			_:
				Main.Upgrades[N].amnt += 1
		
		_text(K)

func _update(key):
	_text(key)
	
	K = key

func _view_update(A):
	if A.has(N):
		self.visible = true
		if Engine.get_frames_drawn() > 1:
			self.unlocked = true
			self.add_stylebox_override("normal",resource1)
			self.add_stylebox_override("disabled",resource2)

func _text(key):
	var amnt = Main.Upgrades[N].amnt
	var cost = Main.Upgrades[N].cost
	
	match key:
		"x10":
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 10)
		"x25":
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 25)
		"x100":
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 100)
		_:
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 1)
	$Cost.text = Main._shorten(cost)
	if Main._comp(Main._conv(cost),Main.rmats):
		if self.disabled == false:
			self.disabled = true
			$Name.add_color_override("font_color",Color("3e3e3e"))
			$Cost.add_color_override("font_color",Color("3e3e3e"))
			$Boost.add_color_override("font_color",Color("3e3e3e"))
			$Description.add_color_override("font_color",Color("3e3e3e"))
	else:
		if self.disabled == true:
			self.disabled = false
			$Name.add_color_override("font_color",Color("e0e0e0"))
			$Cost.add_color_override("font_color",Color("e0e0e0"))
			$Boost.add_color_override("font_color",Color("e0e0e0"))
			$Description.add_color_override("font_color",Color("e0e0e0"))
	
	match N:
		"CostB":
			$Boost.text = "Effect: -" + String(stepify((1 - pow(0.99,Main.Upgrades[N].amnt)) * 100,0.00001)) + "%"
		_:
			$Boost.text = "Boost: " + Main._shorten((pow(1.10,Main.Upgrades[N].amnt) - 1) * 100) + "%"

func _calc(key,amnt):
	match key:
		"x10":
			return Main.Upgrades[N].cost * Main._cost_growth(1.14,amnt,amnt + 10)
		"x25":
			return Main.Upgrades[N].cost * Main._cost_growth(1.14,amnt,amnt + 25)
		"x100":
			return Main.Upgrades[N].cost * Main._cost_growth(1.14,amnt,amnt + 100)
		_:
			return Main.Upgrades[N].cost * Main._cost_growth(1.14,amnt,amnt + 1)

func _hover():
	if unlocked == true:
		unlocked = false
		self.add_stylebox_override("normal",null)
		self.add_stylebox_override("disabled",null)
