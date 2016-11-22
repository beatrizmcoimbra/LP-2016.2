#lang racket

(require levenshtein)
(require htdp/matrix)
(define (distance a b)
  (string-levenshtein a b))

(define (difference lst-1 lst-2)
  (let ((p (length lst-1)))
    (define (auxdiff lst-1 lst-2 out)
      (if (null? lst-1)
          (make-matrix p p (reverse out))
          (begin (for ((i lst-2))
                   (set! out (append (list (distance (car lst-1) i)) out)))
                 (auxdiff (cdr lst-1) lst-2 out))))
    (auxdiff lst-1 lst-2 '())))

