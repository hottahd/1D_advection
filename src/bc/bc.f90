!=====================================================|
subroutine bc(qq)
!=====================================================|
  use back, only: nxg,margin
  implicit none

  integer :: i
  real(KIND(0.d0)), dimension(nxg), intent(inout) :: qq
!-----------------------------------------------------|  

  do i = 1,margin
     qq(i) = qq(nxg - 2*margin + i)
  enddo

  do i = nxg - margin+1,nxg
     qq(i) = qq(i - nxg + 2*margin)
  enddo
  
  return
end subroutine bc
