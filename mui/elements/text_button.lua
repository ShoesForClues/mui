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
		
		local text_element=gel.new("text_element")
		text_element.name.value="text_element"
		text_element.visible.value=true
		text_element.size.value=lmath.udim2.new(1,0,1,0)
		text_element.background_opacity.value=0
		text_element.text.value="Button"
		text_element.text_color.value=mui.layout.text_button.unselected.text_color
		text_element.text_opacity.value=mui.layout.text_button.unselected.text_opacity
		text_element.text_size.value=mui.layout.text_button.unselected.text_size
		text_element.font.value=mui.layout.font.regular
		text_element.text_x_alignment.value=gel.enum.alignment.x.center
		text_element.text_y_alignment.value=gel.enum.alignment.y.center
		text_element.text_wrapped.value=true
		text_element.clip.value=true
		text_element.parent.value=self.container
		
		self.text_element=text_element
	end
	
	function text_button:delete()
		text_button.super.delete(self)
	end
	
	return text_button
end