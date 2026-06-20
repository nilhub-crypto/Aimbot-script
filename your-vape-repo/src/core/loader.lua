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
        local url = string.format(
            'https://raw.githubusercontent.com/%s/%s/%s/your-vape-repo/src/modules/%s.lua',
            self.GitHubUser,
            self.RepoName,
            self.Branch,
            path
        )
        return loadstring(game:HttpGet(url))()
    end)
    
    if success and module then
        module.Name = name
        module.Path = path
        table.insert(self.Modules, module)
        return module
    else
        warn("Failed to load module: " .. name)
        return nil
    end
end

-- Batch load modules from a list
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

-- Get module list from GitHub
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

return Loader
