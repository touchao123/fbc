''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' option (OPTION) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''OptDecl         =   OPTION (EXPLICIT|BASE NUM_LIT|BYVAL|PRIVATE|ESCAPE|DYNAMIC|STATIC)
''
function cOptDecl as integer
	dim s as FBSYMBOL ptr

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

	'' OPTION
	lexSkipToken( )

	select case as const lexGetToken( )
	case FB_TK_EXPLICIT
		lexSkipToken( )
		env.opt.explicit = TRUE

	case FB_TK_BASE
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
			if( hReportError( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: skip stmt
				cSkipStmt( )
			end if

		else
			env.opt.base = valint( *lexGetText( ) )
			lexSkipToken( )
		end if

	case FB_TK_BYVAL
		lexSkipToken( )
		env.opt.parammode = FB_PARAMMODE_BYVAL

	case FB_TK_PRIVATE
		lexSkipToken( )
		env.opt.procpublic = FALSE

	case FB_TK_DYNAMIC
		lexSkipToken( )
		env.opt.dynamic = TRUE

	case FB_TK_STATIC
		lexSkipToken( )
		env.opt.dynamic = FALSE

	case else

		'' ESCAPE? (it's not a reserved word, there are too many already..)
		select case ucase( *lexGetText( ) )
		case "ESCAPE"
			lexSkipToken( )
			env.opt.escapestr = TRUE

		'' NOKEYWORD? (ditto..)
		case "NOKEYWORD"
			lexSkipToken( LEXCHECK_NODEFINE )

			do
				select case lexGetClass( LEXCHECK_NODEFINE )
				case FB_TKCLASS_KEYWORD
					if( symbDelKeyword( lexGetSymChain( )->sym ) = FALSE ) then
						if( hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
							exit function
						end if
					end if

					lexSkipToken( )

				case FB_TKCLASS_IDENTIFIER
					'' proc?
					s = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_PROC )
					if( s <> NULL ) then

						'' is it from the rtlib (gfxlib will be listed as part of the rt too)?
						if( symbGetIsRTL( s ) = FALSE ) then
							if( hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
								exit function
							end if

						else
							'' don't remove if it was defined in other namespace
							if( symbGetHashTb( s ) <> symbGetCurrentHashTb( ) ) then
								if( hReportError( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS ) = FALSE ) then
									exit function
								end if

							else
								symbDelPrototype( s )
							end if
						end if


					else
						'' macro?
						s = symbFindByClass( lexGetSymChain( ), FB_SYMBCLASS_DEFINE )
						if( s = NULL ) then
							if( hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
								exit function
							end if

						else
							'' don't remove if it was defined in other namespace
							if( symbGetHashTb( s ) <> symbGetCurrentHashTb( ) ) then
								if( hReportError( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS ) = FALSE ) then
									exit function
								end if

							else
								symbDelDefine( s )
							end if
						end if

					end if

					lexSkipToken( )

				case else
					if( hReportError( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					else
						'' error recovery: skip until next ','
						cSkipUntil( CHAR_COMMA )
					end if
				end select

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( LEXCHECK_NODEFINE )
			loop

		case else
			if( hReportError( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
		end select

	end select

	function = TRUE

end function

