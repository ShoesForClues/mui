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
		
		local top_frame=gel.new("image_element")
		top_frame.name.value="top_frame"
		top_frame.visible.value=true
		top_frame.size.value=lmath.udim2.new(1,0,0,mui.layout.window.top_frame_size)
		top_frame.background_opacity.value=0
		top_frame.image.value=mui.layout.texture
		top_frame.image_opacity.value=1
		top_frame.image_color.value=lmath.color3.new(1,1,1)
		top_frame.scale_mode.value=gel.enum.scale_mode.slice
		top_frame.rect_offset.value=mui.layout.window.focused.top_frame.rect_offset
		top_frame.slice_center.value=mui.layout.window.focused.top_frame.slice_center
		top_frame.clip.value=true
		top_frame.parent.value=self
		
		local title=gel.new("text_element")
		title.name.value="title"
		title.visible.value=true
		title.position.value=mui.layout.window.focused.title.position
		title.size.value=mui.layout.window.focused.title.size
		title.background_opacity.value=0
		title.font.value=mui.layout.font[mui.layout.window.focused.title.font]
		title.text.value=self.name.value
		title.text_size.value=mui.layout.window.focused.title.text_size
		title.text_x_alignment.value=gel.enum.alignment.x.left
		title.text_y_alignment.value=gel.enum.alignment.y.center
		title.text_opacity.value=1
		title.text_color.value=lmath.color3.new(1,1,1)
		title.filter_mode.value=gel.enum.filter_mode.nearest
		title.parent.value=top_frame
		
		local frame=gel.new("image_element")
		frame.name.value="frame"
		frame.visible.value=true
		frame.size.value=lmath.udim2.new(1,0,1,-mui.layout.window.top_frame_size)
		frame.position.value=lmath.udim2.new(0,0,0,mui.layout.window.top_frame_size)
		frame.background_opacity.value=0
		frame.image.value=mui.layout.texture
		frame.image_opacity.value=1
		frame.image_color.value=lmath.color3.new(1,1,1)
		frame.scale_mode.value=gel.enum.scale_mode.slice
		frame.rect_offset.value=mui.layout.window.focused.frame.rect_offset
		frame.slice_center.value=mui.layout.window.focused.frame.slice_center
		frame.parent.value=self
		
		local container=gel.new("element")
		container.name.value="container"
		container.visible.value=true
		container.clip.value=true
		container.position.value=mui.layout.window.focused.container.position
		container.size.value=mui.layout.window.focused.container.size
		container.parent.value=self
		
		self.top_frame=top_frame
		self.title=title
		self.frame=frame
		self.container=container
		
		self.drag_event=nil
		self.drag_release_event=nil
		
		self.focused:attach(function(_,focused)
			if focused then
				if self.parent.value then
					for _,neighbor in pairs(self.parent.value.children) do
						if neighbor:is(window) and neighbor~=self then
							neighbor.focused.value=false
						end
					end
				end
				self.top_frame.rect_offset.value=mui.layout.window.focused.top_frame.rect_offset
				self.top_frame.slice_center.value=mui.layout.window.focused.top_frame.slice_center
				self.frame.rect_offset.value=mui.layout.window.focused.frame.rect_offset
				self.frame.slice_center.value=mui.layout.window.focused.frame.slice_center
			else
				self.top_frame.rect_offset.value=mui.layout.window.unfocused.top_frame.rect_offset
				self.top_frame.slice_center.value=mui.layout.window.unfocused.top_frame.slice_center
				self.frame.rect_offset.value=mui.layout.window.unfocused.frame.rect_offset
				self.frame.slice_center.value=mui.layout.window.unfocused.frame.slice_center
			end
		end,true)
		
		self.pressed:attach(function()
			if not self.parent.value then
				return
			end
			self.index.value=#self.parent.value.children
			self.focused.value=true
		end,true)
		
		top_frame.pressed:attach(function()
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
			title.text.value=name
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