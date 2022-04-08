extends Button

onready var Main = get_node("/root/Main")
var T
var tech

func _ready():
	if self.name == "Tech":
		return
	T = self.get_parent().get_parent().get_parent().get_name().split("_", true, 0)[0]
	tech = Main[T][self.name]
	
	$Name.text = tech.name
	$Cost.text = Main._shorten(tech.cost)
	$Description.text = tech.desc
	
	self.visible = Main.Technologies.has_all(tech.reqs)
	
	self.connect("pressed",self,"_button_pressed")
	Main.connect("update",self,"_update")

func _button_pressed():
	var cost = tech.cost
	var points = Main[_type(T)]
	
	if Main._comp(points,Main._conv(cost)):
		Main.Technologies[self.name] = tech
		Main[_type(T)] = Main._sub(points,Main._conv(cost))
		self.queue_free()

func _type(type):
	match type:
		"BasicTechs":
			return "btech"
		"PhysicsTechs":
			return "ptech"
		"EngineeringTechs":
			return "etech"
		"ComputingTechs":
			return "ctech"

func _update(input):
	$Cost.text = Main._shorten(tech.cost)
	
	self.visible = Main.Technologies.has_all(tech.reqs)
	
	if self.name in Main.Technologies:
		self.queue_free()
