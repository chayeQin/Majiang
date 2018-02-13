--
-- @brief 
-- @author: qyp
-- @date: 2016/02/18
--

local cls = class("TestScene", cc.load("mvc").ViewBase)

function cls:ctor()
	cls.super.ctor(self)
    local s = cc.Director:getInstance():getWinSize()
    local zeye = cc.Director:getInstance():getZEye()
    local viewAngle = 60 --视角
    local nearZ = 0.1
    local farZ = 2*zeye
    local camera = cc.Camera:createPerspective(viewAngle, s.width/s.height, nearZ, farZ)
    camera:setCameraFlag(cc.CameraFlag.USER1)
    local theta = math.rad(0)
    local y = math.sin(theta)*zeye
    local z = math.cos(theta)*zeye
    camera:setPosition3D(cc.vec3(s.width/2, s.height/2 + y, z + 100))

    print("zeye", z+100)
    -- centre坐标，表示的是视线方向，该方向矢量是由eye坐标、centre坐标共同构成的
    local center = cc.vec3(s.width/2, s.height/2, 0)
    -- 相机朝上方向
    local up = cc.vec3(0.0, 1, 1*math.tan(theta)) 
    camera:lookAt(center, up)
    self:addChild(camera)
    -- 玩家相机sprite
    local layer1 = display.newLayer():addTo(self)
    local sp1 = Util:sprite("ui/keji_kuang")
    sp1:setPosition(cc.p(100, 620))
    sp1:addTo(layer1)
    local drawNode = cc.DrawNode:create()
    drawNode:drawDot(sp1:pos(), 3, cc.c4f(1,0,0,1))
    drawNode:addTo(layer1)
    layer1:setCameraMask(cc.CameraFlag.USER1)

    local layer2 = display.newLayer():addTo(self)
    -- 主相机sprite
    local sp2 = Util:sprite("ui/keji_kuang")
    sp2:setPosition(cc.p(360, 620))
    sp2:addTo(layer2)

    local camPos = camera:getPosition3D()
    dump(camPos, "camera position")
    dump(camera:getNodeToWorldTransform(),  "cam getNodeToWorldTransform")

    local scene = display.getRunningScene()
    local defaultCam = scene:getDefaultCamera()
    local defaultCamPos = defaultCam:getPosition3D()
    -- dump(defaultCamPos, "default camera position")
    dump(sp2:getPosition3D(), "sp2 3d position")
    dump(sp1:getPosition3D(), "sp1 3d position")
    local p = camera:project(sp1:getPosition3D())
    local rev = camera:unproject(cc.vec3(p.x, p.y, 100))
    dump(rev, "unproject")

    p.y = display.height - p.y
    dump(p, "sp1 projection position")
    local drawNode = cc.DrawNode:create()
    drawNode:drawDot(p, 3, cc.c4f(1,0,0,1))
    drawNode:addTo(self)

    -- local rad = math.rad(30)
    -- local dest = cc.mat4.createIdentity()
    -- local output = string.format("sin= %f, cos=%f", math.sin(rad), math.cos(rad))
    -- print(output)
    -- local mat4 = cc.mat4.createRotation(cc.vec3(1, 0, 0), rad, dest) -- 绕X轴旋转
    -- dump(mat4)
    

  
    self:onTouch(function(event)
        dump(event, "defaultCam touch")

        if sp2:isContain(event.x, event.y) then
            print("点击到默认视角精灵")
        end

        local nearP = cc.vec3(event.x, event.y, -1.0)
        local farP  = cc.vec3(event.x, event.y, 1.0)
        nearP = camera:unproject(nearP)
        farP  = camera:unproject(farP)
        dump(event, "点击位置")
        dump(nearP, "near point")
        dump(farP, "far point")

        local dir = cc.vec3(farP.x - nearP.x, farP.y - nearP.y, farP.z - nearP.z)
        local dist=0.0
        local ndd = dir.x * 0 + dir.y * 1 + dir.z * 0
        if ndd == 0 then
            dist=0.0
        else
            local ndo = nearP.x * 0 + nearP.y * 1 + nearP.z * 0
            dist= (0 - ndo) / ndd
        end
        
        local p =   cc.vec3(nearP.x + dist * dir.x, nearP.y + dist * dir.y, nearP.z + dist * dir.z)
        dump(p, "target pos")

        -- local p = camera:unproject(cc.vec3(event.x, event.y, 0))
        -- local p2 = camera:unproject(cc.vec3(0, 0, 0))
        -- dump(p)
        -- dump(p2)

        if sp1:isContain(event.x, event.y) then
            print("点击到玩家视角精灵")
        end

    --     -- local vec3 = cc.vec3(event.x, event.y, 0)
    --     -- local ret = cc.mat4.transformVector(mat4, vec3, dest)
    --     -- dump(event)
    --     -- dump(ret)
    end, nil, true)
end

function cls:onTouchHandler(event)
	if event.name == "began" then
	elseif event.name == "moved" then
	elseif event.name == "ended" then
	end

end

return cls

