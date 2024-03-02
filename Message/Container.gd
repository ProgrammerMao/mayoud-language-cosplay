extends Control

var text

var Rolling_Length = 0
var ROLLING_SPEED = 30

onready var content = $Container/VBox


var user_list = []

var maode_user = [
			["浮生","res://Photo/FuSheng.jpeg"],
			["玄钦","res://Photo/XuanQin.png"],
			["白宇","res://Photo/BaiYu.png"],
			["修凯","res://Photo/XiuKai.png"],
			["焰洛靖湫","res://Photo/YanLuo.jpeg"],
			["辰昇竛泈","res://Photo/ChenSheng.jpeg"],
			["流云","res://Photo/LiuYun.jpeg"],
			["将和","res://Photo/JiangHe.jpeg"],
			["沨","res://Photo/Feng.jpeg"],
]



func _ready():
	get_tree().connect("files_dropped", self, "_load")
#	_load(["res://Chapter/test.txt"], "test")

func _load(path, attribute):
	if attribute is String:
		if attribute == "maode":
			user_list += maode_user
	
	visible = true
	get_parent().get_node("Map").visible = false
	
	var child = get_children()
	for i in child:
		i.free()
	Rolling_Length = 0
	
	var file = File.new()
	file.open(path[0], File.READ)
	text = file.get_as_text()
	text = text.split("\n", false)
	file.close()
	
	_separate()
	
	

func _changed_length():
	var length = 0
	var child = get_children()
	for i in child:
		i.Rolling_Length = length
		length += i.Length

func _input(event):
	if Input.is_action_pressed("up"):
		Rolling_Length += ROLLING_SPEED
	elif Input.is_action_pressed("down"):
		Rolling_Length -= ROLLING_SPEED
	
	if Rolling_Length > 0:
		Rolling_Length = 0

func _process(delta):
	_changed_length()

onready var Message

onready var container = $Container

func _separate():
	var set = false
	var is_user = true
	var new_user = []
	for i in text:
		if i == "#set":
			set = true
		elif i == "#end":
			user_list += new_user
			set = false
		elif set:
			if is_user:
				is_user = false
				new_user.push_back([i])
			else:
				is_user = true
				var user_num = new_user.size() - 1
				new_user[user_num].push_back(i)
		elif i == "<旁白>":
			_create_message(i,"")
		else:
			var not_user = true
			for j in user_list:
				if i == j[0]:
					not_user = false
					_create_message(j[0], j[1])
			if not_user:
				_load_message(i)
	user_list.clear()

func _create_message(user_name, user_photo):
	
	Message = load("res://Message/Message.tscn").instance()
	add_child(Message)
	Message.get_node("User/Name").text = user_name
	Message.get_node("User/Head").texture = load(user_photo)
	
	Message._input(0.0)

func _load_message(user_message):
	if Message:
		Message.get_node("User/Text").text += "\n" + user_message
	


