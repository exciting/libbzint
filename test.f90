
! Copyright (C) Ricardo Gomez-Abal (RGA) and Xinzheng Li (XZL),
! Fritz-Haber-Institut der Max-Planck-Geselschaft, Berlin, Germany.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

program test

integer(4):: i,j,ind

      do i=1,4
       do j=1,4
        ind=mod(j+i-2,4)+1
        write(*,*)i,j,ind
       enddo
      enddo
end
