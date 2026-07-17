extends Node2D

const GRID_W := 14
const GRID_D := 14

var _grid: WorldGrid
var _hud_label: Label


func _ready() -> void:
	_build_background()
	_build_camera()
	_build_grid()
	_build_hud()


func _build_background() -> void:
	var layer := CanvasLayer.new()
	layer.layer = -100
	add_child(layer)

	var bg := TextureRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	var gt := GradientTexture2D.new()
	var grad := Gradient.new()
	grad.add_point(0.0, Palette.BG_TOP)
	grad.add_point(1.0, Palette.BG_HORIZON)
	gt.gradient = grad
	gt.fill = 1
	gt.fill_from = Vector2(0.0, 0.0)
	gt.fill_to = Vector2(0.0, 1.0)
	bg.texture = gt
	bg.expand_mode = 1
	bg.stretch_mode = 0
	layer.add_child(bg)


func _build_camera() -> void:
	var cam := Camera2D.new()
	cam.position = Vector2(0.0, 12.0)
	cam.zoom = Vector2(1.2, 1.2)
	add_child(cam)
	cam.make_current()


func _build_grid() -> void:
	_grid = WorldGrid.new()
	_grid.width = GRID_W
	_grid.depth = GRID_D
	_grid.tile_selected.connect(_on_tile_selected)
	_grid.tile_deselected.connect(_on_tile_deselected)
	add_child(_grid)


func _build_hud() -> void:
	var canvas := CanvasLayer.new()
	add_child(canvas)

	_hud_label = Label.new()
	_hud_label.text = "点击地块以选中 · 右键取消"
	_hud_label.add_theme_font_size_override("font_size", 20)
	_hud_label.add_theme_color_override("font_color", Palette.INK)
	_hud_label.position = Vector2(28.0, 24.0)
	canvas.add_child(_hud_label)

	var title := Label.new()
	title.text = "Cap"
	title.add_theme_font_size_override("font_size", 40)
	title.add_theme_color_override("font_color", Palette.INK)
	title.position = Vector2(28.0, 52.0)
	canvas.add_child(title)


func _on_tile_selected(tile: Tile) -> void:
	_hud_label.text = "已选地块 (%d, %d) · 占用: %s" % [tile.gx, tile.gy, "是" if tile.occupied else "否"]


func _on_tile_deselected() -> void:
	_hud_label.text = "点击地块以选中 · 右键取消"


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		_grid.clear_selection()
