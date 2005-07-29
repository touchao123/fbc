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
 * swap_str.c -- swap f/ strings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_StrSwap( void *str1, int str1_size, void *str2, int str2_size )
{
	FBSTRING 	td;
	char 		*str1_ptr, *str2_ptr;
	int 		str1_len, str2_len, size;

	if( (str1 == NULL) || (str2 == NULL) )
		return;

	FB_STRLOCK();

	/* both var-len? */
	if( (str1_size == -1) && (str2_size == -1) )
	{
     	/* just swap the descriptors */
     	td.data = ((FBSTRING *)str1)->data;
     	td.len  = ((FBSTRING *)str1)->len;

     	((FBSTRING *)str1)->data = ((FBSTRING *)str2)->data;
     	((FBSTRING *)str1)->len = ((FBSTRING *)str2)->len;

     	((FBSTRING *)str2)->data = td.data;
     	((FBSTRING *)str2)->len = td.len;

		FB_STRUNLOCK();

        return;
	}

	FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );
	FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

	if( (str1_ptr == NULL) || (str2_ptr == NULL) )
		return;

	/* handle zstring ptr's */
	if( str1_size <= 0 )
		str1_size = str1_len+1;

	if( str2_size <= 0 )
		str2_size = str2_len+1;

	/* don't overrun */
	size = (str1_size <= str2_size? str1_size : str2_size) - 1;

	if( size > 0 )
		fb_MemSwap( (unsigned char *)str1_ptr, (unsigned char *)str2_ptr, size );

	/* add the null-terms */
	str1_ptr[size] = '\0';
	str2_ptr[size] = '\0';

	FB_STRUNLOCK();
}
