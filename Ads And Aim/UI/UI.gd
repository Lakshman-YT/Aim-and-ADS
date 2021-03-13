extends Control



onready var UI = $"."

onready var right_ch = $Right_CH

onready var left_ch = $Left_CH

onready var up_ch = $Up_CH

onready var down_ch = $Down_CH



var can_fire = true

var CH_recoil_pos = 50





func _ready():

	pass



func fire(delta):

	if Input.is_action_pressed("fire") and can_fire:



		up_ch.position = lerp( up_ch.position , Vector2(0 ,-CH_recoil_pos) , 3*delta)

		down_ch.position = lerp( down_ch.position , Vector2(0 , CH_recoil_pos) , 3 *delta)

		left_ch.position = lerp( left_ch.position , Vector2( -CH_recoil_pos , 0) ,3 *delta)

		right_ch.position = lerp( right_ch.position , Vector2( CH_recoil_pos , 0) ,3 *delta)

		

		can_fire = false

		

		if down_ch.position > Vector2(0,60):

			CH_recoil_pos = 60

		

		

		CH_recoil_pos += 4

		yield(get_tree().create_timer(.25) , "timeout")

		can_fire = true

		

	if !Input.is_action_pressed("fire")  or not can_fire:

		for ch in UI.get_children():

			ch.position = lerp( ch.position , Vector2(0,0) , 3 * delta )

			CH_recoil_pos -= ch.position.x

			

func _physics_process(delta):

	fire(delta)
	
