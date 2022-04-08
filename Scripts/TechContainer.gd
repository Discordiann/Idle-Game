extends GridContainer

func _ready():
	self.get_parent().get_parent().connect("clone",self,"_update")

func _update(clone):
	add_child(clone)
