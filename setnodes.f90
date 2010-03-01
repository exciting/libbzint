
! Copyright (C) Ricardo Gomez-Abal (RGA) and Xinzheng Li (XZL),
! Fritz-Haber-Institut der Max-Planck-Geselschaft, Berlin, Germany.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

!BOP
!
! !ROUTINE: setnodes
!
! !INTERFACE:
      subroutine setnodes
      
! !DESCRIPTION:
!
!This subroutine calculates the coordinates of the nodes of the
!integration polyhedron for convolutions within one tetrahedron.
!
! !USES:
      
      use polyhedron

! !LOCAL VARIABLES:

      implicit none
 
! !EXTERNAL ROUTINES:
      
      external surfnodes
      external unrepnodes
      external relnodes
      external sortnodes
      
! !REVISION HISTORY:
!      
! Created 1st. April 2004 by RGA
! Last Revision: 22st. April 2004 by RGA

!EOP
!BOC     
!     calculate the intersections between three planes that belongs to 
!     the surface of the tetrahedron
        
      call surfnodes

!     Eliminate repetitions and asign the corresponding value to ntype
!
      call unrepnodes

!     Select those nodes that surround the integration region (e<=ef and
!     f>=ef)
!
      call relnodes
!     Sort the nodes in the way needed by convw1t.      
!
      call sortnodes
  
      end subroutine setnodes
      
!EOC
