extends Resource

class_name Mixture


var _name: String
var _effect: String
var _durationSeconds: float
var _potencyLevel: int


func _init(name, effect, durationSeconds, potencyLevel):
    _name = name
    _effect = effect
    _durationSeconds = durationSeconds
    _potencyLevel = potencyLevel
