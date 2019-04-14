!=====================================================|
module back
!=====================================================|
  integer, parameter :: nx = 100
  integer, parameter :: margin = 2
  integer, parameter :: nxg = nx + 2*margin

  ! geometry
  real(KIND(0.d0)), save :: vx
  real(KIND(0.d0)), save :: xmax, xmin, dx
  real(KIND(0.d0)), dimension(nxg), save :: x  ! geometry
  real(KIND(0.d0)), dimension(nxg), save :: qq, qqm, qqp ! variable

  ! time variable
  integer, save :: ns, nd
  real(KIND(0.d0)), save :: time,dt

  ! data directory
  character (len = 10),save :: data_dir
end module back
