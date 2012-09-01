
local function IsFriend(name)
	for i=1,GetNumFriends() do if GetFriendInfo(i) == name then return true end end
	if IsInGuild() then for i=1, GetNumGuildMembers() do if GetGuildRosterInfo(i) == name then return true end end end
end


local f = CreateFrame("Frame")
f:RegisterEvent("PARTY_INVITE_REQUEST")
f:SetScript("OnEvent", function(frame, event, name)
	if IsFriend(name) then
		for i=1,STATICPOPUP_NUMDIALOGS do
			local frame = getglobal("StaticPopup"..i)
			if frame:IsVisible() and frame.which == "PARTY_INVITE" then StaticPopup_OnClick(frame, 1) end
		end
	else SendWho(string.join("", "n-\"", name, "\"")) end
end)


StaticPopupDialogs["LOOT_BIND"].OnCancel = function(self, slot)
	if GetNumGroupMembers() == 0 then ConfirmLootSlot(slot) end
end


local triggers = {
	["Teleportation to the cannon will cost:"] = true,
	["Travel to the faire staging area will cost:"] = true,
}
local f = CreateFrame("Frame")
f:RegisterEvent("GOSSIP_CONFIRM")
f:SetScript("OnEvent", function(self, event, _, text)
	if not triggers[text] then return end
	local frame = StaticPopup1
	if frame.which == "GOSSIP_CONFIRM" and frame:IsVisible() then
		StaticPopup_OnClick(frame, 1)
	end
end)
