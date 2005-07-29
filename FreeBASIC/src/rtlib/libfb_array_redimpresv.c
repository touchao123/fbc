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
 * array_redimpresv.c -- redim preserve function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdarg.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_ArrayRedimPresv( FBARRAY *array, int element_len, int isvarlen, int dimensions, ... )
{
    va_list 	ap;
    int			i;
    int			elements, diff, size;
    FBARRAYDIM	*p;
    int			lbTB[FB_MAXDIMENSIONS];
    int			ubTB[FB_MAXDIMENSIONS];

	FB_LOCK();

    /* load bounds */
    va_start( ap, dimensions );

    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
        ubTB[i] = va_arg( ap, int );

        if( lbTB[i] > ubTB[i] )
        {
            FB_UNLOCK();
            /* should be: subscript out of range */
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    va_end( ap );

    /* calc size */
    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff 	 = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
    size	 = elements * element_len;

    /* new? */
    if( array->ptr == NULL )
    {
    	array->ptr = calloc( size, 1 );
    	if( array->ptr == NULL )
    	{
    		FB_UNLOCK();
    		return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
    	}
    }
    else
    {
        /* var len and current array is bigger? free unused elements */
        if( isvarlen != 0 )
        	if( array->dimTB[0].elements > (ubTB[0] - lbTB[0] + 1) )
        		fb_hArrayFreeVarLenStrs( array, ubTB[0] - lbTB[0] + 1 );

        /* realloc */
        array->ptr = realloc( array->ptr, size );
    	if( array->ptr == NULL )
    	{
    		FB_UNLOCK();
    		return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
    	}

        /* clear remainder */
        if( size > array->size )
        	memset( ((unsigned char*) array->ptr) + array->size, 0, size - array->size );
    }

    /* set descriptor */
    p = &array->dimTB[0];
    for( i = 0; i < dimensions; i++, p++ )
    {
    	p->elements = (ubTB[i] - lbTB[i]) + 1;
    	p->lbound 	= lbTB[i];
    	p->ubound 	= ubTB[i];
    }

	FB_ARRAY_SETDESC( array, element_len, dimensions, size, diff );

	FB_UNLOCK();

    return fb_ErrorSetNum( FB_RTERROR_OK );
}


