extends Node

func _ready() -> void:
	print(NTP.now())
	get_tree().quit()