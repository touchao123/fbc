# include "fbcu.bi"

namespace fbc_tests.overloads.op_cast_coercion

const TEST_VAL_BYTE = 1
const TEST_VAL_SHORT = 2
const TEST_VAL_INTEGER = 3
const TEST_VAL_LONG = 4
const TEST_VAL_LONGINT = 5
const TEST_VAL_UBYTE = 6
const TEST_VAL_USHORT = 7
const TEST_VAL_UINTEGER = 8
const TEST_VAL_ULONG = 9
const TEST_VAL_ULONGINT = 10
const TEST_VAL_SINGLE = 11
const TEST_VAL_DOUBLE = 12
	
type foo
	as byte pad
	
	declare operator cast() as byte
	declare operator cast() as short
	declare operator cast() as integer
	declare operator cast() as long
	declare operator cast() as longint
	declare operator cast() as ubyte
	declare operator cast() as ushort
	declare operator cast() as uinteger
	declare operator cast() as ulong
	declare operator cast() as ulongint
	declare operator cast() as single
	declare operator cast() as double
end type

#macro gen_test( tp )
	operator foo.cast() as tp
		return TEST_VAL_##tp
	end operator

	sub tp##_ref( byref v as tp )
		CU_ASSERT_EQUAL( v, TEST_VAL_##tp )
	end sub
	
	sub tp##_val( byval v as tp )
		CU_ASSERT_EQUAL( v, TEST_VAL_##tp )
	end sub

	sub tp##_test cdecl
		dim f as foo
		
		tp##_ref( f )
		tp##_val( f )
		
	end sub
#endmacro

	gen_test( byte )
	gen_test( short )
	gen_test( integer )
	gen_test( long )
	gen_test( longint )
	gen_test( single )
	gen_test( double )
	gen_test( ubyte )
	gen_test( ushort )
	gen_test( uinteger )
	gen_test( ulong )
	gen_test( ulongint )

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.op_cast_coercion")
	fbcu.add_test("byte", @byte_test)
	fbcu.add_test("ubyte", @ubyte_test)
	fbcu.add_test("short", @short_test)
	fbcu.add_test("ushort", @ushort_test)
	fbcu.add_test("integer", @integer_test)
	fbcu.add_test("uinteger", @uinteger_test)
	fbcu.add_test("long", @long_test)
	fbcu.add_test("ulong", @ulong_test)
	fbcu.add_test("longint", @longint_test)
	fbcu.add_test("ulongint", @ulongint_test)
	fbcu.add_test("single", @single_test)
	fbcu.add_test("double", @double_test)

end sub

end namespace
