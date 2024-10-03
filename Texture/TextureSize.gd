@tool
extends VisualShaderNodeCustom
class_name VisualShaderTextureSize

func _get_name() -> String:
	return "TextureSize"
	
func _get_category() -> String:
	return "Texture"


func _get_code(input_vars, output_vars, mode, type) -> String:
	var texture = input_vars[0]
	
	return "
		{output} = vec2(textureSize({texture},0));
	".format({
		"texture": texture,
		"output": output_vars[0],
	})
	
func _get_description() -> String:
	return "Returns size of texture in a vector"
	
#Input Properties
func _get_input_port_count() -> int:
	return 1
	
func _get_input_port_default_value(port):
	return Texture2D.new()

func _get_input_port_name(port: int) -> String: 
	return "Texture"

func _get_input_port_type(port: int) -> PortType:
	return PORT_TYPE_SAMPLER


#Output Properties
func _get_output_port_count() -> int:
	return 1
	
func _get_output_port_name(port: int) -> String:
	return "Size"
	
func _get_output_port_type(port: int) -> PortType:
	return PORT_TYPE_VECTOR_2D

	
