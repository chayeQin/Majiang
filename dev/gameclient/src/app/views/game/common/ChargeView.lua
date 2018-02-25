--
-- @brief 商城
-- @author myc
-- @date 2018/2/9
--

local cls = class("ChargeView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ChargeView.csb"

cls.RESOURCE_BINDING = {
	["list_shop"] = {
		varname = "list_shop",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

function cls:onCreate()
	self.list_shop = ListView.bind(self,self.list_shop,true)
	Util:touchLayer(self)
	PopupManager:push(self)
	local list = {
		[1] = {price = "￥6", card = 6},
		[2] = {price = "￥30", card = 30},
		[3] = {price = "￥40", card = 40},
		[4] = {price = "￥98", card = 98},
		[5] = {price = "￥198", card = 198},
		[6] = {price = "￥328", card = 328},
		[7] = {price = "￥648", card = 648},
	}
	local showLst = Util:convertSubLst(list,2)
	self.list_shop:update(showLst)
end

function cls:cell(i,data)
	local node = display.newNode()
	node:size(self.list_shop:width() / 4, self.list_shop:height())
	local y = node:height() / 2
	for k,v in pairs(data) do
		local index = (i - 1) * 2 + k
		local cell = self:createCell(index,v)
		cell:addTo(node)
			:pos(0,y)
		y = 0
	end
	return node
end

function cls:createCell(index,data)
	local node = display.newNode()
	node:size(self.list_shop:width() / 4,self.list_shop:height() / 2 - 10)
	local titleBg = Util:sprite9("com/com_img_panel_celltitle",70,0,670,62)
	titleBg:size(node:width() - 10,62)
	titleBg:addTo(node)
	titleBg:pos(node:width() / 2,node:height() - titleBg:height() / 2)
	local labTitle = Util:label(Lang:format("{1}张房卡",data.card),24,cc.c3b(0xdb,0xcf,0xcf))
	labTitle:addTo(titleBg)
			:center()
	local contentBg = Util:sprite9("com/com_img_panel_cellbg",70,10,600,80)
	contentBg:size(node:width() - 10,node:height() - titleBg:height())
	contentBg:addTo(node)
	contentBg:align(display.LEFT_BOTTOM,5,0)
	local light = Util:sprite("img/big_img_tx26")
						:addTo(contentBg)
						:center(0,20)
	if index == 1 then
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center()
	elseif index == 2 then
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(-30,0)
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(30,0)
	elseif index == 3 then
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(-30,0)
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(30,0)
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(0,30)
	else
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(-30,0)
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(30,0)
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(0,30)
		local card = Util:sprite("mainscene/mainscene_img_fangka")
						:addTo(light)
						:center(0,-30)
	end
	Util:button("com/com_btn_create",handler(self,self.btnHandler),
		data.price,40)
		:scale(0.5)
		:addTo(contentBg)
		:pos(contentBg:width() / 2,30)
	return node
end

function cls:onListViewEvent(event)

end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls