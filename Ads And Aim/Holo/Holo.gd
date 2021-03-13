extends Spatial

export var aiming_initial = Vector3()
export var aiming_final = Vector3()
export var hand_initial = Vector3()
export var hand_final = Vector3()

onready var camera = $"../../../../Camera"
onready var hand = $"../../../"
onready var UI = $"../../../../../../Control"


enum scope { aiming , not_aiming , ads , reset }

var ads = false

var current_action 

func _ready():
	pass
	
	
func _physics_process(delta):
	scope(delta)

func scope(delta):
	if Input.is_action_just_pressed("RMB") and current_action != scope.aiming and current_action != scope.ads:
		yield(get_tree().create_timer(.1) , "timeout")
		if Input.is_action_pressed("RMB"):
			current_action = scope.aiming
		if ! Input.is_action_pressed("RMB"):
			current_action = scope.ads
			ads = true
			
	if current_action == scope.aiming and ! Input.is_action_pressed("RMB"):
		current_action = scope.not_aiming
		
	if current_action == scope.ads and Input.is_action_just_pressed("RMB") and ads:
		current_action = scope.reset
		camera.transform.origin = Vector3(0.716,0.607,3.207)
		
	match current_action:
		
		scope.aiming:
			camera.transform.origin = lerp(camera.transform.origin , aiming_final , 10*delta)
			
		scope.not_aiming:
			camera.transform.origin = lerp(camera.transform.origin , aiming_initial , 10*delta)
			
			
		scope.ads:
			camera.transform.origin = Vector3(0,0,0)
			hand.transform.origin = lerp(hand.transform.origin , hand_final, 10*delta)
			camera.fov = lerp(camera.fov , 40 , 10*delta)
			camera.cull_mask  =  camera.cull_mask and 2
			UI.visible = false
			
			
		scope.reset:

			camera.transform.origin = lerp(camera.transform.origin , aiming_initial , 10*delta)
			
			hand.transform.origin = lerp(hand.transform.origin , hand_initial , 10*delta)
			camera.fov = lerp(camera.fov ,70 , 15*delta)
			camera.cull_mask = camera.cull_mask | 2
			UI.visible = true
		_ :
			pass
	
	
	
	
		
		
		
		
	
	
	
