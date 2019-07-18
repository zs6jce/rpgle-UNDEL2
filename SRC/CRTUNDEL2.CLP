
/*  Create all UNDEL2 objects  */

             PGM        PARM(&LIB)

             DCL        VAR(&LIB   ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&DEBUG ) TYPE(*CHAR) LEN(7) VALUE(*ALL)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(8) VALUE(*CURRENT)

             CHGCURLIB  CURLIB(&LIB)

/* Create the cmd  */
             CRTCMD     CMD(&LIB/UNDEL2) PGM(UNDEL2R) SRCFILE(SRC) +
                          MSGF(UNDEL2MF) HLPPNLGRP(UNDEL2U) +
                          HLPID(UNDEL2) PRDLIB(&LIB)

/* Create files  */
             CRTDSPF    FILE(&LIB/UNDEL2D) SRCFILE(SRC)
             CRTPRTF    FILE(&LIB/UNDEL2P) SRCFILE(SRC)

/* Create *PNLGRPs  */
             CRTPNLGRP  PNLGRP(&LIB/UNDEL2U) SRCFILE(SRC)
             CRTPNLGRP  PNLGRP(&LIB/UNDEL2DU) SRCFILE(SRC)

/* Create the *DTAARA  */
/* @shlim:     1000    */
/* @rcds2cpy:  1000    */
             CRTDTAARA  DTAARA(&LIB/UNDEL2A) TYPE(*CHAR) LEN(253) +
                          VALUE(X'000003E8000003E8')

/* Create and populate the *MSGF  */
             CRTMSGF    MSGF(&LIB/UNDEL2MF)
             CRTCLPGM   PGM(&LIB/UNDEL2MFC) SRCFILE(SRC) +
                          TGTRLS(&TGTRLS)
             CALL       PGM(&LIB/UNDEL2MFC)

/* Compile UNDEL2R  */
             CRTRPGMOD  MODULE(&LIB/UNDEL2R) SRCFILE(SRC) +
                          DBGVIEW(&DEBUG) TGTRLS(&TGTRLS)
             CRTCLMOD   MODULE(&LIB/UNDEL2C) SRCFILE(SRC) +
                          TGTRLS(&TGTRLS) DBGVIEW(&DEBUG)
             CRTCLMOD   MODULE(&LIB/UNDEL2MC) SRCFILE(SRC) +
                          TGTRLS(&TGTRLS) DBGVIEW(&DEBUG)
             CRTPGM     PGM(&LIB/UNDEL2R) MODULE( +
                          &LIB/UNDEL2R +
                          &LIB/UNDEL2C +
                          &LIB/UNDEL2MC) +
                          ACTGRP(*NEW) +
                          TGTRLS(&TGTRLS)

/* Compile UNDELM2  */
             CRTRPGMOD  MODULE(&LIB/UNDELM2) SRCFILE(SRC) +
                          DBGVIEW(&DEBUG) TGTRLS(&TGTRLS)
             CRTCLMOD   MODULE(&LIB/UNDELM2C) SRCFILE(SRC) +
                          TGTRLS(&TGTRLS) DBGVIEW(&DEBUG)
             CRTPGM     PGM(&LIB/UNDELM2) MODULE( +
                          &LIB/UNDELM2 +
                          &LIB/UNDELM2C) +
                          ACTGRP(*CALLER) +
                          TGTRLS(&TGTRLS)
             ENDPGM
