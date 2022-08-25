(defn provide-fn! [fn-name ns f]
  (nvim.ex.command_
    (.. "-range " fn-name)
    (bridge.viml->lua ns f {})))

(defn on-filetype []
  (provide-fn! :CcavNsJumpToAlternate :conjure-clj-additions-vanilla.additional-fns :jump-to-alternate-ns!)

  ;; log-parsing functions (based on original way Conjure does things on its own)
  (provide-fn! :CcavRunTestsInTestNs :conjure-clj-additions-vanilla.additional-fns :run-test-ns-tests!)
  (provide-fn! :CcavJumpToFailingCljTest :conjure-clj-additions-vanilla.additional-fns :jump-to-first-failing!)

  ;; util
  (provide-fn! :CcavNsRemove :conjure-clj-additions-vanilla.additional-fns :remove-ns!)
  (provide-fn! :CcavNsCleanup :conjure-clj-additions-vanilla.additional-fns :cleanup-ns!))

(defn init-mappings! []
  (nvim.ex.augroup :jump_to_clj_test_init_filetypes)
  (nvim.ex.autocmd_)
  (nvim.ex.autocmd
    :FileType (str.join "," [:clojure])
    (bridge.viml->lua :conjure-clj-additions-vanilla.main :on-filetype {}))
  (nvim.ex.augroup :END))

(defn init []
  (init-mappings!))
