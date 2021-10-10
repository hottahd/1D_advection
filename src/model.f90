!=====================================================|
subroutine model
!=====================================================|
  use geometry_def, only: vx,kp,xmax,xmin,dx,x,qq &
       & ,nx,nxg,margin
  implicit none
  integer :: i

  real(KIND(0.d0)) :: xm,dd
!-----------------------------------------------------|

  vx = 1.d0
  kp = 0.005d0
  
  xmax = 1.d0
  xmin = 0.d0

  dx = (xmax - xmin)/real(nx)
  x(1 + margin) = xmin + 0.5d0*dx
  do i = margin,1,-1
     x(i) = x(i+1) - dx
  enddo

  do i = 2 + margin,nxg
     x(i) = x(i-1) + dx
  enddo

  xm = 0.5d0*(xmax + xmin)
  dd = 0.1d0
  do i = 1,nxg
     qq(i) = exp(-((x(i)-xm)/dd)**2)
     !if(x(i) < 0.5d0) then
     !  qq(i) = 0.d0
     !else
     !   qq(i) = 1.d0
     !endif
  enddo
     
  return
end subroutine model
