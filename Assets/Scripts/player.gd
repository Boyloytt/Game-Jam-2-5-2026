extends CharacterBody2D
@onready var middle_barrier: StaticBody2D = $"../MiddleBarrier"


const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const push_force = 40.0
const HALFWAY_DISTANCE = 550.0
var leftSide = true
var rightSide = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle Switch.
	if Input.is_action_just_pressed("Switch"):
		var distFromCen = abs(middle_barrier.global_position.x - global_position.x) * 2
		var vec = Vector2(distFromCen, 0)
		if leftSide:
			global_position += vec
			leftSide = false
		else:
			global_position -= vec
			leftSide = true
		#if global_position.x < 576:
			#global_position += Vector2(HALFWAY_DISTANCE, 0)
		#else:
			#global_position -= Vector2(HALFWAY_DISTANCE, 0)
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#moves only moveable objects and their parallel boxes
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider().is_in_group("Moveable"):
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			if c.get_collider().has_node("box2"):
				c.get_collider().get_node("box2").apply_central_impulse(-c.get_normal() * push_force)
