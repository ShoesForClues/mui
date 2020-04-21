return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local radio_button=gel.class.element:extend()
	
	function radio_button:__tostring()
		return "radio_button"
	end
	
	function radio_button:new()
		radio_button.super.new(self)
		
		self.checked = eztask.property.new(false)
		
		self.box=gel.new("image_element")
		:set("name","box")
		:set("visible",true)
		:set("active",true)
		:set("size",lmath.udim2.new(
			0,mui.layout.radio_button.unselected.sprite_size.x,
			0,mui.layout.radio_button.unselected.sprite_size.y
		))
		:set("background_opacity",0)
		:set("rect_offset",mui.layout.radio_button.unselected.rect_offset)
		:set("image",mui.layout.texture)
		:set("image_color",mui.layout.radio_button.unselected.color)
		:set("image_opacity",mui.layout.radio_button.unselected.opacity)
		:set("parent",self)
		
		self.mark=gel.new("image_element")
		:set("name","mark")
		:set("visible",true)
		:set("anchor_point",lmath.vector2.new(0.5,0.5))
		:set("position",lmath.udim2.new(0.5,0,0.5,0))
		:set("size",lmath.udim2.new(
			0,mui.layout.radio_button.unselected.mark.sprite_size.x,
			0,mui.layout.radio_button.unselected.mark.sprite_size.y
		))
		:set("background_opacity",0)
		:set("rect_offset",mui.layout.radio_button.unselected.mark.rect_offset)
		:set("image",mui.layout.texture)
		:set("image_color",mui.layout.radio_button.unselected.mark.color)
		:set("image_opacity",mui.layout.radio_button.unselected.mark.opacity)
		:set("parent",self.box)
		
		self.text_element=gel.new("text_element")
		:set("visible",true)
		:set("size",lmath.udim2.new(
			1,-mui.layout.radio_button.unselected.sprite_size.x-5,
			1,0
		))
		:set("position",lmath.udim2.new(
			0,mui.layout.radio_button.unselected.sprite_size.x+5,
			0,0
		))
		:set("background_opacity",0)
		:set("text","Radio Button")
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
				self.box:set("rect_offset",mui.layout.radio_button.selected.rect_offset)
				:set("image_color",mui.layout.radio_button.selected.color)
				:set("image_opacity",mui.layout.radio_button.selected.opacity)
				
				self.mark:set("rect_offset",mui.layout.radio_button.selected.mark.rect_offset)
				:set("image_color",mui.layout.radio_button.selected.mark.color)
				:set("image_opacity",mui.layout.radio_button.selected.mark.opacity)
				
				if self.parent.value then
					for _,neighbor in pairs(self.parent.value.children) do
						if neighbor:is(radio_button) and neighbor~=self then
							neighbor.checked.value=false
						end
					end
				end
			else
				self.box:set("rect_offset",mui.layout.radio_button.unselected.rect_offset)
				:set("image_color",mui.layout.radio_button.unselected.color)
				:set("image_opacity",mui.layout.radio_button.unselected.opacity)
				
				self.mark:set("rect_offset",mui.layout.radio_button.unselected.mark.rect_offset)
				:set("image_color",mui.layout.radio_button.unselected.mark.color)
				:set("image_opacity",mui.layout.radio_button.unselected.mark.opacity)
			end
		end
		
		self.checked:attach(self.update_appearance,true)
		
		self.box.selected:attach(function(_,selected)
			if selected then
				self.checked.value=not self.checked.value
			end
		end,true)
	end
	
	function radio_button:delete()
		radio_button.super.delete(self)
		
		self.checked:detach()
	end
	
	return radio_button
end