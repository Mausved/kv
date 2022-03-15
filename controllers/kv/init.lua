local utils = require("utils")
local kv = {}

function kv.get(self)
    local id = tonumber(self:stash('id'))
    if utils.isNullType(id) then
        return utils.writeError(self, utils.status_404)
    end

    local data = box.space.table:get(id)

    if utils.isNullType(data) then
        return utils.writeError(self, utils.status_404)
    end

    return utils.writeBody(self, status_200, data)
end

function kv.post(self)
    local status, body = pcall(self.json, self);
    if status == false then
        return utils.writeError(self, utils.status_400)
    end

    local id = tonumber(body.key)
    if utils.isNullType(id) then
        return utils.writeError(self, utils.status_404)
    end

    local checkValue = box.space.table:get(id)
    if utils.isNullType(checkValue) == false then
        return utils.writeError(self, utils.status_409)
    end

    box.space.table:insert { id, body.value }

    local data = box.space.table:get(id)
    return utils.writeBody(self, status_200, data)
end

function kv.delete(self)
    local id = tonumber(self:stash('id'))
    if utils.isNullType(id) then
        return utils.writeError(self, utils.status_404)
    end

    local data = box.space.table:get(id)
    if utils.isNullType(data) then
        return utils.writeError(self, utils.status_404)
    end

    box.space.table:delete(id)

    return utils.writeSuccess(self)
end

function kv.put(self)
    local status, body = pcall(self.json, self);
    if status == false then
        return utils.writeError(self, utils.status_400)
    end

    local id = tonumber(self:stash('id'))
    if utils.isNullType(id) then
        return utils.writeError(self, utils.status_404)
    end

    local checkValue = box.space.table:get(id)
    if utils.isNullType(checkValue) then
        return utils.writeError(self, utils.status_404)
    end

    local data = body.value
    box.space.table:replace { id, data }

    local data = box.space.table:get(id)
    return utils.writeBody(self, status_200, data)
end

return kv