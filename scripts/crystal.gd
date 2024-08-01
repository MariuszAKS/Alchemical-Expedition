extends Resource

class_name Crystal


enum CrystalType {BASE_GROUND, BASE_AIR, BASE_FIRE, BASE_FLUID, BOAR}


var name:String
var type:CrystalType

@export var texture:CompressedTexture2D


func _init(_name:String, _type:CrystalType):
	name = _name
	type = _type
