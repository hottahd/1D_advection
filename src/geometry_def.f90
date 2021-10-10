!=====================================================|
module geometry_def
!=====================================================|
  integer, parameter :: nx = 128
  integer, parameter :: margin = 2
  integer, parameter :: nxg = nx + 2*margin

  ! advection velocity
  real(KIND(0.d0)), save :: vx

  ! diffusion coefficient
  real(KIND(0.d0)), save :: kp
  
  ! geometry
  real(KIND(0.d0)), save :: xmax, xmin, dx
  real(KIND(0.d0)), dimension(nxg), save :: x  ! geometry
  real(KIND(0.d0)), dimension(nxg), save :: qq, qqm, qqp ! variable

  ! time variable
  integer, save :: ns, nd
  real(KIND(0.d0)), save :: time,dt

  ! data directory
  character (len = 10),save :: data_dir
end module geometry_def
