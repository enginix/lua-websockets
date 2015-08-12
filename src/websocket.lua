local frame = require'websocket.frame'

return setmetatable({
  CONTINUATION = frame.CONTINUATION,
  TEXT = frame.TEXT,
  BINARY = frame.BINARY,
  CLOSE = frame.CLOSE,
  PING = frame.PING,
  PONG = frame.PONG
}, {__index = function(self, name)
  if name == 'client' or name == 'server' then
	local backend = require("websocket." .. name)
    self[name] = backend
	return backend
  end
end})
