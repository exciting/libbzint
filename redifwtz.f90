
! Copyright (C) Ricardo Gomez-Abal (RGA) and Xinzheng Li (XZL),
! Fritz-Haber-Institut der Max-Planck-Geselschaft, Berlin, Germany.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

!BOP
!
! !ROUTINE: redifwtz
!
! !INTERFACE:

      subroutine redifwtz(v,omeg,figu,wt)

!
! !DESCRIPTION:
!
! This subroutine calculates the weight on the forth vertex of the tetrahedron.
! for the real frequency case.
! 
                                            
! !INPUT PARAMETERS:
      implicit none
      
      real(8), intent(in) :: v(4)                 ! difference of the energy
!             in k-mesh tetrahedron vertices and k-q mesh tetrahedron vertices.

      real(8), intent(in) :: omeg  ! the frequency omega to be calculated

      integer(4), intent(in) :: figu     ! If figu=4, it belongs to the none
!                                         equally case. If figu=6, v(1)=v(2).
!                                         If figu=8, v(1)=v(2) and v(3)=v(4).
!                                         If figu=10, v(1)=v(2)=v(3).
!                                         If figu=16, v(1)=v(2)=v(3)=v(4). 

 
! !OUTPUT PARAMETERS:            

      real(8), intent(out) :: wt      ! the weight on the whole tetrahedron.

! !LOCAL VARIABLES:

      integer(4) :: i,j

      real(8)    :: aa, cc, dd
      
      real(8), dimension(4,4) :: vdif

      real(8), dimension(4) :: ev

! !DEFINED PARAMETERS:

      real(8), parameter :: haier=1.0d-12
! 
! !SYSTEM ROUTINES:

      intrinsic dlog
      intrinsic dabs

 
! !REVISION HISTORY:
!
! Created 05.11.2004 by XZL.
!
! Intrinsic functions

!EOP
!BOC
      wt=0.0d0

      select case(figu)

      case(4)                ! for the case of none of them are equal

        ev(1:4)=v(1:4)
        do i=1,4
          do j=1,4
            vdif(i,j)=v(i)-v(j)
          enddo
        enddo  
        if(dabs(omeg-v(1)).lt.haier) then
  
          aa=dlog(dabs(vdif(2,1)))*vdif(2,1)**2*vdif(4,3)**2

          aa=aa-dlog(dabs(vdif(3,1)))*vdif(3,1)**2*vdif(4,2)**2

          dd=dlog(dabs(vdif(4,1)))*(vdif(3,1)*vdif(4,2)+vdif(2,1)*    &
     &       vdif(4,3))
          dd=dd-vdif(4,2)*vdif(4,3)

          aa=aa+vdif(3,2)*vdif(4,1)*dd

          cc=6.0d0*vdif(3,2)*vdif(4,2)**2*vdif(4,3)**2

        else if(dabs(omeg-v(2)).lt.haier) then
         
          aa=dlog(dabs(vdif(2,1)))*vdif(2,1)**2*vdif(4,3)**2

          aa=aa-dlog(dabs(vdif(3,2)))*vdif(3,2)**2*vdif(4,1)**2

          dd=dlog(vdif(4,2))*(vdif(4,1)*vdif(3,2)-vdif(4,3)*vdif(2,1))
          dd=dd-vdif(4,3)*vdif(4,1)

          aa=aa+vdif(3,1)*vdif(4,2)*dd
 
          cc=6.0d0*vdif(3,1)*vdif(4,3)**2*vdif(4,1)**2

        else if(dabs(omeg-v(3)).lt.haier) then
      
          aa=dlog(dabs(vdif(3,1)))*vdif(3,1)**2*vdif(4,2)**2

          aa=aa-dlog(dabs(vdif(3,2)))*vdif(3,2)**2*vdif(4,1)**2
 
          dd=dlog(vdif(4,3))*(vdif(4,1)*vdif(3,2)+vdif(4,2)*vdif(3,1))
          dd=dd+vdif(4,2)*vdif(4,1)

          aa=aa-vdif(2,1)*vdif(4,3)*dd

          cc=6.0d0*vdif(2,1)*vdif(4,2)**2*vdif(4,1)**2
  
        else if(dabs(omeg-v(4)).lt.haier) then

          aa=dlog(dabs(vdif(4,3)))*vdif(2,1)*vdif(4,3)

          aa=aa+dlog(dabs(vdif(4,1)))*vdif(4,1)*vdif(3,2)

          aa=aa-dlog(dabs(vdif(4,2)))*vdif(4,2)*vdif(3,1)

          cc=6.0d0*vdif(2,1)*vdif(3,2)*vdif(3,1)

        else

          aa=(omeg-v(3))**3*vdif(2,1)*vdif(4,1)**2*vdif(4,2)**2*      &
     &        dlog(dabs(omeg-v(3)))

          dd=(omeg-v(3))*vdif(4,1)*vdif(4,2)+(omeg-v(2))*vdif(4,1)*   &
     &       vdif(4,3)
          dd=dd+(omeg-v(1))*vdif(4,2)*vdif(4,3)
          aa=aa-(omeg-v(4))**2*dlog(dabs(omeg-v(4)))*dd*vdif(2,1)*    &
     &       vdif(3,1)*vdif(3,2)

          aa=aa-(omeg-v(4))**2*vdif(2,1)*vdif(3,1)*vdif(3,2)*         &
     &       vdif(4,1)*vdif(4,2)*vdif(4,3)

          aa=aa-(omeg-v(2))**3*vdif(3,1)*vdif(4,1)**2*vdif(4,3)**2*   &
     &       dlog(dabs(omeg-v(2)))
         
          aa=aa+(omeg-v(1))**3*vdif(3,2)*vdif(4,2)**2*vdif(4,3)**2*   &
     &       dlog(dabs(omeg-v(1)))

          cc=6.0d0*vdif(2,1)*vdif(3,1)*vdif(3,2)*vdif(4,1)**2*        &
     &       vdif(4,2)**2*vdif(4,3)**2
          
        endif

      case(6)                     ! for the case that a=b

        ev(1:4)=v(1:4)
        ev(1)=(v(1)+v(2))/2.0d0
        ev(2)=ev(1)
        do i=1,4
          do j=1,4
            vdif(i,j)=ev(i)-ev(j)
          enddo
        enddo
        if(dabs(omeg-ev(1)).lt.haier) then

          aa=(dlog(dabs(vdif(4,1)))-dlog(dabs(vdif(3,1))))*vdif(3,1)

          aa=aa-vdif(4,3)
 
          cc=6.0d0*vdif(4,3)**2

        else if(dabs(omeg-ev(3)).lt.haier) then
 
          aa=2.0d0*(dlog(dabs(vdif(3,1)))-dlog(dabs(vdif(4,3))))*     &
     &       vdif(4,3)*vdif(3,1)

          aa=aa+(vdif(3,1)-vdif(4,3))*vdif(4,1)

          cc=6.0d0*vdif(4,1)**3

        else if(dabs(omeg-ev(4)).lt.haier) then
 
          aa=vdif(3,1)+(dlog(dabs(vdif(4,3)))-dlog(dabs(vdif(4,1))))* &
     &       vdif(4,3)
 
          cc=6.0d0*vdif(3,1)**2

        else

          dd=(omeg-ev(3))*vdif(1,4)-2.0d0*vdif(4,3)*(omeg-ev(1))
          aa=dlog(dabs(omeg-ev(4)))*(omeg-ev(4))**2*dd*vdif(3,1)**2
                  
          aa=aa+dlog(dabs(omeg-ev(3)))*(omeg-ev(3))**3*vdif(4,1)**3

          dd=(omeg-ev(3))*vdif(1,4)-2.0d0*(omeg-ev(4))*vdif(3,1)
          aa=aa+dlog(dabs(omeg-ev(1)))*(omeg-ev(1))**2*dd*vdif(4,3)**2

          dd=vdif(3,1)*(omeg-ev(4))**2-(omeg-ev(1))**2*vdif(4,3)
          aa=aa-vdif(3,1)*vdif(4,1)*vdif(4,3)*dd

          cc=6.0d0*vdif(3,1)**2*vdif(4,1)**3*vdif(4,3)**2
          
        endif

      case(8)                      ! for the case that a=b and c=d

        ev(1:4)=v(1:4)
        ev(1)=(v(1)+v(2))/2.0d0
        ev(2)=ev(1)
        do i=1,4
          do j=1,4
            vdif(i,j)=ev(i)-ev(j)
          enddo
        enddo
        if(dabs(omeg-ev(1)).lt.haier) then
        
          aa=-1.0d0
          
          cc=12.0d0*vdif(4,1)

        else if(dabs(omeg-ev(4)).lt.haier) then

          aa=1.0d0
          
          cc=6.0d0*vdif(4,1)

        else

          dd=dlog(dabs(omeg-ev(4)))-dlog(dabs(omeg-ev(1)))

          aa=6.0d0*(omeg-ev(1))**2*dd*(omeg-ev(4))
         
          dd=3.0d0*(omeg-ev(1))*vdif(4,1)+vdif(4,1)**2-6.0d0*          &
     &       (omeg-ev(1))**2
          aa=aa-vdif(4,1)*dd
      
          cc=12.0d0*vdif(4,1)**4    

        endif

      case(10)                   ! for the case that a=b=c

        ev(1:4)=v(1:4)
        ev(1)=(v(1)+v(2)+v(3))/3.0d0
        ev(2)=ev(1)
        ev(3)=ev(1)
        do i=1,4
          do j=1,4
            vdif(i,j)=ev(i)-ev(j)
          enddo
        enddo
        if(dabs(omeg-ev(4)).lt.haier) then
        
          aa=1.0d0
          
          cc=12.0d0*vdif(4,1)

        else

          dd=5.0d0*ev(1)*ev(4)+2.0d0*ev(4)**2-3.0d0*ev(1)*omeg-ev(1)**2
          dd=dd-9.0d0*ev(4)*omeg+6.0d0*omeg**2
          aa=vdif(1,4)*dd
  
          dd=dlog(dabs(omeg-ev(1)))-dlog(dabs(omeg-ev(4)))
          aa=aa-6.0d0*(ev(1)-omeg)*(ev(4)-omeg)**2*dd
 
          cc=12.0d0*vdif(4,1)**4

        endif

      case(16)                   ! for the case that a=b=c=d

        ev(1:4)=v(1:4)
        aa=1.0d0
        
        cc=24.0d0*(omeg-ev(4))     
    
      end select
   
      if(dabs(cc)*1.0d+10.ge.dabs(aa))wt=aa/cc

      return
      
  
      end subroutine redifwtz
!EOC      
