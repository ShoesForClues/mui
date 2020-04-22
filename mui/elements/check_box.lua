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
		
		self.frame=gel.new("image_element")
		:set("name","box")
		:set("visible",true)
		:set("active",true)
		:set("size",lmath.udim2.new(
			0,mui.layout.check_box.unselected.frame.sprite_size.x,
			0,mui.layout.check_box.unselected.frame.sprite_size.y
		))
		:set("background_opacity",0)
		:set("rect_offset",mui.layout.check_box.unselected.frame.rect_offset)
		:set("image",mui.layout.texture)
		:set("image_color",mui.layout.check_box.unselected.frame.color)
		:set("image_opacity",mui.layout.check_box.unselected.frame.opacity)
		:set("parent",self)
		
		self.mark=gel.new("image_element")
		:set("name","mark")
		:set("visible",true)
		:set("anchor_point",lmath.vector2.new(0.5,0.5))
		:set("position",lmath.udim2.new(0.5,0,0.5,0))
		:set("size",lmath.udim2.new(
			0,mui.layout.check_box.unselected.mark.sprite_size.x,
			0,mui.layout.check_box.unselected.mark.sprite_size.y
		))
		:set("background_opacity",0)
		:set("rect_offset",mui.layout.check_box.unselected.mark.rect_offset)
		:set("image",mui.layout.texture)
		:set("image_color",mui.layout.check_box.unselected.mark.color)
		:set("image_opacity",mui.layout.check_box.unselected.mark.opacity)
		:set("parent",self.frame)
		
		self.label=gel.new("text_element")
		:set("visible",true)
		:set("size",lmath.udim2.new(
			1,-mui.layout.check_box.unselected.frame.sprite_size.x-5,
			0,mui.layout.check_box.unselected.frame.sprite_size.y
		))
		:set("anchor_point",lmath.vector2.new(0,0.5))
		:set("position",lmath.udim2.new(
			0,mui.layout.check_box.unselected.frame.sprite_size.x+5,
			0.5,0
		))
		:set("background_opacity",0)
		:set("text","Checkbox")
		:set("font",mui.layout.font.regular)
		:set("text_x_alignment",gel.enum.alignment.x.left)
		:set("text_y_alignment",gel.enum.alignment.y.center)
		:set("text_size",mui.layout.check_box.unselected.label.text_size)
		:set("text_color",mui.layout.check_box.unselected.label.text_color)
		:set("text_opacity",mui.layout.check_box.unselected.label.text_opacity)
		:set("parent",self.frame)
		
		self.text             = self.label.text
		self.text_color       = self.label.text_color
		self.text_opacity     = self.label.text_opacity
		self.text_size        = self.label.text_size
		self.font             = self.label.font
		self.text_x_alignment = self.label.text_x_alignment
		self.text_y_alignment = self.label.text_y_alignment
		self.text_wrapped     = self.label.text_wrapped
		self.multiline        = self.label.multiline
		
		self.update_appearance=function()
			if self.checked.value then
				self.frame:set("rect_offset",mui.layout.check_box.selected.frame.rect_offset)
				:set("image_color",mui.layout.check_box.selected.frame.color)
				:set("image_opacity",mui.layout.check_box.selected.frame.opacity)
				
				self.mark:set("rect_offset",mui.layout.check_box.selected.mark.rect_offset)
				:set("image_color",mui.layout.check_box.selected.mark.color)
				:set("image_opacity",mui.layout.check_box.selected.mark.opacity)
				
				self.label:set("text_size",mui.layout.check_box.selected.label.text_size)
				:set("text_color",mui.layout.check_box.selected.label.text_color)
				:set("text_opacity",mui.layout.check_box.selected.label.text_opacity)
			else
				self.frame:set("rect_offset",mui.layout.check_box.unselected.frame.rect_offset)
				:set("image_color",mui.layout.check_box.unselected.frame.color)
				:set("image_opacity",mui.layout.check_box.unselected.frame.opacity)
				
				self.mark:set("rect_offset",mui.layout.check_box.unselected.mark.rect_offset)
				:set("image_color",mui.layout.check_box.unselected.mark.color)
				:set("image_opacity",mui.layout.check_box.unselected.mark.opacity)
				
				self.label:set("text_size",mui.layout.check_box.unselected.label.text_size)
				:set("text_color",mui.layout.check_box.unselected.label.text_color)
				:set("text_opacity",mui.layout.check_box.unselected.label.text_opacity)
			end
		end
		
		self.checked:attach(self.update_appearance,true)
		
		self.frame.selected:attach(function(_,selected)
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