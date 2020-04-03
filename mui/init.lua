--[[
Modern User Interface created by Shoelee
Copyright (c) 2020
]]

return function(lumiere,lib_dir)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local mui={
		_version = {0,0,4},
		enum     = {},
		class    = {},
		layout   = nil
	}
	
	--Functions
	function mui.wrap(class_name,method,wrap)
		local class=mui.class[class_name]
		assert(class,"No class named "..tostring(class_name))
		assert(class[method],("No method named %s in class %s"):muiat(method,class))
		assert(wrap,"Cannot wrap method with nil")
		local _method=class[method]
		class[method]=function(...) _method(...);wrap(...) end
		return class
	end
	
	function mui.new(class_name)
		local class=mui.class[class_name]
		assert(class,"No class named "..tostring(class_name))
		return class()
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
		
		local layout=lumiere.platform.file.require(layout_dir..".layout")(lumiere)
		
		layout.texture=lumiere.platform.graphics.load_texture(layout_dir.."/"..layout.texture)
		layout.font.regular=lumiere.platform.graphics.load_font(layout_dir.."/"..layout.font.regular)
		layout.font.bold=lumiere.platform.graphics.load_font(layout_dir.."/"..layout.font.bold)
		
		format_layout_section(layout,layout.texture_size)
		
		mui.layout=layout
	end
	
	--Elements
	mui.class.frame       = lumiere.platform.file.require(lib_dir..".elements.frame")(lumiere,mui)
	mui.class.button      = lumiere.platform.file.require(lib_dir..".elements.button")(lumiere,mui)
	mui.class.text_button = lumiere.platform.file.require(lib_dir..".elements.text_button")(lumiere,mui)
	mui.class.text_box    = lumiere.platform.file.require(lib_dir..".elements.text_box")(lumiere,mui)
	mui.class.window      = lumiere.platform.file.require(lib_dir..".elements.window")(lumiere,mui)
	
	return mui
end