local json = require("json")

local utils = {}

utils.OK = "OK"
utils.FAIL = "FAIL"

utils.status_200 = 200
utils.status_400 = 400
utils.status_404 = 404
utils.status_409 = 409

utils.result = {
    status = "",
}

function utils.isNullType(obj)
    if type(obj) == "nil" then
        return true
    end
    return false
end

function utils.writeBody(self, code, body)
    local resp = self:render({ text = json.encode({key=body[1], value=body[2]}) })
    resp.status = code
    return resp
end

function utils.writeStatus(self, code, body)
    local resp = self:render({ text = json.encode(body) })
    resp.status = code
    return resp
end

function utils.writeSuccess(self)
    local res = utils.result
    res.status = utils.OK
    return utils.writeStatus(self, utils.status_200, res)
end

function utils.writeError(self, code)
    local res = utils.result
    res.status = utils.FAIL
    return utils.writeStatus(self, code, res)
end

return utils