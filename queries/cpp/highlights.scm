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
