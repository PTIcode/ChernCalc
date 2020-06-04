(define-param eps 12)
(define-param r 0.1)
(define-param pert 1)

(define-param kx 1)
(define-param ky 1)
(define-param Nband 4)
;(define-param suffix " ") 
;(define-param filename_ev (string-append "ev_" (number->string suffix)) )

(set! num-bands Nband)

(define-param res 50)
(set! resolution res) 

(define-param a1 (vector3 1 0 0))
(define-param a2 (vector3 0.5 (/ (sqrt 3) 2) 0))

(define-param vx (vector3 1 0 0))
(define-param vy (vector3 0 1 0))

(define-param v1 (vector3 -1/6 1/3 0))
(define-param v2 (vector3 1/3 -1/6 0))
(define-param v3 (vector3 -1/6 -1/6 0))

(define-param coord (list v1 v2 v3))

(set! coord (map (lambda (x) (vector3* x pert)) coord))

(define lattice_geometry (list ))

(set! k-points (list (vector3 (+ 1 kx) (+ 1 ky) 0)))

(set! geometry-lattice 
	(make lattice 
		(size 1 1 no-size)
		(basis1 a1)
		(basis2 a2)))


(map 
	(lambda (x) 
		(set! lattice_geometry 
			(append lattice_geometry
				(list 
					(make cylinder 
						(center x) (radius r) (height infinity)
						(material (make dielectric (epsilon eps))))))))
	coord)

(set! geometry lattice_geometry)

(run-tm)
;(run-tm fix-efield-phase output-efield-z)


;(define-param fname (string-append filename_ev "ok"))
;(output-eigenvectors (get-eigenvectors 1 Nband) filename_ev)


(define (output-nonbloch-efield which-band-min which-band-max)
	(do ((i which-band-min (+ i 1))) ((= i (+ which-band-max 1)))
		(get-efield i)
		(cvector-field-nonbloch! cur-field)
		(output-field-to-file -1 "e.")
	)
)

(run-tm (output-nonbloch-efield 1 Nband) )
