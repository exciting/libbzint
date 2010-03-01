
! Copyright (C) Ricardo Gomez-Abal (RGA) and Xinzheng Li (XZL),
! Fritz-Haber-Institut der Max-Planck-Geselschaft, Berlin, Germany.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

!BOP
! 
! !ROUTINE: intern
!
! !INTERFACE:
      subroutine intern(nkp,kp,div,shift,divsh,klist,idiv)
!<sag>
        use control, only: tetraifc
!</sag>

! !DESCRIPTION:
!
! This subroutine transform the submesh coordinates of the kpoints into
! internal coordinates in the basis vectors of the reciprocal lattice
!
! !INPUT PARAMETERS:
!
      implicit none

      integer(4), intent(in) :: nkp      ! Number of k-points
      integer(4), intent(in) :: kp(3,nkp) ! submesh coordinates of the k-points
      integer(4), intent(in) :: div(3)   ! number of divisions of the  submesh in each direction
      integer(4), intent(in) :: shift(3) ! shift of the submesh from  the origin
      integer(4), intent(in) :: divsh    ! common divisor of the shift

! !OUTPUT PARAMETERS:

      integer(4), intent(out) :: idiv     ! minimum common divisor for  the integer coordinates of   the kpoints
      integer(4), intent(out) :: klist(3,nkp)! integer coordinates of  the kpoints
      
! !LOCAL VARIABLES:

      integer(4) :: kpi
      
      integer(4) :: i

      real(8)    :: rind
      
!EOP
!BOC      

      if (trim(tetraifc)=='wien2k') then

!<sag>
!!$         ! original part of code
!!$         idiv=div(1)*div(2)*div(3)*2
         ! new code
         idiv=div(1)*div(2)*div(3)*divsh
!</sag>
         do kpi=1,nkp
            do i=1,3
!<sag>
!!$               ! old version
!!$               rind=dble(divsh*kp(i,kpi)+shift(i))/dble(divsh*div(i))
!!$               klist(i,kpi)=nint(rind*idiv)
               ! new code
               klist(i,kpi)=kp(i,kpi)*idiv/div(i) + &
                    shift(i)*idiv/(div(i)*divsh)
!</sag>
            enddo
         enddo

      else if (trim(tetraifc)=='exciting') then

         ! new code
         idiv=div(1)*div(2)*div(3)*divsh
         do kpi=1,nkp
            do i=1,3
               klist(i,kpi)=kp(i,kpi)*idiv/div(i) + &
                    shift(i)*idiv/(div(i)*divsh)
            end do
         end do

      end if
!</sag>
      call divisi(nkp,idiv,klist)

      end subroutine intern

!EOC
