/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 */

/*
 * str_convpath - path conversion for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include <string.h>
#include "fb.h"

/*:::::*/
char *fb_hConvertPath( char *path, int len )
{
    int i;

    if( path == NULL )
    	return NULL;

	for (i = 0; i < strlen( path ); i++)
	{
		if ( path[i] == '/' )
			path[i] = '\\';
	}

	return path;
}
