''
''
'' gtkcombo -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcombo_bi__
#define __gtkcombo_bi__

#include once "gtk/gtk/gtkhbox.bi"
#include once "gtk/gtk/gtkitem.bi"

type GtkCombo as _GtkCombo
type GtkComboClass as _GtkComboClass

type _GtkCombo
	hbox as GtkHBox
	entry as GtkWidget ptr
	button as GtkWidget ptr
	popup as GtkWidget ptr
	popwin as GtkWidget ptr
	list as GtkWidget ptr
	entry_change_id as guint
	list_change_id as guint
	value_in_list as guint
	ok_if_empty as guint
	case_sensitive as guint
	use_arrows as guint
	use_arrows_always as guint
	current_button as guint16
	activate_id as guint
end type

type _GtkComboClass
	parent_class as GtkHBoxClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_combo_get_type cdecl alias "gtk_combo_get_type" () as GType
declare function gtk_combo_new cdecl alias "gtk_combo_new" () as GtkWidget ptr
declare sub gtk_combo_set_value_in_list cdecl alias "gtk_combo_set_value_in_list" (byval combo as GtkCombo ptr, byval val as gboolean, byval ok_if_empty as gboolean)
declare sub gtk_combo_set_use_arrows cdecl alias "gtk_combo_set_use_arrows" (byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_use_arrows_always cdecl alias "gtk_combo_set_use_arrows_always" (byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_case_sensitive cdecl alias "gtk_combo_set_case_sensitive" (byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_item_string cdecl alias "gtk_combo_set_item_string" (byval combo as GtkCombo ptr, byval item as GtkItem ptr, byval item_value as string)
declare sub gtk_combo_set_popdown_strings cdecl alias "gtk_combo_set_popdown_strings" (byval combo as GtkCombo ptr, byval strings as GList ptr)
declare sub gtk_combo_disable_activate cdecl alias "gtk_combo_disable_activate" (byval combo as GtkCombo ptr)

#endif
