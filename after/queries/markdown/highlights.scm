;; extends

(fenced_code_block
  (fenced_code_block_delimiter) @markup.raw.delimiter
  (#set! conceal "󰅴 "))

(fenced_code_block
  (info_string
    (language) @conceal (#eq? @conceal "rust")
    (#set! conceal " ")))

(fenced_code_block
  (info_string
    (language) @conceal (#eq? @conceal "sh")
    (#set! conceal "󱆃 ")))

(fenced_code_block
  (info_string
    (language) @conceal (#eq? @conceal "bash")
    (#set! conceal "󱆃 ")))
