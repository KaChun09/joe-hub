if game.PlaceId == 18517861463 then
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({Name = "KaChun | Ball Tower Defense [🎄CHRISTMAS-EVENT🎄]", HidePremium = false, SaveConfig = true, ConfigFolder = "KaChunConfig"})

    -- Values
    _G.autoAfk = true
    _G.espEnabled = false
    _G.topDownEnabled = false

    -- Functions
    function autoafk()
        while _G.autoAfk do
            game:GetService("ReplicatedStorage").Remotes.Tap:FireServer()
            wait(0.1) -- Add a small delay to prevent potential infinite loops
        end
    end

    function enableESP()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if not player.Character then continue end
                local character = player.Character
                local highlight = Instance.new("Highlight")
                highlight.Parent = character
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillTransparency = 0.5
                player.CharacterAdded:Connect(function()
                    if _G.espEnabled then
                        enableESP() -- Reapply ESP when the player respawns
                    end
                end)
            end
        end
    end

    function disableESP()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, obj in pairs(player.Character:GetChildren()) do
                    if obj:IsA("Highlight") then
                        obj:Destroy()
                    end
                end
            end
        end
    end

    function enableTopDownView()
        local camera = workspace.CurrentCamera
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")

        camera.CameraType = Enum.CameraType.Scriptable -- Set camera to scriptable mode
        camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 50, 0), rootPart.Position) -- Position camera above the character
    end

    function disableTopDownView()
        local camera = workspace.CurrentCamera
        camera.CameraType = Enum.CameraType.Custom -- Reset camera to default
    end

    -- Tabs
    local Tab = Window:MakeTab({
        Name = "AutoAFK",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Toggles
    Tab:AddToggle({
        Name = "Auto AFK",
        Default = false,
        Callback = function(Value)
            _G.autoAfk = Value
            if Value then
                autoafk() -- Start the autoafk function when toggled on
            end
        end
    })

    Tab:AddToggle({
        Name = "ESP",
        Default = false,
        Callback = function(Value)
            _G.espEnabled = Value
            if Value then
                enableESP() -- Enable ESP
            else
                disableESP() -- Disable ESP
            end
        end
    })

    Tab:AddToggle({
        Name = "Top-Down Camera View",
        Default = false,
        Callback = function(Value)
            _G.topDownEnabled = Value
            if Value then
                enableTopDownView() -- Enable top-down camera view
            else
                disableTopDownView() -- Disable top-down camera view
            end
        end
    })

end

OrionLib:Init()