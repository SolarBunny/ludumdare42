extends Area2D

func _process(delta):
	for area in get_overlapping_areas():
		if area.is_in_group("Player"):
			get_tree().change_scene("res://Scenes/Other/Win/Win.tscn")