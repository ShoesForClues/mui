return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local check_box=gel.class.element:extend()
	
	function check_box:__tostring()
		return "check_box"
	end
	
	function check_box:new()
		check_box.super.new(self)
		
		self.checked = eztask.property.new(false)
		
		self.box=gel.new("image_element")
		:set("name","box")
		:set("visible",true)
		:set("active",true)
		:set("size",lmath.udim2.new(
			0,mui.layout.check_box.unselected.sprite_size.x,
			0,mui.layout.check_box.unselected.sprite_size.y
		))
		:set("rect_offset",mui.layout.check_box.unselected.rect_offset)
		:set("image",mui.layout.texture)
		:set("image_color",mui.layout.check_box.unselected.color)
		:set("image_opacity",mui.layout.check_box.unselected.opacity)
		:set("parent",self)
		
		self.text_element=gel.new("text_element")
		:set("visible",true)
		:set("size",lmath.udim2.new(
			1,-mui.layout.check_box.unselected.sprite_size.x,
			1,0
		))
		:set("position",lmath.udim2.new(
			0,mui.layout.check_box.unselected.sprite_size.x,
			0,0
		))
		:set("background_opacity",0)
		:set("text","Checkbox")
		:set("font",mui.layout.font.regular)
		:set("text_x_alignment",gel.enum.alignment.x.left)
		:set("text_y_alignment",gel.enum.alignment.y.center)
		:set("text_color",lmath.color3.new(0,0,0))
		:set("text_opacity",1)
		:set("parent",self)
		
		self.text             = self.text_element.text
		self.text_color       = self.text_element.text_color
		self.text_opacity     = self.text_element.text_opacity
		self.text_size        = self.text_element.text_size
		self.font             = self.text_element.font
		self.text_x_alignment = self.text_element.text_x_alignment
		self.text_y_alignment = self.text_element.text_y_alignment
		self.text_wrapped     = self.text_element.text_wrapped
		self.multiline        = self.text_element.multiline
		
		self.update_appearance=function()
			if self.checked.value then
				self.box:set("rect_offset",mui.layout.check_box.selected.rect_offset)
				:set("image_color",mui.layout.check_box.selected.color)
				:set("image_opacity",mui.layout.check_box.selected.opacity)
			else
				self.box:set("rect_offset",mui.layout.check_box.unselected.rect_offset)
				:set("image_color",mui.layout.check_box.unselected.color)
				:set("image_opacity",mui.layout.check_box.unselected.opacity)
			end
		end
		
		self.checked:attach(self.update_appearance,true)
		
		self.box.selected:attach(function(_,selected)
			if selected then
				self.checked.value=not self.checked.value
			end
		end,true)
	end
	
	function check_box:delete()
		check_box.super.delete(self)
		
		self.checked:detach()
	end
	
	return check_box
end