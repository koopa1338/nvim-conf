;; inherits: cpp

;; comparison operators
((binary_expression
  operator: "!=" @operator)
 (#set! conceal "≠"))

((binary_expression
  operator: ">=" @operator)
 (#set! conceal "≥"))

((binary_expression
  operator: "<=" @operator)
 (#set! conceal "≤"))

((binary_expression
  operator: "==" @operator)
 (#set! conceal ""))

;; boolean operators
((binary_expression
  operator: "||" @operator)
 (#set! conceal "∨"))

((binary_expression
  operator: "&&" @operator)
 (#set! conceal "∧"))

;; delimiters
((field_expression "->" @punctuation.delimiter) (#set! conceal ""))
