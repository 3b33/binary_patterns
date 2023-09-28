extends Node2D

func _draw():
	var s = $Text_point_size.text as int
	var o = 100 # offset
	var b = $Text_binary.text
	#for x in range(len($Text_binary.text)):
	for x in range($Text_width.text as int):
		var c = b[x % len(b)] as int
		for y in range(DisplayServer.window_get_size()[1]/s):
			var di = b[(x+y) % len(b)] as int # increasing diagonals
			var dd = b[(x-y) % len(b)] as int	# decreasing diagonals
			if di == dd:
				draw_rect(Rect2(x*s,y*s+o,x*s+s,y*s+s+o), Color.WHITE)
			else:
				draw_rect(Rect2(x*s,y*s+o,x*s+s,y*s+s+o), Color.BLACK)

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
	pass
	#_draw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_number_changed():
	if $Text_number.text.is_valid_int() and $Text_number.text != "0":
		$Text_binary.text = to_bin($Text_number.text as int)
		queue_redraw()
		print($Text_number.text)

func _on_binary_changed():
	if $Text_binary.text.is_valid_int():
		queue_redraw()
