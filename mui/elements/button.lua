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
		
		self.active.value=true
		self.background_opacity.value=0
		self.image.value=mui.layout.texture
		self.image_opacity.value=mui.layout.button.unselected.opacity
		self.image_color.value=mui.layout.button.unselected.color
		self.scale_mode.value=gel.enum.scale_mode.slice
		self.rect_offset.value=mui.layout.button.unselected.rect_offset
		self.slice_center.value=mui.layout.button.unselected.slice_center
		
		local container=gel.new("element")
		container.name.value="container"
		container.visible.value=true
		container.clip.value=true
		container.position.value=mui.layout.button.unselected.container.position
		container.size.value=mui.layout.button.unselected.container.size
		container.parent.value=self
		self.container=container
		
		self.selected:attach(function(_,selected)
			if selected then
				self.rect_offset.value=mui.layout.button.selected.rect_offset
				self.slice_center.value=mui.layout.button.selected.slice_center
				self.image_opacity.value=mui.layout.button.selected.opacity
				self.image_color.value=mui.layout.button.selected.color
				container.position.value=mui.layout.button.selected.container.position
				container.size.value=mui.layout.button.selected.container.size
			else
				self.rect_offset.value=mui.layout.button.unselected.rect_offset
				self.slice_center.value=mui.layout.button.unselected.slice_center
				self.image_opacity.value=mui.layout.button.unselected.opacity
				self.image_color.value=mui.layout.button.unselected.color
				container.position.value=mui.layout.button.unselected.container.position
				container.size.value=mui.layout.button.unselected.container.size
			end
		end,true)
		
		self.child_added:attach(function(_,object)
			if object:is(gel.class.element) then
				object.parent.value=self.container
			end
		end,true)
	end
	
	function button:delete()
		button.super.delete(self)
		
	end
	
	return button
end