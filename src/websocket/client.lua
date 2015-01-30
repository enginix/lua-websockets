local socket = require'socket'
local sync = require'websocket.sync'
local tools = require'websocket.tools'

local new = function(ws)
  ws =  ws or {}
  local self = {}
  
  self.sock_connect = function(self,host,port)
    self.sock = socket.tcp()
    if ws.timeout ~= nil then
      self.sock:settimeout(ws.timeout)
    end
    if type(ws.ua) == "string" then
        self.ua = ws.ua
    end
    local _,err = self.sock:connect(host,port)
    if err then
      self.sock:close()
      return nil,err
    end
  end
  
  self.sock_send = function(self,...)
    return self.sock:send(...)
  end
  
  self.sock_receive = function(self,...)
    return self.sock:receive(...)
  end
  
  self.sock_close = function(self)
    self.sock:shutdown()
    self.sock:close()
  end
  
  self = sync.extend(self)
  self.state = 'CLOSED'
  return self
end


return {
  new = new,
  sync = new,
  ev = require'websocket.client_ev',
  --copas = require'websocket.client_copas'
}
