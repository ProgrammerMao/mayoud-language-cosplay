extends Control

var chapter = 0

var speed = 15

onready var Text = $Text

onready var Map = $Map
onready var Main = $Main
onready var User = $User

onready var Parent = get_parent()

var move_time = 0.0

var user = [
			"XuanQin",
			"XiuKai",
			"BaiYu",
			"YanLuo",
			"ChenSheng",
			"Feng",
			"JiangHe",
			"LiuYun",
			"FuSheng",
			
]

func _process(delta):
	for j in user:
		User.get_node(j).visible = false
		
		for i in Main.get_child(chapter).get_children():
		
			if String(i.name) == j:
#				User.get_node(j).visible = true
				
				var user_node = User.get_node(j)
				
				var modulate_a = user_node.modulate.a
				
				var user_point = i.rect_position - Vector2(24, 64)
				
				user_node.visible = true
				
				if modulate_a == 0:
					user_node.rect_position = user_point
				else:
					user_node.rect_position += (user_point - user_node.rect_position) * delta * speed
				if modulate_a != 1:
					User.get_node(j).modulate.a += (1 - User.get_node(j).modulate.a) * delta * speed
	
	
	for i in User.get_children():
		if not i.visible and i.modulate.a != 0:
			i.visible = true
			i.modulate.a += (0 - i.modulate.a) * speed * delta
	
	for i in Main.get_children():
		if i == Main.get_child(chapter):
			i.visible = true
			i.modulate.a += (1 - i.modulate.a) * speed * delta
		elif i.modulate.a != 0:
			i.modulate.a += (0 - i.modulate.a) * speed * delta
		else:
			i.visible = false

func _on_Back_pressed():
	chapter -= 1
	if chapter < 0:
		chapter = 0
	
	change_visible()


func _on_Next_pressed():
	chapter += 1
	
	var chapter_max = Parent.Maode.size() - 1
	if chapter > chapter_max:
		chapter = chapter_max
	
	change_visible()

func change_visible():

	for i in Main.get_children():

		i.visible = false

	Main.get_child(chapter).visible = true

	Text.text = Parent.Maode[chapter][0]



