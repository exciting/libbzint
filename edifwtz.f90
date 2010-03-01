
! Copyright (C) Ricardo Gomez-Abal (RGA) and Xinzheng Li (XZL),
! Fritz-Haber-Institut der Max-Planck-Geselschaft, Berlin, Germany.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

!BOP
!
! !ROUTINE: edifwtz
!
! !INTERFACE:

      subroutine edifwtz(v,omeg,figu,wt)
!
! !DESCRIPTION:
!
! This subroutine calculates the weight on vertex 4 of the small tetrahedron.
! This is for the case of $sigfreq=3$ when we use the imaginary frequency.
! 
                                            
! !INPUT PARAMETERS:
      implicit none
      
      real(8), intent(in) :: v(4)       ! difference of the energy
!                      in k-mesh tetrahedron vertices and k-q mesh  
!                      tetrahedron vertices.

      real(8), intent(in) :: omeg !the frequency omega to be calculated

      integer(4), intent(in) :: figu ! If figu=4, it belongs to the none
!                                   equally case. If figu=6, v(1)=v(2).
!                                   If figu=8, v(1)=v(2) and v(3)=v(4).
!                                   If figu=10, v(1)=v(2)=v(3).
!                                   If figu=16, v(1)=v(2)=v(3)=v(4). 

 
! !OUTPUT PARAMETERS:            

      real(8), intent(out) :: wt  ! the weight on vertex 4.

! !LOCAL VARIABLES:

      integer(4) :: i,j

      real(8)    :: aa, bb, cc, dd
      real(8)    :: bb1,bb2,bb3,bb4
      real(8)    :: vp 

      real(8), dimension(4) :: ev
      real(8), dimension(4,4) :: vdif

! !DEFINED PARAMETERS:

      real(8), parameter :: haier=1.0d-20

! 
! !SYSTEM ROUTINES:

      intrinsic datan
      intrinsic dlog


 
! !REVISION HISTORY:
!
! Created 04.11.2004 by XZL.
!
!EOP
!BOC

      select case(figu)

      case(4)
        do i=1,4
          do j=1,4
            vdif(i,j)=v(i)-v(j)
          enddo
        enddo
         
        aa=2.0d0*vdif(1,2)*vdif(1,3)*vdif(2,3)*vdif(1,4)*vdif(2,4)*     &
     &     vdif(3,4)*(v(4)**2-omeg**2)
  
        aa=aa+2.0d0*omeg*(omeg**2-3.0d0*v(1)**2)*vdif(2,3)*            &
     &     vdif(2,4)**2*vdif(3,4)**2*datan(v(1)/omeg)

        aa=aa-2.0d0*omeg*(omeg**2-3.0d0*v(2)**2)*vdif(1,3)*            &
     &     vdif(1,4)**2*vdif(3,4)**2*datan(v(2)/omeg)

        aa=aa+2.0d0*omeg*vdif(1,2)*(omeg**2-3.0d0*v(3)**2)*            &
     &     vdif(1,4)**2*vdif(2,4)**2*datan(v(3)/omeg)

       
        dd=omeg**2*(v(2)*v(3)+v(1)*(v(2)+v(3)-2.0d0*v(4))-        &
     &      2.0d0*v(2)*v(4)-2.0d0*v(3)*v(4)+3.0d0*v(4)**2)
        dd=dd+3.0d0*v(4)*(v(2)*v(3)*v(4)-v(4)**3+v(1)*(-2.0d0*    &
     &     v(2)*v(3)+v(2)*v(4)+v(3)*v(4)))   
        aa=aa-2.0d0*omeg*vdif(1,2)*vdif(1,3)*vdif(2,3)*dd*              &
     &     datan(v(4)/omeg)
          
        bb1=-v(1)*(v(1)**2-3.0d0*omeg**2)*vdif(2,3)*vdif(2,4)**2*      &
     &     vdif(3,4)**2
     
        bb2=v(2)*(v(2)**2-3.0d0*omeg**2)*vdif(1,3)*vdif(1,4)**2*    &
     &     vdif(3,4)**2
     
        bb3=-vdif(1,2)*v(3)*(v(3)**2-3.0d0*omeg**2)*vdif(1,4)**2*    &
     &     vdif(2,4)**2
     
       
        dd=3.0d0*omeg**2*(v(4)**2*(2.0d0*v(4)-v(3)-v(2))+v(1)*     &
     &     (v(2)*v(3)-v(4)**2))
        dd=dd-v(4)**2*(v(4)*(-2.0d0*v(2)*v(3)+v(2)*v(4)+v(3)*    &
     &     v(4))+v(1)*(3.0d0*v(2)*v(3)-2.0d0*v(2)*v(4)-2.0d0*     &
     &     v(3)*v(4)+v(4)**2))
     
        bb4=-vdif(1,2)*vdif(1,3)*vdif(2,3)*dd
        
        bb=bb1*dlog((v(1)**2+omeg**2)/(v(4)**2+omeg**2))+               &
     &     bb2*dlog((v(2)**2+omeg**2)/(v(4)**2+omeg**2))+               &
     &     bb3*dlog((v(3)**2+omeg**2)/(v(4)**2+omeg**2))+               &
     &     (bb1+bb2+bb3+bb4)*dlog(v(4)**2+omeg**2)
     
        cc=6.0d0*vdif(1,2)*vdif(1,3)*vdif(2,3)*vdif(1,4)**2*  &
     &     vdif(2,4)**2*vdif(3,4)**2

      case(6)
         vp=(v(1)+v(2))*0.5d0
         ev(1)=vp
         ev(2)=vp
         ev(3)=v(3)
         ev(4)=v(4)
         do i=1,4
           do j=1,4
             vdif(i,j)=ev(i)-ev(j)
           enddo
         enddo
          
        dd=omeg**2*ev(4)+ev(1)*(omeg**2-ev(4)**2)+ev(3)*(ev(4)**2-      &
     &     2.0d0*omeg**2)+ev(1)**2*vdif(3,4)   
        aa=-2.0d0*dd*vdif(1,3)*vdif(1,4)*vdif(3,4)
          
        dd=3.0d0*ev(1)**3+3.0d0*ev(1)**2*ev(4)+omeg**2*(2.0d0*ev(3)+    &
     &     ev(4))-3.0d0*ev(1)*(omeg**2+2.0d0*ev(3)*ev(4))   
        aa=aa+2.0d0*omeg*dd*vdif(3,4)**2*datan(ev(1)/omeg)

        aa=aa+2.0d0*omeg*(omeg**2-3.0d0*ev(3)**2)*vdif(1,4)**3*         &
     &     datan(ev(3)/omeg)

        dd=-2.0d0*omeg**2*ev(3)+3.0d0*omeg**2*ev(4)-3.0d0*ev(4)**3-ev(1)* &
     &     (omeg**2-6.0d0*ev(3)*ev(4)+3.0d0*ev(4)**2)
        aa=aa+2.0d0*omeg*vdif(1,3)**2*dd*datan(ev(4)/omeg)

        dd=3.0d0*omeg**2*ev(1)*ev(3)+3.0d0*omeg**2*ev(3)*ev(4)+ev(1)**3*    &
     &     (ev(3)+2.0d0*ev(4))-3.0d0*ev(1)**2*(2.0d0*omeg**2+ev(3)*ev(4))   
        bb1=vdif(3,4)**2*dd
        
        bb3=-ev(3)*(ev(3)**2-3.0d0*omeg**2)*vdif(1,4)**3

        dd=-ev(4)**2*(-3.0d0*ev(1)*ev(3)+2.0d0*ev(1)*ev(4)+ev(3)*ev(4))- &
     &     3.0d0*omeg**2*(ev(1)*ev(3)+(ev(3)-2.0d0*ev(4))*ev(4))   
        bb4=vdif(1,3)**2*dd
        
        bb=bb1*dlog(ev(1)**2+omeg**2)+bb3*dlog(ev(3)**2+omeg**2)+       &
     &     bb4*dlog(ev(4)**2+omeg**2)
     
        cc=6.0d0*vdif(1,3)**2*vdif(1,4)**3*vdif(3,4)**2

      case(8)      ! for the case when v(1)=v(2) and v(3)=v(4)
         vp=(v(1)+v(2))*0.5d0
         ev(1)=vp
         ev(2)=vp
         ev(3)=v(3)
         ev(4)=v(4)
         do i=1,4
           do j=1,4
             vdif(i,j)=ev(i)-ev(j)
           enddo
         enddo
          
          dd=6.0d0*omeg**2-2.0d0*ev(1)**2-5.0d0*ev(1)*ev(4)+ev(4)**2
          aa=vdif(1,4)*dd
          
          dd=6.0d0*omeg*(ev(1)**2+2.0d0*ev(1)*ev(4)-omeg**2)
          aa=aa+dd*(datan(ev(1)/omeg)-datan(ev(4)/omeg))

          dd=3.0d0*(ev(1)**2*ev(4)-(2.0d0*ev(1)+ev(4))*omeg**2)
          bb=dd*dlog((ev(1)**2+omeg**2)/(ev(4)**2+omeg**2))

         
          cc=6.0d0*vdif(1,4)**4

      case(10)
          vp=(v(1)+v(2)+v(3))/3.0d0
         ev(1)=vp
         ev(2)=vp
         ev(3)=vp
         ev(4)=v(4)
         do i=1,4
           do j=1,4
             vdif(i,j)=ev(i)-ev(j)
           enddo
         enddo
     
        dd=6.0d0*omeg**2+ev(1)**2-5.0d0*ev(1)*ev(4)-2.0d0*ev(4)**2
        aa=vdif(4,1)*dd
          
        dd=6.0d0*omeg*(omeg**2-ev(4)**2-2.0d0*ev(1)*ev(4))
        aa=aa+dd*(datan(ev(1)/omeg)-datan(ev(4)/omeg))
        
        dd=-3.0d0*ev(1)*ev(4)**2+3.0d0*omeg**2*(ev(1)+2.0d0*ev(4))
        bb=dd*dlog((ev(1)**2+omeg**2)/(ev(4)**2+omeg**2))

         
        cc=6.0d0*vdif(1,4)**4

      case(16)
        aa=-v(4)
        bb=0.0d0
        cc=12.0d0*(omeg**2+v(4)**2)
      end select

!      wt=0.0d0
!      if((dabs(cc)*1.0d+2).gt.dabs(aa+bb)) then
       wt=(aa+bb)/cc
!      endif
      if(abs(wt).gt.1.0d+1)then
        write(*,1)wt,figu,omeg,v,vdif,aa,bb,cc
!        stop
      endif
    1 format('warning: weightz =',g18.10,' case:',i4,/,'omeg =',g18.10,/,'v =',4g18.10,    &
     &    /,'vdif = ',/,4(4g18.10,/),' aa =',g18.10,' bb =',g18.10,      &
     &    ' cc =',g18.10)     

      return
      
      end subroutine edifwtz
!EOC      
