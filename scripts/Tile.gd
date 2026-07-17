class_name Tile
extends Area2D

signal tile_clicked(tile: Tile)

var gx: int = 0
var gy: int = 0
var occupied: bool = false

var _state: StringName = &"normal"

var lift: float = 0.0:
	set(v):
		lift = v
		queue_redraw()

var base_color: Color = Palette.TILE_NORMAL:
	set(v):
		base_color = v
		queue_redraw()


func _ready() -> void:
	add_to_group("tiles")
	z_index = gx + gy

	var col := CollisionPolygon2D.new()
	col.polygon = _diamond(-Palette.TILE_HEIGHT)
	add_child(col)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

	_update_visual(true)


func set_state(state: StringName) -> void:
	_state = state
	_update_visual(false)


func _on_mouse_entered() -> void:
	if _state != &"selected":
		_state = &"hover"
		_update_visual(false)


func _on_mouse_exited() -> void:
	if _state == &"hover":
		_state = &"normal"
		_update_visual(false)


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		tile_clicked.emit(self)


func _update_visual(instant: bool) -> void:
	var t_lift: float = 0.0
	var t_color: Color = Palette.TILE_NORMAL
	match _state:
		&"selected":
			t_lift = Palette.TILE_HEIGHT * 0.9
			t_color = Palette.TILE_SELECTED
		&"hover":
			t_lift = Palette.TILE_HEIGHT * 0.35
			t_color = Palette.TILE_HOVER
		_:
			t_lift = 0.0
			t_color = Palette.TILE_NORMAL
	if instant:
		lift = t_lift
		base_color = t_color
	else:
		var tw := create_tween().set_parallel(true)
		tw.tween_property(self, "lift", t_lift, 0.12).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		tw.tween_property(self, "base_color", t_color, 0.12)


func _diamond(y_offset: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	pts.append(Vector2(0.0, -Palette.TILE_H / 2.0 + y_offset))
	pts.append(Vector2(Palette.TILE_W / 2.0, y_offset))
	pts.append(Vector2(0.0, Palette.TILE_H / 2.0 + y_offset))
	pts.append(Vector2(-Palette.TILE_W / 2.0, y_offset))
	return pts


func _shade(factor: float) -> Color:
	return Color(base_color.r * factor, base_color.g * factor, base_color.b * factor, 1.0)


func _draw() -> void:
	var tw := Palette.TILE_W
	var th := Palette.TILE_H
	var h := Palette.TILE_HEIGHT
	var l := lift

	# 地面软阴影（不随抬起移动）
	var shadow_pts := PackedVector2Array()
	var segs := 22
	var rx := tw * 0.48
	var ry := th * 0.62
	var sc := Vector2(0.0, th * 0.18)
	for i in segs:
		var a := TAU * i / float(segs)
		shadow_pts.append(sc + Vector2(cos(a) * rx, sin(a) * ry))
	draw_colored_polygon(shadow_pts, Palette.SHADOW)

	# 底面菱形（随抬起上移）
	var bN := Vector2(0.0, -th / 2.0 - l)
	var bE := Vector2(tw / 2.0, -l)
	var bS := Vector2(0.0, th / 2.0 - l)
	var bW := Vector2(-tw / 2.0, -l)
	# 顶面菱形
	var tN := Vector2(0.0, -th / 2.0 - l - h)
	var tE := Vector2(tw / 2.0, -l - h)
	var tS := Vector2(0.0, th / 2.0 - l - h)
	var tW := Vector2(-tw / 2.0, -l - h)

	# 右侧面（E-S，较亮）
	draw_colored_polygon(PackedVector2Array([bE, bS, tS, tE]), _shade(0.80))
	# 左侧面（S-W，较暗）
	draw_colored_polygon(PackedVector2Array([bS, bW, tW, tS]), _shade(0.60))
	# 顶面
	draw_colored_polygon(PackedVector2Array([tN, tE, tS, tW]), base_color)
