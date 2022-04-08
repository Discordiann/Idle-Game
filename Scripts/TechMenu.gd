extends Node2D

onready var Main = get_node("/root/Main")
onready var og = get_node("/root/Main/Copy/Tech")
var N

signal clone()

func _ready():
	N = get_name().split("_", true, 0)[0]
	
	if N in Main.view:
		self.visible = Main.view[N]
	
	for tech in Main[N]:
		var clone = og.duplicate()
		clone.name = tech
		_clone(clone)
	
	Main.connect("update",self,"_update")
	Main.connect("viewupdate",self,"_view_update")

func _update(key):
	pass

func _view_update(A):
	if A.has(N):
		self.visible = true

func _clone(clone):
	emit_signal("clone",clone)
