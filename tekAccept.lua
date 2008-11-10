
local function IsFriend(name)
	for i=1,GetNumFriends() do if GetFriendInfo(i) == name then return true end end
	if IsInGuild() then for i=1, GetNumGuildMembers() do if GetGuildRosterInfo(i) == name then return true end end end
end


local f = CreateFrame("Frame")
f:RegisterEvent("PARTY_INVITE_REQUEST")
f:SetScript("OnEvent", function(frame, event, name)
	if IsFriend(name) then
		AcceptGroup()
		for i=1,STATICPOPUP_NUMDIALOGS do
			local frame = getglobal("StaticPopup"..i)
			if frame:IsVisible() and frame.which == "PARTY_INVITE" then frame:Hide() end
		end
	else SendWho(string.join("", "n-\"", name, "\"")) end
end)


StaticPopupDialogs["LOOT_BIND"].OnCancel = function(self, slot)
	if GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 then ConfirmLootSlot(slot) end
end
