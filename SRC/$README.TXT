
UNDEL2 - Un-delete records in an AS/400 physical file
=====================================================

2007/11/14   Version 2.0.4

Dave McKenzie
Zbig Group, Inc.
davemck@zbiggroup.com

  UNDEL2 is hereby placed in the public domain.  This means you can
  do anything you want with it.

 *==================================================================*/
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR DIRECT, INDIRECT,    *
 *  SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF    *
 *  THE USE OF THIS SOFTWARE.                                       *
 *                                                                  *
 *  THE AUTHOR SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING,    *
 *  BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF                   *
 *  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,              *
 *  AND NON-INFRINGEMENT.  THIS SOFTWARE IS PROVIDED ON AN "AS IS"  *
 *  BASIS, AND THE AUTHOR HAS NO OBLIGATION TO PROVIDE MAINTENANCE, *
 *  SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.               *
 *==================================================================*/

  UNDEL2 is a freeware utility which allows you to view, copy and un-delete
deleted records in a physical file.  You can interactively display active and
deleted records, scan for deleted records and un-delete them.  In addition,
you can copy records to print or to an outfile or un-delete them without
displaying them.

  UNDEL2 is a user-state replacement for UNDEL, which ran in system state.
Whereas UNDEL contained a modified machine instruction and could therefore
not be used as compiled directly from souce, UNDEL2 is written in unmodified
ILE RPG and ILE CL and can be compiled from the included source.

  For instructions about installing to an AS/400, see "Installation" below.


Background:

  When an application program deletes a record in a physical file (e.g. by
using the RPG DELETE op-code), OS/400 does not remove the record or clear
its fields; it only sets a bit in the record saying "this record is deleted."
Once that bit is set, OS/400 will *never* retrieve data from the record using
normal database operations (READ, etc.).  However, you can reuse the record
by issuing a "write by RRN" operation; for example in RPG, a WRITE with the
RECNO option.  OS/400 then resets the "deleted" bit, and writes the new record
over the deleted one.

  That is how UNDEL2 works.  It does not actually "un-delete" the old record,
but writes a new one on top of it.  The trick is: UNDEL2 first retrieves
the data from the old record and puts that data in the new record it writes.
Since OS/400 refuses to return data from the old record, UNDEL2 exploits the
fact that deleted records are visible in a save file.

UNDEL2 copies the deleted record to a file in QTEMP using CPYF with the
NBRRCDS and COMPRESS(*NO) parameters.  Then it saves that to a save file,
copies the save file to a 528-byte physical, and finds the deleted record
in the physical (making it somewhat slower than UNDEL).


Programming Notes:

  1. A new parm has been added to the MPARMS structure passed to UNDELM2:

     $rcds2cpy - For the CPYF NBRRCDS parm.  Multiple calls to UNDELM2 will
                 not redo the CPYF and SAVOBJ if $RRN is within the block
                 of records already copied.

  2. The database utility WRKDBF uses UNDELM and UNDELCB for the undelete
     function, but they no longer work on V5R4M0.  However, you can fix that
     by deleting the program WRKDBF/UNDELM, copying UNDEL2/UNDELM2 to
     the WRKDBF library (using CRTDUPOBJ) and renaming it to UNDELM.


Contents:

  UNDEL2.ZIP contains the following files:

    README       This file.
    UNDEL2.LIB   AS/400 library named UNDEL2, in save file format.

  The following objects are contained in UNDEL2.LIB:

    UNDEL2     The command.
    UNDEL2R    CPP for the command.
    UNDELM2    ILE RPG program that does all the work.
    UNDEL2D    Display file.
    UNDEL2P    Print file.
    UNDEL2MF   Message file.
    UNDEL2A    Data area.
    UNDEL2U    Helptext panel group for UNDEL2 command.
    UNDEL2DU   Helptext panel group for UNDEL2D display file.
    SRC        Sourcefile

Installation:

  To install on an AS/400:
  (Change the library names, etc., as appropriate.)

  The simplest way is to use FTP (if you have a TCP/IP connection).


  1. On the AS/400, create a save file (if you don't have one you can
     use) with the CRTSAVF cmd.

  2. On the PC, start FTP and enter your user and password (if asked).

  3. Enter the following FTP cmds:

     ftp> bin
     ftp> cd myLib
     ftp> put undel2.lib mySavf
     ftp> bye

     Where mySavf is the name of your save file and myLib is the library
     it's located in.

  4. Restore the UNDEL2 library from the save file:

           RSTLIB  SAVLIB(UNDEL2) DEV(*SAVF) SAVF(MYLIB/MYSAVF)

     If you wish, you can restore the objects to another library:

           RSTLIB  SAVLIB(UNDEL2) DEV(*SAVF) SAVF(MYLIB/MYSAVF)
                   RSTLIB(NOTHERLIB)

     The only library dependency in the objects is the PRDLIB parameter
     on the UNDEL2 command.  You can change that to your library:

           CHGCMD  CMD(NOTHERLIB/UNDEL2) PRDLIB(NOTHERLIB)


Execution:

  Enter the command UNDEL2 to interactively display a physical file.  Records
are shown in raw character form.  You can use F19 and F20 to scan for deleted
records, or enter the RRN if you know it.  Use F23 to un-delete a record; you
will be prompted to enter F23 a second time to confirm.

  You can copy deleted records to another file using the OUTFILE parameter.
If the outfile does not already exist, it will be created; if it exists
already, it must have the same record format as the original file.

  Helptext is provided for the UNDEL2 command and within the display.

