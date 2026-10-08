PROGRAM TGROTG
  IMPLICIT NONE
  INTERFACE
     PURE SUBROUTINE GROTG(A, B, C, S)
       IMPLICIT NONE
       REAL(KIND=BLAS_REAL_KIND), INTENT(INOUT) :: A, B
       REAL(KIND=BLAS_REAL_KIND), INTENT(OUT) :: C, S
     END SUBROUTINE GROTG
  END INTERFACE
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: ZERO = 0.0, ONE = 1.0, MXN = HUGE(MXN)
  INTEGER, PARAMETER :: NAB = 14
  REAL(KIND=BLAS_REAL_KIND), PARAMETER :: AB(2,NAB) = RESHAPE((/&
       ZERO, ZERO,&
        ONE, ZERO,&
       ZERO, ZERO,&
        ONE,  ONE,&
       -ONE, ZERO,&
       ZERO, -ONE,&
       -ONE,  ONE,&
        ONE, -ONE,&
       -ONE, -ONE,&
        MXN,  ONE,&
        ONE,  MXN,&
        MXN, ZERO,&
       ZERO,  MXN,&
        MXN,  MXN &
       /), (/2,NAB/))
  REAL(KIND=BLAS_REAL_KIND) :: A, B, C, S
  INTEGER :: I
  DO I = 1, NAB
     A = AB(1,I)
     B = AB(2,I)
     WRITE (*,'(A,ES18.9E4)') 'A=', A
     WRITE (*,'(A,ES18.9E4)') 'B=', B
     CALL GROTG(A, B, C, S)
     WRITE (*,'(A,ES18.9E4)') 'R=', A
     WRITE (*,'(A,ES18.9E4)') 'Z=', B
     WRITE (*,'(A,ES18.9E4)') 'C=', C
     WRITE (*,'(A,ES18.9E4)') 'S=', S
  END DO
END PROGRAM TGROTG
