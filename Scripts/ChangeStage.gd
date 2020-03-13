extends Area2D

# specify the target scene
export (String, FILE, "*.tscn") var target_stage


func _ready():
	pass

# only trigger scene change when player enters area2d
func _on_ChangeStage_body_entered(body):
	if "Player" in body.name:
		if get_parent().name == "StageOne":
			$"/root/GlobalVar".stageOne = true
			$"/root/GlobalVar".stageTwo = false
			
		else:
			$"/root/GlobalVar".stageOne = true
			$"/root/GlobalVar".stageTwo = true
		get_tree().change_scene(target_stage)
