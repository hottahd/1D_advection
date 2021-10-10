!=====================================================|
subroutine exp_diff
!=====================================================|
  use geometry_def, only: qq,qqm,qqp,dx,dt,kp,nxg,margin
  implicit none

  integer :: i,mm
  real(KIND(0.d0)) :: ratio
  real(KIND(0.d0)), dimension(nxg) :: dqq,qqn
!-----------------------------------------------------|  

  ! Runge-Kutta loop
  call diff(qq,dqq)
  do i = 1+margin,nxg-margin
     qqn(i) = qq(i) + dqq(i)
  enddo
  call bc(qqn)

  call diff(qqn,dqq)
  
  do i = 1+margin,nxg-margin
     qqm(i) = 0.5d0*qq(i) + 0.5d0*(qqn(i) + dqq(i))
  enddo

  call bc(qqm)
  
  return

contains
!=====================================================|
  subroutine diff(qq,dqq)
!=====================================================|
    implicit none
    real(KIND(0.d0)), dimension(nxg), intent(in)  :: qq
    real(KIND(0.d0)), dimension(nxg), intent(out) :: dqq
    real(KIND(0.d0)), dimension(nxg) :: fx
    !-----------------------------------------------------|

    do i = 1,nxg-1
       fx(i) = kp*(qq(i+1) - qq(i))/dx
    enddo

    do i = 2,nxg-1
       dqq(i) = (fx(i) - fx(i-1))*dt/dx
    enddo
    
    return
  end subroutine diff
  
end subroutine exp_diff
