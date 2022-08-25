local _2afile_2a = "fnl/conjure-clj-additions-vanilla/additional-fns.fnl"
local _2amodule_name_2a = "conjure-clj-additions-vanilla.additional-fns"
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
local autoload = (require("conjure-clj-additions-vanilla.aniseed.autoload")).autoload
local a, eval, extract, jump, log, nrepl_action, nvim, server, state, str, text = autoload("conjure.aniseed.core"), autoload("conjure.eval"), autoload("conjure.extract"), autoload("conjure-clj-additions-vanilla.jump"), autoload("conjure.log"), autoload("conjure.client.clojure.nrepl.action"), autoload("conjure.aniseed.nvim"), autoload("conjure.client.clojure.nrepl.server"), autoload("conjure.client.clojure.nrepl.state"), autoload("conjure.aniseed.string"), autoload("conjure.text")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["eval"] = eval
_2amodule_locals_2a["extract"] = extract
_2amodule_locals_2a["jump"] = jump
_2amodule_locals_2a["log"] = log
_2amodule_locals_2a["nrepl-action"] = nrepl_action
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["server"] = server
_2amodule_locals_2a["state"] = state
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["text"] = text
local function get_current_ns_21()
  return extract.context()
end
_2amodule_2a["get-current-ns!"] = get_current_ns_21
local function to_test_ns_name(current_ns)
  if text["ends-with"](current_ns, "-test") then
    return current_ns
  else
    return (current_ns .. "-test")
  end
end
_2amodule_2a["to-test-ns-name"] = to_test_ns_name
local function get_alternate_ns_name_21()
  local current_ns = get_current_ns_21()
  if text["ends-with"](current_ns, "-test") then
    return string.sub(current_ns, 1, -6)
  else
    return (current_ns .. "-test")
  end
end
_2amodule_2a["get-alternate-ns-name!"] = get_alternate_ns_name_21
local function remove_ns_21()
  return eval.command("(remove-ns (symbol (str *ns*)))")
end
_2amodule_2a["remove-ns!"] = remove_ns_21
local function cleanup_ns_21()
  return eval.command(("((fn clenaup-ns [ns-sym]" .. "  (when-let [ns (find-ns ns-sym)]" .. "    (run! #(try (ns-unalias ns %) (catch Throwable _)) (keys (ns-aliases ns)))" .. "    (run! #(try (ns-unmap ns %)   (catch Throwable _)) (keys (ns-interns ns)))" .. "    (->> (ns-refers ns)" .. "         (remove (fn [[_ v]] (.startsWith (str v) \"#'clojure.core/\")))" .. "         (map key)" .. "         (run! #(try (ns-unmap ns %) (catch Throwable _))))))" .. "   (symbol (str *ns*)))"))
end
_2amodule_2a["cleanup-ns!"] = cleanup_ns_21
local function run_test_ns_tests_21()
  local current_ns = get_current_ns_21()
  if text["ends-with"](current_ns, "-test") then
    return nrepl_action["run-current-ns-tests"]()
  else
    return nrepl_action["run-alternate-ns-tests"]()
  end
end
_2amodule_2a["run-test-ns-tests!"] = run_test_ns_tests_21
local function jump_to_first_failing_21()
  return jump["jump-to-last-failing-test!"]()
end
_2amodule_2a["jump-to-first-failing!"] = jump_to_first_failing_21
local function jump_to_alternate_ns_21()
  local to_find = get_alternate_ns_name_21()
  return jump["jump-to-buffer-and-line!"](jump["find-buffer-to-jump!"]({namespace = to_find}))
end
_2amodule_2a["jump-to-alternate-ns!"] = jump_to_alternate_ns_21
return _2amodule_2a