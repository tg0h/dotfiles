describe('test toggle-api', function()
  local MODULE = 'toggle-api'
  describe('#find_target_file', function()
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
  end)
end)
