# include "fbcu.bi"

namespace fbc_tests.pointers.funptr_funcderef

const TEST_SUBR = 1234
const TEST_FUNC = 5678

type fntype
	subr as sub (byval x as integer)
	func as function (byval x as integer) as integer
end type

sub subr_cb (byval x as integer)
	CU_ASSERT_EQUAL( x, TEST_SUBR )
end sub
	
function func_cb (byval x as integer) as integer
	CU_ASSERT_EQUAL( x, TEST_FUNC )
	function = -1
end function

function getFn () as fntype ptr
	static as fntype fn = ( @subr_cb, @func_cb )
	function = @fn
end function

	
sub test_basic cdecl ()
	CU_ASSERT_EQUAL( getFn( )->func( TEST_FUNC ), -1 )
	getFn( )->subr( TEST_SUBR )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.funptr-funcderef")
	fbcu.add_test("test_basic", @test_basic)

end sub
	
end namespace