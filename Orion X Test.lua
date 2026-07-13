local OrionLib = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/BlizTBr/scripts/main/Orion%20X"
))()

local Window = OrionLib:MakeWindow({
	Name = "Orion X - Dynamic List Test",
	HidePremium = true,
	SaveConfig = false,
	IntroEnabled = false,
	FreeMouse = true,
})

local ControlsTab = Window:MakeTab({
	Name = "Dynamic List",
	Icon = "list",
	PremiumOnly = false,
})

local Controls = ControlsTab:AddSection({
	Name = "List controls",
})

local Items = ControlsTab:AddSection({
	Name = "Items",
})

local buttons = {}
local nextId = 1
local counterLabel = Controls:AddLabel("0 visible items")

local function updateCounter()
	counterLabel:Set(string.format("%d visible items", #buttons))
end

local function addItem()
	local id = nextId
	nextId += 1

	local button
	button = Items:AddButton({
		Name = string.format("Dynamic button %02d", id),
		Icon = "mouse-pointer-click",
		Callback = function()
			for index, item in ipairs(buttons) do
				if item == button then
					table.remove(buttons, index)
					break
				end
			end
			button:Destroy()
			updateCounter()
		end,
	})

	table.insert(buttons, button)
	updateCounter()
end

local function removeLast()
	local button = table.remove(buttons)
	if button then
		button:Destroy()
		updateCounter()
	end
end

Controls:AddButton({
	Name = "Add 10 buttons",
	Icon = "plus",
	Callback = function()
		for _ = 1, 10 do
			addItem()
		end
	end,
})

Controls:AddButton({
	Name = "Remove last button",
	Icon = "minus",
	Callback = removeLast,
})

Controls:AddButton({
	Name = "Clear list",
	Icon = "trash-2",
	Callback = function()
		while #buttons > 0 do
			removeLast()
		end
	end,
})

for _ = 1, 40 do
	addItem()
end

Window:AddConfigTab()
