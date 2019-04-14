!=====================================================|
subroutine cfl
!=====================================================|
  use back, only: dt,dx,vx
  implicit none
  
  integer :: i
  real(KIND(0.d0)) :: safety = 1.5
!-----------------------------------------------------|  

  dt = safety*dx/vx
  
  return
end subroutine cfl
