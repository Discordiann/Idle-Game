extends Label

onready var Main = get_node("/root/Main")
var T = ""
var innum = false

func _ready():
	T = get_name().split("_", true, 0)[0]
	
	if self.get_parent().name == "Numbers":
		innum = true
	
	if T in Main.view:
		self.visible = Main.view[T]
		if innum == true:
			get_node("/root/Main/Numbers/" + T + "_Icon").visible = Main.view[T]
	
	Main.connect("update", self, "_update")
	Main.connect("viewupdate", self, "_view_update")
	return T

func _update(key):
	match T:
		"divshort":
			if Main._comp(Main.divshort, [1.01,0]):
				self.text = "Due to resource shortages your production is being divided by: " + Main._short_big(Main.divshort)
		"elec":
			self.text = Main._short_big(Main._sub(Main.elec,Main.eleccons)) + "MW"
		_:
			self.text = Main._short_big(Main[T])

func _view_update(A):
	if A.has(T):
		self.visible = true
		if innum == true:
			get_node("/root/Main/Numbers/" + T + "_Icon").visible = true
