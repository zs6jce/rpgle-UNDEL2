      *
      *  Pgm UNDELM2 - User-state replacement for UNDELM
      *
     H bnddir( 'QC2LE' )

     Fundel528  if   f  528        disk    usropn
     Fundel528b if   f  528        disk    usropn
     Fsavf528   if   f  528        disk    usropn
     Fundel528o o    f  528        disk    usropn
     Fdelfile   o    f32766        disk    usropn recno(writeRRN)
     F                                     infds(delfileds)
     F                                     infsr(delinfsr)
     Fdelfilo   o    f32766        disk    usropn
     Fundelsrcf o    f   92        disk    usropn

     d realloc         pr              *   extproc('realloc')
     d  curPtr                         *   value
     d  nuSize                       10u 0 value

     d free            pr                  extproc('free')
     d  freePtr                        *   value

     d cvtd            pr                  extproc('cvtd')
     d  resDate                      10
     d  srcDate                      10
     d  template                    298

     d cvtt            pr                  extproc('cvtt')
     d  resTime                       8
     d  srcTime                       3
     d  template                    138

     d cvtts           pr                  extproc('cvtts')
     d  resTs                        26
     d  srcTs                        10
     d  template                    298

     d bitAnd          pr             1
     d  byte1                         1    value
     d  byte2                         1    value

     d validPkd        pr              n
     d  bytes                         8    value
     d  nBytes                       10i 0 value

     d rd528blk        pr
     d  destptr                        *   value
     d  blklength                    10u 0 value
     d  baseRRN                      10u 0 value
     d  offset                       10u 0 value

     d cvtDate         pr            10
     d  resDateLn                    10u 0
     d  resDateFmt                   10u 0
     d  resDsep                       1
     d  srcDate                       4

     d cvtTime         pr             8
     d  resTimeFmt                   10u 0
     d  resTsep                       1
     d  srcTime                       3

     d cvtTimestamp    pr            26
     d  srcTs                        10

     D ebcdtbl         c                   X'40404040404040404040404040404040+
     D                                       40404040404040404040404040404040+
     D                                       40404040404040404040404040404040+
     D                                       40404040404040404040404040404040+
     D                                       404142434445464748494A4B4C4D4E4F+
     D                                       505152535455565758595A5B5C5D5E5F+
     D                                       606162636465666768696A6B6C6D6E6F+
     D                                       707172737475767778797A7B7C7D7E7F+
     D                                       808182838485868788898A8B8C8D8E8F+
     D                                       909192939495969798999A9B9C9D9E9F+
     D                                       A0A1A2A3A4A5A6A7A8A9AAABACADAEAF+
     D                                       B0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF+
     D                                       C0C1C2C3C4C5C6C7C8C9CACBCCCDCECF+
     D                                       D0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF+
     D                                       E0E1E2E3E4E5E6E7E8E9EAEBECEDEEEF+
     D                                       F0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF'

     D myVersion       c                   '2.0.4   '

     D delfileDS       ds           400
     D  $1stat                11     15
     D  $1exno                46     52

     D cvtTemplate     ds           298
     D  tsize                  1      4u 0 inz(298)
     D  tddatn1                5      6u 0 inz(1)
     D  tddatn2                7      8u 0 inz(2)
     D  tmplt9                 9     10    inz(x'0000')
     D  toplen1               11     12u 0
     D  toplen2               13     14u 0
     D  tmplt15               15     16    inz(x'0000')
     D  tprfmt                17     18u 0 inz(0)
     D  tprsep                19     19    inz(x'00')
     D  tmplt20               20     42
     D  tlisize               43     46u 0 inz(256)
     D  tlisnum               47     48u 0 inz(2)
     D  tmplt49               49     58
     D  toff1                 59     62u 0 inz(24)
     D  toff2                 63     66u 0 inz(140)

      *  DDAT for ext date/timestamp
     D  d1len                 67     68u 0 inz(116)
     D  d1fmt                 69     70u 0
     D  d1dsep                71     71    inz(x'00')
     D  d1tsep                72     72    inz(x'00')
     D  d1hour                73     74u 0 inz(0)
     D  d1min                 75     76u 0 inz(0)
     D  d1mon                 77     78u 0 inz(0)
     D  d1yr                  79     80u 0 inz(0)
     D  d1cent                81     84u 0 inz(0)
     D  d1cendiv              85     88u 0 inz(0)
     D  d1caloff              89     92u 0 inz(82)
     D  tmplt93               93     98    inz(x'000000000000')
      *
     D  d1ernum               99    100u 0 inz(1)
     D  d1erorg              101    104u 0 inz(1721424)
     D  d1ernam              105    136    inz('AD')
     D  tmplt137             137    148
      *
     D  d1canum              149    150u 0 inz(2)
     D  d1cadat1             151    154u 0 inz(1721424)
     D  d1catyp1             155    156u 0 inz(1)
     D  tmplt157             157    166
      *
     D  d1cadat2             167    170u 0 inz(5373485)
     D  d1catyp2             171    172u 0 inz(0)
     D  tmplt173             173    182

      *  DDAT for system internal date/timestamp
     D  d2len                183    184u 0 inz(116)
     D  d2fmt                185    186u 0
     D  d2dsep               187    187    inz(x'00')
     D  d2tsep               188    188    inz(x'00')
     D  d2hour               189    190u 0 inz(0)
     D  d2min                191    192u 0 inz(0)
     D  d2mon                193    194u 0 inz(0)
     D  d2yr                 195    196u 0 inz(0)
     D  d2cent               197    200u 0 inz(0)
     D  d2cendiv             201    204u 0 inz(0)
     D  d2caloff             205    208u 0 inz(82)
     D  tmplt209             209    214    inz(x'000000000000')
      *
     D  d2ernum              215    216u 0 inz(1)
     D  d2erorg              217    220u 0 inz(1721424)
     D  d2ernam              221    252    inz('AD')
     D  tmplt253             253    264
      *
     D  d2canum              265    266u 0 inz(2)
     D  d2cadat1             267    270u 0 inz(1721424)
     D  d2catyp1             271    272u 0 inz(1)
     D  tmplt273             273    282
      *
     D  d2cadat2             283    286u 0 inz(5373485)
     D  d2catyp2             287    288u 0 inz(0)
     D  tmplt289             289    298

     D qusec           ds
     D  qusbprv                1      4b 0                                      bytes provided
     D  qusbavl                5      8b 0                                      bytes avail
     D  qusei                  9     15                                         exception ID
     D  qusedata              17    144                                         exception data

     D qusd0200        ds
     D  qusbrtn07              1      4B 0                                      bytes ret
     D  qusbavl08              5      8B 0                                      bytes avail
     D  qusobjn01              9     18                                         obj name
     D  qusobjln00            19     28                                         obj lib
     D  qusobjt01             29     38                                         obj type
     D  qusrl02               39     48                                         ret lib
     D  quseqa05              91    100                                         obj attr
     D  qustd12              101    150                                         text

     D qusm0200        ds
     D  qusbrtn03              1      4B 0                                      bytes ret
     D  qusbavl04              5      8B 0                                      bytes avail
     D  qusmn03               29     38                                         mbr name
     D  qusnbrcr             141    144i 0                                      cur active recs
     D  qusnbrdr             145    148i 0                                      cur deleted recs
     D  qusncru              253    256u 0                                      cur active recs
     D  qusndru              257    260u 0                                      cur deleted recs

     D qdbq41          ds          1024
     D  qdbbyrtn00             1      4b 0                                      bytes ret
     D  qdbbyava00             5      8b 0                                      bytes avail
     D  qdbfname              71     80                                         fmt name
     D  qdbdfseq              81     93                                         level ID

     D rfdfilelibr     ds
     D   rfdfilename           1     10
     D   rfdlibrname          11     20

     D retfilelibr     ds
     D   retfile               1     10
     D   retlibr              11     20

     D gffilelibr      ds
     D   gffile                1     10
     D   gflibr               11     20

     D gmfilelibr      ds
     D   gmfile                1     10
     D   gmlibr               11     20

     d tmpFilLib       ds
     d   tmpFile               1     10
     d   tmpLibr              11     20

     D                 ds
     D  a1                     1      1a
     D  int2                   3      4i 0
     D  int2a                  3      4
     D  int2r                  4      4
     D  varLn0                 5      6i 0
     D  varLn1                 7      8i 0
     D  uint2                  9     10u 0
     D  uint2r                10     10

      *  Seg Group hdr
     D SGhdr           ds
     D  SGtype                 1      2u 0                                      SG type
     D  SGsize                 3      4u 0                                      # 512-byte sectors
     D  SGobjVad               9     16                                         Object vad
     D  SGspcLoc              25     32                                         Space vad
     D  SGspcOff              31     32u 0                                      Space vad offset

      *  L/D Object Descriptor
     D ldObjDesc       ds
     D  ldOnam                 5     34                                         object name
     D  ldOtyp                35     35                                         object type
     D  ldOstp                36     36                                         object subtype
     D  ldLdes                69     72u 0                                      len of descriptor
     D  ldNobp               101    104u 0                                      # SG's in object
     D  ldNext               205    208u 0                                      # recs to next desc
     D  ldPtplOff            271    272u 0                                      len/vad tbl offset
     D  ldTypeOff            327    328u 0                                      SG type tbl offset

      *  S/R hdr
     D SRhdr           ds            80
     D  SRdes                  1      1                                         type of save
     D  SRlvl                  2      2                                         descriptor level
     D  SRlibName              3     32                                         library
     D  SRsrlnbr              53     60                                         CPU serial number

      *  S/R object hdr
     D OBhdr           ds
     D  OBname                 1     30                                         obj name
     D  OBtyp                 31     31                                         obj type
     D  OBsub                 32     32                                         obj subtype
     D  OBsiz                 68     71u 0                                      obj size
     D  OBofs                 72     75u 0                                      addtl info offset
     D  OBoir                 76     79u 0                                      OIR offset

      *  Database file additional info
     D DBaddl          ds
     D  DBfdtNum              17     20u 0                                      length of FDT
     D  DBmbrOff              21     24u 0                                      mbrDesc offset

      *  Format definition
     D FileFmt         ds
     D  FMTSYP                 1     16
     D  FMTSYPtype            15     15                                         obj type
     D  FMTlvlID              63     75                                         level ID
     D  FMT#flds             126    127u 0                                      # fields
     D  FMTfld1              128    128                                         1st field

      *  Format field definition
     D FmtField        ds
     D  FLDlen                 1      2u 0                                      len of def
     D  FLDdftOff             50     51u 0                                      default offset
     D  FLDdfmt               78     78                                         dat/timfmt
     D  FLDdsep               79     79                                         dat/timsep

      *  Format field default
     D FieldDft        ds
     D  DFTlen                 1      2u 0                                      length
     D  DFTqt                  3      4                                         x'007D'
     D  DFTts                  5     30                                         dft timestamp

      *  Saved field entry
     D fmtFldP         s               *
     D fmtFld          ds                  based(fmtFldP)
     D  FFdfmt                 1      1                                         dat/timfmt
     D  FFdsep                 2      2                                         dat/timsep
     D  FFdftlen               3      4u 0                                      dft length
     D  FFqt                   5      6                                         dft x'007D'
     D  FFts                   7     32                                         dft timestamp

      *  Length/vad entry
     D lenVad          ds
     D  lvLen                  1      4u 0                                      SG length
     D  lvLenDmpd              5      8u 0                                      SG length dumped
     D  lvVad                  9     16                                         SG virtual address

      *  SG types entry
     D SGtypent        ds             8
     D  SGtyp                  1      2u 0                                      SG type

      *  Data Space hdr
     D DB#DSP          ds
     D  DSPentct             301    304u 0                                      last ent (RRN)
     D  DSPdelct             317    320u 0                                      # deleted entries
     D  DSPentln             381    384u 0                                      entry len
     D  DSPfldsgOff          391    392u 0                                      fld table vad offset
     D  DSPmaxub             637    640u 0                                      max user buf len

      *  Data Space field table hdr
     D DSPfinfo        ds            32
     D  DSPfld#                1      2u 0                                      # fields
     D  DSP#var               17     18u 0                                      # varlen fields

      *  Data Space field table entry
     D DS#dspfP        s               *
     D DS#dspf         ds            32    based(DS#dspfP)
     D  DB#type                1      2u 0                                      data type
     D  DB#ln                  3      4u 0                                      field length
     D  DB#digs                4      4                                         field digits
     D  DB#off                 5      8u 0                                      offset (from atr)
     D  DB#ftmod              10     11                                         modifier
     D  DB#fal                15     16u 0                                      allocated length

      *  Data Space rec aux SG specifier
     D recAuxSp        ds             8
     D  raxSeg#                1      2u 0                                      aux SG seq #
     D  raxOff                 3      6u 0                                      aux SG offset
     D  raxOffa                3      6
     D  raxLen                 7      8u 0                                      len flds in aux SG

     D mparms          ds
     D  $oper                  1      8                                         operation
     D  $retc                  9     16                                         return code
     D  $file                 17     26                                         pf file
     D  $libr                 27     36                                         pf library
     D  $mbr                  37     46                                         pf member
     D  $RRN                  47     51p 0                                      pf RRN
     D  $recln                52     54p 0                                      pf record length
     D  $stabyt               55     55                                         record status byte
     D  $schlim               56     58p 0                                      recs 2 sch at a time
      *                                                                           -1 = use $schlim2
     D  $ofile                59     68                                         outfile
     D  $olibr                69     78                                         outfile library
     D  $ombr                 79     88                                         outfile member
     D  $recid                89    101                                         pf record ID
     D  $orcid               102    114                                         outfile record ID
     D  $schlim2             115    120p 0                                      large schlim
     D  $mparms120             1    120                                         large schlim
      * Following field new for UNDELM2
     D  $rcds2cpy            121    125p 0                                      CPYF NBRRCDS
     D  $rcds2cpyc           121    125
     D  $lock                126    126                                         lock mbr Y/N
     D  $bakfile             127    136                                         backup file
     D  $baklibr             137    146                                         backup libr
     D  $bakmbr              147    156                                         backup mbr
     D  $bakrcid             157    169                                         backup recid
     D  $bakstat             170    170                                         backup rec status

     D mparmsin        s                   like(mparms)

      *                                                        note: "pf"  = original physical file
      *                                                              "pfc" = copied   physical file
      *                                                              "pf5" = undel528 physical file
      *
      *  Context for UNDEL528 (pf5ctxOrg) or UNDEL528B (pf5ctxBak)
     D pf5ctxP         s               *
     D pf5ctx          ds                  based(pf5ctxP)
     D dsFldsP                         *
     D fmtFldsP                        *
     D dsFldsAlloc                   10i 0
     D fmtFldsAlloc                  10i 0
     D inPF5loRRN                    10i 0                                      lo pf RRN in pf5
     D inPF5hiRRN                    10i 0                                      hi pf RRN in pf5
     D RRN528in                      10i 0                                      pf5 RRN in r528data
     D pf5RRN                        10i 0                                      cur pf rec pf5 RRN
     D pf5offset                     10i 0                                      cur pf rec pf5 off
     D dsDataRRN                     10i 0
     D dsAuxRRN                      10i 0
     D recEntLn                      10i 0
     D usrBufLn                      10i 0
     D ds#flds                       10i 0
     D ds#vars                       10i 0
     D curActRecs                    10i 0                                      pf cur active recs
     D curDelRecs                    10i 0                                      pf cur deleted recs
     D highRRN                       10i 0                                      pf highest RRN
     D prefxLn                       10i 0                                      ln of atr, recAuxSp
     D*                                                                           & ALWNULL bits
     D PF5file                       10
     D pffile                        10
     D pflibr                        10
     D pfmbr                         10
     D lockPF                         1
     D orgOrBak                       1
     D inPF5file                     10
     D inPF5libr                     10
     D inPF5mbr                      10
     D r528data                     512

     D pf5ctxOrg       s                   like(pf5ctx)
     D pf5ctxBak       s                   like(pf5ctx)

     D m2cparms        ds
     D  m2cpf5name             1     10

     D qtempsyp        s               *
     D librsyp         s               *
     D filsyp          s               *
     D ctxPsav         s               *
     D sRecP           s               *
     D tRecP           s               *
     D sRec            s          32767    based(sRecP)
     D tRec            s          32767    based(tRecP)
     D DToutLen        s             10u 0 dim(26)
     D oDatFmt         s             10u 0
     D ofldln          s             10u 0
     D oTimFmt         s             10u 0

     D iLimit          s             10i 0
     D newAlloc        s             10i 0
     D i               s             10i 0
     D wkInt           s             10i 0
     D wkSecs          s             10i 0
     D obdrcvrlen      s             10i 0
     D mbrrcvrlen      s             10i 0
     D writeRRN        s             10i 0
     D rfdrcvrlen      s             10i 0
     D $RRNpfc         s             10i 0                                      pfc RRN for $RRN
     D RRN528          s             10i 0                                      cur pf5 RRN
     D auxLensOff      s             10i 0                                      auxSG off of lengths
     D schlim          s             10i 0                                      recs 2 sch at a time
     D schcnt          s             10i 0                                      recs searched
     D rcds2cpy        s             10i 0                                      CPYF NBRRCDS
     D ldObjRRN        s             10i 0
     D OBhdrOff        s             10i 0
     D DBaddlOff       s             10i 0
     D fmtOff          s             10i 0
     D DBfmtOff        s             10i 0
     D fieldOff        s             10i 0
     D descSecs        s             10i 0
     D lvTabOff        s             10i 0
     D typTabOff       s             10i 0
     D DShdrSecs       s             10i 0
     D DShdrRRN        s             10i 0
     D DSdataSecs      s             10i 0
     D DSauxSecs       s             10i 0
     D DSroff          s             10i 0
     D RRNcnt          s             10i 0
     D alNULLn         s             10i 0                                      len of ALWNULL bits
     D lntogo          s             10i 0
     D expRecl         s             10i 0
     D fldCnt          s             10i 0
     D varix           s             10i 0
     d ncopied         s             10i 0
     D varLen          s              5i 0
     D udRRN           s              9p 0
     D ouRRN           s              9p 0
     D m2cfrmrcd       s              9p 0
     D m2cnbrrcds      s              9p 0
     d halfBlock       s              9p 0
     D orgPF5name      s             10    inz('UNDEL2528 ')                    PF5 for orig file
     D bakPF5name      s             10    inz('UNDEL2528B')                    PF5 for backup file
     d mbrCopied       s             10
     D recfmtname      s             10
     D formatstr       s             29
     D extDate         s             10
     D extTime         s              8
     D extTs           s             26
     D m2coper         s              8
     D m2cretc         s              8
     D m2cfrmfile      s             10
     D m2cfrmlibr      s             10
     D m2cfrmmbr       s             10
     D m2ccrtfile      s              4
     D rfdfmtname      s              8
     D rfdrecfmt       s             10
     D rfdorideproc    s              1
     D rfdsystem       s             10
     D rfdfmttype      s             10
     D objtype         s             10
     D gmMbr           s             10
     D obdfmtname      s              8
     D mbrfmtname      s              8
     D mbroverride     s              1
     D gfretc          s              8
     D stabyt          s              1
     D delbit          s              1                                         x'40' is deleted bit
     D ddata           s             50
     D recwk           s          32767
     D recwkp          s               *
     D recwkb          s          32767    based(recwkp)
     D record1         s           8200
     D record2         s           8200
     D record3         s           8200
     D record4         s           8166
     D refmt           s              1
     D bkStabyt        s              1
     d loaded528       s               n
     D savf528open     s               n
     D undel528open    s               n
     D undel528bopen   s               n
     D undel528oopen   s               n
     D delfileopen     s               n
     D delfiloopen     s               n
     D srcfilopen      s               n
     d eofsf           s               n
     D nf528           s               n
     D doSearch        s               n
     D pfLocked        s               n
     D noLock          s               n
     D fromMe          s               n

     Iundel528  aa  01
     I                                  1  512  r528data01

     Iundel528b aa  02
     I                                  1  512  r528data02

     Isavf528   aa  03
     I                                  1  512  r528data03
     I                             u  513  516 0r528RRN
     I                                517  528  r528cksum

     C     *entry        plist
     C                   parm                    mparmsin
     C                   parm                    ddata
     C                   parm                    record1
     C                   parm                    record2
     C                   parm                    record3
     C                   parm                    record4

     c                   exsr      ckcaller

     c                   if        $oper = 'VERSION '                           ? version
     c                   eval      $retc = myVersion
     c                   goto      nowReturn
     c                   endif                                                  e version

     c                   if        validPkd($rcds2cpyc:5)                       ? good
     c                   eval      rcds2cpy = $rcds2cpy
     c                   else                                                   x good
     c                   eval      rcds2cpy = 20
     c                   endif                                                  e good

     c                   eval      $retc = *blanks
     C     $oper         caseq     'GETREC  '    @getrec
     C     $oper         caseq     'UNDELETE'    @undele
     C     $oper         caseq     'PRVDEL  '    @prvnxt
     C     $oper         caseq     'NXTDEL  '    @prvnxt
     C     $oper         caseq     'XLTDSPL '    @xltdspl
     C     $oper         caseq     'OUTRID  '    @outrid
     C     $oper         caseq     'OUTFILE '    @outfile
     C     $oper         caseq     'TERMINAT'    @terminat
     C                   cas                     @badoper
     C                   endcs

     c                   if        noLock = *on and $retc = *blanks and         ? noLock
     c                             $bakfile = *blanks
     c                   eval      $retc = 'NOLOCK  '
     c                   endif                                                  e noLock

     c                   eval      noLock = *off

     c     nowReturn     tag
     c                   exsr      doreturn
     c                   return
      *---------------------------------------------------------------------
     c     doreturn      begsr

     c                   if        fromMe                                       ? fromMe
     C                   movel     mparms        mparmsin
     c                   else                                                   x fromMe
     C                   movel     $mparms120    mparmsin
     c                   endif                                                  e fromMe

     c                   return
     c                   endsr
      *---------------------------------------------------------------------
     c     ckcaller      begsr
      *  If this pgm isn't called by UNDEL2R, (e.g. it's called by WRKDBF)
      *  blank the fields in mparms new to UNDELM2
      *  (taking care not to alter fields in WRKDBF after short mparms)

     c                   clear                   mparms
     c                   eval      $retc = %subst(mparmsin: 9: 8)
     c                   eval      %subst(mparmsin: 9: 8) = *blanks

     c                   if        $retc = 'Hi there'                           ? from me
     c                   eval      fromMe = *on
     c                   movel     mparmsin      mparms

     c                   else                                                   x from me
     c                   eval      fromMe = *off
     c                   movel     mparmsin      $mparms120
     c                   endif                                                  e from me
     c                   endsr
      *---------------------------------------------------------------------
     c     @badoper      begsr
     c                   eval      $retc = 'BADOPER '
     c                   endsr
      *---------------------------------------------------------------------
     c     @terminat     begsr

     c                   exsr      closefiles

     c                   eval      pf5ctxP = %addr(pf5ctxOrg)
     c                   exsr      freeAlloc

     c                   eval      pf5ctxP = %addr(pf5ctxBak)
     c                   exsr      freeAlloc
     c                   endsr
      *---------------------------------------------------------------------
     c     freeAlloc     begsr

     c                   if        dsFldsAlloc > 0 and dsFldsP <> *NULL         ? dsFldsP
     c                   callp     free(dsFldsP)
     c                   eval      dsFldsP = *NULL
     c                   eval      dsFldsAlloc = 0
     c                   endif                                                  e dsFldsP

     c                   if        fmtFldsAlloc > 0 and fmtFldsP <> *NULL       ? fmtFldsP
     c                   callp     free(fmtFldsP)
     c                   eval      fmtFldsP = *NULL
     c                   eval      fmtFldsAlloc = 0
     c                   endif                                                  e fmtFldsP
     c                   endsr
      *---------------------------------------------------------------------
     c     closefiles    begsr
     c                   exsr      closeComFiles
     c                   exsr      closeOrgFile
     c                   exsr      closeBakFile
     c                   endsr
      *---------------------------------------------------------------------
     c     closeOrgFile  begsr
     c                   if        undel528open                                 ? undel528
     c                   close     undel528
     c                   eval      undel528open = *off
     c                   endif                                                  e undel528
     c                   endsr
      *---------------------------------------------------------------------
     c     closeBakFile  begsr
     c                   if        undel528bopen                                ? undel528b
     c                   close     undel528b
     c                   eval      undel528bopen = *off
     c                   endif                                                  e undel528b
     c                   endsr
      *---------------------------------------------------------------------
     c     closeComFiles begsr

     c                   if        savf528open                                  ? savf528
     c                   close     savf528
     c                   eval      savf528open = *off
     c                   endif                                                  e savf528

     c                   if        delfileopen                                  ? delfile
     c                   close     delfile
     c                   eval      delfileopen = *off
     c                   endif                                                  e delfile

     c                   if        delfiloopen                                  ? delfilo
     c                   close     delfilo
     c                   eval      delfiloopen = *off
     c                   endif                                                  e delfilo

     c                   if        undel528oopen                                ? undel528o
     c                   close     undel528o
     c                   eval      undel528oopen = *off
     c                   endif                                                  e undel528o

     c                   if        srcfilopen                                   ? undelsrcf
     c                   close     undelsrcf
     c                   eval      srcfilopen = *off
     c                   endif                                                  e undelsrcf
     c                   endsr
      *---------------------------------------------------------------------
     c     @getrec       begsr
     c                   exsr      get1rec
     c                   endsr
      *---------------------------------------------------------------------
     c     @undele       begsr
     c                   eval      udRRN = $RRN
     c                   eval      $stabyt = x'00'
     c                   exsr      get1rec

      *  If rec not found, return
     c                   if        $RRN <> udRRN                                ? diff $RRN
     c                   eval      $RRN = udRRN
     c                   eval      $retc = 'BADRRN  '
     c                   endif                                                  e diff $RRN
     c     $retc         cabne     *blanks       endundel

     c                   if        bitAnd($stabyt:x'C0') <> x'C0'               ? not deleted
     c                   eval      $retc = 'NOTDLTD '
     c                   goto      endundel
     c                   endif                                                  e not deleted

     c                   exsr      undelete
     c     $retc         cabne     *blanks       endundel

      *  Force re-save of pf
     c                   eval      inPF5loRRN = 0
     c                   eval      inPF5hiRRN = 0

      *  Re-get rec
     c                   exsr      get1rec

     c     endundel      tag
     c                   endsr
      *---------------------------------------------------------------------
     c     @prvnxt       begsr
     c                   exsr      nxtdel
     c                   endsr
      *---------------------------------------------------------------------
     c     @xltdspl      begsr
      *  Translate ddata per ebcdtbl (to blank non-displayable chars)

     c                   eval      iLimit = %size(ddata)

     c     1             do        iLimit        i                              d i
     c                   eval      int2 = 0
     c                   eval      int2r = %subst(ddata:i:1)
     c                   eval      %subst(ddata:i:1) =
     c                             %subst(ebcdtbl:int2+1:1)
     c                   enddo                                                  e i
     c                   endsr
      *---------------------------------------------------------------------
     c     @outrid       begsr

      *  Get output format ID

     c                   eval      $orcid = *blanks
     c                   eval      rfdfilename = $ofile
     c                   eval      rfdlibrname = $olibr

     c                   exsr      dbrtvfd

     c                   eval      $olibr = retlibr
     c                   eval      $orcid = qdbdfseq
     c                   endsr
      *---------------------------------------------------------------------
     c     @outfile      begsr

     c                   if        $RRN <= 0                                    ? 0 $RRN
     c                   eval      $retc = 'BADRRN  '
     c                   goto      endoutf
     c                   endif                                                  e 0 $RRN

     c                   eval      ouRRN = $RRN
     c                   exsr      get1rec
     c     $retc         cabne     *blanks       endoutf

      *  If different rec ID, return
     c                   if        $orcid <> *blanks and                        ? diff $recid
     c                             $orcid <> $recid
     c                   eval      $retc = 'DIFRECID'
     c                   endif                                                  e diff $recid
     c     $retc         cabne     *blanks       endoutf

      *  If rec not found, return
     c                   if        $RRN <> ouRRN                                ? diff $RRN
     c                   eval      $RRN = ouRRN
     c                   eval      $retc = 'BADRRN  '
     c                   endif                                                  e diff $RRN
     c     $retc         cabne     *blanks       endoutf

     c                   exsr      outfile
     c     endoutf       tag
     c                   endsr
      *---------------------------------------------------------------------
     c     get1rec       begsr
      *  Get a rec (with no searching)

     c                   eval      doSearch = *off
     c                   exsr      getrec
     c                   endsr
      *---------------------------------------------------------------------
     c     getrec        begsr
      *  Get a record

     c                   eval      $bakstat = ' '
     c                   eval      pf5ctxP = %addr(pf5ctxOrg)
     c                   eval      gffile = $file
     c                   eval      gflibr = $libr

     c                   exsr      getfil

     c                   eval      $retc = gfretc
     c     $retc         cabne     *blanks       endgetr
     c                   eval      $libr = gflibr
     c                   eval      gmfile = $file
     c                   eval      gmlibr = $libr
     c                   eval      gmmbr  = $mbr

     c                   exsr      getmbr

     c                   eval      $mbr = gmmbr

      *  If RRN is past # recs in mbr, use highest RRN
     c                   if        $RRN > highRRN                               ? highRRN
     c                   eval      $RRN = highRRN
     c                   endif                                                  e highRRN

     c                   if        highRRN > 0                                  ? some recs
     c                   if        $RRN <= 0 and $oper = 'GETREC  '             ? $RRN
     c                   eval      $RRN = 1
     c                   endif                                                  e $RRN

     c                   if        $bakfile <> *blanks                          ? $bakfile
     c                   exsr      vfyBakfile
     c     $retc         cabne     *blanks       endgetr
     c                   endif                                                  e $bakfile

     c                   exsr      loadOrg528
     c     $retc         cabne     *blanks       endgetr

     c                   eval      pf5ctxP = %addr(pf5ctxOrg)
     c                   exsr      calcRRNoff

      *  If doSearch, search for a deleted rec
     c                   if        doSearch                                     ? doSearch
     c                   exsr      search4del

     c                   if        $retc <> *blanks and $retc <> 'LIMXCEDD'     ? err
     c                   goto      endgetr
     c                   endif                                                  e err
     c                   endif                                                  e doSearch

      *  Get data from the rec
     c                   exsr      getdata
     c                   eval      $stabyt = %subst(recwk:1:1)

      *  If deleted rec, get from backup file, if any
     c                   if        bitAnd($stabyt:x'C0') = x'C0' and            ? deleted
     c                             $bakfile <> *blanks
     c                   exsr      getBakRec
     c                   endif                                                  e deleted
     c                   endif                                                  e some recs

     c     endgetr       tag
     c                   endsr
      *---------------------------------------------------------------------
     c     getBakRec     begsr
      *  Get rec from backup file

     c                   eval      pf5ctxP = %addr(pf5ctxBak)
     c                   eval      gmfile = $bakfile
     c                   eval      gmlibr = $baklibr
     c                   eval      gmmbr  = $bakmbr

     c                   exsr      getmbr

     c                   eval      $bakmbr = gmmbr

      *  If RRN is past # recs in mbr, forget it
     c                   if        $RRN > highRRN                               ? highRRN
     c                   goto      endgbr
     c                   endif                                                  e highRRN

      *  Get data from the rec
     c                   exsr      calcRRNoff
     c                   exsr      getdata

     c                   eval      $bakstat = 'A'
     c                   eval      bkStabyt = %subst(recwk:1:1)
     c                   if        bitAnd(bkStabyt:x'C0') = x'C0'                ? deleted
     c                   eval      $bakstat = 'D'
     c                   endif                                                   e deleted

     c     endgbr        tag
     c                   eval      pf5ctxP = %addr(pf5ctxOrg)
     c                   endsr
      *---------------------------------------------------------------------
     c     load528       begsr
      *  If rec is not currently in 528-byte PF, load it from orig/back file

     c                   eval      loaded528 = *off
     c                   eval      m2cpf5name = PF5file

     c                   if        $RRN < inPF5loRRN or                         ? diff
     c                             $RRN > inPF5hiRRN or
     c                             pffile <> inPF5file or
     c                             pflibr <> inPF5libr or
     c                             pfmbr  <> inPF5mbr

     c                   exsr      closeComFiles
     c                   if        orgOrBak = 'O'                               ? Org
     c                   exsr      closeOrgFile
     c                   else                                                   x Org
     c                   exsr      closeBakFile
     c                   endif                                                  e Org

     c                   eval      m2ccrtfile = '*NO '

      *  CRTFILE(*YES) if new libr/file
     c                   if        pffile <> inPF5file or                       ? crtfile
     c                             pflibr <> inPF5libr
     c                   eval      m2ccrtfile = '*YES'

      *  Gen DDS source with FORMAT keyword
     c                   exsr      genfmtdds

      *  Check for work PF in QTEMP
     c                   eval      obdrcvrlen = %size(qusd0200)
     c                   eval      obdfmtname = 'OBJD0200'
     c                   eval      tmpFile = 'UNDEL2PF  '
     c                   eval      tmpLibr = 'QTEMP     '
     c                   eval      objtype = '*FILE     '
     c                   eval      qusbprv = %size(qusec)
     c                   eval      qusbavl = 0

     c                   call      'QUSROBJD'
     c                   parm                    qusd0200
     c                   parm                    obdrcvrlen
     c                   parm                    obdfmtname
     c                   parm                    tmpFilLib
     c                   parm                    objtype
     c                   parm                    qusec

      *  If there's a file already there, delete it
     c                   if        qusbavl = 0                                  ? dltf
     c                   eval      m2coper = 'DLTPF   '
     c                   exsr      tom2c
     c     $retc         cabne     *blanks       endld5
     c                   endif                                                  e dlft
     c                   endif                                                  e crtfile

     c                   eval      m2cfrmrcd = $RRN

      *  If rolling back, put $RRN in middle of block of records
     c                   if        $RRN < inPF5loRRN                            ? back
     c                   eval      halfBlock = rcds2cpy / 2
     c                   eval      m2cfrmrcd = $RRN - halfBlock
     c                   if        m2cfrmrcd < 1                                   ? < 1
     c                   eval      m2cfrmrcd = 1
     c                   endif                                                  e < 1
     c                   endif                                                  e back

      *  If asked, lock the PF
     c                   if        lockPF = 'Y'                                 ? lockPF
     c                   eval      noLock = *off
     c                   eval      pfLocked = *off
     c                   eval      m2coper = 'LOCKPF  '
     c                   exsr      tom2c
     c                   if        m2cretc = 'NOLOCK  '                         ? m2cretc
     c                   eval      noLock = *on
     c                   else                                                   x m2cretc
     c                   eval      pfLocked = *on
     c                   endif                                                  e m2cretc
     c                   endif                                                  e lockPF

      *  Copy recs from the PF to work PF
     c                   eval      m2cnbrrcds = rcds2cpy
     c                   eval      m2coper = 'CPYPF   '
     c                   eval      m2cfrmfile = pffile
     c                   eval      m2cfrmlibr = pflibr
     c                   eval      m2cfrmmbr  = pfmbr
     c                   exsr      callm2c
     c     $retc         cabne     *blanks       endld5
     c                   eval      ncopied = m2cnbrrcds
     c                   eval      mbrcopied = m2cfrmmbr

     c                   if        lockPF = 'Y'                                 ? unlock
     c                   exsr      unlockpf
     c                   endif                                                  e unlock

     C                   if        ncopied > 0                                  ? ncopied

      *  Save work PF to save file
     c                   eval      m2coper = 'SAVPF   '
     c                   exsr      tom2c
     c     $retc         cabne     *blanks       endld5

      *  Clear (or create) the 528-byte PF, and do overrides
     c                   eval      m2coper = 'CLR528  '
     c                   exsr      tom2c
     c     $retc         cabne     *blanks       endld5

      *  Copy save file to 528-byte PF

     C                   open      savf528
     c                   eval      savf528open = *on
     C                   open      undel528o
     c                   eval      undel528oopen = *on

     C     eofsf         doueq     *on                                          d to eof
     C                   read      savf528                                77
     c                   eval      eofsf = *in77
     C     eofsf         ifeq      *off                                         ? read
     C                   except    out528
     C                   endif                                                  e read
     C                   enddo                                                  e to eof

     C                   close     savf528
     c                   eval      savf528open = *off
     C                   close     undel528o
     c                   eval      undel528oopen = *off

     c                   eval      inPF5loRRN = m2cfrmrcd
     c                   eval      inPF5hiRRN = m2cfrmrcd + ncopied - 1
     c                   eval      inPF5file  = pffile
     c                   eval      inPF5libr  = pflibr
     c                   eval      inPF5mbr   = mbrcopied
     c                   endif                                                  e ncopied

     c                   eval      loaded528 = *on
     c                   endif                                                  e diff

      *  Open 528-byte physical
     c                   if        PF5file = orgPF5name                         ? orgPF5name
     c                   if        undel528open <> *on                          ? undel528
     c                   eval      m2coper = 'ORIDE528'
     c                   exsr      tom2c
     C                   open      undel528
     c                   eval      undel528open = *on
     c                   endif                                                  e undel528
     c                   endif                                                  e orgPF5name

     c                   if        PF5file = bakPF5name                         ? bakPF5name
     c                   if        undel528bopen <> *on                         ? undel528b
     c                   eval      m2coper = 'ORIDEBAK'
     c                   exsr      tom2c
     C                   open      undel528b
     c                   eval      undel528bopen = *on
     c                   endif                                                  e undel528b
     c                   endif                                                  e bakPF5name

      *  If new undel528 loaded, find Data Space
     c                   if        loaded528 = *on                              ? loaded528
     c                   exsr      getds
     c                   endif                                                  e loaded528

     c                   eval      $recln = usrBufLn
     c     endld5        tag
     c                   exsr      unlockpf
     c                   endsr
      *---------------------------------------------------------------------
     c     vfyBakfile    begsr
      *  Verify backup file

     c     $bakfile      cabeq     *blanks       endgetbk
     c                   eval      pf5ctxP = %addr(pf5ctxBak)
     c                   eval      gffile = $bakfile
     c                   eval      gflibr = $baklibr

     c                   exsr      getfil

     c                   if        gfretc = 'LOGICAL '
     c                   eval      $retc =  'BKLOGICL'
     c                   endif
     c                   if        gfretc = 'NOTDBFIL'
     c                   eval      $retc =  'BKNOTDB '
     c                   endif
     c                   if        gfretc = 'BADLIB  '
     c                   eval      $retc =  'BKBADLIB'
     c                   endif
     c                   if        gfretc = 'BADFILE '
     c                   eval      $retc =  'BKBADFIL'
     c                   endif
     c     $retc         cabne     *blanks       endgetbk
     c                   eval      $baklibr = gflibr

     c                   if        $bakmbr = '*FILEMBR  '                       ? *filembr
     c                   eval      $bakmbr = $mbr
     c                   endif                                                  e *filembr

     c                   eval      gmfile = $bakfile
     c                   eval      gmlibr = $baklibr
     c                   eval      gmmbr  = $bakmbr

      *  Get member description
     c                   exsr      getmbr

     c                   if        $retc = 'BADMBR  '                           ? BADMBR
     c                   eval      $retc = 'BKBADMBR'
     c                   goto      endgetbk
     c                   endif                                                  e BADMBR

     c                   eval      $bakmbr = gmmbr

      *  Get backup file format ID
     c                   eval      $bakrcid = *blanks
     c                   eval      rfdfilename = $bakfile
     c                   eval      rfdlibrname = $baklibr

     c                   exsr      dbrtvfd

     c                   eval      $bakrcid = qdbdfseq

      *  Get subject file format ID
     c                   eval      rfdfilename = $file
     c                   eval      rfdlibrname = $libr

     c                   exsr      dbrtvfd

     c                   if        $bakrcid <> qdbdfseq                         ? diff
     c                   eval      $recid = qdbdfseq
     c                   eval      $retc = 'BKDIFFMT'
     c                   goto      endgetbk
     c                   endif                                                  e diff

     c     endgetbk      tag
     c                   endsr
      *---------------------------------------------------------------------
     c     loadOrg528    begsr

     c                   eval      ctxPsav = pf5ctxP

      *  Load 528-byte physical from original file
     c                   eval      pf5ctxP = %addr(pf5ctxOrg)
     c                   eval      PF5file = orgPF5name
     c                   eval      pffile  = $file
     c                   eval      pflibr  = $libr
     c                   eval      pfmbr   = $mbr
     c                   eval      lockPF  = $lock
     c                   exsr      load528

      *  If specified, load 2nd 528-byte physical from backup file
     c                   if        $bakfile <> *blanks                          ? $bakfile
     c                   eval      pf5ctxP = %addr(pf5ctxBak)
     c                   eval      PF5file = bakPF5name
     c                   eval      pffile  = $bakfile
     c                   eval      pflibr  = $baklibr
     c                   eval      pfmbr   = $bakmbr
     c                   eval      lockPF  = 'N'
     c                   exsr      load528
     c                   endif                                                  e $bakfile

     c                   eval      pf5ctxP = ctxPsav
     c                   endsr
      *---------------------------------------------------------------------
     c     unlockpf      begsr
      *  Unlock the PF if locked

     c                   if        pfLocked                                     ? pfLocked
     c                   eval      m2coper = 'UNLOCKPF'
     c                   exsr      tom2c
     c                   if        m2cretc = *blanks                            ? m2cretc
     c                   eval      pfLocked = *off
     c                   endif                                                  e m2cretc
     c                   endif                                                  e pfLocked
     c                   endsr
      *---------------------------------------------------------------------
     c     genfmtdds     begsr
      *  Gen DDS source with FORMAT keyword to create temp file

      *  Create a srcf in QTEMP, if not yet
     c                   eval      m2coper = 'CRTSRCF '
     c                   exsr      tom2c
      *
      *  Get file format name
     c                   eval      rfdfilename = $file
     c                   eval      rfdlibrname = $libr
     c                   exsr      dbrtvfd
     c                   eval      recfmtname = qdbfname

      *  Write DDS source
     c                   open      undelsrcf
     c                   eval      srcfilopen = *on

     c                   eval      formatstr = 'FORMAT(' + %trim($libr) + '/' +
     c                                         %trim($file) + ')'
     c                   except    outsrcf

     c                   close     undelsrcf
     c                   eval      srcfilopen = *off
     c                   endsr
      *---------------------------------------------------------------------
     c     nxtdel        begsr
      *  Search for previous or next deleted rec, per $oper

     c                   eval      schlim = $schlim
     c                   if        schlim = -1                                  ? -1
     c                   eval      schlim = $schlim2
     c                   endif                                                  e -1

     c                   eval      doSearch = *on
     c                   exsr      getrec
     c                   endsr
      *---------------------------------------------------------------------
     c     search4del    begsr
      *  Search to a deleted rec.
      *  At entrance, pf5RRN & pf5offset point to rec status byte.
      *  Return with  pf5RRN & pf5offset pointing to deleted rec status byte.

     c                   eval      delbit = x'00'
     c                   eval      schcnt = 0

      *  Loop to a deleted rec
     c                   dou       delbit = x'40'                               ? to deleted
     c                   callp     rd528blk(%addr(stabyt): 1:
     c                                      pf5RRN: pf5offset)
     c                   eval      delbit = bitAnd(stabyt:x'40')

      *  Quit when we find a deleted rec
     c                   if        delbit = x'40'                               ? deleted
     c                   leave
     c                   else                                                   x deleted

     c                   eval      schcnt = schcnt + 1

      *  Quit if search limit exceeded
     c                   if        schcnt >= schlim                             ? schlim
     c                   eval      $retc = 'LIMXCEDD'
     c                   leave
     c                   endif                                                  e schlim

      *  If searching backward...
     c                   if        $oper = 'PRVDEL  '                           ? PRVDEL
     c                   if        $RRN <= 1                                    ? too low
     c                   eval      $retc = 'LIMXCEDD'
     c                   else                                                   x too low
     c                   eval      $RRN = $RRN - 1
     c                   endif                                                  e too low

      *  If searching forward...
     c                   else                                                   x PRVDEL
     c                   if        $RRN >= highRRN                              ? too high
     c                   eval      $retc = 'LIMXCEDD'
     c                   else                                                   x too high
     c                   eval      $RRN = $RRN + 1
     c                   end                                                    e too high
     c                   endif                                                  e PRVDEL

     c                   exsr      loadOrg528
     c                   exsr      calcRRNoff
     c                   end                                                    e deleted
     c     $retc         cabne     *blanks       ends2d
     c                   enddo                                                  e to deleted

     c     ends2d        tag
     c                   endsr
      *---------------------------------------------------------------------
     c     getfmt        begsr
      *  Get format and load field list

     c                   eval      DBfmtOff = 0
     c                   eval      fmtOff = DBaddlOff + DBfdtNum + 32

      *  Search for format -- loop looking for sysptr
     c                   do        4                                            d 4 tries
     c                   callp     rd528blk(%addr(FMTSYP): %size(FMTSYP):
     c                                      RRN528: fmtOff)
     c                   if        FMTSYPtype = x'19'                           ? FMTSYPtype
     c                   eval      DBfmtOff = fmtOff
     c                   leave
     c                   endif                                                  e FMTSYPtype
     c                   eval      fmtOff = fmtOff + 16
     c                   enddo                                                  e 4 tries

     c                   if        DBfmtOff = 0                                 e fmt N.F.
     c                   eval      $retc = 'FMTNF   '
     c                   goto      endgfm
     c                   endif                                                  e fmt N.F.
      *  Get format
     c                   callp     rd528blk(%addr(FileFmt): %size(FileFmt):
     c                                      RRN528: DBfmtOff)
     c                   eval      $recid = FMTlvlID
     c                   eval      fieldOff = DBfmtOff + 127

      *  Allocate heapspace for fields
     c                   eval      newAlloc = FMT#flds * %size(fmtFld)
     c                   eval      fmtFldsP = realloc(fmtFldsP: newAlloc)
     c                   eval      fmtFldsAlloc = newAlloc
     c                   eval      fmtFldP = fmtFldsP
      *  Load fields
     c                   do        FMT#flds                                     d FMT#flds
     c                   callp     rd528blk(%addr(FmtField): %size(FmtField):
     c                                      RRN528: fieldOff)
     c                   eval      FFdfmt = FLDdfmt
     c                   eval      FFdsep = FLDdsep
     c                   eval      FFdftlen = 0
     c                   eval      FFqt = *blanks
     c                   eval      FFts = *blanks
      *  Get default, if any
     c                   if        FLDdftOff > 0                                ? default
     c                   callp     rd528blk(%addr(FieldDft): %size(FieldDft):
     c                                      RRN528: fieldOff + FLDdftOff)
     c                   eval      FFdftlen = DFTlen
     c                   eval      FFqt = DFTqt
     c                   eval      FFts = DFTts
     c                   endif                                                  e default

     c                   eval      fieldOff = fieldOff + FLDlen
     c                   eval      fmtFldP = fmtFldP + %size(fmtFld)
     c                   enddo                                                  e FMT#flds
     c     endgfm        tag
     c                   endsr
      *---------------------------------------------------------------------
     c     getfil        begsr

     c                   eval      gfretc = *blanks
     c                   if        gflibr = *blanks                             ? gflibr
     c                   eval      gflibr = '*LIBL     '
     c                   endif                                                  e gflibr
     c                   eval      obdrcvrlen = %size(qusd0200)
     c                   eval      obdfmtname = 'OBJD0200'
     c                   eval      objtype = '*FILE     '
     c                   eval      qusbprv = %size(qusec)
     c                   eval      qusbavl = 0

     c                   call      'QUSROBJD'
     c                   parm                    qusd0200
     c                   parm                    obdrcvrlen
     c                   parm                    obdfmtname
     c                   parm                    gffilelibr
     c                   parm                    objtype
     c                   parm                    qusec

     c                   if        qusbavl = 0                                  ? qusbavl
     c                   eval      gflibr = qusrl02
     c                   if        %subst(quseqa05:1:2) = 'PF' or               ? PF/LF
     c                             %subst(quseqa05:1:2) = 'LF'
     c                   if        %subst(quseqa05:1:2) = 'LF'                  ? LF
     c                   eval      gfretc = 'LOGICAL '
     c                   endif                                                  e LF
     c                   else                                                   x PF/LF
     c                   eval      gfretc = 'NOTDBFIL'
     c                   endif                                                  e PF/LF

     c                   else                                                   x qusbavl
     c                   if        qusei = 'CPF9810'                            ? CPF9810
     c                   eval      gfretc = 'BADLIB  '
     c                   else                                                   x CPF9810
     c                   eval      gfretc = 'BADFILE '
     c                   endif                                                  e CPF9810
     c                   endif                                                  e qusbavl
     c                   endsr
      *---------------------------------------------------------------------
     c     getmbr        begsr

      *  Get member description
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
     c                   eval      $retc = 'BADMBR  '
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
     c                   eval      highRRN = curActRecs + curDelRecs
     c     endgm         tag
     c                   endsr
      *---------------------------------------------------------------------
     c     getds         begsr
      *  Get Data Space

     c                   if        $RRN <= 0                                    ? $RRN
     c                   eval      $RRN = 1
     c                   endif                                                  e $RRN

      *  Get QSRDSSPC.1 rec
     c                   eval      ldObjRRN = 9
     c                   callp     rd528blk(%addr(ldObjDesc): %size(ldObjDesc):
     c                                      ldObjRRN: 0)
      *  Get QSRDSSPC.1 SG hdr
     c                   eval      RRN528 = 17
     c                   callp     rd528blk(%addr(SGhdr): %size(SGhdr):
     c                                      RRN528: 0)
      *  Get S/R hdr
     c                   callp     rd528blk(%addr(SRhdr): %size(SRhdr):
     c                                      RRN528: SGspcOff)
      *  Get 1st S/R object hdr
     c                   eval      OBhdrOff = SGspcOff + 80
     c                   callp     rd528blk(%addr(OBhdr): %size(OBhdr):
     c                                      RRN528: OBhdrOff)
      *  If ASP info present, OBhdr occurs 32 bytes later
     c                   if        OBtyp <> x'19'                               ? not file
     c                   eval      OBhdrOff = OBhdrOff + 32
     c                   callp     rd528blk(%addr(OBhdr): %size(OBhdr):
     c                                      RRN528: OBhdrOff)
     c                   endif                                                  e not file

      *  Get DB additional info
     c                   eval      DBaddlOff = SGspcOff + OBofs
     c                   callp     rd528blk(%addr(DBaddl): %size(DBaddl):
     c                                      RRN528: DBaddlOff)
      *  Get format                         RRN528: DBaddlOff)
     c                   exsr      getfmt
     c     $retc         cabne     *blanks       endgds

      *  Get obj descriptor for data space
     c                   eval      RRN528 = ldObjRRN + ldNext

     c                   callp     rd528blk(%addr(ldObjDesc): %size(ldObjDesc):
     c                                      RRN528: 0)
     c                   eval      wkInt = (ldLdes + 4095) / 4096
     c                   eval      descSecs = 8 * wkInt
     c                   eval      RRNcnt = RRN528 + descSecs
     c                   eval      lvTabOff = (ldPtplOff - 4096)
     c                   eval      typTabOff = (ldTypeOff - 4096)
     c                   eval      DShdrSecs = 0
     c                   eval      DShdrRRN = 0
     c                   eval      DSdataSecs = 0
     c                   eval      dsDataRRN = 0
     c                   eval      DSauxSecs = 0
     c                   eval      dsAuxRRN = 0

      *  Loop thru lenVad's and SG type table in parallel
     c                   do        ldNobp                                       d ldNobp
     c                   callp     rd528blk(%addr(lenVad): %size(lenVad):
     c                                      RRN528: lvTabOff)
     c                   eval      wkSecs = lvLenDmpd / 512
     c                   callp     rd528blk(%addr(SGtypent): %size(SGtypent):
     c                                      RRN528: typTabOff)
     c                   if        SGtyp = 1                                    ? 1=hdr
     c                   eval      DShdrSecs = wkSecs
     c                   eval      DShdrRRN = RRNcnt
     c                   endif                                                  e 1=hdr
     c
     c                   if        SGtyp = 3                                    ? 3=data
     c                   eval      DSdataSecs = wkSecs
     c                   eval      dsDataRRN = RRNcnt
     c                   endif                                                  e 3=data
     c
     c                   if        SGtyp = 19                                   ? x13=aux
     c                   eval      DSauxSecs = wkSecs
     c                   eval      dsAuxRRN = RRNcnt
     c                   endif                                                  e x13=aux
     c
     c                   eval      RRNcnt = RRNcnt + wkSecs
     c                   eval      lvTabOff = lvTabOff + 16
     c                   eval      typTabOff = typTabOff + 8
     c                   enddo                                                  e ldNobp

      *  Get Data Space header
     c                   callp     rd528blk(%addr(DB#DSP): %size(DB#DSP):
     c                                      DShdrRRN: 0)
     c                   eval      recEntLn = DSPentLn
     c                   eval      usrBufLn = DSPmaxub

      *  Get Data Space field table hdr
     c                   callp     rd528blk(%addr(DSPfinfo): %size(DSPfinfo):
     c                                      DShdrRRN: DSPfldsgOff)
     c                   eval      ds#flds = DSPfld#
     c                   eval      ds#vars = DSP#var
      *  Get Data Space field table in heap
     c                   eval      newAlloc = ds#flds * %size(DS#dspf)

     c                   if        newAlloc > dsFldsAlloc                       ? more
     c                   eval      dsFldsP = realloc(dsFldsP: newAlloc)
     c                   eval      dsFldsAlloc = newAlloc
     c                   end                                                    e more

     c                   callp     rd528blk(dsFldsP: dsFldsAlloc:
     c                                      DShdrRRN: DSPfldsgOff + 32)

      *  Calc len of ALWNULL bits from offset to 1st field
     c                   eval      DS#dspfP = dsFldsP
     c                   eval      prefxLn = DB#off
     c                   eval      alNULLn = prefxLn - 1                        for status byte

     c                   if        DSP#var > 0                                  ? varlen
     c                   eval      alNULLn = alNULLn + 8
     c                   endif                                                  e varlen
     c     endgds        tag
     c                   endsr
      *---------------------------------------------------------------------
     c     getdata       begsr
      *  Get data for rec into recwk, starting at status byte,
      *  and into record1, et al, excluding status byte, recAusSp & ALWNULL bytes.
      *  At entrance, pf5RRN & pf5offset point to rec status byte.

     c                   callp     rd528blk(%addr(recwk): recEntln:
     c                                      pf5RRN: pf5offset)

     c                   eval      lntogo = recEntln - prefxLn

     c                   if        %parms >= 3 and lntogo > 0                   ? record1
     c                   eval      recwkp = %addr(recwk) + prefxLn
     c                   eval      record1 = %subst(recwkb:1:lntogo)
     c                   eval      lntogo = lntogo - %size(record1)
     c                   endif                                                  e record1

     c                   if        %parms >= 4 and lntogo > 0                   ? record2
     c                   eval      recwkp = recwkp + %size(record1)
     c                   eval      record2 = %subst(recwkb:1:lntogo)
     c                   eval      lntogo = lntogo - %size(record2)
     c                   endif                                                  e record2

     c                   if        %parms >= 5 and lntogo > 0                   ? record3
     c                   eval      recwkp = recwkp + %size(record2)
     c                   eval      record3 = %subst(recwkb:1:lntogo)
     c                   eval      lntogo = lntogo - %size(record3)
     c                   endif                                                  e record3

     c                   if        %parms >= 6 and lntogo > 0                   ? record4
     c                   eval      recwkp = recwkp + %size(record3)
     c                   eval      record4 = %subst(recwkb:1:lntogo)
     c                   eval      lntogo = lntogo - %size(record4)
     c                   endif                                                  e record4

      *  Read thru field table to see whether there are
      *  any reformattable fields.
     c                   eval      DS#dspfP = dsFldsP
     c                   eval      fmtFldP = fmtFldsP
     c                   eval      refmt = ' '
     c                   eval      expRecl = 0
     c                   eval      fldCnt = 0

     c                   dow       fldCnt < ds#flds                             d fldlup1
     c                   eval      fldCnt = fldCnt + 1
     c                   if        fldCnt <> 1                                  ? not 1st
     c                   eval      DS#dspfP = DS#dspfP + %size(DS#dspf)
     c                   eval      fmtFldP = fmtFldP + %size(fmtFld)
     c                   endif                                                  e not 1st
      *  Date
     c                   if        DB#type = 11                                 ? date
     c                   eval      refmt = 'Y'
     c                   eval      uint2 = 0
     c                   eval      uint2r = FFdfmt
     c                   eval      oDatFmt = uint2
     c                   eval      ofldln = 0
     c                   if        oDatFmt >= 1 and oDatFmt <= 26               ? 1-26
     c                   eval      ofldln = DToutLen(oDatFmt)
     c                   endif                                                  e 1-26
     c                   if        oFldLn = 0                                   ? default
     c                   eval      oDatFmt = 3                                    *ISO
     c                   eval      ofldln = 10
     c                   endif                                                  e default
     c                   eval      expRecl = expRecl + ofldln
     c                   iter
     c                   endif                                                  e date
      *  Time
     c                   if        DB#type = 12                                 ? time
     c                   eval      refmt = 'Y'
     c                   eval      expRecl = expRecl + 8
     c                   iter
     c                   endif                                                  e time
      *  Timestamp
     c                   if        DB#type = 13                                 ? timestamp
     c                   eval      refmt = 'Y'
     c                   eval      expRecl = expRecl + 26
     c                   iter
     c                   endif                                                  e timestamp

      *  Varlen
     c                   if        bitAnd(DB#ftmod:x'80') = x'80'               ? varlen
     c                   eval      refmt = 'Y'
     c                   eval      ofldln = DB#ln + 2
     c                   eval      expRecl = expRecl + ofldln
     c                   iter
     c                   endif                                                  e varlen

     c                   eval      ofldln = DB#ln
      *  Zoned/Packed
     c                   if        DB#type = 2 or DB#type = 3                   ? zoned/packed
     c                   eval      uint2 = 0
     c                   eval      uint2r = DB#digs
     c                   eval      ofldln = uint2
     c                   if        DB#type = 3                                  ? packed
     c                   eval      ofldln = ofldln + 2
     c                   eval      ofldln = ofldln / 2
     c                   endif                                                  e packed
     c                   endif                                                  e zoned/packed
      *  Normal
     c                   eval      expRecl = expRecl + ofldln
     c                   enddo                                                  e fldlup1

      *  Does rec need to be reformatted?
     c                   if        refmt = 'Y'                                  ? refmt
     c                   exsr      reformat
     c                   endif                                                  e refmt
     c                   endsr
      *---------------------------------------------------------------------
     c     calcRRNoff    begsr
      *  Calc pf5RRN & pf5offset for $RRN

      *  $RRNpfc = RRN in copied file corresponding to $RRN in original physical file
     c                   eval      $RRNpfc = $RRN - (inPF5loRRN - 1)

      *  DSroff = rec off in this DS (within spc excl. of x'20' bytes for SG hdr)
     c                   eval      DSroff = ($RRNpfc - 1) * recEntln
     c                   eval      DSroff = DSroff + recEntln                   for dflt entry

      *  pf5RRN    = RRN in undel528 containing $RRN rec
      *  pf5offset = offset within undel528 rec of status byte of $RRN rec
     c                   eval      pf5RRN = dsDataRRN
     c                   eval      pf5offset = DSroff + 32                      for SG hdr
     c                   endsr
      *---------------------------------------------------------------------
     c     reformat      begsr

     c                   eval      $recln = expRecl

      *  If any variable-length fields...
     c                   if        ds#vars > 0                                  ? ds#vars
     c                   eval      recAuxSp = %subst(recwk:2)
     c                   if        raxSeg# > 0                                  ? raxSeg#
      *  Calc offset to lengths in aux SG for this rec (after RRN field)
     c                   eval      auxLensOff = raxOff + 4
     c                   endif                                                  e raxSeg#
     c                   endif                                                  e ds#vars

     c                   eval      DS#dspfP = dsFldsP
     c                   eval      fmtFldP = fmtFldsP
     c                   eval      tRecP = %addr(record1)
     c                   eval      varix = 0
     c                   eval      fldCnt = 0

      *  Loop thru DS field table
     c                   dow       fldCnt < ds#flds                             d fldlup2
     c                   eval      fldCnt = fldCnt + 1

     c                   if        fldCnt <> 1                                  ? not 1st
     c                   eval      DS#dspfP = DS#dspfP + %size(DS#dspf)
     c                   eval      fmtFldP = fmtFldP + %size(fmtFld)
     c                   endif                                                  e not 1st

     c                   eval      sRecP = %addr(recwk) + DB#off
      *  Date
     c                   if        DB#type = 11                                 ? date
     c                   eval      uint2 = 0
     c                   eval      uint2r = FFdfmt
     c                   eval      oDatFmt = uint2
     c                   eval      ofldln = 0
     c                   if        oDatFmt >= 1 and oDatFmt <= 26               ? 1-26
     c                   eval      ofldln = DToutLen(oDatFmt)
     c                   endif                                                  e 1-26
     c                   if        oFldLn = 0                                   ? default
     c                   eval      oDatFmt = 3                                    *ISO
     c                   eval      ofldln = 10
     c                   endif                                                  e default

     c                   eval      extDate = cvtDate(ofldln: oDatFmt: FFdsep:
     c                                               sRec)
     c                   eval      %subst(tRec:1:ofldln) = extDate
     c                   eval      tRecP = tRecP + ofldln
     c                   iter
     c                   endif                                                  e date
      *  Time
     c                   if        DB#type = 12                                 ? time
     c                   eval      uint2 = 0
     c                   eval      uint2r = FFdfmt
     c                   eval      oTimFmt = uint2

     c                   if        oTimFmt <> 27                                ? not *HMS
     c                   if        oTimFmt = 1 or oTimFmt = 2                   ?
     c                   eval      oTimFmt = 2                                    *USA
     c                   endif                                                  e
     c                   if        oTimFmt = 3 or oTimFmt = 4                   ?
     c                   eval      oTimFmt = 4                                    *ISO
     c                   endif                                                  e
     c                   if        oTimFmt = 5 or oTimFmt = 6                   ?
     c                   eval      oTimFmt = 6                                    *EUR
     c                   endif                                                  e
     c                   if        oTimFmt = 7 or oTimFmt = 8                   ?
     c                   eval      oTimFmt = 8                                    *JIS
     c                   endif                                                  e
     c                   endif                                                  e not *HMS

     c                   eval      extTime = cvtTime(oTimFmt: FFdsep: sRec)
     c                   eval      %subst(tRec:1:8) = extTime
     c                   eval      tRecP = tRecP + 8
     c                   iter
     c                   endif                                                  e time
      *  Timestamp
     c                   if        DB#type = 13                                 ? timestamp
     c                   eval      extTs = cvtTimestamp(sRec)
     c                   eval      %subst(tRec:1:26) = extTs
     c                   eval      tRecP = tRecP + 26
     c                   iter
     c                   endif                                                  e timestamp
      *  Varlen
     c                   if        bitAnd(DB#ftmod:x'80') = x'80'               ? varlen
     c                   eval      %subst(tRec:3:DB#ln) = *allx'00'
     c                   eval      int2a = %subst(sRec:1:2)
     c                   eval      varLen = int2

     c                   if        varLen >= 0                                  ? in rec
      *  Here if var is in rec
     c                   eval      int2 = varLen
     c                   eval      %subst(tRec:1:2) = int2a
     c                   eval      %subst(tRec:3:varLen) =
     c                             %subst(sRec:3:varLen)
     c                   else                                                   x in rec
      *  Here if var is in aux SG
     c                   if        raxSeg# <= 0                                 ? raxSeg#
     c                   eval      int2 = 0
     c                   eval      %subst(tRec:1:2) = int2a
     c                   else                                                   x raxSeg#
      *  Get len-to-end of prev field (varLen0), and of this field (varLen1)
     c                   eval      int2 = (varix - 1) * 2                       - 1 to get prv field
     c                   callp     rd528blk(%addr(varLn0): 4:
     c                                      dsAuxRRN: auxLensOff + int2)
     c                   if        varix = 0                                    ? 1st var field
     c                   eval      varLn0 = 0
     c                   endif                                                  e 1st var field

     c                   eval      varLen = varLn1 - varLn0
     c                   eval      int2 = varLen
     c                   eval      %subst(tRec:1:2) = int2a
      *  Copy field data
     c                   if        varLen > 0                                   ? varLen
     c                   eval      int2 = (ds#vars * 2) + varLn0
     c                   callp     rd528blk((tRecP + 2): varLen:
     c                                      dsAuxRRN: auxLensOff + int2)
     c                   endif                                                  e varLen
     c                   endif                                                  e raxSeg#
     c                   endif                                                  e in rec

     c                   eval      ofldln = DB#ln + 2
     c                   eval      tRecP = tRecP + ofldln
     c                   eval      varix = varix + 1
     c                   iter
     c                   endif                                                  e varlen

     c                   eval      ofldln = DB#ln
      *  Zoned/Packed
     c                   if        DB#type = 2 or DB#type = 3                   ? zoned/packed
     c                   eval      uint2 = 0
     c                   eval      uint2r = DB#digs
     c                   eval      ofldln = uint2
     c                   if        DB#type = 3                                  ? packed
     c                   eval      ofldln = ofldln + 2
     c                   eval      ofldln = ofldln / 2
     c                   endif                                                  e packed
     c                   endif                                                  e zoned/packed
      *  Normal
     c                   eval      %subst(tRec:1:ofldln) =
     c                             %subst(sRec:1:ofldln)
     c                   eval      tRecP  = tRecP + ofldln
     c                   enddo                                                  e fldlup2
     c                   endsr
      *---------------------------------------------------------------------
     c     undelete      begsr

     C                   if        delfileopen <> *on                           ? delfileopen

      *  Override and open the original physical
     c                   eval      m2coper = 'ORIDEDEL'
     c                   exsr      tom2c
     c                   open      delfile                              77

     c                   if        *in77 = *on                                  ? *in77
     c                   eval      $retc = 'BADUNDEL'
     c                   goto      endund
     c                   endif                                                  e *in77

     c                   eval      delfileopen = *on
     c                   eval      m2coper = 'RCV2CALR'
     c                   exsr      tom2c
     c                   endif                                                  e delfileopen

     c                   eval      writeRRN = $RRN
     c                   except    writedel

     c     endund        tag
     c                   endsr
      *---------------------------------------------------------------------
     c     outfile       begsr

     c                   if        delfiloopen <> *on                           ? delfiloopen

      *  Override and open the original physical
     c                   eval      m2coper = 'ORIDEDEO'
     c                   exsr      tom2cof
     c                   open      delfilo
     c                   eval      delfiloopen = *on
     c                   eval      m2coper = 'RCV2CALR'
     c                   exsr      tom2c
     c                   endif                                                  e delfiloopen

     c                   except    writedelo
     c                   endsr
      *---------------------------------------------------------------------

     c     dbrtvfd       begsr

      *  Get file format ID

     c                   eval      rfdrcvrlen = %size(qdbq41)
     c                   eval      rfdfmtname = 'FILD0200'
     c                   eval      rfdrecfmt  = '*FIRST    '
     c                   eval      rfdorideproc = '0'
     c                   eval      rfdsystem  = '*LCL      '
     c                   eval      rfdfmttype = '*EXT      '
     c                   eval      qusbprv = %size(qusec)
     c                   eval      qusbavl = 0

     c                   call      'QDBRTVFD'
     c                   parm                    qdbq41
     c                   parm                    rfdrcvrlen
     c                   parm                    retfilelibr
     c                   parm                    rfdfmtname
     c                   parm                    rfdfilelibr
     c                   parm                    rfdrecfmt
     c                   parm                    rfdorideproc
     c                   parm                    rfdsystem
     c                   parm                    rfdfmttype
     c                   parm                    qusec
     c                   endsr
      *---------------------------------------------------------------------
     c     tom2cof       begsr
     c                   eval      m2cfrmfile = $ofile
     c                   eval      m2cfrmlibr = $olibr
     c                   eval      m2cfrmmbr  = $ombr
     c                   exsr      callm2c
     c                   endsr
      *---------------------------------------------------------------------
     c     tom2c         begsr
     c                   eval      m2cfrmfile = $file
     c                   eval      m2cfrmlibr = $libr
     c                   eval      m2cfrmmbr  = $mbr
     c                   exsr      callm2c
     c                   endsr
      *---------------------------------------------------------------------
     c     callm2c       begsr
     c                   eval      m2cretc = *blanks
     c                   callb     'UNDELM2C'
     C                   parm                    m2coper
     C                   parm                    m2cretc
     C                   parm                    m2cfrmfile
     C                   parm                    m2cfrmlibr
     C                   parm                    m2cfrmmbr
     C                   parm                    m2cfrmrcd
     C                   parm                    m2cnbrrcds
     C                   parm                    m2ccrtfile
     C                   parm                    m2cparms

     c                   eval      $retc = m2cretc
     c                   endsr
      *---------------------------------------------------------------------
     c     delinfsr      begsr
     c                   eval      $retc = 'BADUNDEL'
     c                   exsr      doreturn
     c                   endsr
      *---------------------------------------------------------------------
     c     *inzsr        begsr

     c                   eval      DToutLen = 0
     c                   eval      DToutLen(1) = 10                             x01 = *USA
     c                   eval      DToutLen(3) = 10                             x03 = *ISO
     c                   eval      DToutLen(5) = 10                             x05 = *EUR
     c                   eval      DToutLen(7) = 10                             x07 = *JIS
     c                   eval      DToutLen(23) = 8                             x17 = *MDY
     c                   eval      DToutLen(24) = 8                             x18 = *DMY
     c                   eval      DToutLen(25) = 8                             x19 = *YMD
     c                   eval      DToutLen(26) = 6                             x1A = *JUL
     c                   eval      tmplt20 = *allx'00'
     c                   eval      tmplt49 = *allx'00'
     c                   eval      tmplt137 = *allx'00'
     c                   eval      tmplt157 = *allx'00'
     c                   eval      tmplt173 = *allx'00'
     c                   eval      tmplt209 = *allx'00'
     c                   eval      tmplt253 = *allx'00'
     c                   eval      tmplt273 = *allx'00'
     c                   eval      tmplt289 = *allx'00'
     c                   eval      pfLocked = *off

     c                   eval      pf5ctxP = %addr(pf5ctxBak)
     c                   clear                   pf5ctx
     c                   eval      orgOrBak = 'B'

     c                   eval      pf5ctxP = %addr(pf5ctxOrg)
     c                   clear                   pf5ctx
     c                   eval      orgOrBak = 'O'
     c                   endsr
      *---------------------------------------------------------------------
     Oundel528o e            out528
     O                       r528data03         512
     O                       r528RRN            516u
     O                       r528cksum          528

     Odelfile   e            writedel
     O                       record1
     O                       record2
     O                       record3
     O                       record4

     Odelfilo   e            writedelo
     O                       record1
     O                       record2
     O                       record3
     O                       record4

     Oundelsrcf e            outsrcf
     O                                            6 '000100'
     O                                           12 '000000'
     O                                           18 'A'
     O                                           29 'R'
     O                       recfmtname          40
     O                       formatstr           85
      *---------------------------------------------------------------------
      *  Bitwise-and bytes

     p bitAnd          b

     d bitAnd          pi             1
     d  byte1                         1    value
     d  byte2                         1    value

     d                 ds
     d  uint4                  1      4u 0
     d  lbyte1                 1      1
     d  rbyte1                 2      2
     d  lbyte2                 3      3
     d  rbyte2                 4      4
     d                 ds
     d  resuint                1      2u 0
     d  result                 2      2

     c                   eval      uint4 = 0
     c                   eval      resuint = 0
     c                   eval      rbyte1 = byte1
     c                   eval      rbyte2 = byte2

     c                   do        8                                            d 8
     c                   eval      resuint = resuint + resuint
     c                   eval      lbyte1 = x'00'
     c                   eval      lbyte2 = x'00'
     c                   eval      uint4 = uint4 + uint4
     c                   if        lbyte1 <> x'00' and lbyte2 <> x'00'          ? aone
     c                   eval      resuint = resuint + 1
     c                   endif                                                  e aone
     c                   enddo                                                  e 8

     c                   return    result
     p bitAnd          e
      *---------------------------------------------------------------------
      *  Validate a packed field for decimal data errors
      *  Return *on if valid; else *off

     p validPkd        b

     d validPkd        pi              n
     d  bytes                         8    value
     d  nBytes                       10i 0 value

     d  result         s               n
     d  i              s             10i 0
     d  byte           s              1
     d  lNib           s              1
     d  rNib           s              1

     c                   eval      result = *on
     c                   eval      i = 1

      *  Loop thru bytes of field
     c                   dow       i < nBytes                                   d i
     c                   eval      byte = %subst(bytes:i:1)
     c                   eval      lNib = bitAnd(byte:x'F0')
     c                   eval      rNib = bitAnd(byte:x'0F')

     c                   if        lNib > x'90'                                 ? bad lNib
     c                   eval      result = *off
     c                   endif                                                  e bad lNib

     c                   if        rNib > x'09'                                 ? bad rNib
     c                   eval      result = *off
     c                   endif                                                  e bad rNib

     c                   eval      i = i + 1
     c                   enddo                                                  e i

      *  Now check last byte
     c                   eval      byte = %subst(bytes:i:1)
     c                   eval      lNib = bitAnd(byte:x'F0')
     c                   eval      rNib = bitAnd(byte:x'0F')

     c                   if        lNib > x'90'                                 ? bad dig
     c                   eval      result = *off
     c                   endif                                                  e bad dig

     c                   if        rNib <> x'0D' and rNib <> x'0F'              ? bad sign
     c                   eval      result = *off
     c                   endif                                                  e bad sign

     c                   return    result
     p validPkd        e
      *---------------------------------------------------------------------
      *  Read a block from the 528-byte physical

     p rd528blk        b

     d rd528blk        pi
     d  destptr                        *   value
     d  blklength                    10u 0 value
     d  baseRRN                      10u 0 value
     d  offset                       10u 0 value

     d  destp          s               *
     d  destblk        s          32767    based(destp)
     d  RRN            s             10u 0
     d  off            s             10u 0
     d  recoff         s             10u 0
     d  recoffq        s             10u 0
     d  len2go         s             10u 0
     d  len            s             10u 0
     d  leftinrec      s             10u 0

     c                   eval      destp = destptr
     c                   eval      len2go = blklength
     c                   eval      off = offset

      *  Loop thru pieces of block in seperate recs

     c                   dow       len2go > 0                                   d len2go
     c                   eval      RRN = baseRRN + (off / 512)
     c***                eval      recoff = %rem(off:512)
     c     off           div       512           recoffq
     c                   mvr                     recoff
     c                   eval      leftinrec = 512 - recoff
     c                   eval      len = len2go

     c                   if        len > leftinrec                              ? len
     c                   eval      len = leftinrec
     c                   endif                                                  e len

     c                   if        RRN <> RRN528in                              ? RRN

     c                   if        PF5file = orgPF5name                         ? orgPF5name
     c     RRN           chain     undel528                           77
     c                   eval      r528data = r528data01
     c                   else                                                   e orgPF5name
     c     RRN           chain     undel528b                          77
     c                   eval      r528data = r528data02
     c                   endif                                                  e orgPF5name

     c                   if        *in77 = *off                                 ? *in77
     c                   eval      RRN528in = RRN
     c                   endif                                                  e *in77
     c                   endif                                                  e RRN

     c                   eval      %subst(destblk:1:len) =
     c                             %subst(r528data:recoff+1:len)
     c                   eval      len2go = len2go - len
     c                   eval      off    = off + len
     c                   eval      destp  = destp + len
     c                   enddo                                                  e len2go

     p rd528blk        e
      *---------------------------------------------------------------------
      *  Convert date data type to external form

     p cvtDate         b

     d cvtDate         pi            10
     d  resDateLn                    10u 0
     d  resDateFmt                   10u 0
     d  resDsep                       1
     d  srcDate                       4

     D resDate         s             10
     D srcDate10       s             10

     c                   eval      srcDate10 = srcDate
     c                   eval      toplen1 = resDateLn
     c                   eval      d1fmt   = resDateFmt
     c                   eval      d1dsep  = resDsep

     c                   if        d1dsep = x'EE'                               ? d1dsep
     c                   eval      d1dsep = x'00'
     c                   endif                                                  e d1dsep

     c                   eval      toplen2 = 4
     c                   eval      d2fmt = 10                                   system internal
     c                   eval      d1hour = 0
     c                   eval      d1min  = 0
     c                   eval      d2hour = 0
     c                   eval      d2min  = 0

     c                   callp     cvtd(resDate: srcDate10: cvtTemplate)

     c                   eval      d1dsep = x'00'
     c                   return    resDate
     p cvtDate         e
      *---------------------------------------------------------------------
      *  Convert time data type to external form

     p cvtTime         b

     d cvtTime         pi             8
     d  resTimeFmt                   10u 0
     d  resTsep                       1
     d  srcTime                       3

     D cvttTemplate    ds           138
     D  isize                  1      4u 0 inz(138)
     D  iddatn1                5      6u 0 inz(1)
     D  iddatn2                7      8u 0 inz(2)
     D  ttmplt9                9     10    inz(x'0000')
     D  ioplen1               11     12u 0 inz(8)
     D  ioplen2               13     14u 0 inz(3)
     D  ttmplt15              15     16    inz(x'0000')
     D  iprfmt                17     18u 0 inz(0)
     D  iprsep                19     19    inz(x'00')
     D  ttmplt20              20     42
     D  ilisize               43     46u 0 inz(96)
     D  ilisnum               47     48u 0 inz(2)
     D  ttmplt49              49     58
     D  ioff1                 59     62u 0 inz(24)
     D  ioff2                 63     66u 0 inz(60)

      *  DDAT for ext time
     D  d3len                 67     68u 0 inz(36)
     D  d3fmt                 69     70u 0
     D  d3dsep                71     71    inz(x'00')
     D  d3tsep                72     72    inz(x'00')
     D  d3hour                73     74u 0 inz(24)
     D  d3min                 75     76u 0 inz(60)
     D  d3mon                 77     78u 0 inz(0)
     D  d3yr                  79     80u 0 inz(0)
     D  d3cent                81     84u 0 inz(0)
     D  d3cendiv              85     88u 0 inz(0)
     D  d3caloff              89     92u 0 inz(0)
     D  ttmplt93              93     98    inz(x'000000000000')
     D  d3ernum               99    100u 0 inz(0)
     D  d3canum              101    102u 0 inz(0)

      *  DDAT for system internal time
     D  d4len                103    104u 0 inz(36)
     D  d4fmt                105    106u 0 inz(11)
     D  d4dsep               107    107    inz(x'00')
     D  d4tsep               108    108    inz(x'00')
     D  d4hour               109    110u 0 inz(24)
     D  d4min                111    112u 0 inz(60)
     D  d4mon                113    114u 0 inz(0)
     D  d4yr                 115    116u 0 inz(0)
     D  d4cent               117    120u 0 inz(0)
     D  d4cendiv             121    124u 0 inz(0)
     D  d4caloff             125    128u 0 inz(0)
     D  ttmplt129            129    134    inz(x'000000000000')
     D  d4ernum              135    136u 0 inz(0)
     D  d4canum              137    138u 0 inz(0)

     D resTime         s              8

     c                   eval      ttmplt20 = *allx'00'
     c                   eval      ttmplt49 = *allx'00'
     c                   eval      ttmplt129 = *allx'00'
     c                   eval      d3fmt = resTimeFmt
     c                   eval      d3tsep = resTsep

     c                   if        d3tsep = x'EE'                               ? d3tsep
     c                   eval      d3tsep = x'00'
     c                   endif                                                  e d3tsep

     c                   callp     cvtt(resTime: srcTime: cvttTemplate)

     c                   eval      d3tsep = x'00'
     c                   return    resTime
     p cvtTime         e
      *---------------------------------------------------------------------
      *  Convert date data type to external form

     p cvtTimestamp    b

     d cvtTimestamp    pi            26
     d  srcTs                        10

     d resTs           s             26

     c                   eval      toplen1 = 26
     c                   eval      toplen2 = 10
     c                   eval      d1fmt   = 9                                  SAA timestamp
     c                   eval      d2fmt   = 12                                 sys internal t.s.
     c                   eval      d1hour  = 24
     c                   eval      d1min   = 60
     c                   eval      d2hour  = 24
     c                   eval      d2min   = 60

     c                   callp     cvtts(resTs: srcTs: cvtTemplate)

     c                   return    resTs
     p cvtTimestamp    e
      *---------------------------------------------------------------------
