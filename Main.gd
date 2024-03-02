extends Control

onready var map = $Map
onready var container = $Container


var Maode = [
				["1243年11月3日", "res://Content/Maode/1243.11.3.0/Leave.txt" ],
				["1243年11月15日", "res://Content/Maode/1243.11.15.0/Snows.txt" ],
				["1243年12月4日", "res://Content/Maode/1243.12.4.0/Autumn.txt" ],
				["1243年12月5日 上午", "res://Content/Maode/1243.12.5.0/BreezeForest.txt", "res://Content/Maode/1243.12.5.0/Ullr.txt" ],
				["1243年12月5日 下午", "res://Content/Maode/1243.12.5.1/SnowVolt.txt" ],
				["1243年12月6日", "res://Content/Maode/1243.12.6.0/Map.txt", "res://Content/Maode/1243.12.6.0/Merchant.txt", "res://Content/Maode/1243.12.6.0/Norta.txt" ],
				["1243年12月7日 上午", "res://Content/Maode/1243.12.7.0/Meet.txt" ],
				["1243年12月7日 中午", "res://Content/Maode/1243.12.7.1/Fight.txt", "res://Content/Maode/1243.12.7.1/Forest.txt" ],
				["1243年12月7日 夜晚", "res://Content/Maode/1243.12.7.2/Rest.txt", "res://Content/Maode/1243.12.7.2/Meet.txt" ],
				["1243年12月8日 早晨", "res://Content/Maode/1243.12.8.0/Forest.txt" ], 
				["1243年12月8日 中午&下午", "res://Content/Maode/1243.12.8.1/Running.txt", "res://Content/Maode/1243.12.8.1/Forward.txt" ],
				["1243年12月8日 夜晚", "res://Content/Maode/1243.12.8.2/Back.txt", "res://Content/Maode/1243.12.8.2/Village.txt" ],
#				["1243年12月9日 夜晚", "三小时独行", "res://Content/Maode/1243.12.7.2/Rest.txt"]],
				]

func _ready():
	bar.get_node("Map").pressed = true
	container.visible = false
	map.visible = true
	map.change_visible()

func _on_1_pressed():
	_load(1)


func _on_2_pressed():
	_load(2)


func _on_3_pressed():
	_load(3)

func _load(content):
	if content is int:
		container._load([Maode[map.chapter][content]], "maode")
	else:
		container._load([content], null)
	bar.get_node("Container").pressed = true


onready var bar = $Bar

func _process(delta):
	for i in bar.get_children():
		if i.name != "Color":
			var node = get_node(i.name)
			if i.pressed:
				node.visible = true
				node.modulate.a += (1 - node.modulate.a) * delta * map.speed
			elif node.modulate.a > 0.1 and node.visible:
				node.modulate.a += (0 - node.modulate.a) * delta * map.speed
			else:
				node.visible = false


