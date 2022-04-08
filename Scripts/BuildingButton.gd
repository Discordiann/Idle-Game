extends Button

onready var Main = get_node("/root/Main")
var T = ""

func _ready():
	T = get_name().split("_", true, 0)[0]
	return T

func _pressed():
	Main._buy_building(T)
