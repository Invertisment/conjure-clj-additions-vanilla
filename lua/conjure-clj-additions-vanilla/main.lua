local _2afile_2a = "fnl/conjure-clj-additions-vanilla/main.fnl"
local _2amodule_name_2a = "conjure-clj-additions-vanilla.main"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local bridge, nvim, str = require("conjure.bridge"), require("conjure.aniseed.nvim"), require("conjure.aniseed.string")
do end (_2amodule_locals_2a)["bridge"] = bridge
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
local function provide_fn_21(fn_name, ns, f)
  return nvim.ex.command_(("-range " .. fn_name), bridge["viml->lua"](ns, f, {}))
end
_2amodule_2a["provide-fn!"] = provide_fn_21
local function on_filetype()
  provide_fn_21("CcavNsJumpToAlternate", "conjure-clj-additions-vanilla.additional-fns", "jump-to-alternate-ns!")
  provide_fn_21("CcavRunTestsInTestNs", "conjure-clj-additions-vanilla.additional-fns", "run-test-ns-tests!")
  provide_fn_21("CcavJumpToFailingCljTest", "conjure-clj-additions-vanilla.additional-fns", "jump-to-first-failing!")
  provide_fn_21("CcavNsRemove", "conjure-clj-additions-vanilla.additional-fns", "remove-ns!")
  return provide_fn_21("CcavNsCleanup", "conjure-clj-additions-vanilla.additional-fns", "cleanup-ns!")
end
_2amodule_2a["on-filetype"] = on_filetype
local function init_mappings_21()
  nvim.ex.augroup("jump_to_clj_test_init_filetypes")
  nvim.ex.autocmd_()
  nvim.ex.autocmd("FileType", str.join(",", {"clojure"}), bridge["viml->lua"]("conjure-clj-additions-vanilla.main", "on-filetype", {}))
  return nvim.ex.augroup("END")
end
_2amodule_2a["init-mappings!"] = init_mappings_21
local function init()
  return init_mappings_21()
end
_2amodule_2a["init"] = init
return _2amodule_2a