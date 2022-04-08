extends Button

var resource = preload("res://style_unlocked.tres").duplicate()
onready var Main = get_node("/root/Main")
var Ms = []
var N = ""
var unlocked = false

func _ready():
	N = get_name().split("_", true, 0)[0]
	
	if N in Main.view:
		self.visible = Main.view[N]
	
	Main.connect("viewupdate",self,"_view_update")
	self.connect("mouse_entered",self,"_hover")
	
	var Msn = get_parent().get_children()
	for i in Msn.size():
		if "_Menu" in Msn[i].get_name():
			Ms.append(Msn[i])
	return Ms
	return N

func _pressed():
	var T = get_name().split("_", true, 0)[0]
	var M = get_parent().get_node(T + "_Menu")
	if M.visible == false:
		for i in Ms.size():
			var Msi = Ms[i]
			if Msi && Msi.visible == true:
				Msi.visible = (false)
			M.visible = (true)

func _view_update(A):
	if A.has(N):
		self.visible = true
		if Engine.get_frames_drawn() > 1:
			unlocked = true
			self.add_stylebox_override("normal",resource)

func _hover():
	if unlocked == true:
		unlocked = false
		self.add_stylebox_override("normal",null)
