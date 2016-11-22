#lang racket
(require levenshtein)

(define (distance-matrix phrases1 phrases2)
  (define (aux seq1 seq2 using-seq2 out)
    (if (null? seq1)
        (reverse out)
        (if (null? using-seq2)
            (aux (cdr seq1) seq2 seq2 (cons '() out))
            (aux seq1
                 seq2
                 (cdr using-seq2)
                 (cons (cons (string-levenshtein (car seq1)
                                                 (car using-seq2))
                             (car out))
                       (cdr out))))))
  (aux phrases1 (reverse phrases2) (reverse phrases2) (list null)))

