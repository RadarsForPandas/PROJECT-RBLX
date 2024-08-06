local GamesFol = {
    {
        PlaceIDs = {301549746},
        ScriptURL = "https://raw.githubusercontent.com/RadarsForPandas/PROJECT-RBLX/main/Games/CBRA"
    }
}

local function loadGameScript(placeID)
    for _, game in ipairs(GamesFol) do
        for _, id in ipairs(game.PlaceIDs) do
            if id == placeID then
         --       print("Loading script for place ID: " .. id)
                local scriptContent = game:HttpGet(game.ScriptURL)
                loadstring(scriptContent)()
                return
            end
        end
    end
--    print("No script found for place ID: " .. placeID)
end

local placeID = game.PlaceId
loadGameScript(placeID)
