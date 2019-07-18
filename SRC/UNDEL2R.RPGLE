      *
      *  Pgm UNDEL2R - Un-delete records
      *
     Fundel2d   cf   e             workstn usropn
     F                                     sfile(undels1:@1rrn)
     F                                     sfile(msgsfl:msgrrn)
     F                                     sfile(undels2:@2rrn)
     Fundel2p   o    e             printer oflind(*in15)
     F                                     usropn

     F*ndel528  if   f  528        disk    usropn

     D k8              s             50    dim(164)
     D ret             s              8    dim(22) ctdata perrcd(1)
     D mid             s             10    dim(22) alt(ret)
     D msgds           s            512
     D rec1            s           8200
     D rec2            s           8200
     D rec3            s           8200
     D rec4            s           8166
     D usrspcPtr       s               *
     D usSize          s             10i 0
     D listEntN        s             10i 0
     D noLock          s               n
     D s2eof           s               n
     D someSel         s               n

     D mparms          ds
     D  $oper                  1      8
     D  $retc                  9     16
     D  $file                 17     26
     D  $libr                 27     36
     D  $mbr                  37     46
     D  $rrn                  47     51p 0
     D  $rrnc                 47     51
     D  $recln                52     54p 0
     D  $stbyt                55     55
     D  $shlim                56     58p 0
     D  $ofile                59     68
     D  $olibr                69     78
     D  $ombr                 79     88
     D  $recid                89    101
     D  $orcid               102    114
     D  $shli2               115    120p 0
      * Following field new for UNDELM2
     D  $rcds2cpy            121    125p 0
     D  $lock                126    126
     D  $bakfile             127    136
     D  $baklibr             137    146
     D  $bakmbr              147    156
     D  $bakrcid             157    169
     D  $bakstat             170    170

     D parms2c         ds
     D  p2cjob                 1     10
     D  p2cusr                11     20
     D  p2cjobn               21     26

     D undel2a         ds           253
     D  @shlim                 1      4b 0
     D  @rcds2cpy              5      8b 0
     D  @rcds2cpyc             5      8

     D ddata           ds
     D  lastr                  1      1    inz('*')
     D  datach                 2     51
     D  rastr                 52     52    inz('*')

     D msgids          ds
     D  msgid                  1      7
     D  dtacod                 8     10

     D msgdta          ds           256
     D  ms04b                  1      4b 0
     D  ms10a                  1     10
     D  ms10b                 11     20
     D  ms10c                 21     30
     D  ms08a                  1      8
     D  ms10d                  9     18
     D  ms10e                 19     28
     D  msrrnc                 1      5
     D  msfile                 6     15
     D  mslibr                16     25
     D  msmbr                 26     35
     D  msofil                36     45
     D  msolib                46     55
     D  msombr                56     65
     D  ms13a                  1     13
     D  ms10f                 14     23
     D  ms10g                 24     33
     D  ms13b                 34     46
     D  ms10h                 47     56
     D  ms10i                 57     66

     D                 ds
     D  bin2                   1      2b 0
     D  bin2r                  2      2

     D pfilib          ds
     D  pfile                  1     10
     D  plibr                 11     20

     D pbakfilib       ds
     D  pbakfile               1     10
     D  pbaklibr              11     20

     D poutfi          ds
     D  oufil                  1     10
     D  oulib                 11     20

     D poutmb          ds
     D  pm#elm                 1      2b 0
     D  pmmbr                  3     12
     D  pmrepl                13     20

     D o1fillib        ds
     D  o1file                 1     10
     D  o1libr                11     20

     DQUSH0100p        s               *

     DQUSH0100         DS                  based(QUSH0100p)                     QRPGLESRC.QUSGEN
     D QUSOLD                125    128B 0                                      Offset List Data
     D QUSSLD                129    132B 0                                      Size List Data
     D QUSNBRLE              133    136B 0                                      Number List Entries
     D QUSSEE                137    140B 0                                      Size Each Entry

     DQWC0100Lp        s               *

     DQWC0100L         DS                  based(QWC0100Lp)                     QRPGLESRC.QWCLOBJL
     D QWCJN01                 1     10
     D QWCJUN                 11     20
     D QWCJNBR                21     26
     D QWCLS                  27     36
     D QWCLS00                37     40B 0
     D QWCLT                  41     44B 0
     D QWCMN                  45     54
     D QWCSHARE               55     55
     D QWCLS01                56     56
     D QWCTI                  57     64

     D usnamlib        ds
     D  usname                 1     10
     D  uslibr                11     20

     D quscattrs       ds
     D  usatnum                1      4i 0
     D  usatkey                5      8i 0
     D  usatlen                9     12i 0
     D  usatauto              13     13

     D QUSEC           ds
     D  QUSBPRV                1      4i 0
     D  QUSBAVL                5      8i 0
     D  QUSEI                  9     15
     D  QUSERVED               9     15
     D  QUSED128              17    144

     D                sds
     D  ##prog                 1     10

     I*ndel528  aa  01
     I*                                 1  512  r512


     C     *entry        plist
     C                   parm                    pfilib
     C                   parm                    pmbr             10
     C                   parm                    prcdnb            9 0
     C                   parm                    pactio            4
     C                   parm                    plock             1
     C                   parm                    pbakfilib
     C                   parm                    pbakmbr          10
     C                   parm                    poutpu            8
     C                   parm                    poutfi
     C                   parm                    poutmb
      *
     C     first         ifeq      *blanks                                      d 1 time
     C                   exsr      zinit
     C                   move      'N'           first             1
     C                   end                                                    e 1 time
      *
     C                   movel     pfile         dfile
     C                   movel     plibr         dlibr
     C                   movel     pmbr          dmbr
     C                   z-add     prcdnb        drrn
      *
      *  if batch, print instead of display
     C     $jobty        ifeq      '0'                                          ? batch
     C     poutpu        andeq     '*'
     C                   movel     '*PRINT'      poutpu
     C                   end                                                    e batch
      *
      *  get current library
     C     dlibr         ifeq      '*CURLIB'                                    ? *curlib
     C                   movel     $curli        dlibr
     C     dlibr         ifeq      '*NONE'                                      ? *crtdft
     C                   movel     'QGPL    '    dlibr
     C                   end                                                    e *crtdft
     C                   end                                                    e *curlib
      *
     C     pactio        ifeq      '*RTV'                                       ? *rtv
     C     poutpu        caseq     '*       '    dodsp
     C     poutpu        caseq     '*PRINT  '    doprt
     C     poutpu        caseq     '*OUTFILE'    dooutf
     C                   end
     C                   end                                                    e *rtv
      *
     C     pactio        ifeq      '*UPD'                                       ? *upd
     C                   exsr      doupd
     C                   end                                                    e *upd
      *
     C     thend         tag
     C                   movel     'TERMINAT'    $oper
     C                   exsr      tourm2
     C                   movel     'RMVALL  '    msgop
     C                   exsr      tourmc
     C                   seton                                        lr
      *-------------------------------------------------------------------------
     C     doupd         begsr
      *
     C                   move      'ESCP    '    msgop
     C                   exsr      undelt
     C     $retc         ifeq      *blanks                                      ? good
     C     $rrn          andgt     0
     C                   movel     'TOL0013'     msgid
     C                   move      $rrnc         msrrnc
     C                   move      $file         msfile
     C                   move      $libr         mslibr
     C                   move      $mbr          msmbr
     C                   move      'INFO    '    msgop
     C                   exsr      wrmsg
     C                   end                                                    e good
     C                   endsr
      *-------------------------------------------------------------------------
     C     dodsp         begsr
     C                   open      undel2d
     C                   move      'Y'           dspopn            1
     C                   z-add     1             dposit
     C                   move      *blanks       ofile
     C                   move      *blanks       olibr
     C                   move      *blanks       ombr
     C                   move      *blank        dsp1st
      *
     C     1             doueq     2                                            d forever
     C     dposit        ifgt      $recln                                       ? 2 big
     C                   z-add     $recln        dposit
     C                   end                                                    e 2 big
     C     dposit        iflt      1                                            ? 2 small
     C                   z-add     1             dposit
     C                   end                                                    e 2 small
     C     drrn          iflt      1                                            ? no rrn
     C                   z-add     0             drrn
     C                   end                                                    e no rrn
      *  round position-in-rec down
     C                   exsr      round
      *
      *  get current library
     C     dlibr         ifeq      '*CURLIB'                                    ? *curlib
     C                   movel     $curli        dlibr
     C     dlibr         ifeq      '*NONE'                                      ? *crtdft
     C                   movel     'QGPL    '    dlibr
     C                   end                                                    e *crtdft
     C                   end                                                    e *curlib
      *
      *  get the record (except 1st time)
     C     dsp1st        ifne      *blanks                                      ? get rec
     C     dfile         orne      *blanks
     C                   exsr      rdrec
     C                   end                                                    e get rec
     C                   move      'N'           dsp1st            1
      *
     C     dfile         ifne      ofile                                        ? diff
     C     dlibr         orne      olibr
     C     dmbr          orne      ombr
     C     dfile         ifne      *blanks                                      ? n-blank
     C     dlibr         andne     *blanks
     C     dmbr          andne     *blanks
     C                   movel     'RTVMBRD '    $coper
     C                   exsr      tourc
     C                   end                                                    e n-blank
     C                   end                                                    e diff
      *
      *  write the subfile page
     C                   exsr      wrsfl
      *  to the screen!
     C                   exsr      dspundelc1
      *
     C                   if        noLock = *on                                 ? nolock
     C                   eval      noLock = *off
     C                   exsr      lockwin
     C                   exsr      dspundelc1
     C                   end                                                    e nolock
      *
     C                   read      undelc1
     C     *inkc         cabeq     '1'           enddsp
     C     *inkl         cabeq     '1'           enddsp
      *
      *  if any msg's, clear msg subfile
     C     msgrrn        ifgt      0                                            ? any msgs
     C                   setoff                                       9596
     C                   write     msgsflc
     C                   z-add     0             msgrrn
     C                   end                                                    e any msgs
      *  roll back...
     C     *in93         ifeq      '1'                                          ? back
     C     dposit        ifle      1                                            ? @ top
     C                   sub       1             drrn
     C     drrn          iflt      1                                            ? < 1
     C                   z-add     1             drrn
     C                   end                                                    e < 1
     C                   else                                                   x @ top
     C                   sub       perpag        dposit
     C     dposit        iflt      1                                            ? 2 much
     C                   z-add     1             dposit
     C                   end                                                    e 2 much
     C                   end                                                    e @ top
     C                   end                                                    e back
      *  roll forward...
     C     *in92         ifeq      '1'                                          ? fwd
     C                   add       perpag        dposit
     C     dposit        ifgt      $recln                                       ? 2 far
     C                   z-add     1             dposit
     C                   add       1             drrn
     C                   end                                                    e 2 far
     C                   end                                                    e fwd
      *
      *  round position-in-rec down
     C                   exsr      round
      *
      *  if f19/f20...
     C     *inkt         ifeq      '1'                                          ? f19/20=prv/next
     C     *inku         oreq      '1'
     C     *like         define    drrn          xrrn
     C                   z-add     drrn          xrrn
     C                   movel     'NXTDEL  '    $oper
     C     drrn          add       1             $rrn
     C     *inkt         ifeq      '1'                                          ? f19=prv
     C                   movel     'PRVDEL  '    $oper
     C     drrn          sub       1             $rrn
     C                   end                                                    e f19=prv
      *
     C                   exsr      tourm2
      *
     C     $retc         ifeq      *blanks                                      ? good
     C                   exsr      getsts
     C                   else                                                   x good
     C     $retc         ifeq      'LIMXCEDD'                                   ? limxcedd
     C                   z-add     $rrn          drrn
     C     $rrn          sub       xrrn          ms04b
     C     ms04b         iflt      0                                            ? neg
     C                   z-sub     ms04b         ms04b
     C                   end                                                    e neg
     C     ms04b         ifeq      1                                            ? 1
     C                   movel     'TOL0017'     msgid
     C                   else                                                   x 1
     C                   movel     'TOL0015'     msgid
     C                   end                                                    e 1
     C                   exsr      wrmsg
     C                   else                                                   x limxcedd
     C                   exsr      retmsg
     C                   end                                                    e limxcedd
     C                   end                                                    e good
     C                   end                                                    e f19/20=prv/next
      *
      *  if f23...
     C     *inkx         ifeq      '1'                                          ? f23=undelete
      *   undelete rec on 2nd f23 in a row
     C     prif23        ifeq      '1'                                          ? prior f23
     C                   exsr      undelt
     C     $retc         ifeq      *blanks                                      ? good
     C                   move      $rrnc         msrrnc
     C                   move      $file         msfile
     C                   move      $libr         mslibr
     C                   move      $mbr          msmbr
     C                   movel     'TOL0013'     msgid
     C                   exsr      wrmsg
     C                   end                                                    e good
      *   if 1st f23, say "un-delete pending"
     C                   else                                                   x prior f23
     C                   move      $rrnc         msrrnc
     C                   move      $file         msfile
     C                   move      $libr         mslibr
     C                   move      $mbr          msmbr
     C                   movel     'TOL0014'     msgid
     C                   exsr      wrmsg
     C                   end                                                    e prior f23
     C                   end                                                    e f23=undelete
     C                   move      *inkx         prif23            1
     C                   end                                                    e forever
     C     enddsp        tag
     C                   close     undel2d
     C                   move      'N'           dspopn
     C                   endsr
      *-------------------------------------------------------------------------
     C     dspundelc1    begsr

     C                   write     undeldf1
     C     msgrrn        ifgt      0                                            ? any msgs
     C                   seton                                        9596
     C                   write     msgsflc
     C                   setoff                                       9596
     C                   end                                                    e any msgs
     C     dfile         comp      *blanks                            313130
     C                   seton                                        20        sfldspctl
     C     #insfl        comp      0                                  21        sfldsp
     C     *like         define    dfile         ofile
     C     *like         define    dlibr         olibr
     C     *like         define    dmbr          ombr
     C                   movel     dfile         ofile
     C                   movel     dlibr         olibr
     C                   movel     dmbr          ombr

     C                   write     undelc1
     C                   endsr
      *-------------------------------------------------------------------------
     C     doprt         begsr
      *
     C                   open      undel2p
     C                   move      'Y'           prtopn            1
      *
     C                   exsr      rdrec
     C                   movel     'RTVMBRD '    $coper
     C                   exsr      tourc
     C                   movel     $sysnm        sysnam
     C                   write     undelpr1
      *
     C     gotrec        ifeq      'Y'                                          ? rec read
     C                   z-add     1             dpos
     C                   z-add     0             rec#in
      *
      *  write all lines for this rec
     C     dpos          dowle     $recln                                       d 1 page
     C                   exsr      get8k
     C                   move      k8(l#)        datach
      *
     C                   movel     'XLTDSPL '    $oper
     C                   exsr      tourm
      *
     C   16              exsr      oflo6
     C                   setoff                                       15
     C                   write     undelpr2
     C   15              seton                                        16
     C                   add       linlen        dpos
     C                   end                                                    e 1 page
     C                   end                                                    e rec read
      *
     C     endprt        tag
     C                   close     undel2p
     C                   move      'N'           prtopn
     C                   endsr
      *-------------------------------------------------------------------------
     C     oflo6         begsr
     C                   write     undelpr1
     C                   setoff                                       16
     C                   endsr
      *----------------------------------------------------------------
     C     dooutf        begsr
      *
     C                   movel     dfile         $file
     C                   movel     dlibr         $libr
     C                   movel     dmbr          $mbr
     C                   z-add     drrn          $rrn
     C                   movel     oufil         $ofile
     C                   movel     oulib         $olibr
     C                   movel     pmmbr         $ombr
      *
      *  ck outfile existence
     C                   movel     'CKOUTF  '    $coper
     C                   exsr      tourc
     C                   move      *blanks       $orcid
      *
      *  if outfile exists, it must have the same rec fmt;
      *  get the rec fmt
     C     $cretc        ifeq      *blanks                                      ? found
     C                   movel     'OUTRID  '    $oper
     C                   exsr      tourm2
     C                   end                                                    e found
      *
      *  create the outfile or member, if necessary
     C                   movel     'CRTOUTF '    $coper
     C                   exsr      tourc
     C     $cretc        cabne     'GOOD'        endouf
      *
      *  write the rec to the outfile
     C                   move      'ESCP    '    msgop
     C                   movel     'OUTFILE '    $oper
     C                   exsr      tourm
      *
     C     $retc         ifeq      *blanks                                      ? good
     C     $rrn          andgt     0
     C                   movel     'TOL0018'     msgid
     C                   move      $rrnc         msrrnc
     C                   move      $file         msfile
     C                   move      $libr         mslibr
     C                   move      $mbr          msmbr
     C                   move      $ofile        msofil
     C                   move      $olibr        msolib
     C                   move      $ombr         msombr
     C                   move      'INFO    '    msgop
     C                   exsr      wrmsg
     C                   end                                                    e good
     C     endouf        endsr
      *-------------------------------------------------------------------------
     C     tourm         begsr
      *
     C                   exsr      tourm2
      *
      *  write err msg, if any
     C                   exsr      retmsg
     C                   endsr
      *-------------------------------------------------------------------------
     C     tourm2        begsr
     C                   eval      $retc = 'Hi there'
     C                   call      'UNDELM2'                            51
     C                   parm                    mparms
     C                   parm                    datach
     C                   parm                    rec1
     C                   parm                    rec2
     C                   parm                    rec3
     C                   parm                    rec4
      *
     C     $retc         ifeq      'NOLOCK  '                                   ? nolock
     C                   eval      $retc = *blanks
     C                   eval      noLock = *on
     C                   end                                                    e nolock
     C                   endsr
      *-------------------------------------------------------------------------
     C     tourc         begsr
     C                   callb     'UNDEL2C'                            51
     C                   parm                    $coper            8
     C                   parm                    $cretc           10
     C                   parm                    $file
     C                   parm                    $libr
     C                   parm                    $mbr
     C                   parm                    dactrc
     C                   parm                    ddelrc
     C                   parm                    $ofile
     C                   parm                    $olibr
     C                   parm                    $ombr
     C                   parm                    pmrepl
     C                   parm                    ##prog
     C                   parm                    $curli           10
     C                   parm                    $sysnm            8
     C                   parm                    $jobty            1
     C                   parm                    parms2c
     C                   endsr
      *-------------------------------------------------------------------------
     C     tourmc        begsr
     C                   callb     'UNDEL2MC'
     C                   parm                    msgop             8
     C                   parm                    msgds
     C                   parm                    msgid
     C                   parm                    msgdta
     C                   parm                    msgkey            4
     C                   parm                    ##prog
     C                   endsr
      *-------------------------------------------------------------------------
     C     rdrec         begsr
      *
     C                   move      *blanks       gotrec            1
     C                   move      *blanks       dstat
     C                   movel     dfile         $file
     C                   movel     dlibr         $libr
     C                   movel     dmbr          $mbr
     C                   z-add     drrn          $rrn
     C                   z-add     0             $recln
     C                   move      *blanks       rec1
     C                   move      *blanks       rec2
     C                   move      *blanks       rec3
     C                   move      *blanks       rec4
      *
     C                   movel     'GETREC  '    $oper
     C                   exsr      tourm
      *
     C     $retc         ifeq      *blanks                                      ? good
     C                   move      'Y'           gotrec
     C                   exsr      getsts
     C                   end                                                    e good
     C                   endsr
      *-------------------------------------------------------------------------
     C     lockwin       begsr
      *  Display "mbr locked" window
      *
     C                   exfmt     undelw1
     C     *inkc         cabeq     '1'           endlock
     C     *inkl         cabeq     '1'           endlock
      *
     C     *inkf         ifeq      '1'                                          ? F6=dsp locks
     C                   exsr      dsplocks
     C                   endif                                                  e F6=dsp locks
      *
     C     endlock       tag
     C                   endsr
      *-------------------------------------------------------------------------
     C     dsplocks      begsr
      *  Display mbr data locks

     C                   eval      @2rrn = 0
     C                   eval      #insfl2 = 0
     C                   setoff                                       20        sflclr
     C                   setoff                                       21
     C                   write     undelc2

     C                   eval      usname = 'UNDEL2LOCK'
     C                   eval      uslibr = 'QTEMP     '
     C                   eval      OBJLusrspc = usnamlib
     C                   eval      usSize = 32768
     C                   exsr      crtusrspc
     C                   eval      QUSH0100p = usrspcPtr

     C                   eval      objlfmt = 'OBJL0100'
     C                   eval      objltype = '*FILE'
     C                   eval      objlmbr = dmbr
     C                   eval      o1file = dfile
     C                   eval      o1libr = dlibr
     C                   eval      QUSEC = *allx'00'
     C                   eval      QUSBPRV = 144

      *  List object locks
     C                   call      'QWCLOBJL'                           51
     C                   parm                    OBJLusrspc       20
     C                   parm                    objlfmt           8
     C                   parm                    o1fillib
     C                   parm                    objltype         10
     C                   parm                    objlmbr          10
     C                   parm                    QUSEC

     C                   eval      QUSH0100p = usrspcPtr
     C                   eval      QWC0100Lp = QUSH0100p + QUSOLD

      *  Loop thru lock entries
     C     1             do        QUSNBRLE      listEntN                       d listEntN
     C                   if        QWCLS00 = 1                                  ? held
     C                   if        QWCLT = 4                                    ? data lock
     C                   if        QWCLS = '*SHRUPD   ' or                      ? state
     C                             QWCLS = '*SHRNUP   ' or
     C                             QWCLS = '*EXCLRD   ' or
     C                             QWCLS = '*EXCL     '
     C                   eval      SELBAR = ' '
     C                   eval      JOBNAM = QWCJN01
     C                   eval      JOBUSR = QWCJUN
     C                   eval      JOBNUM = QWCJNBR
     C                   eval      LCKTYPE = QWCLS
     C                   add       1             @2rrn             5 0
     C                   add       1             #insfl2           5 0
     C                   write     undels2
     C                   endif                                                  e state
     C                   endif                                                  e data lock
     C                   endif                                                  e held

     C                   eval      QWC0100Lp = QWC0100Lp + QUSSEE
     C                   enddo                                                  e listEntN

      *  Loop on screen til user stops making selections
     C     someSel       doueq     *off                                         d someSel
     C                   eval      someSel = *off
     C                   write     undeldf2
     C                   seton                                        20        sfldspctl
     C     #insfl2       comp      0                                  21        sfldsp
     C                   seton                                        22        sflend
     C                   exfmt     undelc2

      *  Process selections
     C     s2eof         doueq     *on                                          d s2eof
     C                   readc     undels2                                77
     C                   eval      s2eof = *in77
     C     s2eof         ifeq      *off                                         ? undels2

     C     SELBAR        ifeq      '5'                                          ? selbar5
     C                   eval      someSel = *on
     C                   eval      p2cjob = JOBNAM
     C                   eval      p2cusr = JOBUSR
     C                   eval      p2cjobn = JOBNUM
     C                   eval      $coper = 'WRKJOB  '
     C                   exsr      tourc
     C                   end                                                    e selbar5

     C     SELBAR        ifeq      '8'                                          ? selbar8
     C                   eval      someSel = *on
     C                   eval      p2cjob = JOBNAM
     C                   eval      p2cusr = JOBUSR
     C                   eval      p2cjobn = JOBNUM
     C                   eval      $coper = 'WRKJOBLK'
     C                   exsr      tourc
     C                   end                                                    e selbar8

     C     SELBAR        ifeq      '9'                                          ? selbar9
     C                   eval      someSel = *on
     C                   eval      p2cjob = JOBNAM
     C                   eval      p2cusr = JOBUSR
     C                   eval      p2cjobn = JOBNUM
     C                   eval      $coper = 'WRKJOBOF'
     C                   exsr      tourc
     C                   end                                                    e selbar9

     C                   eval      SELBAR = *blank
     C                   update    undels2
     C                   end                                                    e undels2
     C                   end                                                    e s2eof
     C                   enddo                                                  e someSel

     C                   endsr
      *-------------------------------------------------------------------------
     C     getsts        begsr
      *
     C                   movel     $libr         dlibr
     C                   movel     $mbr          dmbr
     C                   z-add     $rrn          drrn
     C                   move      *blanks       dstat
     C                   move      *blanks       blabel
     C                   move      *blanks       bstat
     C     $rrn          ifgt      0                                            ? has recs
     C                   movel     'ACTIVE '     dstat
     C                   testb     '1'           $stbyt                   51
     C   51              movel     'DELETED'     dstat
     C     $bakstat      ifne      ' '                                          ? $bakstat
     C     $bakfile      andne     *blanks
     C                   movel     'Backup:'     blabel
     C     $bakstat      ifeq      'D'                                          ? deleted
     C                   movel     'DELETED'     bstat
     C                   else                                                   x deleted
     C                   movel     'ACTIVE '     bstat
     C                   end                                                    e deleted
     C                   end                                                    e $bakstat
     C                   end                                                    e has recs
     C                   endsr
      *-------------------------------------------------------------------------
     C     undelt        begsr
      *
     C                   movel     dfile         $file
     C                   movel     dlibr         $libr
     C                   movel     dmbr          $mbr
     C                   z-add     drrn          $rrn
     C                   z-add     0             $recln
      *
     C                   movel     'UNDELETE'    $oper
     C                   exsr      tourm
      *
     C     $retc         ifeq      *blanks                                      ? undeld
     C                   add       1             dactrc
     C                   sub       1             ddelrc
     C                   end                                                    e undeld
      *
     C     $retc         ifeq      *blanks                                      ? good
     C     $retc         oreq      'NOTDLTD '
     C                   movel     $libr         dlibr
     C                   movel     $mbr          dmbr
     C                   z-add     $rrn          drrn
     C                   movel     'ACTIVE '     dstat
     C                   testb     '1'           $stbyt                   51
     C   51              movel     'DELETED'     dstat
     C                   end                                                    e good
     C                   endsr
      *-------------------------------------------------------------------------
     C     round         begsr
      *  round position-in-rec down
      *
     C                   sub       1             dposit
     C                   div       linlen        dposit
     C                   mult      linlen        dposit
     C                   add       1             dposit
     C                   endsr
      *-------------------------------------------------------------------------
     C     wrsfl         begsr
      *
     C                   z-add     0             #insfl
     C                   setoff                                       20        sflclr
     C                   write     undelc1
      *
     C     gotrec        ifeq      'Y'                                          ? rec read
      *  get 50-char line#
     C                   exsr      round
     C                   z-add     dposit        dpos
     C                   z-add     0             rec#in
     C                   z-add     0             @1rrn
     C                   z-add     0             #insfl
      *
      *  write 1 page of subfile recs
     C     @1rrn         dowlt     #onpag                                       d 1 page
     C     dpos          andle     $recln
     C                   exsr      get8k
     C                   move      k8(l#)        datach
      *
     C                   movel     'XLTDSPL '    $oper
     C                   exsr      tourm
      *
     C                   add       1             @1rrn             5 0
     C                   add       1             #insfl            5 0
     C                   write     undels1
     C                   add       linlen        dpos
     C                   end                                                    e 1 page
     C                   end                                                    e rec read
      *
     C                   move      *blanks       dmore
     C     #insfl        ifgt      0                                            ? any sfl
     C                   move      'More...'     dmore
     C     dpos          ifgt      $recln                                       ? bottom
     C                   move      ' Bottom'     dmore
     C                   end                                                    e bottom
     C                   end                                                    e any sfl
     C                   endsr
      *-------------------------------------------------------------------------
     C     get8k         begsr
      *  get approp. 8k block into k8 array
      *
     C                   z-add     0             l#                5 0          line in 8k
     C     dpos          sub       1             line#             5 0          line in 32k
     C                   div       linlen        line#
     C                   add       1             line#
      *
     C     line#         ifle      164                                          ? rec1
     C                   z-add     line#         l#
     C                   z-add     1             rec#              3 0
     C                   else                                                   x rec1
     C     line#         ifle      328                                          ? rec2
     C     line#         sub       164           l#
     C                   z-add     2             rec#
     C                   else                                                   x rec2
     C     line#         ifle      492                                          ? rec3
     C     line#         sub       328           l#
     C                   z-add     3             rec#
     C                   else                                                   x rec3
     C     line#         sub       492           l#
     C                   z-add     4             rec#
     C                   end                                                    e rec3
     C                   end                                                    e rec2
     C                   end                                                    e rec1
      *
      *  put rec in k8, if not already
     C     rec#          ifne      rec#in                                       ? diff rec
     C     rec#          ifeq      1
     C                   movea     rec1          k8
     C                   end
     C     rec#          ifeq      2
     C                   movea     rec2          k8
     C                   end
     C     rec#          ifeq      3
     C                   movea     rec3          k8
     C                   end
     C     rec#          ifeq      4
     C                   movea     rec4          k8
     C                   end
     C                   z-add     rec#          rec#in            3 0
     C                   end                                                    e diff rec
     C                   endsr
      *-------------------------------------------------------------------------
     C     retmsg        begsr
      *  write a msg per $retc

     C     $retc         ifeq      'BKBADLIB'                                   ? escp
     C     $retc         oreq      'BKBADFIL'
     C     $retc         oreq      'BKBADMBR'
     C     $retc         oreq      'BKDIFFMT'
     C     $retc         oreq      'BKLOGICL'
     C     $retc         oreq      'BKNOTDB '
     C                   move      'ESCP    '    msgop
     C                   endif                                                  e escp
      *
     C     $retc         ifne      *blanks                                      ? a $retc
     C                   z-add     1             @x                5 0
     C     $retc         lookup    ret(@x)                                51
     C     *in51         ifeq      '0'                                          ? n.f.
     C                   movel     'TOL6666'     msgid
     C                   move      $retc         ms08a
     C                   movel     'UNDELM2   '  ms10d
     C                   movel     ##prog        ms10e
      *
     C                   else                                                   x n.f.
     C                   movel     mid(@x)       msgids
     C     dtacod        ifeq      '  1'                                        ? cod 1
     C                   move      $rrnc         msrrnc
     C                   move      $file         msfile
     C                   move      $libr         mslibr
     C                   move      $mbr          msmbr
     C                   end                                                    e cod 1
      *
     C     dtacod        ifeq      '  2'                                        ? cod 2
     C                   movel     $oper         ms08a
     C                   movel     'UNDELM2   '  ms10d
     C                   end                                                    e cod 2
      *
     C     dtacod        ifeq      '  3'                                        ? cod 3
     C                   movel     $libr         msgdta
     C                   end                                                    e cod 3
      *
     C     dtacod        ifeq      '  4'                                        ? cod 4
     C                   move      $file         ms10a
     C                   move      $libr         ms10b
     C                   end                                                    e cod 4
      *
     C     dtacod        ifeq      '  5'                                        ? cod 5
     C                   move      $file         ms10a
     C                   move      $libr         ms10b
     C                   move      $mbr          ms10c
     C                   end                                                    e cod 5
      *
     C     dtacod        ifeq      '  6'                                        ? cod 6
     C                   move      $recid        ms13b
     C                   move      $file         ms10h
     C                   move      $libr         ms10i
     C                   move      $orcid        ms13a
     C                   move      $ofile        ms10f
     C                   move      $olibr        ms10g
     C                   end                                                    e cod 6
      *
     C     dtacod        ifeq      '  7'                                        ? cod 7
     C                   move      $ofile        ms10a
     C                   move      $olibr        ms10b
     C                   move      $ombr         ms10c
     C                   end                                                    e cod 7
      *
     C     dtacod        ifeq      '  8'                                        ? cod 8
     C                   movel     $baklibr      msgdta
     C                   end                                                    e cod 8
      *
     C     dtacod        ifeq      '  9'                                        ? cod 9
     C                   move      $bakfile      ms10a
     C                   move      $baklibr      ms10b
     C                   end                                                    e cod 9
      *
     C     dtacod        ifeq      ' 10'                                        ? cod 10
     C                   move      $bakfile      ms10a
     C                   move      $baklibr      ms10b
     C                   move      $bakmbr       ms10c
     C                   end                                                    e cod 10
      *
     C     dtacod        ifeq      ' 11'                                        ? cod 11
     C                   move      $bakrcid      ms13a
     C                   move      $bakfile      ms10f
     C                   move      $baklibr      ms10g
     C                   move      $recid        ms13b
     C                   move      $file         ms10h
     C                   move      $libr         ms10i
     C                   end                                                    e cod 11
      *
     C                   end                                                    e n.f.
      *
     C                   exsr      wrmsg
     C                   end                                                    e a $retc
     C                   endsr
      *-------------------------------------------------------------------------
     C     wrmsg         begsr
      *  interface to msg handler pgm
      *
      *  default to writing from the msgf
     C     msgop         ifeq      *blanks                                      ? default
     C                   move      'MSGF    '    msgop
     C                   end                                                    e default
      *  call pgm to perform msg op's
     C                   exsr      tourmc
      *
      *  then write the msg to the sub-file
     C     dspopn        ifeq      'Y'                                          ? dspf open
     C     msgop         ifeq      'MSG     '                                   ? write msg
     C     msgop         oreq      'MSGF    '
     C                   movel     '*'           fldpgm
     C                   move      msgkey        fldkey
     C                   add       1             msgrrn            5 0
     C                   write     msgsfl
     C                   end                                                    e write msg
     C                   end                                                    e dspf open
      *
     C                   move      *blanks       msgid
     C                   move      *blanks       msgdta
     C                   move      *blanks       msgop
     C                   endsr
      *-------------------------------------------------------------------------
     C     crtusrspc     begsr
      *
     C                   exsr      uscrtus
      *
      *  If already there, delete & recreate
     C                   if        QUSBAVL > 0 and QUSEI = 'CPF9870'            ? there
     C                   eval      QUSEC = *allx'00'
     C                   eval      QUSBPRV = 144
     C                   call      'QUSDLTUS'                           51
     C                   parm                    usnamlib
     C                   parm                    QUSEC
     C                   exsr      uscrtus
     C                   endif                                                  e there
      *
      *  Change attributes to "automatically extendible"
     C                   eval      usatnum = 1
     C                   eval      usatkey = 3
     C                   eval      usatlen = 1
     C                   eval      usatauto = '1'
     C                   eval      QUSEC = *allx'00'
     C                   eval      QUSBPRV = 144

     C                   call      'QUSCUSAT'                           51
     C                   parm                    usretlib         10
     C                   parm                    usnamlib
     C                   parm                    quscattrs
     C                   parm                    QUSEC

      *  Get pointer to usrspc
     C                   call      'QUSPTRUS'                           51
     C                   parm                    usnamlib
     C                   parm                    usrspcPtr
     C                   parm                    QUSEC
     C                   endsr
      *-------------------------------------------------------------------------
     C     uscrtus       begsr
     C                   eval      usinit = x'00'
     C                   eval      usauth = '*ALL      '
     C                   eval      usrepl = '*NO       '
     C                   eval      ustext = *blanks
     C                   eval      QUSEC = *allx'00'
     C                   eval      QUSBPRV = 144

     C                   call      'QUSCRTUS'                           51
     C                   parm                    usnamlib
     C                   parm                    usattr           10
     C                   parm                    usSize
     C                   parm                    usinit            1
     C                   parm                    usauth           10
     C                   parm                    ustext           50
     C                   parm                    usrepl           10
     C                   parm                    QUSEC
     C                   endsr
      *-------------------------------------------------------------------------
     C     zinit         begsr
      *
      *  # sfl recs per page:
     C                   z-add     14            #onpag            3 0
      *  len of ea sfl line:
     C                   z-add     50            linlen            3 0
      *  bytes per page
     C     #onpag        mult      linlen        perpag            5 0
      *
     C                   move      plock         $lock
     C                   move      pbakfile      $bakfile
     C                   move      pbaklibr      $baklibr
     C                   move      pbakmbr       $bakmbr
      *
     C     *dtaara       define                  undel2a
     C                   in        undel2a
     C                   z-add     -1            $shlim
     C                   z-add     @shlim        $shli2
      *
     C     @rcds2cpyc    ifeq      '    '                                       ? blanks
     C                   z-add     20            $rcds2cpy
     C                   else                                                   x blanks
     C                   z-add     @rcds2cpy     $rcds2cpy
     C                   endif                                                  e blanks
      *
     C                   z-add     0             $rrn
     C                   z-add     0             $recln
     C                   z-add     0             msgrrn
      *
     C                   movel     'SYSNAME '    $coper
     C                   exsr      tourc
      *
     C                   movel     'VERSION '    $oper
     C                   exsr      tourm2
     C                   movel     $retc         dvers
     C                   endsr
      *-------------------------------------------------------------------------
**  RET/MID
NOTDLTD TOL0001  1
BADOPER TOL0002  2
BADLIB  TOL0003  3
LIBAUT  TOL0004  3
BADFILE TOL0005  4
FILEAUT TOL0006  4
NOTDBFILTOL0007  4
LOGICAL TOL0008  4
NOMBR   TOL0009  4
BADMBR  TOL0010  5
BADRRN  TOL0011  1
BADUNDELTOL0012  1
DIFRECIDTOL0019  6
DUPUNDELTOL0020  1
BADOUTF TOL0021  1
DUPOUTF TOL0022  7
BKBADLIBTOL0003  8
BKBADFILTOL0005  9
BKBADMBRTOL0010 10
BKDIFFMTTOL0024 11
BKLOGICLTOL0025  9
BKNOTDB TOL0026  9
