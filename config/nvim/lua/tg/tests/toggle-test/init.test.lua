describe('test toggle-test', function()
  local MODULE = 'toggle-test'
  describe('#find_target_file', function()
    -- it('should have lots of features', function()
    --   -- deep check comparisons!
    --   assert.are.same({ table = 'great' }, { table = 'great' })
    --
    --   -- or check by reference!
    --   assert.are_not.equal({ table = 'great' }, { table = 'great' })
    --
    --   assert.truthy('this is a string') -- truthy: not false or nil
    --
    --   assert.True(1 == 1)
    --   assert.is_true(1 == 1)
    --
    --   assert.falsy(nil)
    --   assert.has_error(function() error('Wat') end, 'Wat')
    -- end)
    --
    -- it(
    --   'should provide some shortcuts to common functions',
    --   function() assert.are.unique({ { thing = 1 }, { thing = 2 }, { thing = 3 } }) end
    -- )
    --
    it('should find the target file - if current file is source file, it goes to test file', function()
      local M = require(MODULE)
      local utils = require('tg.utils')
      local dirname = '/src/repo/packages/common-services/services/fooService'
      local basename = 'FooService.ts'
      local TARGET_PATH = '/src/repo/packages/common-services/tests/services/fooService/FooService.test.ts'
      stub(utils, 'is_file_exist', function(potential_match_path)
        if potential_match_path == TARGET_PATH then return true end
      end)

      local target_file = M.find_target_file(dirname, basename)

      assert(target_file == TARGET_PATH)
    end)

    it('should find the target file - in lua, if current file is source file, it goes to test file', function()
      local M = require(MODULE)
      local utils = require('tg.utils')
      local dirname = '/src/repo/packages/common-services/services/fooService'
      local basename = 'FooService.lua'
      local TARGET_PATH = '/src/repo/packages/common-services/tests/services/fooService/FooService.test.lua'
      stub(utils, 'is_file_exist', function(potential_match_path)
        if potential_match_path == TARGET_PATH then return true end
      end)

      local target_file = M.find_target_file(dirname, basename)

      assert(target_file == TARGET_PATH)
    end)

    it('should find the target file - if current file is test file, it goes to source file', function()
      local M = require(MODULE)
      local utils = require('tg.utils')
      local dirname = '/src/repo/packages/common-services/tests/services/fooService'
      local basename = 'FooService.test.ts'
      local TARGET_PATH = '/src/repo/packages/common-services/services/fooService/FooService.ts'
      stub(utils, 'is_file_exist', function(potential_match_path)
        if potential_match_path == TARGET_PATH then return true end
      end)

      local target_file = M.find_target_file(dirname, basename)

      assert(target_file == TARGET_PATH)
    end)

    it('should return nil if current file is not in the configured packages', function()
      local M = require(MODULE)
      local dirname = '/src/repo/packages/FOO_PACKAGE/tests/services/fooService'
      local basename = 'FooService.test.ts'
      local TARGET_PATH = '/src/repo/packages/common-services/services/fooService/FooService.ts'
      -- stub(M, 'is_file_exist', function(potential_match_path)
      --   if potential_match_path == TARGET_PATH then return true end
      -- end)

      local target_file = M.find_target_file(dirname, basename)

      assert.are.same(target_file, nil)
    end)

    -- it('should have mocks and spies for functional tests', function()
    --   local thing = require('inits')
    --   spy.on(thing, 'greet')
    --   thing.greet('Hi!')
    --
    --   assert.spy(thing.greet).was.called()
    --   assert.spy(thing.greet).was.called_with('Hi!')
    -- end)
  end)

  describe('#is_test_file', function()
    local M = require(MODULE)

    it('should detect a test file', function()
      local is_test_file = M.is_test_file('/folder/service.test.lua')
      assert.truthy(is_test_file)
    end)

    it('should detect a non-test file', function()
      local is_test_file = M.is_test_file('/folder/toggle-test.lua')
      assert.falsy(is_test_file)
    end)
  end)
end)
