return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local text_box=gel.class.image_element:extend()
	
	function text_box:__tostring()
		return "text_box"
	end
	
	function text_box:new()
		text_box.super.new(self)
		
		self.active.value=true
		self.background_opacity.value=0
		self.image.value=mui.layout.texture
		self.image_opacity.value=1
		self.image_color.value=lmath.color3.new(1,1,1)
		self.scale_mode.value=gel.enum.scale_mode.slice
		self.rect_offset.value=mui.layout.text_box.unfocused.rect_offset
		self.slice_center.value=mui.layout.text_box.unfocused.slice_center
		
		local text_element=gel.new("text_element")
		text_element.name.value="text_element"
		text_element.visible.value=true
		text_element.background_opacity.value=mui.layout.text_box.unfocused.container.opacity
		text_element.background_color.value=mui.layout.text_box.unfocused.container.color
		text_element.text.value="Textbox"
		text_element.text_color.value=mui.layout.text_box.default_text_color
		text_element.text_opacity.value=1
		text_element.text_size.value=mui.layout.text_box.default_text_size
		text_element.font.value=mui.layout.font.regular
		text_element.text_x_alignment.value=gel.enum.alignment.x.center
		text_element.text_y_alignment.value=gel.enum.alignment.y.center
		text_element.text_wrapped.value=true
		text_element.clip.value=true
		text_element.selectable.value=true
		text_element.editable.value=true
		text_element.position.value=mui.layout.text_box.unfocused.container.position
		text_element.size.value=mui.layout.text_box.unfocused.container.size
		text_element.parent.value=self
		self.text_element=text_element
		
		self.text_element.focused:attach(function(_,focused)
			if focused then
				self.rect_offset.value=mui.layout.text_box.focused.rect_offset
				self.slice_center.value=mui.layout.text_box.focused.slice_center
			else
				self.rect_offset.value=mui.layout.text_box.unfocused.rect_offset
				self.slice_center.value=mui.layout.text_box.unfocused.slice_center
			end
		end,true)
	end
	
	function text_box:delete()
		text_box.super.delete(self)
	end
	
	return text_box
end