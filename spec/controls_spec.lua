describe('controls persistence', function()
  local controls
  local fs

  before_each(function()
    local data = {}
    fs = {
      write = function(name, content) data[name] = content end,
      read = function(name) return data[name] end
    }
    rawset(_G, 'love', {filesystem = fs})
    package.loaded['controls'] = nil
    controls = require('controls')
    controls.load()
  end)

  it('saves and loads bindings', function()
    controls.set('action', 'space')
    package.loaded['controls'] = nil
    controls = require('controls')
    rawset(_G, 'love', {filesystem = fs})
    controls.load()
    assert.are.equal('space', controls.get('action'))
  end)

  it('rejects conflicting assignments', function()
    local ok, conflict = controls.set('up', controls.get('down'))
    assert.is_false(ok)
    assert.are.equal('down', conflict)
  end)
end)
