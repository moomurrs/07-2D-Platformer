extends Node2D


func _ready():
	#  auto focus on the start button first
	$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()
	
func _physics_process(delta):
	#if $MarginContainer/VBoxContainer/VBoxContainer/Start.is_hovered():
		#$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()
	pass

# start the game at stage one
func _on_Start_pressed():
	get_tree().change_scene("res://StageOne.tscn")

# quit the game
func _on_Exit_pressed():
	get_tree().quit()
