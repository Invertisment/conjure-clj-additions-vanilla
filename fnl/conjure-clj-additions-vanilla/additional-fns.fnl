(module conjure-clj-additions-vanilla.additional-fns
  {autoload {text conjure.text
             extract conjure.extract
             str conjure.aniseed.string
             nrepl-action conjure.client.clojure.nrepl.action
             eval conjure.eval
             a conjure.aniseed.core
             server conjure.client.clojure.nrepl.server
             log conjure.log
             state conjure.client.clojure.nrepl.state
             jump conjure-clj-additions-vanilla.jump
             nvim conjure.aniseed.nvim
             }})

(defn get-current-ns! []
  (extract.context))

(defn to-test-ns-name [current-ns]
  (if (text.ends-with current-ns "-test")
    current-ns
    (.. current-ns "-test")))

(defn get-alternate-ns-name! []
  (let [current-ns (get-current-ns!)]
    (if (text.ends-with current-ns "-test")
      (string.sub current-ns 1 -6)
      (.. current-ns "-test"))))

(defn remove-ns! []
  (eval.command "(remove-ns (symbol (str *ns*)))"))

(defn cleanup-ns! []
  (eval.command
    (..
      ;; Cleanup a namespace
      ;; https://www.reddit.com/r/Clojure/comments/rq51mg/comment/hq9gfk6/?utm_source=reddit&utm_medium=web2x&context=3
      ;; https://github.com/seancorfield/vscode-clover-setup/blob/develop/config.cljs#L79-L89
      "((fn clenaup-ns [ns-sym]"
      "  (when-let [ns (find-ns ns-sym)]"
      "    (run! #(try (ns-unalias ns %) (catch Throwable _)) (keys (ns-aliases ns)))"
      "    (run! #(try (ns-unmap ns %)   (catch Throwable _)) (keys (ns-interns ns)))"
      "    (->> (ns-refers ns)"
      "         (remove (fn [[_ v]] (.startsWith (str v) \"#'clojure.core/\")))"
      "         (map key)"
      "         (run! #(try (ns-unmap ns %) (catch Throwable _))))))"
      "   (symbol (str *ns*)))")))

(defn run-test-ns-tests! []
  (let [current-ns (get-current-ns!)]
    (if (text.ends-with current-ns "-test")
      (nrepl-action.run-current-ns-tests)
      (nrepl-action.run-alternate-ns-tests))))

(defn jump-to-first-failing! []
  (jump.jump-to-last-failing-test!))

(defn jump-to-alternate-ns! []
  (let [to-find (get-alternate-ns-name!)]
    (->> {:namespace to-find}
         jump.find-buffer-to-jump!
         jump.jump-to-buffer-and-line!)))
