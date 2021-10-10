!=====================================================|
subroutine mhd
!=====================================================|
  use geometry_def, only: nxg,qq,qqm  
  implicit none

  integer :: i
!-----------------------------------------------------|

  call cfl
  !call sc4rk4
  !call sc2rk2
  call sc2ssprk2

  do i = 1,nxg
     qq(i) = qqm(i)
  enddo
  
  !call exp_diff
  !call artdif
  !call lf
  !call ftcs

  !do i = 1,nxg
  !   qq(i) = qqm(i)
  !enddo
  

  return
end subroutine mhd
