class_name WorldGrid
extends Node2D

signal tile_selected(tile: Tile)
signal tile_deselected

@export var width: int = 14
@export var depth: int = 14

var _tiles: Dictionary = {}
var _selected: Tile = null


func _ready() -> void:
	_build()


func _build() -> void:
	var tw := Palette.TILE_W
	var th := Palette.TILE_H
	var off_y := -((width - 1) + (depth - 1)) * th * 0.25
	for x in width:
		for y in depth:
			var t := Tile.new()
			t.gx = x
			t.gy = y
			var sx := (x - y) * (tw / 2.0)
			var sy := (x + y) * (th / 2.0) + off_y
			t.position = Vector2(sx, sy)
			t.tile_clicked.connect(_on_tile_clicked)
			add_child(t)
			_tiles[Vector2i(x, y)] = t


func get_tile(x: int, y: int) -> Tile:
	return _tiles.get(Vector2i(x, y))


func get_all_tiles() -> Array:
	return _tiles.values()


func clear_selection() -> void:
	if _selected:
		_selected.set_state(&"normal")
		_selected = null
		tile_deselected.emit()


func _on_tile_clicked(tile: Tile) -> void:
	if _selected == tile:
		_selected.set_state(&"normal")
		_selected = null
		tile_deselected.emit()
		return
	if _selected:
		_selected.set_state(&"normal")
	_selected = tile
	tile.set_state(&"selected")
	tile_selected.emit(tile)
