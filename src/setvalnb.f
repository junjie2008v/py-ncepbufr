	SUBROUTINE SETVALNB ( LUNIT, TAGPV, NTAGPV, TAGNB, NTAGNB,
     .                        R8VAL, IRET )

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    SETVALNB
C   PRGMMR: J. ATOR          ORG: NCEP       DATE: 2016-07-29
C
C ABSTRACT:  THIS SUBROUTINE SHOULD ONLY BE CALLED WHEN A BUFR FILE IS
C   OPENED FOR OUTPUT, AND A SUBSET DEFINITION MUST ALREADY BE IN SCOPE
C   VIA A PREVIOUS CALL TO BUFR ARCHIVE LIBRARY SUBROUTINE OPENMB OR
C   EQUIVALENT.  THE FUNCTION WILL FIRST SEARCH FOR THE (NTAGPV)th
C   OCCURRENCE OF MNEMONIC TAGPV WITHIN THE OVERALL SUBSET DEFINITION,
C   COUNTING FROM THE BEGINNING OF THE SUBSET.  IF FOUND, IT WILL THEN
C   SEARCH FORWARD (IF NTAGNB IS POSITIVE) OR BACKWARD (IF NTAGNB IS
C   NEGATIVE) FROM THAT POINT WITHIN THE SUBSET FOR THE (NTAGNB)th
C   OCCURRENCE OF MNEMONIC TAGNB AND STORE R8VAL AS THE VALUE
C   CORRESPONDING TO THAT MNEMONIC. 
C
C PROGRAM HISTORY LOG:
C 2016-07-29  J. ATOR    -- ORIGINAL AUTHOR; BASED ON GETVALNB
C
C USAGE:    CALL SETVALNB (LUNIT, TAGPV, NTAGPV, TAGNB, NTAGNB,
C                          R8VAL, IRET)
C   INPUT ARGUMENT LIST:
C     LUNIT    - INTEGER: FORTRAN LOGICAL UNIT NUMBER FOR BUFR FILE
C     TAGPV    - CHARACTER*(*): PIVOT MNEMONIC; THE FUNCTION WILL
C                FIRST SEARCH FOR the (NTAGPV)th OCCURRENCE OF THIS
C                MNEMONIC, COUNTING FROM THE BEGINNING OF THE OVERALL
C                SUBSET DEFINITION
C     NTAGPV   - INTEGER: ORDINAL OCCURRENCE OF TAGPV TO SEARCH FOR
C     TAGNB    - CHARACTER*(*): NEARBY MNEMONIC; ASSUMING TAGPV IS
C                SUCCESSFULLY FOUND, THE FUNCTION WILL THEN SEARCH
C                NEARBY FOR THE (NTAGNB)th OCCURRENCE OF TAGNB AND
C                STORE R8VAL AS THE CORRESPONDING VALUE
C     NTAGNB   - INTEGER: ORDINAL OCCURRENCE OF TAGNB TO SEARCH FOR,
C                COUNTING FROM THE LOCATION OF TAGPV WITHIN THE OVERALL
C                SUBSET DEFINITION.  IF NTAGNB IS POSITIVE, THE FUNCTION
C                WILL SEARCH IN A FORWARD DIRECTION FROM THE LOCATION OF
C                TAGPV, OR IF NTAGNB IS NEGATIVE IT WILL INSTEAD SEARCH
C                IN A BACKWARDS DIRECTION.
C     R8VAL    - REAL*8: VALUE TO BE STORED CORRESPONDING TO (NTAGNB)th
C                OCCURRENCE OF TAGNB.
C
C   OUTPUT ARGUMENT LIST:
C     IRET     - INTEGER: RETURN CODE
C                   0 = NORMAL RETURN
C                  -1 = (NTAGNB)th OCCURENCE OF MNEMONIC TAGNB COULD
C                       NOT BE FOUND, OR SOME OTHER ERROR OCCURRED
C
C REMARKS:
C    THIS ROUTINE CALLS:        FSTAG    STATUS
C    THIS ROUTINE IS CALLED BY: None
C                               Normally called only by application
C                               programs
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

	USE MODA_USRINT
	USE MODA_MSGCWD
	USE MODA_TABLES

	INCLUDE 'bufrlib.prm'

	CHARACTER*(*) TAGPV, TAGNB

	REAL*8  R8VAL

C----------------------------------------------------------------------
C----------------------------------------------------------------------

	IRET = -1

C	Get LUN from LUNIT.

	CALL STATUS (LUNIT, LUN, IL, IM )
	IF ( IL .LE. 0 ) RETURN
	IF ( INODE(LUN) .NE. INV(1,LUN) ) RETURN

C	Starting from the beginning of the subset, locate the (NTAGPV)th
C	occurrence of TAGPV.

	CALL FSTAG( LUN, TAGPV, NTAGPV, 1, NPV, IERFT )
	IF ( IERFT .NE. 0 ) RETURN

C	Now, starting from the (NTAGPV)th occurrence of TAGPV, search
C	forward or backward for the (NTAGNB)th occurrence of TAGNB.

	CALL FSTAG( LUN, TAGNB, NTAGNB, NPV, NNB, IERFT )
	IF ( IERFT .NE. 0 ) RETURN

	IRET = 0
	VAL(NNB,LUN) = R8VAL
	    
	RETURN
	END