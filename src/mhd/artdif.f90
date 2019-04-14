!=====================================================|
subroutine artdif
!=====================================================|
  use back, only: qq,qqm,qqp,nxg,vx,dx,dt
  implicit none

  integer :: i
  real(KIND(0.d0)), parameter :: fh = 1.1d0, ep = 1.d0
  real(KIND(0.d0)), dimension(nxg) :: fx,dui
  real(KIND(0.d0)) :: dul,dur,duc,mup,mlo
  real(KIND(0.d0)) :: ul,ur,du,ra,pp,cc
!-----------------------------------------------------|  

  do i = 1,nxg
     qqp(i) = qqm(i)
  enddo

  ! calculating artificial diffusivity flux
  do i = 1,nxg-1
     dul = qqp(i  ) - qqp(i-1)
     dur = qqp(i+1) - qqp(i  )
     duc = 0.5d0*(qqp(i+1) - qqp(i-1))

     mup = max(ep*dul,ep*dur,duc)
     mlo = min(ep*dul,ep*dur,duc)

     dui(i) = min(0.d0,mup) + max(0.d0,mlo)
  enddo

  do i = 1,nxg-1
     ul = qqp(i  ) + 0.5d0*dui(i  )
     ur = qqp(i+1) - 0.5d0*dui(i+1)
     du = qqp(i+1) - qqp(i)
     du = sign(1.d0,du)*max(abs(du),1.d-20)
     ra = min((ur-ul)/du,1.d0)
     pp = (0.5d0 + sign(0.5d0,ra))*max(0.d0,1.d0 + fh*(ra-1.d0))
     cc = vx
     fx(i) = -0.5d0*(ur - ul)*pp*cc
  enddo

  do i = 2,nxg-1
     qqm(i) = qqm(i) -(fx(i) - fx(i-1))/dx*dt
  enddo

  call bc(qqm)
  return
end subroutine artdif
