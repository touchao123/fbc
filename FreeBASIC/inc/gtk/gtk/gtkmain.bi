''
''
'' gtkmain -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmain_bi__
#define __gtkmain_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkwidget.bi"

type GtkKeySnoopFunc as function cdecl(byval as GtkWidget ptr, byval as GdkEventKey ptr, byval as gpointer) as gint

declare function gtk_check_version cdecl alias "gtk_check_version" (byval required_major as guint, byval required_minor as guint, byval required_micro as guint) as zstring ptr
declare function gtk_parse_args cdecl alias "gtk_parse_args" (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as gboolean
declare sub gtk_init cdecl alias "gtk_init" (byval argc as integer ptr, byval argv as byte ptr ptr ptr)
declare function gtk_init_check cdecl alias "gtk_init_check" (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as gboolean
declare function gtk_init_with_args cdecl alias "gtk_init_with_args" (byval argc as integer ptr, byval argv as byte ptr ptr ptr, byval parameter_string as string, byval entries as GOptionEntry ptr, byval translation_domain as string, byval error as GError ptr ptr) as gboolean
declare function gtk_get_option_group cdecl alias "gtk_get_option_group" (byval open_default_display as gboolean) as GOptionGroup ptr
declare sub gtk_exit cdecl alias "gtk_exit" (byval error_code as gint)
declare sub gtk_disable_setlocale cdecl alias "gtk_disable_setlocale" ()
declare function gtk_set_locale cdecl alias "gtk_set_locale" () as zstring ptr
declare function gtk_get_default_language cdecl alias "gtk_get_default_language" () as PangoLanguage ptr
declare function gtk_events_pending cdecl alias "gtk_events_pending" () as gboolean
declare sub gtk_main_do_event cdecl alias "gtk_main_do_event" (byval event as GdkEvent ptr)
declare sub gtk_main cdecl alias "gtk_main" ()
declare function gtk_main_level cdecl alias "gtk_main_level" () as guint
declare sub gtk_main_quit cdecl alias "gtk_main_quit" ()
declare function gtk_main_iteration cdecl alias "gtk_main_iteration" () as gboolean
declare function gtk_main_iteration_do cdecl alias "gtk_main_iteration_do" (byval blocking as gboolean) as gboolean
declare function gtk_true cdecl alias "gtk_true" () as gboolean
declare function gtk_false cdecl alias "gtk_false" () as gboolean
declare sub gtk_grab_add cdecl alias "gtk_grab_add" (byval widget as GtkWidget ptr)
declare function gtk_grab_get_current cdecl alias "gtk_grab_get_current" () as GtkWidget ptr
declare sub gtk_grab_remove cdecl alias "gtk_grab_remove" (byval widget as GtkWidget ptr)
declare sub gtk_init_add cdecl alias "gtk_init_add" (byval function as GtkFunction, byval data as gpointer)
declare sub gtk_quit_add_destroy cdecl alias "gtk_quit_add_destroy" (byval main_level as guint, byval object as GtkObject ptr)
declare function gtk_quit_add cdecl alias "gtk_quit_add" (byval main_level as guint, byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_quit_add_full cdecl alias "gtk_quit_add_full" (byval main_level as guint, byval function as GtkFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GtkDestroyNotify) as guint
declare sub gtk_quit_remove cdecl alias "gtk_quit_remove" (byval quit_handler_id as guint)
declare sub gtk_quit_remove_by_data cdecl alias "gtk_quit_remove_by_data" (byval data as gpointer)
declare function gtk_timeout_add cdecl alias "gtk_timeout_add" (byval interval as guint32, byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_timeout_add_full cdecl alias "gtk_timeout_add_full" (byval interval as guint32, byval function as GtkFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GtkDestroyNotify) as guint
declare sub gtk_timeout_remove cdecl alias "gtk_timeout_remove" (byval timeout_handler_id as guint)
declare function gtk_idle_add cdecl alias "gtk_idle_add" (byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_idle_add_priority cdecl alias "gtk_idle_add_priority" (byval priority as gint, byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_idle_add_full cdecl alias "gtk_idle_add_full" (byval priority as gint, byval function as GtkFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GtkDestroyNotify) as guint
declare sub gtk_idle_remove cdecl alias "gtk_idle_remove" (byval idle_handler_id as guint)
declare sub gtk_idle_remove_by_data cdecl alias "gtk_idle_remove_by_data" (byval data as gpointer)
declare function gtk_input_add_full cdecl alias "gtk_input_add_full" (byval source as gint, byval condition as GdkInputCondition, byval function as GdkInputFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GtkDestroyNotify) as guint
declare sub gtk_input_remove cdecl alias "gtk_input_remove" (byval input_handler_id as guint)
declare function gtk_key_snooper_install cdecl alias "gtk_key_snooper_install" (byval snooper as GtkKeySnoopFunc, byval func_data as gpointer) as guint
declare sub gtk_key_snooper_remove cdecl alias "gtk_key_snooper_remove" (byval snooper_handler_id as guint)
declare function gtk_get_current_event cdecl alias "gtk_get_current_event" () as GdkEvent ptr
declare function gtk_get_current_event_time cdecl alias "gtk_get_current_event_time" () as guint32
declare function gtk_get_current_event_state cdecl alias "gtk_get_current_event_state" (byval state as GdkModifierType ptr) as gboolean
declare function gtk_get_event_widget cdecl alias "gtk_get_event_widget" (byval event as GdkEvent ptr) as GtkWidget ptr
declare sub gtk_propagate_event cdecl alias "gtk_propagate_event" (byval widget as GtkWidget ptr, byval event as GdkEvent ptr)
declare function _gtk_boolean_handled_accumulator cdecl alias "_gtk_boolean_handled_accumulator" (byval ihint as GSignalInvocationHint ptr, byval return_accu as GValue ptr, byval handler_return as GValue ptr, byval dummy as gpointer) as gboolean
declare function _gtk_get_lc_ctype cdecl alias "_gtk_get_lc_ctype" () as zstring ptr

#endif
