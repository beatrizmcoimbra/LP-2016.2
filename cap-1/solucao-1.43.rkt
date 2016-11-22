#lang racket

<<<<<<< HEAD

=======
>>>>>>> f1e4f2a613e33d7654cf1ae4a03dbdaf07c10b07
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (cond ((< n 0) (error "'n' can't be a negative number"))
        ((= n 0) null)
        ((= n 1) f)
<<<<<<< HEAD
        (else (compose f (repeated f (- n 1))))))
=======
        (else (compose f (repeated f (- n 1))))))
>>>>>>> f1e4f2a613e33d7654cf1ae4a03dbdaf07c10b07
