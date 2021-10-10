!=====================================================|
subroutine sc2ssprk2
!=====================================================|
  use geometry_def, only: qq,qqm,qqp,dx,dt,vx,nxg,margin
  implicit none

  integer :: i,mm
  real(KIND(0.d0)) :: ratio
  real(KIND(0.d0)), dimension(nxg) :: dqq,qqn
!-----------------------------------------------------|  

  ! Runge-Kutta loop
  call sc2(qq,dqq)
  do i = 1+margin,nxg-margin
     qqn(i) = qq(i) + dqq(i)
  enddo
  call bc(qqn)

  call sc2(qqn,dqq)
  
  do i = 1+margin,nxg-margin
     qqm(i) = 0.5d0*qq(i) + 0.5d0*(qqn(i) + dqq(i))
  enddo

  call bc(qqm)
  
  return

contains
!=====================================================|
  subroutine sc2(qq,dqq)
!=====================================================|
    implicit none
    real(KIND(0.d0)), dimension(nxg), intent(in)  :: qq
    real(KIND(0.d0)), dimension(nxg), intent(out) :: dqq
    !-----------------------------------------------------|

    do i = 1+margin,nxg-margin
       dqq(i) = -vx*(qq(i+1) - qq(i-1))/dx*dt*0.5d0
    enddo
    
    return
  end subroutine sc2
  
end subroutine sc2ssprk2
