/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 *	dev_lpt - LPTx device
 *
 * chng: jun/2006 written [jeffmarshall]
 *
 */

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"
#include "fb_printer.h"

/*:::::*/
int fb_DevLptParseProtocol( const char * proto_raw, size_t proto_raw_len, DEV_LPT_PROTOCOL ** lptinfo_in )
{
	char *p, *ptail, *pc, *pe;
	DEV_LPT_PROTOCOL *lptinfo;

	if( proto_raw == NULL )
		return FALSE;

	if( lptinfo_in == NULL )
		return FALSE;

	*lptinfo_in = malloc( sizeof( DEV_LPT_PROTOCOL ) + proto_raw_len + 1 );
	lptinfo = *lptinfo_in;

	if( lptinfo == NULL )
		return FALSE;

	strncpy( lptinfo->raw, proto_raw, proto_raw_len );
	lptinfo->raw[proto_raw_len] = '\0';

	p = lptinfo->raw;
	ptail = p + strlen( lptinfo->raw );

	lptinfo->iPort = 0;
	lptinfo->proto =
	  lptinfo->name = 
	    lptinfo->title =
	      lptinfo->emu = ptail;

	/* "PRN:" */

	if( stricmp( p, "PRN:" ) == 0)
	{
		lptinfo->proto = p;
		lptinfo->iPort = 1;
		return TRUE;
	}

	/* "LPTx:" */
	
	if( strnicmp( p, "LPT", 3) != 0)
		return FALSE;

	pc = strchr( p, ':' );
	if( !pc )
		return FALSE;

	lptinfo->proto = p;
	p = pc + 1;
	*pc-- = '\0';

	/* Get port number if any */
	while( ( *pc >= '0' ) && ( *pc <= '9' ))
		pc--;
	pc++;
	lptinfo->iPort = atoi( pc );

	/* Name, TITLE=?, EMU=? */

	while( *p )
	{
		if( isspace( *p ) || ( *p == ',' ))
			p++;

		else
		{
			char * pt;

			pe = strchr(p, '=');
			pc = strchr(p, ',');

			if( pc && pe > pc )
				pe = NULL;

			if( !pe )
			{
				lptinfo->name = p;
			}
			else
			{
				/* remove spaces before '=' */
				pt = pe - 1;
				while( isspace( *pt )) *pt-- = '\0';

				/* remove spaces after '=' or end*/
				*pe++ = '\0';
				while( isspace( *pe )) *pe++ = '\0';

				if( stricmp( p, "EMU" ) == 0)
				{
					lptinfo->emu = pe;
				}
				else if( stricmp( p, "TITLE" ) == 0)
				{
					lptinfo->title = pe;
				}
				/* just ignore options we don't understand to allow forward compatibility */
			}

			/* remove spaces before ',' or end*/
			pt = pc ? pc : ptail;
			pt--;
			while( isspace( *pt )) *pt-- = '\0';

			if( pc )
			{
				p = pc + 1;
				*pc = '\0';
			}	
			else
			{
				p = ptail;
			}
		}
	}

	return TRUE;
}

/** Tests for the right file name for LPT access.
 *
 * Allowed file names are:
 *
 * - PRN:
 * - LPT:
 * - LPTx: with x>=1
 * - LPT:printer_name,EMU=?,TITLE=?,OPT=?, ...
 */
/*:::::*/
int fb_DevLptTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{

	DEV_LPT_PROTOCOL *lptinfo;
	int ret = fb_DevLptParseProtocol( filename, filename_len, &lptinfo);
	if( lptinfo )
		free( lptinfo );
	return ret;

}

