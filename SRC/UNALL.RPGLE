
      *  This pgm undeletes all deleted records in a physical file.
      *  Before running, override "afile" to the desired file.

     Fafile     ip   f32766        disk    infds(finfds)

     D finfds          ds
     D  infFile               83     92
     D  infLibr               93    102
     D  infMbr               129    138
     D  infNumrecs           156    159i 0
     D  infRRN               397    400i 0

     D qusec           ds
     D  qusbprv                1      4b 0
     D  qusbavl                5      8b 0
     D  qusei                  9     15
     D  qusedata              17    144

     D qusm0200        ds
     D  qusbrtn03              1      4i 0                                      bytes ret
     D  qusbavl04              5      8i 0                                      bytes avail
     D  qusmn03               29     38                                         mbr name
     D  qusnbrcr             141    144i 0                                      cur active recs
     D  qusnbrdr             145    148i 0                                      cur deleted recs
     D  qusncru              253    256u 0                                      cur active recs
     D  qusndru              257    260u 0                                      cur deleted recs

     D gmfilelibr      ds
     D   gmfile                1     10
     D   gmlibr               11     20

     D hiRRN           s             10i 0
     D RRNfrom         s             10i 0
     D RRNto           s             10i 0
     D prvRRN          s             10i 0
     D RRN             s             10i 0
     D mbrrcvrlen      s             10i 0
     D curActRecs      s             10i 0
     D curDelRecs      s             10i 0
     D mbrfmtname      s              8
     D mbroverride     s              1
     D gmMbr           s             10
     D gmretc          s              8
     D ddata           s             50
     D rec1            s           8200
     D rec2            s           8200
     D rec3            s           8200
     D rec4            s           8166

     D mparms          ds
     D  $oper                  1      8
     D  $retc                  9     16
     D  $file                 17     26
     D  $libr                 27     36
     D  $mbr                  37     46
     D  $rrn                  47     51p 0
     D  $rrnc                 47     51
     D  $recln                52     54p 0
     D  $stabyt               55     55
     D  $schlim               56     58p 0
     D  $ofile                59     68
     D  $olibr                69     78
     D  $ombr                 79     88
     D  $recid                89    101
     D  $orcid               102    114
     D  $schlim2             115    120p 0
      * Following field new for UNDELM2
     D  $rcds2cpy            121    125p 0
     D  $lock                126    126
     D  $bakfile             127    136
     D  $baklibr             137    146
     D  $bakmbr              147    156
     D  $bakrcid             157    169
     D  $bakstat             170    170

     Iafile     aa  01

     C                   if        infRRN > prvRRN + 1
     C                   eval      RRNfrom = prvRRN + 1
     C                   eval      RRNto   = infRRN - 1
     C                   exsr      undel
     C                   endif

     C                   eval      prvRRN = infRRN

     Clr                 if        prvRRN < hiRRN
     Clr                 eval      RRNfrom = prvRRN + 1
     Clr                 eval      RRNto   = hiRRN
     Clr                 exsr      undel
     Clr                 endif

     Clr                 eval      $oper = 'TERMINAT'
     Clr                 exsr      tom2
      *---------------------------------------------------------------------
     C     undel         begsr
     C                   for       RRN = RRNfrom to RRNto
     C                   eval      $rrn = RRN
     C                   eval      $oper = 'UNDELETE'
     C                   exsr      tom2
     C                   endfor
     C                   endsr
      *---------------------------------------------------------------------
     C     tom2          begsr
     C                   eval      $retc = *blanks
     C                   call      'UNDELM2'
     C                   parm                    mparms
     C                   parm                    ddata
     C                   parm                    rec1
     C                   parm                    rec2
     C                   parm                    rec3
     C                   parm                    rec4
     C                   endsr
      *---------------------------------------------------------------------
     c     getmbr        begsr

      *  Get member description
     c                   eval      gmretc = *blanks
     c                   eval      mbrrcvrlen = %size(qusm0200)
     c                   eval      mbrfmtname = 'MBRD0200'
     c                   eval      mbroverride = '0'
     c                   eval      qusbprv = %size(qusec)
     c                   eval      qusbavl = 0

     c                   call      'QUSRMBRD'
     c                   parm                    qusm0200
     c                   parm                    mbrrcvrlen
     c                   parm                    mbrfmtname
     c                   parm                    gmfilelibr
     c                   parm                    gmmbr
     c                   parm                    mbroverride
     c                   parm                    qusec

     c                   if        qusbavl > 0                                  ? qusbavl
     c                   eval      gmretc = 'BADMBR  '
     c                   goto      endgm
     c                   endif                                                  e qusbavl

     c                   eval      gmmbr = qusmn03
     c                   eval      curActRecs = qusnbrcr
     c                   eval      curDelRecs = qusnbrdr

      *  NOTE: qusncru & qusndru were added in V4R5M0
     c                   if        qusncru > 0                                  ? qusncru
     c                   eval      curActRecs = qusncru
     c                   endif                                                  e qusncru
     c                   if        qusndru > 0                                  ? qusndru
     c                   eval      curDelRecs = qusndru
     c                   endif                                                  e qusndru
     c                   eval      hiRRN = curActRecs + curDelRecs
     c     endgm         tag
     c                   endsr
      *---------------------------------------------------------------------
     C     *inzsr        begsr
     C                   eval      $file = infFile
     C                   eval      $libr = infLibr
     C                   eval      $mbr  = infMbr
     C                   eval      $recln = 0
     C                   eval      $schlim = 100
     C                   eval      $schlim2 = $schlim
     C                   eval      $rcds2cpy = 20
     C                   eval      prvRRN = 0
     C                   eval      hiRRN = 0
     c                   eval      gmfile = $file
     c                   eval      gmlibr = $libr
     c                   eval      gmmbr  = $mbr

     c                   exsr      getmbr

     c                   eval      $mbr = gmmbr
     C                   endsr
      *---------------------------------------------------------------------
