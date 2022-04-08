extends Label

onready var Main = get_node("/root/Main")
var T = ""
var B = ""

func _ready():
	T = get_name()
	B = get_parent().get_name()
	Main.connect("update", self, "_update")
	return T
	return B

func _update():
	match T:
		"Cost":
			self.text = String(Main.Buildings[B].cost)
		"Production":
			self.text = String(Main.Buildings[B].production * Main.Buildings[B].amount)
		"Amount":
			self.text = String(Main.Buildings[B].amount)
