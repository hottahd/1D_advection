!=====================================================|
subroutine io
!=====================================================|
  use back, only: ns,nd,time,data_dir,time &
       & ,nx,nxg,margin,xmax,xmin,qq
  implicit none
  integer :: idf = 10
  character (len=8) :: cnd
!-----------------------------------------------------|  

  write(*,913) ns,time,nd

  if(ns == 0) then
     open(idf,file=trim(data_dir)//'params.dac',form='formatted')
     write(idf,'(1x,i8,1x,e16.10,1x,e16.10)') nx,xmax,xmin
     close(idf)     
  endif

  open(idf,file=trim(data_dir)//'nd.dac',form='formatted')
  write(idf,'(i8)') nd
  close(idf)

  write(cnd,'(i8.8)') nd
  
  open(idf,file=trim(data_dir)//'t.dac.'//cnd,form='unformatted',access='stream')
  write(idf) time
  close(idf)

  open(idf,file=trim(data_dir)//'qq.dac.'//cnd,form='unformatted',access='stream')
  write(idf) qq(1+margin:nxg-margin)
  close(idf)

  return
913 format(1x,' write    ','step=',i8,' time=',e10.3,' nd=',i4)
end subroutine io

