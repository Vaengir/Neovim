; This doesn't work, however I think this is a problem with the rust parser.
; The tree displays the fields correctly but it doesn't get highlighted.
; I think the `raw_string_literal` is represented twice and thus gets overwritten by the rust parser.
;; extends

(macro_invocation
  (scoped_identifier
    path: (identifier) @path (#eq? @path "sqlx")
    name: (identifier) @name (#eq? @name "query_as"))

  (token_tree
    (raw_string_literal
      (string_content) @injection.content
      (#set! injection.include-children)
      (#set! injection.language "sql"))))
