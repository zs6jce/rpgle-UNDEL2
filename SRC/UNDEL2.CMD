/*  UNDEL2 - Undelete records                                       */
/*          CPP: UNDEL2R                                            */

             CMD        PROMPT('Un-delete Record')
             PARM       KWD(FILE) TYPE(FILE) MIN(0) +
                        PROMPT('File')
             PARM       KWD(MBR) TYPE(*NAME) LEN(10) +
                        DFT(*FIRST) +
                        SPCVAL(*FIRST '          ') +
                        PROMPT('Member')
             PARM       KWD(RCDNBR) TYPE(*DEC) LEN(9) +
                        DFT(1) +
                        PROMPT('Record number')
             PARM       KWD(ACTION) TYPE(*CHAR) LEN(4) +
                        DFT(*RTV) RSTD(*YES) +
                        SPCVAL(*RTV *UPD) +
                        PROMPT('Action')
             PARM       KWD(LOCK) TYPE(*CHAR) LEN(1) RSTD(*YES) +
                          DFT(*YES) SPCVAL((*YES Y) (*NO N)) +
                          PROMPT('Lock member')
             PARM       KWD(BAKFILE) TYPE(FILE) MIN(0) +
                          PROMPT('Backup file')
             PARM       KWD(BAKMBR) TYPE(*NAME) LEN(10) +
                          DFT(*FILEMBR) SPCVAL((*FILEMBR) (*FIRST)) +
                          PROMPT('Backup file member')
             PARM       KWD(OUTPUT) TYPE(*CHAR) LEN(8) RSTD(*YES) +
                          DFT(*) SPCVAL((*) (*PRINT) (*OUTFILE)) +
                          PROMPT('Output')
             PARM       KWD(OUTFILE) TYPE(FILE) PMTCTL(OUTPUT) +
                          PROMPT('File to receive output')
             PARM       KWD(OUTMBR) TYPE(OUTMBR) PMTCTL(OUTPUT) +
                          PROMPT('Output member options')
 FILE:       QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) +
                        DFT(*LIBL) +
                        SPCVAL(*LIBL *CURLIB) +
                        PROMPT('Library')
 OUTMBR:     ELEM       TYPE(*NAME) LEN(10) DFT(*FIRST) +
                          SPCVAL((*FIRST)) PROMPT('Member to +
                          receive output')
             ELEM       TYPE(*CHAR) LEN(8) RSTD(*YES) DFT(*REPLACE) +
                          SPCVAL((*REPLACE) (*ADD)) PROMPT('Replace +
                          or add records')
 OUTPUT:     PMTCTL     CTL(OUTPUT) COND((*EQ *OUTFILE))
             DEP        CTL(&OUTPUT *EQ *OUTFILE) PARM((OUTFILE)) +
                          MSGID(CPD9861)
             DEP        CTL(OUTPUT) PARM((&ACTION *EQ *RTV)) +
                          MSGID(TOL0016)
