extends Node2D

#signals
signal timer(time)

#variables for timer
var time_passed : float = 0.0

func _process(delta):
	time_passed += delta
	timer.emit(time_passed)
