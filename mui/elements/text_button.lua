return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local text_button=mui.class.button:extend()
	
	function text_button:__tostring()
		return "text_button"
	end
	
	function text_button:new()
		text_button.super.new(self)
		
		self.text_element=gel.new("text_element")
		:set("name","text_element")
		:set("visible",true)
		:set("size",lmath.udim2.new(1,0,1,0))
		:set("background_opacity",0)
		:set("text","Button")
		:set("text_color",mui.layout.text_button.unselected.text_color)
		:set("text_opacity",mui.layout.text_button.unselected.text_opacity)
		:set("text_size",mui.layout.text_button.unselected.text_size)
		:set("font",mui.layout.font.regular)
		:set("text_x_alignment",gel.enum.alignment.x.center)
		:set("text_y_alignment",gel.enum.alignment.y.center)
		:set("text_wrapped",true)
		:set("clip",true)
		:set("parent",self.container)
		
		self.text             = self.text_element.text
		self.text_color       = self.text_element.text_color
		self.text_opacity     = self.text_element.text_opacity
		self.text_size        = self.text_element.text_size
		self.font             = self.text_element.font
		self.text_x_alignment = self.text_element.text_x_alignment
		self.text_y_alignment = self.text_element.text_y_alignment
		self.text_wrapped     = self.text_element.text_wrapped
	end
	
	function text_button:delete()
		text_button.super.delete(self)
	end
	
	return text_button
end