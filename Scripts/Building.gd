extends Button

var resource1 = preload("res://style_unlocked.tres").duplicate()
var resource2 = preload("res://style_disabled_unlocked.tres")
onready var Main = get_node("/root/Main")
onready var N = self.name
var T = ""
var K
var unlocked = false
var hovered = false

func _ready():
	T = _type(N)
	
	var amnt = Main.Buildings[N].amnt
	
	$HSlider.min_value = 1
	$HSlider.max_value = 1
	$HSlider.step = .1
	$Owned.text = "Owned: " + Main._shorten(amnt)
	$Cost.text = "Cost: " + Main._shorten((Main.Buildings[N].cost * Main._cost_growth(1.11,amnt,amnt + 1)) * pow(0.99,Main.Upgrades.CostB.amnt))
	$HSlider.value = Main.Buildings[N].power
	$Power.text = "Power: " + Main._short_big(Main._electricity_cons(N)) + "MW"
	_prod()
	
	self.connect("pressed",self,"_button_pressed")
	Main.connect("update",self,"_update")
	Main.connect("viewupdate",self,"_view_update")
	$HSlider.connect("value_changed",self,"_power")
	self.connect("mouse_entered",self,"_hover")
	self.connect("mouse_exited",self,"_anti_hover")
	
	if N in Main.view:
		self.visible = Main.view[N]
	
	var elec = Main.view.elec
	var tech = Main.Technologies.has("BUnderclock")
	if elec == true || tech == true:
		$HSlider.visible = true
		if elec == true:
			$HSlider.max_value = 2
			$Power.visible = true
		if tech == true:
			$HSlider.min_value = 0.2
	else:
		$HSlider.visible = false
		$Power.visible = false
	
	
	return T

func _button_pressed():
	var key = K
	
	var mats = Main.mats
	var amnt = Main.Buildings[N].amnt
	var cost = _calc(key,amnt)
	
	if (Main._comp(mats,Main._conv(cost))):
		Main.mats = Main._sub(mats,Main._conv(cost))
		
		match key:
			"x10":
				Main.Buildings[N].amnt += 10
			"x25":
				Main.Buildings[N].amnt += 25
			"x100":
				Main.Buildings[N].amnt += 100
			_:
				Main.Buildings[N].amnt += 1
		
		_text(key)

func _update(key):
	_text(key)
	
	K = key

func _view_update(A):
	if A.has(N):
		self.visible = true
		if Engine.get_frames_drawn() > 1:
			unlocked = true
			self.add_stylebox_override("normal",resource1)
			self.add_stylebox_override("disabled",resource2)
	if A.has("elec") || A.has("Underclock"):
		$HSlider.visible = true
		if A.has("elec") == true:
			$HSlider.max_value = 2
			$Power.visible = true
		if A.has("Underclock") == true:
			$HSlider.min_value = 0.2

func _type(name):
	match name:
		"MatEx":
			return ["matprod","matcons"]
		"RMatRef":
			return ["rmatprod","rmatcons"]
		"BTechLab":
			return ["btechprod","btechcons"]
		"PTechLab":
			return ["ptechprod","ptechcons"]
		"ETechLab":
			return ["etechprod","etechcons"]
		"CTechLab":
			return ["ctechprod","ctechcons"]
		"FuelRef":
			return ["fuelprod","fuelcons"]
		"PowerPlnt":
			return ["elec","eleccons"]
		"FactB":
			return "factb"
		"University":
			return "unib"
		"House":
			return "popmax"
		"Farm":
			return "popprod"
		"Leisure":
			return "leisure"

func _text(key):
	var amnt = Main.Buildings[N].amnt
	var cost = Main.Buildings[N].cost
	
	match key:
		"x10":
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 10) * pow(0.99,Main.Upgrades.CostB.amnt)
		"x25":
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 25) * pow(0.99,Main.Upgrades.CostB.amnt)
		"x100":
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 100) * pow(0.99,Main.Upgrades.CostB.amnt)
		_:
			cost = cost * Main._cost_growth(1.14,amnt,amnt + 1) * pow(0.99,Main.Upgrades.CostB.amnt)
	$Cost.text = "Cost: " + Main._shorten(cost)
	if Main._comp(Main.mats,Main._conv(cost)) == false:
		if self.disabled == false:
			self.disabled = true
			$Name.add_color_override("font_color",Color("3e3e3e"))
			$Cost.add_color_override("font_color",Color("3e3e3e"))
			$Owned.add_color_override("font_color",Color("3e3e3e"))
			$Production.add_color_override("font_color",Color("3e3e3e"))
			$Power.add_color_override("font_color",Color("3e3e3e"))
			$Description.add_color_override("font_color",Color("3e3e3e"))
	else:
		if self.disabled == true:
			self.disabled = false
			$Name.add_color_override("font_color",Color("e0e0e0"))
			$Cost.add_color_override("font_color",Color("e0e0e0"))
			$Owned.add_color_override("font_color",Color("e0e0e0"))
			$Production.add_color_override("font_color",Color("e0e0e0"))
			$Power.add_color_override("font_color",Color("e0e0e0"))
			$Description.add_color_override("font_color",Color("e0e0e0"))
	$Owned.text = "Owned: " + Main._shorten(amnt)
	$HSlider.value = Main.Buildings[N].power
	$Power.text = "Power: " + Main._short_big(Main._electricity_cons(N)) + "MW"
	_prod()

func _prod():
	match N:
		"FactB":
			$Production.text = "Prod: " + Main._short_big(Main.factb) + "%"
		"University":
			$Production.text = "Prod: " + Main._short_big(Main.unib) + "%"
		"House":
			$Production.text = "Prod: " + Main._short_big(Main.popmax)
		"Farm":
			$Production.text = "Prod: " + Main._short_big(Main.popprod)
		"Leisure":
			$Production.text = "Prod: " + Main._short_big(Main.leisure) + "%"
		_:
			if hovered:
				$Production.text = "Prod: " + Main._short_big(Main._sub(Main[T[0]],Main[T[1]]))
			else:
				$Production.text = "Prod: " + Main._short_big(Main[T[0]])

func _calc(key,amnt):
	match key:
		"x10":
			return Main.Buildings[N].cost * Main._cost_growth(1.14,amnt,amnt + 10) * pow(0.99,Main.Upgrades.CostB.amnt)
		"x25":
			return Main.Buildings[N].cost * Main._cost_growth(1.14,amnt,amnt + 25) * pow(0.99,Main.Upgrades.CostB.amnt)
		"x100":
			return Main.Buildings[N].cost * Main._cost_growth(1.14,amnt,amnt + 100) * pow(0.99,Main.Upgrades.CostB.amnt)
		_:
			return Main.Buildings[N].cost * Main._cost_growth(1.14,amnt,amnt + 1) * pow(0.99,Main.Upgrades.CostB.amnt)

func _power(p):
	Main.Buildings[N].power = p

func _hover():
	hovered = true
	if unlocked == true:
		unlocked = false
		self.add_stylebox_override("normal",null)
		self.add_stylebox_override("disabled",null)

func _anti_hover():
	hovered = false
