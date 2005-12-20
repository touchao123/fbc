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
 * str_oct.c -- oct$ routine for long long's
 *
 * chng: apr/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static char *hFillDigits( char *buf, int digits, int totdigs, int cnt )
{
	if( digits > 0 )
	{
		digits -= totdigs - cnt;
		while( digits > 0 )
		{
			*buf++ = '0';
			--digits;
		}
	}

	return buf;
}

/*:::::*/
FBCALL FBSTRING *fb_OCTEx_l ( unsigned long long num, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs, rem;

	totdigs = ((sizeof(long long)*8) / 3) + 1;

	if( digits > 0 )
	{
		if( digits < totdigs )
			totdigs = digits;
		else if( digits > totdigs )
			digits = totdigs;
	}

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, totdigs );
	if( dst == NULL )
		return &fb_strNullDesc;

	/* convert */
	buf = dst->data;

	if( num == 0 )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = '0';
	}
	else
	{
		/* too small? */
		if( totdigs < 3 )
		{
			rem = 0;
			num <<= ((sizeof(long long)*8) - totdigs * 3);
		}
		else
		{
			rem = totdigs % 3;
			num <<= ((sizeof(long long)*8) - ((totdigs-(rem == 0?0:1)) * 3 + rem));
		}

		/* remainder? */
		if( rem > 0 )
		{
			if( num > (0xFFFFFFFFFFFFFFFFULL >> rem) )
			{
				buf = hFillDigits( buf, digits, totdigs, 1 );
				*buf++ = '0' + ((num & ~(0xFFFFFFFFFFFFFFFFULL >> rem))
								  >> (sizeof(long long)*8-rem));
			}

			num <<= rem;
			i = 1;
		}
		else
			i = 0;

		/* check for 0's at msb? */
		if( buf == dst->data )
		{
			for( ; i < totdigs; i++, num <<= 3 )
				if( num > 0x1FFFFFFFFFFFFFFFULL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			if( num > 0x1FFFFFFFFFFFFFFFULL )
				*buf++ = '0' + ((num & 0xE000000000000000ULL) >> (sizeof(long long)*8-3));
			else
				*buf++ = '0';
	}

	/* add null-term */
	*buf = '\0';

    fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_OCT_l ( unsigned long long num )
{
	return fb_OCTEx_l( num, 0 );
}

