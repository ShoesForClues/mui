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
		
		self:set("active",true)
		:set("background_opacity",0)
		:set("image",mui.layout.texture)
		:set("image_opacity",mui.layout.frame_1.opacity)
		:set("image_color",mui.layout.frame_1.color)
		:set("scale_mode",gel.enum.scale_mode.slice)
		:set("rect_offset",mui.layout.frame_1.rect_offset)
		:set("slice_center",mui.layout.frame_1.slice_center)
		
		self.container=gel.new("element")
		:set("name","container")
		:set("visible",true)
		:set("clip",true)
		:set("position",mui.layout.frame_1.container.position)
		:set("size",mui.layout.frame_1.container.size)
		:set("parent",self)
		
		self.frame_type:attach(function(_,frame_type)
			if frame_type==1 then
				self:set("rect_offset",mui.layout.frame_1.rect_offset)
				:set("slice_center",mui.layout.frame_1.slice_center)
				:set("image_opacity",mui.layout.frame_1.opacity)
				:set("image_color",mui.layout.frame_1.color)
				
				self.container:set("position",mui.layout.frame_2.container.position)
				:set("size",mui.layout.frame_2.container.size)
			elseif frame_type==2 then
				self:set("rect_offset",mui.layout.frame_2.rect_offset)
				:set("slice_center",mui.layout.frame_2.slice_center)
				:set("image_opacity",mui.layout.frame_2.opacity)
				:set("image_color",mui.layout.frame_2.color)
				
				self.container:set("position",mui.layout.frame_3.container.position)
				:set("size",mui.layout.frame_3.container.size)
			elseif frame_type==3 then
				self:set("rect_offset",mui.layout.frame_3.rect_offset)
				:set("slice_center",mui.layout.frame_3.slice_center)
				:set("image_opacity",mui.layout.frame_3.opacity)
				:set("image_color",mui.layout.frame_3.color)
				
				self.container:set("position",mui.layout.frame_3.container.position)
				:set("size",mui.layout.frame_3.container.size)
			end
		end,true)
		
		self.child_added:attach(function(_,object)
			object.parent.value=self.container
		end,true)
	end
	
	function frame:delete()
		frame.super.delete(self)
		
		self.frame_type:detach()
	end
	
	return frame
end