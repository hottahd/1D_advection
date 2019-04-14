!=====================================================|
subroutine sc4rk4
!=====================================================|
  use back, only: qq,qqm,qqp,dx,dt,vx,nxg,margin
  implicit none

  integer :: i,mm
  real(KIND(0.d0)) :: ratio
  real(KIND(0.d0)) :: dqq
!-----------------------------------------------------|  

  ! Runge-Kutta loop
  do mm = 1,4
     if(mm == 1) ratio = 1.d0/4.d0
     if(mm == 2) ratio = 1.d0/3.d0
     if(mm == 3) ratio = 1.d0/2.d0
     if(mm == 4) ratio = 1.d0

     if(mm == 1) then
        do i = 1,nxg
           qqp(i) = qq(i)
        enddo
     else
        do i = 1,nxg
           qqp(i) = qqm(i)
        enddo
     endif
        
     do i = 1+margin,nxg-margin
        dqq = -vx*(-qqp(i+2) + 8.d0*qqp(i+1) - 8.d0*qqp(i-1) + qqp(i-2))/12.d0/dx*dt
        qqm(i) = qq(i) + ratio*dqq
     enddo
     call bc(qqm)
  enddo
  
  return
end subroutine sc4rk4
