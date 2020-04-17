return function(lumiere,mui)
	local eztask = lumiere:depend "eztask"
	local lmath  = lumiere:depend "lmath"
	local class  = lumiere:depend "class"
	local gel    = lumiere:depend "gel"
	
	local window=gel.class.element:extend()
	
	function window:__tostring()
		return "window"
	end
	
	function window:new()
		window.super.new(self)
		
		self.clip.value=true
		self.active.value=true
		
		self.resizable  = eztask.property.new(false)
		self.draggable  = eztask.property.new(true)
		self.borderless = eztask.property.new(false)
		self.focused    = eztask.property.new(false)
		self.min_width  = eztask.property.new(0)
		self.min_height = eztask.property.new(0)
		self.icon       = eztask.property.new()
		
		self.top_frame=gel.new("image_element")
		:set("name","top_frame")
		:set("visible",true)
		:set("size",lmath.udim2.new(1,0,0,mui.layout.window.top_frame_size))
		:set("background_opacity",0)
		:set("image",mui.layout.texture)
		:set("image_opacity",mui.layout.window.focused.top_frame.opacity)
		:set("image_color",mui.layout.window.focused.top_frame.color)
		:set("scale_mode",gel.enum.scale_mode.slice)
		:set("rect_offset",mui.layout.window.focused.top_frame.rect_offset)
		:set("slice_center",mui.layout.window.focused.top_frame.slice_center)
		:set("clip",true)
		:set("parent",self)
		
		self.title=gel.new("text_element")
		:set("name","title")
		:set("visible",true)
		:set("position",mui.layout.window.focused.title.position)
		:set("size",mui.layout.window.focused.title.size)
		:set("background_opacity",0)
		:set("font",mui.layout.font[mui.layout.window.focused.title.font])
		:set("text",self.name.value)
		:set("text_size",mui.layout.window.focused.title.text_size)
		:set("text_x_alignment",gel.enum.alignment.x.left)
		:set("text_y_alignment",gel.enum.alignment.y.center)
		:set("text_opacity",1)
		:set("text_color",lmath.color3.new(1,1,1))
		:set("filter_mode",gel.enum.filter_mode.nearest)
		:set("parent",self.top_frame)
		
		self.frame=gel.new("image_element")
		:set("name","frame")
		:set("visible",true)
		:set("size",lmath.udim2.new(1,0,1,-mui.layout.window.top_frame_size))
		:set("position",lmath.udim2.new(0,0,0,mui.layout.window.top_frame_size))
		:set("background_opacity",0)
		:set("image",mui.layout.texture)
		:set("image_opacity",mui.layout.window.focused.frame.opactity)
		:set("image_color",mui.layout.window.focused.frame.color)
		:set("scale_mode",gel.enum.scale_mode.slice)
		:set("rect_offset",mui.layout.window.focused.frame.rect_offset)
		:set("slice_center",mui.layout.window.focused.frame.slice_center)
		:set("parent",self)
		
		self.container=gel.new("element")
		:set("name","container")
		:set("visible",true)
		:set("clip",true)
		:set("position",mui.layout.window.focused.container.position)
		:set("size",mui.layout.window.focused.container.size)
		:set("parent",self)
		
		self.drag_event=nil
		self.drag_release_event=nil
		
		self.focused:attach(function(_,focused)
			if focused then
				if self.parent.value then
					--[[
					for _,neighbor in pairs(self.parent.value.children) do
						if neighbor:is(window) and neighbor~=self then
							neighbor.focused.value=false
						end
					end
					]]
					for i=#self.parent.value.children,1,-1 do
						local neighbor=self.parent.value.children[i]
						if neighbor:is(window) and neighbor~=self then
							neighbor.focused.value=false
							break
						end
					end
				end
				self.top_frame.rect_offset.value=mui.layout.window.focused.top_frame.rect_offset
				self.top_frame.slice_center.value=mui.layout.window.focused.top_frame.slice_center
				self.top_frame.image_color.value=mui.layout.window.focused.top_frame.color
				self.top_frame.image_opacity.value=mui.layout.window.focused.top_frame.opacity
				self.frame.rect_offset.value=mui.layout.window.focused.frame.rect_offset
				self.frame.slice_center.value=mui.layout.window.focused.frame.slice_center
				self.frame.image_color.value=mui.layout.window.focused.frame.color
				self.frame.image_opacity.value=mui.layout.window.focused.frame.opacity
			else
				self.top_frame.rect_offset.value=mui.layout.window.unfocused.top_frame.rect_offset
				self.top_frame.slice_center.value=mui.layout.window.unfocused.top_frame.slice_center
				self.top_frame.image_color.value=mui.layout.window.unfocused.top_frame.color
				self.top_frame.image_opacity.value=mui.layout.window.unfocused.top_frame.opacity
				self.frame.rect_offset.value=mui.layout.window.unfocused.frame.rect_offset
				self.frame.slice_center.value=mui.layout.window.unfocused.frame.slice_center
				self.frame.image_color.value=mui.layout.window.unfocused.frame.color
				self.frame.image_opacity.value=mui.layout.window.unfocused.frame.opacity
			end
		end,true)
		
		self.pressed:attach(function()
			if not self.parent.value then
				return
			end
			self.index.value=#self.parent.value.children
			self.focused.value=true
		end,true)
		
		self.top_frame.pressed:attach(function()
			if self.drag_event then
				return
			end
			if not self.draggable.value then
				return
			end
			if self.gui.value then
				local gui=self.gui.value
				local start_cursor=lmath.vector2.new(
					gui.cursor_position.value.x,
					gui.cursor_position.value.y
				)
				local start_position=self.position.value
				self.drag_event=gui.cursor_position:attach(function(_,cursor_position)
					self.position.value=start_position+lmath.udim2.new(
						0,cursor_position.x-start_cursor.x,
						0,cursor_position.y-start_cursor.y
					)
				end,true)
				self.drag_release_event=gui.cursor_released:attach(function()
					if self.drag_event then
						self.drag_event:detach()
						self.drag_event=nil
					end
					if self.drag_release_event then
						self.drag_release_event:detach()
						self.drag_release_event=nil
					end
				end,true)
			end
		end,true)
		
		self.name:attach(function(_,name)
			self.title.text.value=name
		end,true)
		
		self.parent:attach(function(_,parent)
			self.focused.value=parent~=nil
		end,true)
		
		self.borderless:attach(function(_,borderless)
			if borderless then
				self.top_frame.visible.value=false
				self.frame.visible.value=false
				self.container.position.value=lmath.udim2.new(0,0,0,0)
				self.container.size.value=lmath.udim2.new(1,0,1,0)
			else
				self.top_frame.visible.value=true
				self.frame.visible.value=true
				if self.focused.value then
					self.container.position.value=mui.layout.window.focused.container.position
					self.container.size.value=mui.layout.window.focused.container.size
				else
					self.container.position.value=mui.layout.window.unfocused.container.position
					self.container.size.value=mui.layout.window.unfocused.container.size
				end
			end
		end,true)
		
		self.child_added:attach(function(_,object)
			if object:is(gel.class.element) then
				object.parent.value=self.container
			end
		end,true)
	end
	
	function window:delete()
		window.super.delete(self)
		
		self.resizable:detach()
		self.draggable:detach()
		self.borderless:detach()
		self.focused:detach()
		self.min_width:detach()
		self.min_height:detach()
		self.icon:detach()
		
		if self.drag_event then
			self.drag_event:detach()
			self.drag_event=nil
		end
		if self.drag_release_event then
			self.drag_release_event:detach()
			self.drag_release_event=nil
		end
	end
	
	return window
end