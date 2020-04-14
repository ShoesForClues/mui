return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local button=gel.class.image_element:extend()
	
	function button:__tostring()
		return "button"
	end
	
	function button:new()
		button.super.new(self)
		
		self.selected_color               = eztask.property.new(mui.layout.button.selected.color)
		self.selected_opacity             = eztask.property.new(mui.layout.button.selected.opacity)
		self.selected_container_color     = eztask.property.new(mui.layout.button.selected.container.color)
		self.selected_container_opacity   = eztask.property.new(mui.layout.button.selected.container.opacity)
		
		self.unselected_color             = eztask.property.new(mui.layout.button.unselected.color)
		self.unselected_opacity           = eztask.property.new(mui.layout.button.unselected.opacity)
		self.unselected_container_color   = eztask.property.new(mui.layout.button.unselected.container.color)
		self.unselected_container_opacity = eztask.property.new(mui.layout.button.unselected.container.opacity)
		
		self.active.value=true
		self.background_opacity.value=0
		self.image.value=mui.layout.texture
		self.image_opacity.value=self.unselected_opacity.value
		self.image_color.value=self.unselected_color.value
		self.scale_mode.value=gel.enum.scale_mode.slice
		self.rect_offset.value=mui.layout.button.unselected.rect_offset
		self.slice_center.value=mui.layout.button.unselected.slice_center
		
		self.container=gel.new("element")
		:set("name","container")
		:set("visible",true)
		:set("clip",true)
		:set("position",mui.layout.button.unselected.container.position)
		:set("size",mui.layout.button.unselected.container.size)
		:set("parent",self)
		
		self.update_appearance=function()
			if self.selected.value then
				self.rect_offset.value=mui.layout.button.selected.rect_offset
				self.slice_center.value=mui.layout.button.selected.slice_center
				self.image_opacity.value=self.selected_opacity.value
				self.image_color.value=self.selected_color.value
				self.container.position.value=mui.layout.button.selected.container.position
				self.container.size.value=mui.layout.button.selected.container.size
			else
				self.rect_offset.value=mui.layout.button.unselected.rect_offset
				self.slice_center.value=mui.layout.button.unselected.slice_center
				self.image_opacity.value=self.unselected_opacity.value
				self.image_color.value=self.unselected_color.value
				self.container.position.value=mui.layout.button.unselected.container.position
				self.container.size.value=mui.layout.button.unselected.container.size
			end
		end
		
		self.selected:attach(self.update_appearance,true)
		self.selected_color:attach(self.update_appearance,true)
		self.selected_opacity:attach(self.update_appearance,true)
		self.selected_container_color:attach(self.update_appearance,true)
		self.selected_container_opacity:attach(self.update_appearance,true)
		self.unselected_color:attach(self.update_appearance,true)
		self.unselected_opacity:attach(self.update_appearance,true)
		self.unselected_container_color:attach(self.update_appearance,true)
		self.unselected_container_opacity:attach(self.update_appearance,true)
	end
	
	function button:delete()
		button.super.delete(self)
		
		self.selected_color:detach()
		self.selected_opacity:detach()
		self.selected_container_color:detach()
		self.selected_container_opacity:detach()
		self.unselected_color:detach()
		self.unselected_opacity:detach()
		self.unselected_container_color:detach()
		self.unselected_container_opacity:detach()
	end
	
	return button
end