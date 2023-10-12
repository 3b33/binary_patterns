extends Node2D

var start = Time.get_ticks_msec()

func _draw():
	var b = find_child("Text_binary").text
	var div = int(find_child("Text_patterns").text)
	var b_add = 0
	for piy in range(div):
		for pix in range(div):
			var dispSize = DisplayServer.window_get_size()
			#var s = $Text_point_size.text as int
			var s = int(find_child("Text_pointsize").text)
			var o = find_child("menu_end").position.y # y offset for menu
			b_add += 1
			if pix + piy > 0:
				b = to_bin(find_child("Text_number").text as int + b_add)
			var p1 = find_child("Text_param1").text as int
			var p2 = find_child("Text_param2").text as int
			#for x in range(len($Text_binary.text)):
			var pattern_width = dispSize[0]/div
			for x in range(ceil(pattern_width/s)):
				var c = b[x % len(b)] as int
				for y in range(dispSize[1]/s/div):
					var di = b[(x+p2*y) % len(b)] as int	# increasing diagonals
					var dd = b[(x+p1*y) % len(b)] as int	# decreasing diagonals
		#			if find_child("CheckBox_4").button_pressed:
		#				if di == 1 and dd == 1:
		#					draw_rect(Rect2(x*s,y*s+o,x*s+s,y*s+s+o), Color(1,1,.5))
		#				elif di == 0 and dd == 0:
		#					draw_rect(Rect2(x*s,y*s+o,x*s+s,y*s+s+o), Color(1,.9,.5))
		#				elif di == 1 and dd == 0:
		#					draw_rect(Rect2(x*s,y*s+o,x*s+s,y*s+s+o), Color(.1,.3,.3))	# dark cyan
		#				elif di == 0 and dd == 1:
		#					draw_rect(Rect2(x*s,y*s+o,x*s+s,y*s+s+o), Color(.2,.2,.5))	# dark blue
					var rect = Rect2(x*s+pix*pattern_width,y*s+o+piy*pattern_width,x*s+s+pix*pattern_width,y*s+s+o+piy*pattern_width)
					if find_child("CheckBox_1").button_pressed:
						if di == dd:
							draw_rect(rect, Color.WHITE)
						else:
							draw_rect(rect, Color.BLACK)
					if find_child("CheckBox_2").button_pressed:
						if di == dd:
							draw_rect(rect, Color.BLACK)
						else:
							draw_rect(rect, Color.WHITE)
					elif find_child("CheckBox_3").button_pressed:
						if di == 1 and dd == 1:
							draw_rect(rect, Color.WHITE)
						elif di == 1 and dd == 0:
							draw_rect(rect, Color.DIM_GRAY)
						elif di == 0 and dd == 0:
							draw_rect(rect, Color.LIGHT_GRAY)
						else:
							draw_rect(rect, Color.BLACK)
					elif find_child("CheckBox_4").button_pressed:
						if di == 1 and dd == 1:
							draw_rect(rect, Color.BLACK)
						elif di == 1 and dd == 0:
							draw_rect(rect, Color.LIGHT_GRAY)
						elif di == 0 and dd == 0:
							draw_rect(rect, Color.DIM_GRAY)
						else:
							draw_rect(rect, Color.WHITE)

func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += str(i)
	return s

func to_bin(x):
	if x == 0: return [0]
	var bit = []
	while x:
		bit.append(x % 2)
		x >>= 1
	bit.reverse()
	return array_to_string(bit)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(DisplayServer.window_get_size())
	#Engine.time_scale = .0001

var lapsed = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if find_child("Button_play").button_pressed:
		if ((Time.get_ticks_msec() - start) / 800) as int > lapsed:
			lapsed = ((Time.get_ticks_msec() - start) / 800) as int
			#print(lapsed)
			#find_child("Text_number").text = str(find_child("Text_number").text as int + 1)
			#if find_child("Text_number").text == "999999999999999999":
			#	find_child("Text_number").text = "0"
			#_on_number_changed()
			_on_button_rnd()


func _on_number_changed():
	if find_child("Text_number").text.is_valid_int() and find_child("Text_number").text != "0":
		find_child("Text_binary").text = to_bin(find_child("Text_number").text as int)
		queue_redraw()
		print(find_child("Text_number").text)

func _on_binary_changed():
	if find_child("Text_binary").text.is_valid_int():
		queue_redraw()


func _on_button_rnd():
	find_child("Text_number").text = str(randi_range(999,9999999999))
	_on_number_changed()


func _redraw():
	queue_redraw()
	
func _on_param_changed():
	if find_child("Text_param1").text.is_valid_int() and find_child("Text_param2").text.is_valid_int():
		queue_redraw()
	else:
		find_child("Text_param1").text = "-1"
		find_child("Text_param2").text = "1"


