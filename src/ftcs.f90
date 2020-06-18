!=====================================================|
subroutine ftcs
!=====================================================|
  use geometry_def, only: qq,qqm,qqp,dx,dt,vx,nxg,margin
  implicit none

  integer :: i,mm
  real(KIND(0.d0)) :: ratio
  real(KIND(0.d0)) :: dqq
!-----------------------------------------------------|  

  ! use Lax
  do i = 2,nxg-1
     qqm(i) = qq(i) - vx*(qq(i+1) - qq(i-1))/2.d0/dx*dt
  enddo
  
  call bc(qqm)
  
  return
  
end subroutine ftcs
