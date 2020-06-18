!=====================================================|
subroutine sc2rk2
!=====================================================|
  use geometry_def, only: qq,qqm,qqp,dx,dt,vx,nxg,margin
  implicit none

  integer :: i,mm
  real(KIND(0.d0)) :: ratio
  real(KIND(0.d0)) :: dqq
!-----------------------------------------------------|  

  ! Runge-Kutta loop
  call sc2(qq,qqm)
  call bc(qqm)

  call sc2(qqm,qqp)
  
  do i = 1+margin,nxg-margin
     qqm(i) = 0.5d0*(qqp(i) + qq(i))
  enddo

  call bc(qqm)
  
  return

contains
!=====================================================|
  subroutine sc2(qq,qqm)
!=====================================================|
    implicit none
    real(KIND(0.d0)), dimension(nxg), intent(in)  :: qq
    real(KIND(0.d0)), dimension(nxg), intent(out) :: qqm    
    !-----------------------------------------------------|

    do i = 1+margin,nxg-margin
       dqq = -vx*(qq(i+1) - qq(i-1))*0.5d0/dx*dt
       qqm(i) = qq(i) + dqq
    enddo
    
    return
  end subroutine sc2

  
end subroutine sc2rk2
