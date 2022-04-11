extends Node2D

signal update()
signal viewupdate()

onready var Tech = get_node("/root/Main/TechTrees_Menu")

var autosave = true

var mats = [float(1),float(2)]
var matprod = [float(0),float(0)]
var matcons = [float(0),float(0)]
var rmats = [float(0),float(0)]
var rmatprod = [float(0),float(0)]
var rmatcons = [float(0),float(0)]
var btech = [float(0),float(0)]
var btechprod = [float(0),float(0)]
var btechcons = [float(0),float(0)]
var ptech = [float(0),float(0)]
var ptechprod = [float(0),float(0)]
var ptechcons = [float(0),float(0)]
var etech = [float(0),float(0)]
var etechprod = [float(0),float(0)]
var etechcons = [float(0),float(0)]
var ctech = [float(0),float(0)]
var ctechprod = [float(0),float(0)]
var ctechcons = [float(0),float(0)]
var pop = [float(0),float(0)]
var popmax = [float(0),float(0)]
var popprod = [float(0),float(0)]
var fuel = [float(0),float(0)]
var fuelprod = [float(0),float(0)]
var fuelcons = [float(0),float(0)]
var elec = [float(0),float(0)]
var elecprod = [float(0),float(0)]
var eleccons = [float(0),float(0)]
var elecboost = [float(0),float(0)]
var divshort = [float(1),float(0)]
var factb = [float(0),float(0)]
var factprod = [float(0),float(0)]
var unib = [float(0),float(0)]
var uniprod = [float(0),float(0)]
var leisure = [float(1),float(0)]
var matsatis = [float(1),float(0)]
var rmatsatis = [float(1),float(0)]
var btechsatis = [float(1),float(0)]
var fuelsatis = [float(1),float(0)]

var view = {
	"rmats": false,
	"btech": false,
	"ptech": false,
	"etech": false,
	"ctech": false,
	"pop": false,
	"fuel": false,
	"elec": false,
	"RMatRef": false,
	"BTechLab": false,
	"PTechLab": false,
	"ETechLab": false,
	"CTechLab": false,
	"FuelRef": false,
	"PowerPlnt": false,
	"Advanced": false,
	"City": false,
	"Upgrades": false,
	"AdvancedUpgrades": false,
	"CostB": false,
	"TechB": false,
	"BTechLabB": false,
	"PTechLabB": false,
	"ETechLabB": false,
	"CTechLabB": false,
	"TechTrees": false,
	"PhysicsTechs": false,
	"EngineeringTechs": false,
	"ComputingTechs": false,
	"Conquest": false,
	"Underclock": false,
}

var toggles = {
	"MatDis": false,
	"RMatDis": false,
	"BTechDis": false,
	"PhysTechDis": false,
}

var Buildings = {
	"MatEx": {"amnt":0,"cost":100,"power":1,"powercons":.4},
	"RMatRef": {"amnt":0,"cost":2000,"power":1,"powercons":.8},
	"BTechLab": {"amnt":0,"cost":20000,"power":1,"powercons":2},
	"PTechLab": {"amnt":0,"cost":2e9,"power":1,"powercons":4},
	"ETechLab": {"amnt":0,"cost":2e11,"power":1,"powercons":6},
	"CTechLab": {"amnt":0,"cost":2e13,"power":1,"powercons":8},
	"FuelRef": {"amnt":0,"cost":1e6,"power":1,"powercons":1},
	"PowerPlnt": {"amnt":0,"cost":5e6,"power":1,"powercons":2},
	"FactB": {"amnt":0,"cost":1e5,"power":1,"powercons":1},
	"House": {"amnt":0,"cost":1e4,"power":1,"powercons":4},
	"Farm": {"amnt":0,"cost":5e3,"power":1,"powercons":4},
	"Leisure": {"amnt":0,"cost":5e4,"power":1,"powercons":.8},
	"University": {"amnt":0,"cost":1e5,"power":1,"powercons":2},
}

var Upgrades = {
	"MatB": {"amnt":0,"cost":1000},
	"MatExB": {"amnt":0,"cost":1000},
	"RMatB": {"amnt":0,"cost":2500},
	"RMatRefB": {"amnt":0,"cost":2500},
	"CostB": {"amnt":0,"cost":20000},
	"TechB": {"amnt":0,"cost":10000},
	"BTechLabB": {"amnt":0,"cost":10000},
	"PTechLabB": {"amnt":0,"cost":1e9},
	"ETechLabB": {"amnt":0,"cost":1e11},
	"CTechLabB": {"amnt":0,"cost":1e13},
}

var BasicTechs = {
	"BEffici1": {"cost":1e3,"name":"Writing","desc":"Boosts all production by 20%","reqs":[]},
	"BEffici2": {"cost":1e5,"name":"Organization","desc":"Boosts all production by 20%","reqs":["BEffici1"]},
	"BEffici3": {"cost":1e7,"name":"Division of Labor","desc":"Boosts all production by 20%","reqs":["BEffici2"]},
	"BEffici4": {"cost":1e9,"name":"Self-Sufficient Facilities","desc":"Boosts all production by 20%","reqs":["BEffici3"]},
	"BEffici5": {"cost":1e11,"name":"Maximum Efficiency","desc":"Boosts all production by 20%","reqs":["BEffici4"]},
	
	"BEffici6": {"cost":1e2,"name":"Iron Tools","desc":"Boosts material production by 20%","reqs":[]},
	"BEffici7": {"cost":1e4,"name":"Steel Tools","desc":"Boosts material production by 20%","reqs":["BEffici6"]},
	"BEffici8": {"cost":1e6,"name":"Tunneling","desc":"Boosts material production by 20%","reqs":["BEffici7"]},
	"BEffici9": {"cost":1e8,"name":"Dynamite","desc":"Boosts material production by 20%","reqs":["BEffici8"]},
	"BEffici10": {"cost":1e10,"name":"Extraction Patterns","desc":"Boosts material production by 20%","reqs":["BEffici9"]},
	
	"BMatEffici": {"cost":1e6,"name":"Ore Deposit Survey","desc":"Boosts material production by 2x","reqs":["BEffici1"]},
	"BRMatEffici": {"cost":1e9,"name":"Foundry Redesign","desc":"Boosts refined material production by 2x","reqs":["BEffici3","BMatEffici"]},
	
	"BTechEffici1": {"cost":1e6,"name":"Scientific Method","desc":"Boosts tech production by 20%","reqs":[]},
	"BTechEffici2": {"cost":1e9,"name":"Superior Science","desc":"Boosts tech production by 20%","reqs":["BTechEffici1"]},
	"BTechEffici3": {"cost":1e12,"name":"Brain Drain Mitigation","desc":"Boosts tech production by 20%","reqs":["BTechEffici2"]},
	
	"BAdvUnlock": {"cost":1e4,"name":"Inventive Building Design","desc":"Unlocks the Advanced Buildings tab","reqs":[]},
	"BAdvUpUnlock": {"cost":1e6,"name":"Synergistic Concepts","desc":"Unlocks the Advanced Upgrades tab","reqs":[]},
	"BCityUnlock": {"cost":1e7,"name":"Government Theory","desc":"Unlocks the City tab","reqs":["BAdvUnlock"]},
	"BConqUnlock": {"cost":1e7,"name":"Threat Detection","desc":"Unlocks the Conquest tab","reqs":[]},
	"BPTechUnlock": {"cost":1e7,"name":"Discovery of Gravity","desc":"Unlocks physics research","reqs":["BTechEffici1"]},
	"BETechUnlock": {"cost":1e9,"name":"Professional Design","desc":"Unlocks engineering research","reqs":["BPTechUnlock"]},
	"BCTechUnlock": {"cost":1e11,"name":"Automatic Calculation","desc":"Unlocks computing research","reqs":["BETechUnlock"]},
	
	"BUnderclock": {"cost":1e3,"name":"Underclocking","desc":"Slow your buildings down to 20% production","reqs":[]}
}

var PhysicsTechs = {
	"PElecUnlock": {"cost":1e4,"name":"Discovery of Electricity","desc":"Unlocks fuel and electricity production","reqs":[]}
}

var EngineeringTechs = {
	
}

var ComputingTechs = {
	
}

var Technologies = {}

func _ready():
	_load()

# @Depreciated
func _return_data(data:String):
	match data:
		"mat":
			return mats
		"rmat":
			return rmats
		"btech":
			return btech
		"ptech":
			return ptech
		"etech":
			return etech
		"ctech":
			return ctech
		"Buildings":
			return Buildings
		"matBuildings":
			return Buildings[0-4]

#func _set(property, value):
#	self[property] = value
#	_update()

func _update():
	var input
	
	if Input.is_action_pressed("x10"):
		input = "x10"
	else: if Input.is_action_pressed("x25"):
		input = "x25"
	else: if Input.is_action_pressed("x100"):
		input = "x100"
	else:
		input = "x1"
	
	emit_signal("update",input)

func _tech_update(tech):
	pass

func _find_total_production(type:String):
	match type:
		"mats":
			return _div(_mult(_mult(_mult(_mult(_mult(_mult(_mult(_mult(_mult(_mult(
			_mult(_mult(_conv(Buildings.MatEx.amnt * 10), _add(_conv(min(1,Buildings.MatEx.power)),_mult(_conv(max(1,Buildings.MatEx.power) - 1),elecboost))), _conv(pow(1.10,Upgrades.MatExB.amnt)))
			 , _conv(pow(1.10,Upgrades.MatB.amnt)))
			 , BTechBoost())
			 , GlobalBoost())
			 , _conv(pow(1.20,int(Technologies.has("BEffici6")))))
			 , _conv(pow(1.20,int(Technologies.has("BEffici7")))))
			 , _conv(pow(1.20,int(Technologies.has("BEffici8")))))
			 , _conv(pow(1.20,int(Technologies.has("BEffici9")))))
			 , _conv(pow(1.20,int(Technologies.has("BEffici10")))))
			
			 , _conv(pow(2,int(Technologies.has("BMatEffici")))))
			
			 , factb)
			
			 , divshort
			)
		"rmats":
			return _div(_mult(_mult(_mult(_mult(_mult(
			_mult(_mult(_conv(Buildings.RMatRef.amnt * 5), _add(_conv(min(1,Buildings.RMatRef.power)),_mult(_conv(max(1,Buildings.RMatRef.power) - 1),elecboost))), _conv(pow(1.10,Upgrades.RMatRefB.amnt)))
			 , _conv(pow(1.10,Upgrades.RMatB.amnt)))
			 , BTechBoost())
			 , GlobalBoost())
			 , _conv(pow(2,int(Technologies.has("BRMatEffici")))))
			
			 , factb)
			
			 , divshort
			)
		"btech":
			return _div(_mult(_mult(_mult(_mult(_mult(_mult(_mult(
			_mult(_mult(_conv(Buildings.BTechLab.amnt * 2), _add(_conv(min(1,Buildings.BTechLab.power)),_mult(_conv(max(1,Buildings.BTechLab.power) - 1),elecboost))), _conv(pow(1.10,Upgrades.BTechLabB.amnt)))
			 , _conv(pow(1.10,Upgrades.TechB.amnt)))
			 , BTechBoost())
			 , GlobalBoost())
			 , _conv(pow(2,int(Technologies.has("BTechEffici1")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici2")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici3")))))
			
			 , unib)
			
			 , divshort
			)
		"ptech":
			return _div(_mult(_mult(_mult(_mult(_mult(_mult(_mult(
			_mult(_mult(_conv(Buildings.PTechLab.amnt * 1), _add(_conv(min(1,Buildings.PTechLab.power)),_mult(_conv(max(1,Buildings.PTechLab.power) - 1),elecboost))), _conv(pow(1.10,Upgrades.PTechLabB.amnt)))
			 , _conv(pow(1.10,Upgrades.TechB.amnt)))
			 , BTechBoost())
			 , GlobalBoost())
			 , _conv(pow(2,int(Technologies.has("BTechEffici1")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici2")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici3")))))
			
			 , unib)
			
			 , divshort
			)
		"etech":
			return _div(_mult(_mult(_mult(_mult(_mult(_mult(_mult(
			_mult(_mult(_conv(Buildings.ETechLab.amnt * 1), _add(_conv(min(1,Buildings.ETechLab.power)),_mult(_conv(max(1,Buildings.ETechLab.power) - 1),elecboost))), _conv(pow(1.10,Upgrades.ETechLabB.amnt)))
			 , _conv(pow(1.10,Upgrades.TechB.amnt)))
			 , BTechBoost())
			 , GlobalBoost())
			 , _conv(pow(2,int(Technologies.has("BTechEffici1")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici2")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici3")))))
			
			 , unib)
			
			 , divshort
			)
		"ctech":
			return _div(_mult(_mult(_mult(_mult(_mult(_mult(_mult(
			_mult(_mult(_conv(Buildings.CTechLab.amnt * 1), _add(_conv(min(1,Buildings.CTechLab.power)),_mult(_conv(max(1,Buildings.CTechLab.power) - 1),elecboost))), _conv(pow(1.10,Upgrades.CTechLabB.amnt)))
			 , _conv(pow(1.10,Upgrades.TechB.amnt)))
			 , BTechBoost())
			 , GlobalBoost())
			 , _conv(pow(2,int(Technologies.has("BTechEffici1")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici2")))))
			 , _conv(pow(2,int(Technologies.has("BTechEffici3")))))
			
			 , unib)
			
			 , divshort
			)
		"pop":
			return _mult(
			_mult(_mult(_conv(Buildings.Farm.amnt * 1), _add(_conv(min(1,Buildings.Farm.power)),_mult(_conv(max(1,Buildings.Farm.power) - 1),elecboost))),_div(_find_total_production("popmax"),_add(pop,[1,0])))
			 , BTechBoost())
		"popmax":
			return _mult(_conv(Buildings.House.amnt * 10), _add(_conv(min(1,Buildings.House.power)),_mult(_conv(max(1,Buildings.House.power) - 1),elecboost)))
		"leisure":
			return _add(_mult(
			_mult(_conv(_log_base(Buildings.Leisure.amnt + 1,2)), _add(_conv(min(1,Buildings.Leisure.power)),_mult(_conv(max(1,Buildings.Leisure.power) - 1),elecboost)))
			 , BTechBoost())
			 , [1,0]
			)
		"fuel":
			return _div(_mult(_mult(
			_mult(_conv(Buildings.FuelRef.amnt * 10), _add(_conv(min(1,Buildings.FuelRef.power)),_mult(_conv(max(1,Buildings.FuelRef.power) - 1),elecboost)))
			 , BTechBoost())
			 , GlobalBoost())
			
			 , divshort
			)
		"elec":
			return _div(_mult(_mult(
			_mult(_conv(Buildings.PowerPlnt.amnt * 20), _add(_conv(min(1,Buildings.PowerPlnt.power)),_mult(_conv(max(1,Buildings.PowerPlnt.power) - 1),elecboost)))
			 , BTechBoost())
			 , GlobalBoost())
			
			 , divshort
			)
		"factb":
			return _add(_div(_mult(
			_mult(_conv(_log_base(Buildings.FactB.amnt + 1,2)), _add(_conv(min(1,Buildings.FactB.power)),_mult(_conv(max(1,Buildings.FactB.power) - 1),elecboost)))
			 , BTechBoost())
			
			 , divshort
			)
			 , [1,0]
			)
		"factcons":
			return _mult(
			_mult(_conv(Buildings.FactB.amnt * 100), _add(_conv(min(1,Buildings.FactB.power)),_mult(_conv(max(1,Buildings.FactB.power) - 1),elecboost)))
			 , BTechBoost())
		"unib":
			return _add(_div(_mult(
			_mult(_conv(_log_base(Buildings.University.amnt + 1,2)), _add(_conv(min(1,Buildings.University.power)),_mult(_conv(max(1,Buildings.University.power) - 1),elecboost)))
			 , BTechBoost())
			
			 , divshort
			)
			 , [1,0]
			)
		"unicons":
			return _mult(
			_mult(_conv(Buildings.University.amnt * 100), _add(_conv(min(1,Buildings.University.power)),_mult(_conv(max(1,Buildings.University.power) - 1),elecboost)))
			 , BTechBoost())

func _process(delta):
	if _comp([1,0],_mult(_mult(mats,mats), [1,-18])):
		divshort = [1,0]
	else:
		divshort = _mult(_mult(mats,mats), [1,-18])
	
	leisure = _find_total_production("leisure")
	popmax = _find_total_production("popmax")
	popprod = _find_total_production("pop")
	pop = _add(pop, _mult(popprod, _conv(delta)))
	if _comp(pop,popmax):
		pop = popmax
	
	matprod = _find_total_production("mats")
	rmatprod = _find_total_production("rmats")
	btechprod = _find_total_production("btech")
	ptechprod = _find_total_production("ptech")
	etechprod = _find_total_production("etech")
	ctechprod = _find_total_production("ctech")
	fuelprod = _find_total_production("fuel")
	var factcons = _find_total_production("factcons")
	var unicons = _find_total_production("unicons")
	factprod = _find_total_production("factb")
	uniprod = _find_total_production("unib")
	elecprod = _find_total_production("elec")
	
	matcons = _add(_add(_mult(rmatprod,[1,1]),_mult(fuelprod,[1,1])),factcons)
	rmatcons = _add(_mult(btechprod,[1,1]),unicons)
	btechcons = _add(_add(_mult(ptechprod,[1,1]),_mult(etechprod,[1,1])),_mult(ctechprod,[1,1]))
	fuelcons = elec
	
	matsatis = _min([1,0],_div(_add(mats,matprod),matcons))
	rmatsatis = _min([1,0],_div(_add(rmats,_mult(rmatprod,matsatis)),rmatcons))
	btechsatis = _min([1,0],_div(_add(btech,_mult(btechprod,rmatsatis)),btechcons))
	fuelsatis = _min([1,0],_div(_add(fuel,_mult(fuelprod,matsatis)),fuelcons))
	
	rmatprod = _mult(rmatprod,matsatis)
	btechprod = _mult(btechprod,rmatsatis)
	ptechprod = _mult(ptechprod,btechsatis)
	etechprod = _mult(etechprod,btechsatis)
	ctechprod = _mult(ctechprod,btechsatis)
	fuelprod = _mult(fuelprod,matsatis)
	elecprod = _mult(elecprod,fuelsatis)
	factprod = _mult(factprod,matsatis)
	uniprod = _mult(uniprod,rmatsatis)
	
	matcons = _mult(matcons,matsatis)
	rmatcons = _mult(rmatcons,rmatsatis)
	btechcons = _mult(btechcons,btechsatis)
	fuelcons = _mult(fuelcons,matsatis)
	
	mats = _add(mats,_mult(_sub(matprod,matcons),_conv(delta)))
	rmats = _add(rmats,_mult(_sub(rmatprod,rmatcons),_conv(delta)))
	btech = _add(btech,_mult(_sub(btechprod,btechcons),_conv(delta)))
	ptech = _add(ptech,_mult(ptechprod,_conv(delta)))
	etech = _add(etech,_mult(etechprod,_conv(delta)))
	ctech = _add(ctech,_mult(ctechprod,_conv(delta)))
	fuel = _add(fuel,_mult(_sub(fuelprod,fuelcons),_conv(delta)))
	elec = elecprod
	factb = factprod
	unib = uniprod
	
	#Old Code
	
	#leisure = _find_total_production("leisure")
	#eleccons = _electricity_cons("all")
	#elecboost = _min([1,0],_div(elec,eleccons))
	#if elecboost == [0,0]:
		#elecboost = [1,0]
	#popprod = _find_total_production("pop")
	#pop = _add(pop, _mult(popprod, _conv(delta)))
	#popmax = _find_total_production("popmax")
	#if _comp(pop,popmax):
		#pop = popmax
	#matprod = _find_total_production("mats")
	#mats = _add(mats, _mult(matprod, _conv(delta)))
	#rmatprod = _mult(_find_total_production("rmats"), [1,1])
	#matprod = _sub(matprod,rmatprod)
	#var matcons = _mult(rmatprod, _conv(delta))
	#if _comp(mats,matcons):
		#rmats = _add(rmats, _div(matcons, [1,1]))
		#mats = _sub(mats, matcons)
	#rmatprod = _div(rmatprod,[1,1])
	#var factprod = _find_total_production("factcons")
	#matcons = _mult(factprod, _conv(delta))
	#matprod = _sub(matprod,factprod)
	#if _comp(mats,matcons):
		#factb = _find_total_production("factb")
		#mats = _sub(mats, matcons)
	#else:
		#factb = _div(factb,[1.1,0])
	#fuelprod = _mult(_find_total_production("fuel"), [1,1])
	#matcons = _mult(fuelprod, _conv(delta))
	#matprod = _sub(matprod,fuelprod)
	#if _comp(mats,matcons):
		#fuel = _add(fuel, _div(matcons, [1,1]))
		#mats = _sub(mats,matcons)
	#fuelprod = _div(fuelprod,[1,1])
	#var elecprod = _find_total_production("elec")
	#var fuelcons = _mult(elecprod, _conv(delta))
	#fuelprod = _sub(fuelprod,elecprod)
	#if _comp(fuel,fuelcons):
		#elec = elecprod
		#fuel = _sub(fuel,fuelcons)
	#else:
		#elec = _div(elec,[1.1,0])
	#btechprod = _mult(_find_total_production("btech"), [1,1])
	#var rmatcons = _mult(btechprod, _conv(delta))
	#rmatprod = _sub(rmatprod,btechprod)
	#if _comp(rmats,rmatcons):
		#btech = _add(btech, _div(rmatcons, [1,1]))
		#rmats = _sub(rmats, rmatcons)
	#btechprod = _div(btechprod,[1,1])
	#var uniprod = _find_total_production("unicons")
	#rmatcons = _mult(uniprod, _conv(delta))
	#rmatprod = _sub(rmatprod,uniprod)
	#if _comp(rmats,matcons):
		#unib = _find_total_production("unib")
		#rmats = _sub(rmats, rmatcons)
	#else:
		#unib = _div(unib,[1.1,0])
	#ptechprod = _mult(_find_total_production("ptech"), [1,1])
	#var btechcons = _mult(ptechprod, _conv(delta))
	#btechprod = _sub(btechprod,ptechprod)
	#if _comp(btech,btechcons):
		#ptech = _add(ptech, _div(btechcons, [1,1]))
		#btech = _sub(btech, btechcons)
	#ptechprod = _div(ptechprod,[1,1])
	#etechprod = _mult(_find_total_production("etech"), [1,1])
	#btechcons = _mult(etechprod, _conv(delta))
	#btechprod = _sub(btechprod,etechprod)
	#if _comp(btech,btechcons):
		#etech = _add(etech, _div(btechcons, [1,1]))
		#btech = _sub(btech, btechcons)
	#etechprod = _div(etechprod,[1,1])
	#ctechprod = _mult(_find_total_production("ctech"), [1,1])
	#btechcons = _mult(ctechprod, _conv(delta))
	#btechprod = _sub(btechprod,ctechprod)
	#if _comp(btech,btechcons):
		#ctech = _add(ctech, _div(btechcons, [1,1]))
		#btech = _sub(btech, btechcons)
	#ctechprod = _div(ctechprod,[1,1])
	
	_update()
	_view_update()
	
	$FPS.text = String(Engine.get_frames_per_second())

func _view_update():
	var update = []
	
	if view.RMatRef == false && _comp(mats, [1,3]):
		view.RMatRef = true
		update.append("RMatRef")
	else: if view.BTechLab == false && _comp(mats, [1,4]):
		view.BTechLab = true
		update.append("BTechLab")
	else: if view.PTechLab == false && Technologies.has("BPTechUnlock"):
		view.PTechLab = true
		update.append("PTechLab")
	else: if view.ETechLab == false && Technologies.has("BETechUnlock"):
		view.ETechLab = true
		update.append("ETechLab")
	else: if view.CTechLab == false && Technologies.has("BCTechUnlock"):
		view.CTechLab = true
		update.append("CTechLab")
	else: if view.elec == false && Technologies.has("PElecUnlock"):
		view.elec = true
		view.fuel = true
		view.PowerPlnt = true
		view.FuelRef = true
		update.append("PowerPlnt")
		update.append("FuelRef")
	else: if view.rmats == false && _comp(rmats,[1,0]):
		view.rmats = true
		update.append("rmats")
	else: if view.btech == false && _comp(btech,[1,0]):
		view.btech = true
		view.BTechLabB = true
		view.TechB = true
		view.TechTrees = true
		update.append("btech")
		update.append("BTechLabB")
		update.append("TechB")
		update.append("TechTrees")
	else: if view.ptech == false && _comp(ptech,[1,0]):
		view.ptech = true
		view.PhysicsTechs = true
		view.PTechLabB = true
		update.append("ptech")
		update.append("PhysicsTechs")
		update.append("PTechLabB")
	else: if view.etech == false && _comp(etech,[1,0]):
		view.etech = true
		view.EngineeringTechs = true
		view.ETechLabB = true
		update.append("etech")
		update.append("EngineeringTechs")
		update.append("ETechLabB")
	else: if view.ctech == false && _comp(ctech,[1,0]):
		view.ctech = true
		view.ComputingTechs = true
		view.CTechLabB = true
		update.append("ctech")
		update.append("ComputingTechs")
		update.append("CTechLabB")
	else: if view.Upgrades == false && _comp(rmats,[1,3]):
		view.Upgrades = true
		update.append("Upgrades")
	else: if view.Advanced == false && Technologies.has("BAdvUnlock"):
		view.Advanced = true
		update.append("Advanced")
	else: if view.City == false && Technologies.has("BCityUnlock"):
		view.City = true
		view.pop = true
		update.append("City")
		update.append("pop")
	else: if view.AdvancedUpgrades == false && Technologies.has("BAdvUpUnlock"):
		view.AdvancedUpgrades = true
		update.append("AdvancedUpgrades")
	else: if view.Conquest == false && Technologies.has("BConqUnlock"):
		view.Conquest = true
		update.append("Conquest")
	else: if view.CostB == false && _comp(rmats,[1,4]):
		view.CostB = true
		update.append("CostB")
	else: if view.Underclock == false && Technologies.has("BUnderclock"):
		view.Underclock = true
		update.append("Underclock")
	
	emit_signal("viewupdate",update)

func _save():
	var save_game = File.new()
	save_game.open("user://savegame.txt", File.WRITE)
	var save_info:Dictionary = {
		"mats": mats,
		"rmats": rmats,
		"btech": btech,
		"ptech": ptech,
		"etech": etech,
		"ctech": ctech,
		"factb": factb,
		"pop": pop,
		"fuel": fuel,
		"elec": elec,
		"eleccons": eleccons,
		"unib": unib,
		"leisure": leisure,
		"view": view,
		"toggles": toggles,
		"Buildings": Buildings,
		"Upgrades": Upgrades,
		"Technologies": Technologies,
		"autosave": autosave,
	}
	save_game.store_var(save_info)
	save_game.close()

func _load():
	var save_game = File.new()
	if save_game.file_exists("user://savegame.txt"):
		save_game.open("user://savegame.txt", File.READ)
		var save_info = save_game.get_var()
		save_game.close()
		for key in save_info:
			if key in self:
				self[key] = save_info[key]
	var update = []
	for key in view:
		if view[key] == true:
			update.append(key)
	emit_signal("viewupdate",update)

func _on_Save_pressed():
	_save()

func _shorten(num):
	if num == 0:
		return "0"
	if num < 1000000:
		return String(round(num))
	var e = floor(_log10(abs(num)))
	var n = num * pow(10, -e)
	var n2 = stepify(n,0.01)
	if n2 == 10:
		n2 = 1
		e += 1
	return "%se%s" %  [n2, e]

func _short_big(n:Array):
	if(n[0] == 0):
		return "0"
	if(n[1] < 6):
		return String(round(n[0] * pow(10,n[1])))
	var n2 = stepify(n[0],0.01)
	if(n[1] > 1000000):
		return "%se%s" % [n2, _shorten(n[1])]
	return "%se%s" % [n2, n[1]]

func _log10(n):
	return log(n) / log(10)

func _cost_growth(i, b, n):
	return max(0,pow(i,b) * (1 - pow(i,(n - b))) / (1 - i))

func _add(a1:Array, a2:Array):
	var a3 = [0,0]
	if(abs(a1[1] - a2[1]) < 9):
		a3[0] = a1[0] + a2[0] / pow(10,(a1[1] - a2[1]))
		a3[1] = a1[1]
	else:
		if(a1[1] >= a2[1]):
			a3[0] = a1[0]
			a3[1] = a1[1]
		else:
			a3[0] = a2[0]
			a3[1] = a2[1]
	var i = _log10(abs(a3[0]))
	if(i >= 1):
		a3[0] = a3[0] / pow(10,floor(i))
		a3[1] = round(a3[1] + floor(i))
	if(i < 0):
		a3[0] = a3[0] * pow(10,-floor(i))
		a3[1] = round(a3[1] + floor(i))
	return a3

func _sub(a1:Array, a2:Array):
	var a3 = [0,0]
	if(abs(a1[1] - a2[1]) < 9):
		a3[0] = a1[0] - a2[0] / pow(10,(a1[1] - a2[1]))
		a3[1] = a1[1]
	else:
		if(a1[1] >= a2[1]):
			a3[0] = a1[0]
			a3[1] = a1[1]
		else:
			a3[0] = a2[0]
			a3[1] = a2[1]
	var i = _log10(abs(a3[0]))
	if(i == -INF):
		return [0,0]
	if(i >= 1):
		a3[0] = a3[0] / pow(10,floor(i))
		a3[1] = round(a3[1] + floor(i))
	if(i < 0):
		a3[0] = a3[0] * pow(10,-floor(i))
		a3[1] = round(a3[1] + floor(i))
	return a3

func _mult(a1:Array, a2:Array):
	var a3 = [0,0]
	if(a1[0] == 0):
		return a3
	a3[0] = a1[0] * a2[0]
	a3[1] = a1[1] + a2[1]
	var i = _log10(abs(a3[0]))
	if(i >= 1):
		a3[0] = a3[0] / pow(10,floor(i))
		a3[1] = round(a3[1] + floor(i))
	if(i < 0):
		a3[0] = a3[0] * pow(10,-floor(i))
		a3[1] = round(a3[1] + floor(i))
	return a3

func _div(a1:Array, a2:Array):
	var a3 = [0,0]
	if(a2[0] == 0):
		if(a1[0] == 0):
			return [1,0]
		else:
			return [0,0]
	else:
		a3[0] = float(a1[0]) / float(a2[0])
	a3[1] = float(a1[1]) - float(a2[1])
	var i = _log10(abs(a3[0]))
	if(i == -INF):
		return [0,0]
	if(i >= 1):
		a3[0] = a3[0] / pow(10,floor(i))
		a3[1] = round(a3[1] + floor(i))
	if(i < 0):
		a3[0] = a3[0] * pow(10,-floor(i))
		a3[1] = round(a3[1] + floor(i))
	return a3

func _conv(n):
	var a = [0,0]
	var i = _log10(abs(n))
	if(i == -INF):
		return [0,0]
	else: if(i == INF):
		return [1.79,308]
	else: if(i == NAN):
		return [0,0]
	a[0] = n / pow(10,floor(i))
	a[1] = floor(i)
	return a

func _comp(a1:Array, a2:Array):
	if(a1[1] > a2[1]):
		return true
	else: if(a1[1] == a2[1]):
		if(a1[0] >= a2[0]):
			return true
		else:
			return false
	else:
		return false

func _min(a1:Array,a2:Array):
	if(_comp(a1,a2)):
		return a2
	else:
		return a1

func _on_AutoSave_timeout():
	if autosave == true:
		_save()

func _big_log(n:Array):
	var i = 0
	i = _log10(abs(n[0])) + n[1]
	return i

func _log_base(n,b):
	return log(n) / log(b)

func BTechBoost():
	return _mult(_mult(_mult(_mult(
		  _conv(pow(1.20,int(Technologies.has("BEffici1"))))
		, _conv(pow(1.20,int(Technologies.has("BEffici2")))))
		, _conv(pow(1.20,int(Technologies.has("BEffici3")))))
		, _conv(pow(1.20,int(Technologies.has("BEffici4")))))
		, _conv(pow(1.20,int(Technologies.has("BEffici5")))))

func GlobalBoost():
	return _add(_mult(_conv(_big_log(_add(pop,[1,0]))),leisure),[1,0])

func _electricity_cons(b):
	match b:
		"all":
			var sum = [0,0]
			for b in Buildings:
				sum = _add(sum,_mult(_mult(_conv(Buildings[b].amnt),_conv(max(0,Buildings[b].power - 1))),_conv(Buildings[b].powercons)))
			return sum
		_:
			return _mult(_mult(_conv(Buildings[b].amnt),_conv(max(0,Buildings[b].power - 1))),_conv(Buildings[b].powercons))
	
