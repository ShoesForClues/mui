return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local frame=gel.class.image_element:extend()
	
	function frame:__tostring()
		return "frame"
	end
	
	function frame:new()
		frame.super.new(self)
		
		self.frame_type = eztask.property.new(1)
		
		self.active.value=true
		self.background_opacity.value=0
		self.image.value=mui.layout.texture
		self.image_opacity.value=mui.layout.frame_1.opacity
		self.image_color.value=mui.layout.frame_1.color
		self.scale_mode.value=gel.enum.scale_mode.slice
		self.rect_offset.value=mui.layout.frame_1.rect_offset
		self.slice_center.value=mui.layout.frame_1.slice_center
		
		self.container=gel.new("element")
		:set("name","container")
		:set("visible",true)
		:set("clip",true)
		:set("position",mui.layout.frame_1.container.position)
		:set("size",mui.layout.frame_1.container.size)
		:set("parent",self)
		
		self.frame_type:attach(function(_,frame_type)
			if frame_type==1 then
				self.rect_offset.value=mui.layout.frame_1.rect_offset
				self.slice_center.value=mui.layout.frame_1.slice_center
				self.image_opacity.value=mui.layout.frame_1.opacity
				self.image_color.value=mui.layout.frame_1.color
				self.container.position.value=mui.layout.frame_1.container.position
				self.container.size.value=mui.layout.frame_1.container.size
			elseif frame_type==2 then
				self.rect_offset.value=mui.layout.frame_2.rect_offset
				self.slice_center.value=mui.layout.frame_2.slice_center
				self.image_opacity.value=mui.layout.frame_2.opacity
				self.image_color.value=mui.layout.frame_2.color
				self.container.position.value=mui.layout.frame_2.container.position
				self.container.size.value=mui.layout.frame_2.container.size
			elseif frame_type==3 then
				self.rect_offset.value=mui.layout.frame_3.rect_offset
				self.slice_center.value=mui.layout.frame_3.slice_center
				self.image_opacity.value=mui.layout.frame_3.opacity
				self.image_color.value=mui.layout.frame_3.color
				self.container.position.value=mui.layout.frame_3.container.position
				self.container.size.value=mui.layout.frame_3.container.size
			end
		end,true)
		
		self.child_added:attach(function(_,object)
			if object:is(gel.class.element) then
				object.parent.value=self.container
			end
		end,true)
	end
	
	function frame:delete()
		frame.super.delete(self)
		
		self.frame_type:detach()
	end
	
	return frame
end