local fs = require 'utils.fs'

local function make_package_json_util(file)
  return {
    file = file,
    has_key = function(key)
      return file.data ~= nil and file.data[key] ~= nil
    end,
    has_dependency = function(name)
      return file.data ~= nil and file.data.dependencies ~= nil and file.data.dependencies[name] ~= nil
    end,
    has_dev_dependency = function(name)
      return file.data ~= nil and file.data.devDependencies ~= nil and file.data.devDependencies[name] ~= nil
    end,
  }
end

local M = {}

local cached = nil
M.get_package_json = function(parent)
  local path = fs.join(parent, 'package.json')
  if not cached or cached.file.path ~= path then
    cached = make_package_json_util(fs.read_json_sync(path))
  end
  return cached
end

M.condition = function(opts)
  return function(utils)
    if utils.root_has_file(opts.config_files) then
      return true
    end
    local package_json = M.get_package_json(opts.root())
    if not package_json then
      return false
    end
    return package_json.has_key(opts.package_json.config_key)
        or package_json.has_dependency(opts.package_json.dependency)
        or package_json.has_dev_dependency(opts.package_json.dependency)
  end
end

return M
