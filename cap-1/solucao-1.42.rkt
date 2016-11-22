#lang racket

<<<<<<< HEAD

=======
>>>>>>> f1e4f2a613e33d7654cf1ae4a03dbdaf07c10b07
(define (inc x) (+ x 1))

(define (compose f g)
  (lambda (x) (f (g x))))

((compose sqr inc) 6)
<<<<<<< HEAD
;49
=======

>>>>>>> f1e4f2a613e33d7654cf1ae4a03dbdaf07c10b07
