## Conjure Clojure additions vanilla (no nREPL)

Provides two modes to jump to failing test and execute tests (functions have to be mapped manually):
1. Conjure's original mode -- limited jumping but more basic setup and doesn't require to add nREPL in your `:dev` deps

Provides these additional helpers:
```
:CcavNsCleanup         // Clean current ns (doesn't break the ns that imports current ns)
:CcavNsRemove          // Run `remove-ns` on the current namespace
:CcavNsJumpToAlternate // Jumps to `-test` or to regular ns depending on which one you're located in
```

It's based on [Conjure](https://github.com/Olical/conjure/) and requires it to operate (strongly coupled, parses the log output).
Mostly useful when editing Clojure.

## Conjure-based basic tests (run tests and output to log)

You can use these functions to bind to your wanted keys:
```
:CcavRunTestsInTestNs     // Run tests from test ns regardless if you're in test or in main ns (doesn't parse exceptions)
:CcavJumpToFailingCljTest // Jump to first failed test
```

### `CcavJumpToFailingCljTest`
This function allows finding first failing test when executing tests.

Example binding:
```
autocmd FileType clojure nnoremap <silent> <localleader>tf :CcaJumpToFailingCljTest<CR>
```

This function allows two jumping modes:
1. When executing all namespace's tests it jumps to the namespace and the line
2. When executing single test suite via `:ConjureCljRunCurrentTest` it jumps only to the line

#### Usage (whole test namespace)
1. Run tests via `<locallleader>tn` or `<locallleader>tN` (`ccaRunTestsInTestNs` and `ConjureCljRunCurrentTest` both work).
2. Execute `:CcaJumpToFailingCljTest` to jump to first failing test.
3. \*mandatory lag\*
4. Profit

#### Usage (only focused test suite)
1. Run tests via `<locallleader>tc` (`ccaRunTestsInTestNs`).
2. Execute `:CcaJumpToFailingCljTest` to jump to first failing test.
3. \*mandatory lag\*
4. Profit

### `CcavRunTestsInTestNs`
With this you can run `core_test.clj` regardless whether you're located in `core.clj` or `core_test.clj`.

To bind it to `<locallleader>tn` you can do this (the first two lines change Conjure's keybinds `tn` and `tN` to NOOP):

```
let g:conjure#client#clojure#nrepl#mapping#run_alternate_ns_tests = '🇺🇦'
let g:conjure#client#clojure#nrepl#mapping#run_current_ns_tests = '🇺🇦'
autocmd FileType clojure nnoremap <silent> <localleader>tn :JumpToFirstCljTestRunTestNsTests<CR>
```
