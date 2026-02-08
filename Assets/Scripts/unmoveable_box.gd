extends RigidBody2D
@onready var box_pair: Node2D = $".."
@onready var moveable_box: RigidBody2D = $"../moveableBox"
@onready var this: RigidBody2D = $"."

var moveablePosition
var spawnVector := Vector2(0,0)
var vector := Vector2(0,0)


func _ready() -> void:
	spawnVector = Vector2(global_position.x, 0)
	vector = moveable_box.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	vector = moveable_box.global_position
	global_position = vector + spawnVector 
	get_node("CollisionShape2D").global_position = global_position
	pass
