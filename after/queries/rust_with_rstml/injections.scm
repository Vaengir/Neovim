;; extends

(call_expression
  function: (field_expression
    value: (macro_invocation
      macro: (scoped_identifier
        path: (identifier) @path (#eq? @path "sqlx")
        name: (identifier) @name (#eq? @name "query_as")))))
  (token_tree
    (raw_string_literal
      (string_content) @injection.content
          (#set! injection.include-children)
          (#set! injection.language "sql")))