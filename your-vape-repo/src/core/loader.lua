-- Main Loader for Vape Modules
local Loader = {}
Loader.Modules = {}
Loader.Categories = {}
Loader.GitHubUser = "nilhub-crypto"
Loader.RepoName = "Aimbot-script"
Loader.Branch = "main"

-- Load a single module from GitHub
function Loader:LoadModule(path, name)
    local success, module = pcall(function()
        -- Build the URL correctly
        local url = string.format(
            'https://raw.githubusercontent.com/%s/%s/%s/your-vape-repo/src/modules/%s.lua',
            self.GitHubUser,
            self.RepoName,
            self.Branch,
            path .. "/" .. name
        )
        
        -- Fetch and load the Lua code
        local code = game:HttpGet(url)
        return loadstring(code)()
    end)
    
    if success and module then
        module.Name = name
        module.Path = path
        table.insert(self.Modules, module)
        print("✅ Loaded module: " .. name)
        return module
    else
        warn("❌ Failed to load module: " .. name)
        warn("Error: " .. tostring(module))
        return nil
    end
end

-- Load all modules from a list
function Loader:LoadModules(moduleList)
    local loaded = {}
    for _, moduleInfo in ipairs(moduleList) do
        local module = self:LoadModule(moduleInfo.path, moduleInfo.name)
        if module then
            table.insert(loaded, module)
        end
    end
    return loaded
end

-- Get module list from GitHub (optional)
function Loader:GetModuleList()
    local success, data = pcall(function()
        local url = string.format(
            'https://raw.githubusercontent.com/%s/%s/%s/your-vape-repo/src/modules/modules.json',
            self.GitHubUser,
            self.RepoName,
            self.Branch
        )
        return game:HttpGet(url)
    end)
    
    if success then
        return game:GetService("HttpService"):JSONDecode(data)
    end
    return {}
end

-- Initialize the loader with Vape API
function Loader:Initialize(api)
    self.API = api
    print("🚀 Loader initialized!")
    return self
end

return Loader
