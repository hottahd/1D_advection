!=====================================================|
subroutine mhd
!=====================================================|
  use back, only: nxg,qq,qqm  
  implicit none

  integer :: i
!-----------------------------------------------------|

  call cfl  
  call sc4rk4
  call artdif

  do i = 1,nxg
     qq(i) = qqm(i)
  enddo
  

  return
end subroutine mhd
