!=====================================================|
subroutine cfl
!=====================================================|
  use geometry_def, only: dt,dx,vx,kp
  implicit none
  
  integer :: i
  real(KIND(0.d0)) :: safety = 0.9d0
!-----------------------------------------------------|  

  dt = safety*min(dx/vx,dx**2/kp*0.5d0)
  
  return
end subroutine cfl
