class_name Palette
extends RefCounted

# 跳一跳风格柔和马卡龙配色
const BG_TOP := Color(0.659, 0.753, 0.772)        # 柔和蓝灰天顶 #A8C0C5
const BG_HORIZON := Color(0.949, 0.843, 0.769)    # 暖桃地平线   #F2D7C4

const TILE_NORMAL := Color(0.561, 0.725, 0.659)   # 鼠尾草绿 #8FB9A8
const TILE_HOVER := Color(0.710, 0.839, 0.780)    # 浅薄荷   #B5D6C7
const TILE_SELECTED := Color(0.910, 0.659, 0.486) # 柔珊瑚   #E8A87C

const ACCENT := Color(0.949, 0.780, 0.529)        # 暖黄强调 #F2C787
const INK := Color(0.231, 0.251, 0.239)           # 深墨绿文字 #3B403D
const SHADOW := Color(0.180, 0.157, 0.137, 0.16)  # 地面软阴影

# 等距瓦片几何（2:1 菱形）
const TILE_W := 66.0
const TILE_H := 33.0
const TILE_HEIGHT := 13.0                          # 平台厚度（px）
