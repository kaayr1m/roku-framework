function UIView(options, appendOptions = invalid as Object)
    this = UILayout(options) 'Add Layout Tools
    this.Append({
        backgroundOpacity : if_else(options["background-opacity"] <> invalid, options["background-opacity"], "100")
        backgroundColor  : 255 'black
    })
    
    this.backgroundColor = ColorWithName(options["background-color"], ColorOpacity()[this.backgroundOpacity])
    
    AddSpriteContainerTo(this)
    
    if appendOptions <> invalid then this.Append(appendOptions) 'Other Views options
    
    'Called by RefreshScreen
    this.draw = function(component as Object) as Boolean
        return true
    end function
    
    'Call Render Screen After This
    this.setZ = function(z)
        m.layout___pr.z = z
        m.sprites.SetZ(z)
    end function
    
    'Call Render Screen After This
    this.addZ = function(z)
        m.layout___pr.z = m.layout___pr.z + z
        m.sprites.AddZ(z)
    end function
    
    'Call Render Screen After This
    this.setX = function(x)
        offset = x - m.x()
        
        m.layout___pr.x = x
        
        m.sprites.MoveOffset(offset, 0)
    end function
    
    'Call Render Screen After This
    this.setY = function(y)
        offset = y - m.y()
        
        m.layout___pr.y = y
        
        m.sprites.MoveOffset(0, offset)
    end function
    
    'Call Render Screen After This
    this.setHeight = function(height)
        m.layout___pr.height = height
    end function
    
    'Call Render Screen After This
    this.setWidth = function(width)
        m.layout___pr.width = width
    end function
    
    'Call Render Screen After This
    this.MoveTo = function(x, y)
        offset_x = x - m.x()
        offset_y = y - m.y()
        
        m.layout___pr.x = x
        m.layout___pr.y = y
        
        m.sprites.MoveOffset(offset_x, offset_y)
    end function
    
    'Call Render Screen After This
    this.MoveOffset = function(x, y)
        
        m.layout___pr.x = m.layout___pr.x + x
        m.layout___pr.y = m.layout___pr.y + y
        
        m.sprites.MoveOffset(x, y)
    end function
    
    this.base_layout_prepareForLayout = this.prepareForLayout
    this.prepareForLayout = function()
        m.base_layout_prepareForLayout()
    end function
    
    this.base_layout_didLayout = this.didLayout
    this.didLayout = function()
        m.base_layout_didLayout()
    end function
    
    this.initBackground = function()
        bitmap = CreateBitmap(m.width(), m.height())
        bitmap.Clear(m.backgroundColor)
        
        region = CreateRegion(0, 0, m.width(), m.height(), bitmap)
        sprite = CreateSprite(m.x(), m.y(), region)
        
        m.sprites.Add(sprite)
        m.sprites.SetDrawableFlag(m.isOpaque())
    end function
    
    this.setBackgroundColor = function(color as Integer)
        m.backgroundColor = color
        if m.bitmap = invalid then m.initBackground()
    end function
    
    this.init = function()
        if m.backgroundColor <> invalid then m.initBackground()
        print "INIT [ "+ m.id+" ]"
    end function
    
    return this
end function