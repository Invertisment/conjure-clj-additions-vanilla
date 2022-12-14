local _2afile_2a = "fnl/conjure-clj-additions-vanilla/jump.fnl"
local _2amodule_name_2a = "conjure-clj-additions-vanilla.jump"
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
local a, buffer, client, editor, fennel, fs, nvim, str = autoload("conjure-clj-additions-vanilla.aniseed.core"), autoload("conjure.buffer"), autoload("conjure.client"), autoload("conjure.editor"), autoload("fennel"), autoload("conjure.fs"), autoload("conjure.aniseed.nvim"), autoload("conjure.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["buffer"] = buffer
_2amodule_locals_2a["client"] = client
_2amodule_locals_2a["editor"] = editor
_2amodule_locals_2a["fennel"] = fennel
_2amodule_locals_2a["fs"] = fs
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
local function execution_separator_3f(line)
  return string.match(line, "^; [-]")
end
_2amodule_2a["execution-separator?"] = execution_separator_3f
local function run_ns_tests_find_ns(line)
  local found_namespace = string.match(line, "; run[-]ns[-]tests: ([^\n ]+)")
  if found_namespace then
    return {namespace = found_namespace}
  else
    return nil
  end
end
_2amodule_2a["run-ns-tests-find-ns"] = run_ns_tests_find_ns
--[[ (run-ns-tests-find-ns "; run-ns-tests: core.core-test
") ]]--
--[[ (run-ns-tests-find-ns "; run-ns-tests: core.core-test") ]]--
--[[ (run-ns-tests-find-ns "; run-current-test: partial-test
") ]]--
--[[ (run-ns-tests-find-ns "; hi: partial-test
") ]]--
local function run_current_test_find_suite_name(failure_line)
  local found_suite_name = (string.match(failure_line, "; FAIL in [(]([^ ]+)[)]") or string.match(failure_line, "; ERROR in [(]([^ ]+)[)]"))
  local function _2_()
    if found_suite_name then
      return {["suite-name"] = found_suite_name}
    else
      return nil
    end
  end
  return _2_()
end
_2amodule_2a["run-current-test-find-suite-name"] = run_current_test_find_suite_name
--[[ (run-current-test-find-suite-name "; FAIL in (my-test) (form-init3584826820959655573.clj:1664)
") ]]--
--[[ (run-current-test-find-suite-name "; ERROR in (my-test) (form-init3584826820959655573.clj:1664)
") ]]--
local function failure_file_line(failure_line)
  local found_line = tonumber((string.match(failure_line, "; FAIL in [^ ]+ [^:]+:([0-9]+)") or string.match(failure_line, "; ERROR in [^ ]+ [^:]+:([0-9]+)")))
  if found_line then
    return {["failed-line"] = found_line}
  else
    return nil
  end
end
_2amodule_2a["failure-file-line"] = failure_file_line
--[[ (failure-file-line "; FAIL in (my-test) (form-init3584826820959655573.clj:1664)
") ]]--
--[[ (failure-file-line "; FAIL in (my-test) (form-init3584826820959655573.clj)
") ]]--
--[[ (failure-file-line "; ERROR in (my-test) (form-init3584826820959655573.clj:1664)
") ]]--
local function str_replace(txt, find, replacement)
  local _5_ = string.gsub(txt, find, replacement)
  return _5_
end
_2amodule_2a["str-replace"] = str_replace
--[[ (str-replace "txt" "x" "u") ]]--
--[[ (str-replace "{:test 6, :pass 19, :fail 0, :error 0, :type :summary}" "," " ") ]]--
local function parse_obj(line)
  local output = nil
  local function _6_()
    local form = fennel.eval(str_replace(line, ",", ""))
    output = form
    return nil
  end
  pcall(_6_)
  return output
end
_2amodule_2a["parse-obj"] = parse_obj
--[[ (parse-obj "{:res :ok :id 1}") ]]--
--[[ (parse-obj "{:res :something-else :id 1}") ]]--
--[[ (parse-obj "{:res NOPE :ok :id 1}") ]]--
--[[ (parse-obj ":hello") ]]--
--[[ (fennel.eval (str-replace "{:test 6 :pass 19 :fail 0 :error 0 :type :summary}" "," " ")) ]]--
--[[ (parse-obj "{:test 6, :pass 19, :fail 0, :error 0, :type :summary}") ]]--
local function drop_until_match(s, match_str, match_str_drop_len)
  local index = string.find(s, match_str)
  if index then
    return string.sub(s, (index + match_str_drop_len))
  else
    return nil
  end
end
_2amodule_2a["drop-until-match"] = drop_until_match
--[[ (drop-until-match ";; aa{:res :ok :id 1}
" "aa{" 2) ]]--
--[[ (drop-until-match ";; aa{:res :ok :id 1}
" "aa{" 1) ]]--
local function conjure_log_buf_name()
  return str.join({"conjure-log-", nvim.fn.getpid(), client.get("buf-suffix")})
end
_2amodule_2a["conjure-log-buf-name"] = conjure_log_buf_name
local function upsert_buf(buf_name)
  return buffer["upsert-hidden"](buf_name)
end
_2amodule_2a["upsert-buf"] = upsert_buf
local function empty_3f(li)
  return (0 == #li)
end
_2amodule_2a["empty?"] = empty_3f
--[[ (empty? {}) ]]--
--[[ (empty? ["hi"]) ]]--
local function chunk_by_header(f, li)
  local out
  local function _8_(out0, item)
    local current_group = a.get(out0, "current-group")
    local output = a.get(out0, "output")
    if f(item) then
      if not empty_3f(current_group) then
        table.insert(output, current_group)
      else
      end
      return a.assoc(out0, "current-group", {item})
    else
      table.insert(current_group, item)
      return out0
    end
  end
  out = a.reduce(_8_, {output = {}, ["current-group"] = {}}, li)
  if empty_3f(a.get(out, "current-group")) then
    return a.get(out, "output")
  else
    table.insert(a.get(out, "output"), a.get(out, "current-group"))
    return a.get(out, "output")
  end
end
_2amodule_2a["chunk-by-header"] = chunk_by_header
--[[ (chunk-by-header (fn [item] (= item 2)) [1 2 3 4 5 6 7 2 8 9 2 0 2]) ]]--
--[[ (chunk-by-header (fn [item] (= item 2)) [1 2 3 4 5 6 7 2 8 9 2 0]) ]]--
--[[ (chunk-by-header (fn [item] (= item 2)) [2 3 2 5]) ]]--
--[[ (chunk-by-header (fn [item] (= item 2)) [2 2]) ]]--
local function take_last_matching_chunk(chunk_boundary_fn, chunk_match_fn, li)
  return a.last(a.filter(chunk_match_fn, chunk_by_header(chunk_boundary_fn, li)))
end
_2amodule_2a["take-last-matching-chunk"] = take_last_matching_chunk
--[[ (take-last-matching-chunk (fn [item] (= item 2)) [1 2 3 4 5 6 7 2 8 9 2 0 2]) ]]--
--[[ (take-last-matching-chunk (fn [item] (= item 2)) [1 2 3 4 5 6 7 2 8 9 2 0]) ]]--
--[[ (take-last-matching-chunk (fn [item] (= item 2)) [2 3 2 5]) ]]--
--[[ (take-last-matching-chunk (fn [item] (= item 2)) [2 2]) ]]--
local function to_chunks(lines)
  local function _12_(_241)
    return execution_separator_3f(_241)
  end
  return chunk_by_header(_12_, lines)
end
_2amodule_2a["to-chunks"] = to_chunks
local function conjure_log_buf_content_21()
  return vim.api.nvim_buf_get_lines(upsert_buf(conjure_log_buf_name()), 0, -1, true)
end
_2amodule_2a["conjure-log-buf-content!"] = conjure_log_buf_content_21
--[[ (conjure-log-buf-content!) ]]--
local function filter_test_outputs(lines)
  return a.last(to_chunks(lines))
end
_2amodule_2a["filter-test-outputs"] = filter_test_outputs
--[[ (filter-test-outputs (conjure-log-buf-content!)) ]]--
--[[ (def single-testsuite ["; --------------------------------------------------------------------------------"
 "; run-current-test: testsuite-test"
 "; FAIL in (partial-refunds-test) (form-init2746081655060792820.clj:100)"
 "; --------------------------------------------------------------------------------"
 "; run-current-test: testsuite-test"
 ";"
 "; FAIL in (partial-refunds-test) (form-init3584826820959655573.clj:124)"
 ";"
 "; Ran 6 tests containing 19 assertions."
 "; 1 failures, 0 errors."
 "{:test 6, :pass 18, :fail 1, :error 0, :type :summary}"]) ]]--
--[[ (def namespace-testsuite ["; --------------------------------------------------------------------------------"
 "; run-ns-tests: core.core-test"
 ";"
 "; Testing core.core-test"
 ";"
 "; FAIL in (partial-refunds-test) (form-init2746081655060792820.clj:100)"
 "; FAIL in (partial-refunds-test) (form-init2746081655060792820.clj:189)"
 "; FAIL in (partial-refunds-test) (form-init2746081655060792820.clj:1664)"
 ";"
 "; Ran 6 tests containing 19 assertions."
 "; 1 failures, 0 errors."
 "{:test 6, :pass 18, :fail 1, :error 0, :type :summary}"]) ]]--
--[[ (def ok-testsuite ["; --------------------------------------------------------------------------------"
 "; run-ns-tests: core.core-test"
 ";"
 "; Testing core.core-test"
 ";"
 "; Ran 7 tests containing 19 assertions."
 "; 0 failures, 0 errors."
 "{:test 7, :pass 19, :fail 0, :error 0, :type :summary}"
 "; --------------------------------------------------------------------------------"
 "; run-ns-tests: core.core-test"
 ";"
 "; Testing core.core-test"
 ";"
 "; Ran 7 tests containing 19 assertions."
 "; 0 failures, 0 errors."
 "{:test 7, :pass 19, :fail 0, :error 0, :type :summary}"]) ]]--
--[[ (filter-test-outputs single-testsuite) ]]--
--[[ (filter-test-outputs namespace-testsuite) ]]--
--[[ (filter-test-outputs ok-testsuite) ]]--
--[[ (filter-test-outputs (a.concat namespace-testsuite ok-testsuite)) ]]--
local function first_error_jump(test_result_chunk)
  local output
  local function _13_(out, item)
    return a.merge(item, out)
  end
  local function _14_(line)
    if ("string" == type(line)) then
      local failure_line_details = failure_file_line(line)
      return a.merge({}, run_current_test_find_suite_name(line), run_ns_tests_find_ns(line), failure_line_details)
    else
      return nil
    end
  end
  output = a.reduce(_13_, {}, a.map(_14_, test_result_chunk))
  if a.get(output, "failed-line") then
    return output
  else
    return nil
  end
end
_2amodule_2a["first-error-jump"] = first_error_jump
--[[ (first-error-jump (filter-test-outputs namespace-testsuite)) ]]--
--[[ (first-error-jump (filter-test-outputs single-testsuite)) ]]--
--[[ (first-error-jump (filter-test-outputs (conjure-log-buf-content!))) ]]--
local function ns__3efilename(ns_name)
  return (string.gsub(string.gsub(ns_name, "-", "_"), "[.]", "/") .. ".clj")
end
_2amodule_2a["ns->filename"] = ns__3efilename
--[[ (ns->filename "core.core-test") ]]--
--[[ (ns->filename "core.co-----re-tes-t") ]]--
local function buffer_details_21(buf_id)
  return {["buffer-id"] = buf_id, ["buffer-name"] = nvim.buf_get_name(buf_id)}
end
_2amodule_2a["buffer-details!"] = buffer_details_21
--[[ (nvim.buf_get_name 0) ]]--
local function get_buffers_21()
  return a.map(buffer_details_21, vim.api.nvim_list_bufs())
end
_2amodule_2a["get-buffers!"] = get_buffers_21
--[[ (get-buffers!) ]]--
--[[ (def sample-buffers [{:buffer-id 1 :buffer-name "/home/_/.config/nvim/fnl/_/core.fnl"}
 {:buffer-id 3
  :buffer-name "/home/_/.config/nvim/fnl/_/conjure-log-683854.fnl"}
 {:buffer-id 131 :buffer-name "test/clj/core/core_test.clj"}
 {:buffer-id 13 :buffer-name "/home/_/.config/nvim/fnl/_/core.core-test"}]) ]]--
local function get_current_buffer_21()
  return buffer_details_21(nvim.buf.nr())
end
_2amodule_2a["get-current-buffer!"] = get_current_buffer_21
local function find_matching_buffer(expected_ns, buffers)
  local to_find = ns__3efilename(expected_ns)
  local function _17_(desc)
    local id = a.get(desc, "buffer-id")
    local name = a.get(desc, "buffer-name")
    return string.find(name, to_find)
  end
  return a.first(a.filter(_17_, buffers))
end
_2amodule_2a["find-matching-buffer"] = find_matching_buffer
--[[ (find-matching-buffer "core.core-test" sample-buffers) ]]--
--[[ (find-matching-buffer "core.core-test2" sample-buffers) ]]--
--[[ (find-matching-buffer "core.core-test" (get-buffers!)) ]]--
local function find_buffer_to_jump_21(buf_info)
  local failing_namespace = a.get(buf_info, "namespace")
  local failing_line = a.get(buf_info, "failed-line")
  if failing_namespace then
    local found = find_matching_buffer(failing_namespace, get_buffers_21())
    if found then
      return a.merge(found, buf_info)
    else
      return nil
    end
  else
    if failing_line then
      return a.merge(get_current_buffer_21(), buf_info)
    else
      return nil
    end
  end
end
_2amodule_2a["find-buffer-to-jump!"] = find_buffer_to_jump_21
local function query_buffers_and_find_buffer_to_jump_21()
  return find_buffer_to_jump_21(first_error_jump(filter_test_outputs(conjure_log_buf_content_21())))
end
_2amodule_2a["query-buffers-and-find-buffer-to-jump!"] = query_buffers_and_find_buffer_to_jump_21
--[[ (query-buffers-and-find-buffer-to-jump!) ]]--
local function edit_buffer_21(buffer_name)
  if a["string?"](buffer_name) then
    return nvim.ex.edit(fs["localise-path"](buffer_name))
  else
    return nil
  end
end
_2amodule_2a["edit-buffer!"] = edit_buffer_21
local function go_to_first_char_21()
  return vim.api.nvim_exec(":normal! _", false)
end
_2amodule_2a["go-to-first-char!"] = go_to_first_char_21
local function go_to_line_21(buffer_name, line)
  edit_buffer_21(buffer_name)
  editor["go-to"](buffer_name, line, 1)
  return go_to_first_char_21()
end
_2amodule_2a["go-to-line!"] = go_to_line_21
--[[ (go-to-line! (nvim.buf_get_name (nvim.buf.nr)) 249) ]]--
local function go_to_buffer_21(buffer_name, buffer_id)
  return edit_buffer_21(buffer_name)
end
_2amodule_2a["go-to-buffer!"] = go_to_buffer_21
local function go_to_first_readable_char_21(buffer_id)
  return vim.api.nvim_command("call search('[^ \9]')")
end
_2amodule_2a["go-to-first-readable-char!"] = go_to_first_readable_char_21
local function jump_21(buffer_and_line_info)
  local failed_line = a.get(buffer_and_line_info, "failed-line")
  if failed_line then
    return go_to_line_21(a.get(buffer_and_line_info, "buffer-name"), failed_line)
  else
    return go_to_buffer_21(a.get(buffer_and_line_info, "buffer-name"), a.get(buffer_and_line_info, "buffer-id"))
  end
end
_2amodule_2a["jump!"] = jump_21
--[[ (jump! {:buffer-id 26
 :buffer-name "/home/user/.config/nvim/fnl/_/core/core_test.clj"
 :failed-line 10
 :namespace "core.core-test"
 :suite-name "my-failing-testsuite"}) ]]--
--[[ (jump! {:buffer-id 1
 :buffer-name "/home/user/.config/nvim/fnl/_/core.fnl"
 :failed-line 270
 :namespace "core.core-test"
 :suite-name "my-failing-testsuite"}) ]]--
local function jump_to_buffer_and_line_21(to_jump)
  if to_jump then
    return jump_21(to_jump)
  else
    return nvim.echo("Nothing to jump to")
  end
end
_2amodule_2a["jump-to-buffer-and-line!"] = jump_to_buffer_and_line_21
local function jump_to_last_failing_test_21()
  return jump_to_buffer_and_line_21(query_buffers_and_find_buffer_to_jump_21())
end
_2amodule_2a["jump-to-last-failing-test!"] = jump_to_last_failing_test_21
--[[ (jump-to-last-failing-test!) ]]--
return _2amodule_2a