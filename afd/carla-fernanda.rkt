#lang racket

(define english-1
  '((Initial (1))
    (Final (9))
    (From 1 to 3 by S)
    (From 1 to 2 by DET)
    (From 2 to 3 by N)
    (From 3 to 4 by BV)
    (From 3 to 10 by ADV)
    (From 3 to 10 by |#|)
    (From 4 to 5 by ADV)
    (From 4 to 5 by |#|)
    (From 5 to 6 by DET)
    (From 5 to 7 by DET)
    (From 5 to 8 by |#|)
    (From 6 to 7 by ADJ)    
    (From 6 to 6 by MOD)
    (From 7 to 9 by N)
    (From 8 to 8 by MOD)
    (From 8 to 9 by ADJ)
    (From 9 to 4 by CNJ)
    (From 9 to 1 by CNJ)
    (From 10 to 11 by DV)
    (From 11 to 9 by IN)
    (From 11 to 12 by IN)
    (From 12 to 8 by |#|)))

(define abbreviations
  '((S kim sandy lee she he it)
    (DET a an the her his my)
    (N consumer man woman girl boy mother father)
    (IN basket football piano cake)
    (BV is was got become)
    (DV does studies plays)
    (CNJ and or)
    (ADJ happy sad intelligent stupid beautiful ugly cool nice good bad fat)
    (MOD very)
    (ADV often always sometimes never anytime)))

(define (initial-nodes network)
  (cadar (filter (lambda (x) (eq? (car x) 'Initial)) network)))

(define (transitions network)
  (filter (lambda (x) (eq? (car x) 'From)) network))

(define (final-nodes network)
  (cadar (filter (lambda (x) (eq? (car x) 'Final)) network)))

(define (trans-node transition)
  (list-ref transition 1))

(define (trans-newnode transition)
  (list-ref transition 3))

(define (trans-label transition)
  (list-ref transition 5))

(define (recognize network tape)
  (with-handlers ((boolean? (lambda (s) s)))
    (for-each (lambda (node)
                (recognize-next node tape network))
              (initial-nodes network))
    #f))

(define (recognize-next node tape network)
  (if (and (empty? tape) (member node (final-nodes network)))
      (raise #t #t)
      (for ((transition (transitions network)))
        (if (equal? node (trans-node transition))
            (for ((newtape (recognize-move (trans-label transition) tape)))
              (recognize-next (trans-newnode transition) newtape network))
            null))))

(define (recognize-move label tape)
  (cond ((empty? tape) null)
        ((equal? label '|#|) (list tape))
        ((or (equal? label (car tape))
              (member (car tape) (assoc label abbreviations)))
         (list (cdr tape)))
        (else null)))      

(define (generate-move label tape)
  (if (equal? label '|#|)
      empty
      (cdr (assoc label abbreviations))))

(define (generate-next node tape network)
  (if (member node (final-nodes network))
      (displayln tape)
      (for ((transition (transitions network)))
        (if (equal? node (trans-node transition))
            (for ((newtape (generate-move (trans-label transition) tape)))
              (generate-next (trans-newnode transition)
                             (append tape (list newtape)) network))
            'pass))))

(define (generate network)
  (for ([initialnode (initial-nodes network)])
    (generate-next initialnode null network)))

