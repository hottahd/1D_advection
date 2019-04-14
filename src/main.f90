!=====================================================|
program main
!=====================================================|
  use back, only: time,dt,ns,nd,data_dir
  implicit none

  real(KIND(0.d0)) :: dtout,tend,timep
  logical :: exist
!-----------------------------------------------------|  
! make data directory

  data_dir = "data/"
  inquire(file=trim(data_dir),exist=exist)
  if(.not. exist) then
     call system("mkdir "//trim(data_dir))
  endif
  
!-----------------------------------------------------|  
! initial time counter

  dtout = 0.02d0
  time = 0.d0
  tend = 1.d0
  ns = 0
  nd = 0

!-----------------------------------------------------|  
! initial setting
  
  call model
  
!-----------------------------------------------------|  
! initial I/O

  call io
  
!-----------------------------------------------------|  
! time marching

1000 continue
  call mhd

  timep = time
  time = time + dt
  ns = ns + 1

  if(int(timep/dtout) /= int(time/dtout)) then
     nd = nd + 1
     call io
  endif
  
  if(time < tend) goto 1000
  write(*,*) "### NORMAL END ###"
  
  
  stop
end program main
