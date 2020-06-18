!=====================================================|
subroutine cfl
!=====================================================|
  use geometry_def, only: dt,dx,vx
  implicit none
  
  integer :: i
  real(KIND(0.d0)) :: safety = 0.40
!-----------------------------------------------------|  

  dt = safety*dx/vx
  
  return
end subroutine cfl
