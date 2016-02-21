-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	ActionsManager.registerResultHandler("dodge", onDefense);
  ActionsManager.registerResultHandler("parry", onDefense);
  ActionsManager.registerResultHandler("block", onDefense);
end

function onDefense(rSource, rTarget, rRoll)
  local rMessage = ActionsManager2.createActionMessage(rSource, rRoll);
	local nTotal = ActionsManager2.total(rRoll);
  local aAddIcons = {};

  local nTarget = tonumber((string.match(rRoll.nTarget, "%d+") or "0"));
  local sExtra = (string.match(rRoll.nTarget, "[uUfF]") or "");

  rMessage.text = string.format("%s\n%s%s%s %s(%d%s):%s",
      (string.format(rMessage.text,(rTarget and string.format(" > %s",rTarget.sName) or ""))),
      (rRoll.sWeapon or ""), 
      ((rRoll.sWeapon and rRoll.sWeapon ~= '' and rRoll.sTargetDesc and rRoll.sTargetDesc ~= '') and "\n" or ""), 
      (rRoll.sTargetDesc or ""), 
      (rRoll.nMod ~= 0 and string.format("(%d%s%d)=", nTarget, (rRoll.nMod > 0 and "+" or ""), rRoll.nMod) or ""),
      nTarget + rRoll.nMod, 
      sExtra,
      GameSystem.rollResult(nTotal, nTarget + rRoll.nMod)
  );

	if #aAddIcons > 0 then
		rMessage.icon = { rMessage.icon };
		for _,v in ipairs(aAddIcons) do
			table.insert(rMessage.icon, v);
		end
	end
	
	Comm.deliverChatMessage(rMessage);
end
