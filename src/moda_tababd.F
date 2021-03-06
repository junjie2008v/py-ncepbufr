	MODULE MODA_TABABD

#ifndef MAXTBA_H
#define MAXTBA_H
	  USE MODV_MAXTBA
#endif

#ifndef MAXTBB_H
#define MAXTBB_H
	  USE MODV_MAXTBB
#endif

#ifndef MAXTBD_H
#define MAXTBD_H
	  USE MODV_MAXTBD
#endif

#ifndef NFILES_H
#define NFILES_H
	  USE MODV_NFILES
#endif

#ifdef DYNAMIC_ALLOCATION
	  INTEGER, ALLOCATABLE :: NTBA(:)
	  INTEGER, ALLOCATABLE :: NTBB(:)
	  INTEGER, ALLOCATABLE :: NTBD(:)
	  INTEGER, ALLOCATABLE :: MTAB(:,:)
	  INTEGER, ALLOCATABLE :: IDNA(:,:,:)
	  INTEGER, ALLOCATABLE :: IDNB(:,:)
	  INTEGER, ALLOCATABLE :: IDND(:,:)
	  CHARACTER*128, ALLOCATABLE :: TABA(:,:)
	  CHARACTER*128, ALLOCATABLE :: TABB(:,:)
	  CHARACTER*600, ALLOCATABLE :: TABD(:,:)
#else
	  INTEGER :: NTBA(0:NFILES)
	  INTEGER :: NTBB(0:NFILES)
	  INTEGER :: NTBD(0:NFILES)
	  INTEGER :: MTAB(MAXTBA,NFILES)
	  INTEGER :: IDNA(MAXTBA,NFILES,2)
	  INTEGER :: IDNB(MAXTBB,NFILES)
	  INTEGER :: IDND(MAXTBD,NFILES)
	  CHARACTER*128 :: TABA(MAXTBA,NFILES)
	  CHARACTER*128 :: TABB(MAXTBB,NFILES)
	  CHARACTER*600 :: TABD(MAXTBD,NFILES)
#endif

	END MODULE
