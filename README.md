
# Additional-Godot-Shader-Graph-Nodes 

This repository contains a collection of custom Shader Graph nodes designed to enhance the visual effects in your Godot projects. These nodes provide additional functionality and flexibility for shader development within the Godot Engine’s Visual Shader Editor. They can be easily integrated into your existing shader graphs to create a wide variety of effects, from procedural textures to dynamic lighting and more.

# Requirements
Godot Version: These nodes are compatible with Godot Engine 4.0 or higher.

## Installation

1.  **Download the Collection**: Clone or download this repository to your local machine.
2.  **Import into Your Project**: Copy the files into your project folder, in any directory. Once the files are imported nodes can be found in the "Add Node" menu under "Addons"



# Included Nodes

### Color Compression
Reduces the available colors of an image to a specified amount of colors per channel. Can be used to create limited palette retro textures.

### Dither
The **Dither Node** applies a dithering effect to your textures or materials, creating the illusion of higher color depth or smooth gradients by dispersing pixel colors. This effect is commonly used in retro-style visuals or to simulate transparency on platforms with limited bit depth.

### Sobel
The **Sobel Node** performs edge detection on your textures or materials, highlighting areas where there is a significant change in color or brightness. This effect is commonly used for stylized visuals such as outlines, sketch effects, or to enhance details in images.

### Texture Size
Outputs the size of a texture from a Sampler2D as a Vector2D.

### Pixelate UV
The **Pixelate UV Node** converts smooth UV coordinates into pixelated ones, effectively reducing the resolution of textures by emulating pixelation. This is perfect for creating retro, low-resolution visual styles or optimizing texture rendering in stylized games. By controlling how UV coordinates are sampled, this node lets you simulate lower texture resolutions without needing to modify the actual texture size.

### Tileable UV Pan/Scale
The **Tileable UV Pan/Scale Node** pans and scales UV coordinates in repeating space. Effectively allowing for repeating patterns of textures on surfaces without changing the UV Mapping of the model.

### Angle To Quaternion

The **Angle to Quaternion Node** converts an input angle (or rotation axis and angle) into a quaternion, which is essential for handling rotations in 3D space. Quaternions are more efficient and stable than Euler angles for smooth, continuous rotations, preventing issues like gimbal lock. This node simplifies converting angular rotations into quaternion form, making it easier to apply complex rotations in shaders.


## Contributing

Contributions are welcome! If you have suggestions, bug reports, or improvements, feel free to open an issue or submit a pull request. 

## License

This project is licensed under the MIT License. Feel free to use it in both personal and commercial projects.
