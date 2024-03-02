extends Control

var Rolling_Length = 0

var Length = 0

onready var Main = get_parent()



func _input(event):
	
	
	if $User/Name.text == "<旁白>":
		$User.visible = false
		$Narration.visible = true
		$Narration/Text.text = $User/Text.text
		Length = $Narration/Text.rect_size.y + 20
	else:
		Length = $User/Text.rect_position.y + $User/Text.rect_size.y + 30
	
	if $User/Text.rect_size.x > 928:
		$User/Text.rect_size.x = 928
		$User/Text.autowrap = true
	
	rect_position.y = Rolling_Length + Main.Rolling_Length
	

