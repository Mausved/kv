log = require("log")

local config = {
    host = "0.0.0.0",
    port = 8000,
    moduleName = "kv",
    kvPort = 3301
}

box.cfg { listen = config.kvPort }
box.schema.space.create("table")
box.space.table:create_index("primary", {})

local httpd = require('http.server').new(config.host, config.port, {
    log_requests = true,
    log_errors = true,
})

httpd:route({ path = '/' .. config.moduleName, method = 'POST' }, config.moduleName .. "#post")
httpd:route({ path = '/' .. config.moduleName .. '/:id', method = 'GET' }, config.moduleName .. "#get")
httpd:route({ path = '/' .. config.moduleName .. '/:id', method = 'PUT' }, config.moduleName .. "#put")
httpd:route({ path = '/' .. config.moduleName .. '/:id', method = 'DELETE' }, config.moduleName .. "#delete")

httpd:start()
