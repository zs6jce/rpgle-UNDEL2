             PGM
             DCL        VAR(&MSGF) TYPE(*CHAR) LEN(10) VALUE(UNDEL2MF)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)

             DCL        &ERRORSW *LGL                     /* Std err */
             DCL        &EMSGID *CHAR LEN(7)              /* Std err */
             DCL        &EMSGDTA *CHAR LEN(100)           /* Std err */
             DCL        &EMSGF *CHAR LEN(10)              /* Std err */
             DCL        &EMSGFLIB *CHAR LEN(10)           /* Std err */

             MONMSG     MSGID(CPF0000) EXEC(GOTO STDERR1) /* Std err */

             CHGVAR     VAR(&MSGID) VALUE(TOL0001)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412) /* already there */
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Record +
                          &1 in file &3/&2 mbr &4 is not deleted.') +
                          SECLVL('&N Cause . . . . . :   The record +
                          is already active; no need to un-delete. +
                          &N Recovery  . . . :   Choose a deleted +
                          record.  Then try the request again.') +
                          SEV(00) FMT((*DEC 9) (*CHAR 10) (*CHAR +
                          10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0002)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) +
                          MSG('Operation code &1 is unrecognized by +
                          pgm &2.') SECLVL('&N Cause . . . . . :   +
                          Program &2 does not know what to do with +
                          operation code &1. &N Recovery  . . . :   +
                          Use a recognized operation code.') +
                          SEV(40) FMT((*CHAR 8) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0003)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Library +
                          &1 not found.') SECLVL('&N Cause . . . . +
                          . :   Library &1 does not exist or is not +
                          in the library list. &N Recovery  . . . +
                          :   Change the library name.  Then try +
                          the request again.') SEV(40) FMT((*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0004)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Not +
                          authorized to library &1.') SECLVL('&N +
                          Cause . . . . . :   Your user profile +
                          does not have authority to library &1. &N +
                          Recovery  . . . :   Obtain authority to +
                          library &1.  Then try the request +
                          again.') SEV(40) FMT((*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0005)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('File +
                          &2/&1 not found.') SECLVL('&N Cause . . . +
                          . . :   File &2/&1 does not exist or is +
                          not in the library list. &N Recovery  . . +
                          . :   Change the file name.  Then try the +
                          request again.') SEV(40) FMT((*CHAR 10) +
                          (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0006)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Not +
                          authorized to file &2/&1.') SECLVL('&N +
                          Cause . . . . . :   Your user profile +
                          does not have authority to file &2/&1. &N +
                          Recovery  . . . :   Obtain authority to +
                          file &2/&1.  Then try the request +
                          again.') SEV(40) FMT((*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0007)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('File +
                          &2/&1 is not a database file.') +
                          SECLVL('&N Cause . . . . . :   You can +
                          un-delete records only in database files. +
                          &N Recovery  . . . :   Choose a database +
                          file.  Then try the request again.') +
                          SEV(40) FMT((*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0008)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('File +
                          &2/&1 is a logical file.') SECLVL('&N +
                          Cause . . . . . :   You can un-delete +
                          records only in physical files. &N +
                          Recovery  . . . :   Choose a physical +
                          file.  Then try the request again.') +
                          SEV(40) FMT((*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0009)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('File +
                          &2/&1 has no members.') SECLVL('&N Cause +
                          . . . . . :   As records are contained in +
                          members, there are no records to +
                          un-delete. &N Recovery  . . . :   Choose +
                          a file with members.  Then try the +
                          request again.') SEV(40) FMT((*CHAR 10) +
                          (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0010)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Member +
                          &3 not found in file &2/&1.') SECLVL('&N +
                          Cause . . . . . :   Member &3 does not +
                          exist in file &2/&1. &N Recovery  . . . +
                          :   Change the member name.  Then try the +
                          request again.') SEV(40) FMT((*CHAR 10) +
                          (*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0011)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Invalid +
                          relative record # &1 in file &3/&2 mbr +
                          &4.') SECLVL('&N Cause . . . . . :   RRN +
                          &1 is not in mbr &4 in file &3/&2. &N +
                          Recovery  . . . :   Change the relative +
                          record number.  Then try the request +
                          again.') SEV(40) FMT((*DEC 9) (*CHAR 10) +
                          (*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0012)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Error +
                          un-deleting RRN &1 in file &3/&2 mbr +
                          &4.') SECLVL('&N Cause . . . . . :   An +
                          error occurred when attempting to +
                          un-delete RRN &1 in member &4 in file +
                          &3/&2. &N Recovery  . . . :   See the +
                          previously listed messages.') SEV(40) +
                          FMT((*DEC 9) (*CHAR 10) (*CHAR 10) (*CHAR +
                          10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0013)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Record +
                          &1 in file &3/&2 mbr &4 has been +
                          un-deleted.') SECLVL('&N Cause . . . . . +
                          :   Record &1 is now active and contains +
                          the data it had when it was deleted. &N +
                          Recovery  . . . :   None.') SEV(00) +
                          FMT((*DEC 9) (*CHAR 10) (*CHAR 10) (*CHAR +
                          10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0014)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) +
                          MSG('Un-delete pending.  Press F23 again +
                          to un-delete; any other key not to.') +
                          SECLVL('&N Cause . . . . . :   Record &1 +
                          in file &3/&2 mbr &4 will be un-deleted +
                          when you press F23 again.') SEV(00) +
                          FMT((*DEC 9) (*CHAR 10) (*CHAR 10) (*CHAR +
                          10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0015)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('&1 +
                          records scanned without finding a deleted +
                          record.') SECLVL('&N Cause . . . . . :   +
                          &1 records have been scanned without +
                          finding a deleted record. &N Recovery  . +
                          . . :   Press F19 or F20 again to +
                          continue scanning.') SEV(00) FMT((*BIN 4))

             CHGVAR     VAR(&MSGID) VALUE(TOL0016)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('ACTION +
                          parameter must be *RTV if OUTPUT +
                          parameter is specified.') SECLVL('&N +
                          Cause . . . . . :   If the ACTION +
                          parameter is *UPD, the OUTPUT parameter +
                          must not be specified. &N Recovery  . . . +
                          :   Change the ACTION or OUTPUT +
                          parameter.') SEV(40)

             CHGVAR     VAR(&MSGID) VALUE(TOL0017)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('&1 +
                          record scanned without finding a deleted +
                          record.') SECLVL('&N Cause . . . . . :   +
                          &1 record has been scanned without +
                          finding a deleted record. &N Recovery  . +
                          . . :   Press F19 or F20 again to +
                          continue scanning.') SEV(00) FMT((*BIN 4))

             CHGVAR     VAR(&MSGID) VALUE(TOL0018)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Record +
                          &1 in file &3/&2 mbr &4 has been written +
                          to file &6/&5, mbr &7.') SECLVL('&N Cause +
                          . . . . . :   The record contains the +
                          data it had when it was deleted. &N +
                          Recovery  . . . :   None.') SEV(00) +
                          FMT((*DEC 9) (*CHAR 10) (*CHAR 10) (*CHAR +
                          10) (*CHAR 10) (*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0019)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Format +
                          &1 in outfile &3/&2 different from format +
                          &4 in file &6/&5.') SECLVL('&N Cause . . +
                          . . . :   The subject file and outfile +
                          record formats must match. &N Recovery  . +
                          . . :   Specify an outfile with a format +
                          that matches the subject file.') SEV(40) +
                          FMT((*CHAR 13) (*CHAR 10) (*CHAR 10) +
                          (*CHAR 13) (*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0020)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) +
                          MSG('Duplicate record RRN &1 in file +
                          &3/&2, mbr &4.') SECLVL('&N Cause . . . . +
                          . :   The keys of record &1 are the same +
                          as another record in some indexed file, +
                          and at least one of them has unique keys. +
                          &N Recovery  . . . :   See low level +
                          messages previously listed.') SEV(40) +
                          FMT((*DEC 9) (*CHAR 10) (*CHAR 10) (*CHAR +
                          10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0021)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Error +
                          copying RRN &1 in file &3/&2 mbr &4.') +
                          SECLVL('&N Cause . . . . . :   An error +
                          occurred when attempting to copy RRN &1 +
                          in member &4 in file &3/&2. &N Recovery  +
                          . . . :   See the messages previously +
                          listed.') SEV(40) FMT((*DEC 9) (*CHAR 10) +
                          (*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0022)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) +
                          MSG('Duplicate record in file &2/&1, mbr +
                          &3.') SECLVL('&N Cause . . . . . :   The +
                          keys of the record are the same as +
                          another record. &N Recovery  . . . :   +
                          See low level messages previously +
                          listed.') SEV(40) FMT((*CHAR 10) (*CHAR +
                          10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0023)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('  ') +
                          SECLVL(' ') SEV(0)

             CHGVAR     VAR(&MSGID) VALUE(TOL0024)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Format +
                          level ID &1 in backup file &3/&2 +
                          different from format level ID &4 in file +
                          &6/&5.') SECLVL('&N Cause . . . . . :   +
                          The backup file and subject file record +
                          formats must match. &N Recovery  . . . +
                          :   Specify a backup file with a format +
                          that matches the subject file.') SEV(40) +
                          FMT((*CHAR 13) (*CHAR 10) (*CHAR 10) +
                          (*CHAR 13) (*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0025)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('File +
                          &2/&1 is a logical file.') SECLVL('&N +
                          Cause . . . . . :   The backup file must +
                          be a physical file. &N Recovery  . . . +
                          :   Choose a physical file.  Then try the +
                          request again.') SEV(40) FMT((*CHAR 10) +
                          (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL0026)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('File +
                          &2/&1 is not a database file.') +
                          SECLVL('&N Cause . . . . . :   The backup +
                          file must be a physical database file. &N +
                          Recovery  . . . :   Choose a database +
                          file.  Then try the request again.') +
                          SEV(40) FMT((*CHAR 10) (*CHAR 10))

             CHGVAR     VAR(&MSGID) VALUE(TOL6666)
             ADDMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Hi')
             MONMSG     MSGID(CPF2412)
             CHGMSGD    MSGID(&MSGID) MSGF(*LIBL/&MSGF) MSG('Unknown +
                          return code &1 passed back from pgm &2.') +
                          SECLVL('&N Cause . . . . . :   The +
                          calling program (&3) has not been coded +
                          to handle this return code. &N Recovery  +
                          . . . :   Contact the author.') SEV(40) +
                          FMT((*CHAR 8) (*CHAR 10) (*CHAR 10))

             GOTO       CMDLBL(ENDPGM)
/*-----------------------------------------------------------------*/
 STDERR1:               /* Standard error handling routine */
             IF         &ERRORSW SNDPGMMSG MSGID(CPF9999) +
                          MSGF(QCPFMSG) MSGTYPE(*ESCAPE) /* Func chk */
             CHGVAR     &ERRORSW '1' /* Set to fail if error occurs */
 STDERR2:    RCVMSG     MSGTYPE(*DIAG) MSGDTA(&EMSGDTA) MSGID(&EMSGID) +
                          MSGF(&EMSGF) MSGFLIB(&EMSGFLIB)
             IF         (&EMSGID *EQ '       ') GOTO STDERR3
             SNDPGMMSG  MSGID(&EMSGID) MSGF(&EMSGFLIB/&EMSGF) +
                          MSGDTA(&EMSGDTA) TOPGMQ(*PRV *) +
                          MSGTYPE(*DIAG)
             GOTO       STDERR2 /* Loop back for addl diagnostics */
 STDERR3:    RCVMSG     MSGTYPE(*EXCP) MSGDTA(&EMSGDTA) MSGID(&EMSGID) +
                          MSGF(&EMSGF) MSGFLIB(&EMSGFLIB)
             SNDPGMMSG  MSGID(&EMSGID) MSGF(&EMSGFLIB/&EMSGF) +
                          MSGDTA(&EMSGDTA) TOPGMQ(*PRV *) +
                          MSGTYPE(*ESCAPE)
/*-----------------------------------------------------------------*/
ENDPGM:
             ENDPGM
