;; inherits: rust
;; keywords
((function_item "fn" @keyword) (#set! conceal ""))
((mutable_specifier) @keyword (#set! conceal ""))
((visibility_modifier) @keyword (#set! conceal ""))
(unsafe_block"unsafe" @keyword (#set! conceal ""))
(function_modifiers"unsafe" @keyword (#set! conceal ""))
;; delimiter
((function_item "->" @punctuation.delimiter) (#set! conceal ""))
((match_arm "=>" @punctuation.delimiter) (#set! conceal ""))
;; operator
((binary_expression operator: "!=" @operator) (#set! conceal "≠"))
((reference_expression "&" @operator) (#set! conceal ""))
((reference_type "&" @operator) (#set! conceal ""))
;; other
((match_expression "match" @conditional) (#set! conceal "")) 

