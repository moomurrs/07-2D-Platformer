extends Area2D

# specify the target scene
export (String, FILE, "*.tscn") var target_stage

func _ready():
	pass

# only trigger scene change when player enters area2d
func _on_ChangeStage_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene(target_stage)
