extends CheckBox

onready var Main = get_node("/root/Main")
onready var Tech = get_node("/root/Main/TechTrees_Menu")

var T = ""

func _ready():
	pass

func _pressed():
	T = get_parent().name + self.name
	#match get_parent().name:
		#"Materials":
			#T = "Materials" + self.name
		#"RefinedMaterials":
			#T = "RefinedMaterials" + self.name
		#"BasicTech":
			#T = "BasicTech" + self.name
		#"PhysicsTech":
			#T = "PhysicsTech" + self.name
	if self.pressed == true:
		Main.toggles[T] = true
	else:
		Main.toggles[T] = false

func _update(Tech):
	pass
