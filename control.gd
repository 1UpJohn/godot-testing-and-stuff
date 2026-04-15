extends Control

@onready var label = $Label

var shader_material : ShaderMaterial
var origin : Vector2

enum Effect { none, wave, shake, rumble }

var current_effect = Effect.none
var effect_strength := 1.0

var amplitude := 10.0
var frequency := 10.0
var speed := 2.0
var shake_strength := 3.0
var rumble_strength := 15.0


func _ready():
	origin = label.position
	setup_wave_shader()


func setup_wave_shader():
	var shader = Shader.new()
	shader.code = """
		shader_type canvas_item;

		uniform float amplitude;
		uniform float frequency;
		uniform float speed;

		void vertex() {
			float time = TIME * speed;
			float wave = sin(VERTEX.x * 0.05 * frequency + time) * amplitude;
			VERTEX.y += wave;
		}
	"""

	shader_material = ShaderMaterial.new()
	shader_material.shader = shader


func set_effect(e, strength := 1.0):
	current_effect = e
	effect_strength = strength


func _process(delta):
	var t = Time.get_ticks_msec() / 1000.0

	match current_effect:
		Effect.none:
			label.material = null
			label.position = origin

		Effect.wave:
			label.material = shader_material
			shader_material.set_shader_parameter("amplitude", amplitude * effect_strength)
			shader_material.set_shader_parameter("frequency", frequency)
			shader_material.set_shader_parameter("speed", speed)
			label.position = origin

		Effect.shake:
			label.material = null
			label.position = origin + Vector2(
				randf_range(-shake_strength, shake_strength) * effect_strength,
				randf_range(-shake_strength, shake_strength) * effect_strength
			)

		Effect.rumble:
			label.material = null
			var base = sin(t * 6.0)
			var sharp = sign(base) * pow(abs(base), 0.4)

			var x = sharp * rumble_strength * effect_strength
			var y = sin(t * 20.0) * (rumble_strength * 0.5) * effect_strength

			label.position = origin + Vector2(x, y)

# original script remade
