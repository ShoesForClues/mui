--[[
Modern User Interface

MIT License

Copyright (c) 2020 Shoelee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

return function(lumiere,lib_dir)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local mui={
		_version = {0,0,6},
		enum     = {},
		class    = {},
		layout   = nil
	}
	
	function mui.wrap(class_name,method,wrap)
		local class=mui.class[class_name]
		
		assert(class,"No class named "..tostring(class_name))
		assert(wrap,"Cannot wrap method with nil")
		assert(class[method],("No method named %s in class %s"):format(method,class))
		
		local _method=class[method]
		class[method]=function(...) _method(...);wrap(...) end
		
		return class
	end
	
	function mui.new(class_name)
		--[[
		local class=mui.class[class_name]
		assert(class,"No class named "..tostring(class_name))
		return class()
		]]
		return mui.class[class_name]()
	end
	
	local function format_layout_section(section,texture_size)
		if section.sprite_position and section.sprite_size then
			section.rect_offset=lmath.rect.new(
				section.sprite_position.x/texture_size.x,
				section.sprite_position.y/texture_size.y,
				(section.sprite_position.x+section.sprite_size.x)/texture_size.x,
				(section.sprite_position.y+section.sprite_size.y)/texture_size.y
			)
		end
		for _,sub_section in pairs(section) do
			if type(sub_section)=="table" and getmetatable(sub_section)==nil then
				format_layout_section(sub_section,texture_size)
			end
		end
	end
	
	function mui:init(layout_dir)
		assert(layout_dir,"Cannot initialize without a layout!")
		
		local layout=lumiere.require(layout_dir..".layout")(lumiere)
		
		layout.texture=lumiere.platform.graphics.load_texture(layout_dir.."/"..layout.texture)
		layout.font.regular=lumiere.platform.graphics.load_font(layout_dir.."/"..layout.font.regular)
		layout.font.bold=lumiere.platform.graphics.load_font(layout_dir.."/"..layout.font.bold)
		
		format_layout_section(layout,layout.texture_size)
		
		mui.layout=layout
	end
	
	mui.class.frame        = lumiere.require(lib_dir..".elements.frame")(lumiere,mui)
	mui.class.button       = lumiere.require(lib_dir..".elements.button")(lumiere,mui)
	mui.class.text_button  = lumiere.require(lib_dir..".elements.text_button")(lumiere,mui)
	mui.class.text_box     = lumiere.require(lib_dir..".elements.text_box")(lumiere,mui)
	mui.class.check_box    = lumiere.require(lib_dir..".elements.check_box")(lumiere,mui)
	mui.class.radio_button = lumiere.require(lib_dir..".elements.radio_button")(lumiere,mui)
	mui.class.window       = lumiere.require(lib_dir..".elements.window")(lumiere,mui)
	
	return mui
end