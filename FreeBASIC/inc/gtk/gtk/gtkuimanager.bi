''
''
'' gtkuimanager -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkuimanager_bi__
#define __gtkuimanager_bi__

#include once "gtk/glib.bi"
#include once "gtk/glib-object.bi"
#include once "gtk/gtk/gtkaccelgroup.bi"
#include once "gtk/gtk/gtkwidget.bi"
#include once "gtk/gtk/gtkaction.bi"
#include once "gtk/gtk/gtkactiongroup.bi"

type GtkUIManager as _GtkUIManager
type GtkUIManagerClass as _GtkUIManagerClass
type GtkUIManagerPrivate as _GtkUIManagerPrivate

type _GtkUIManager
	parent as GObject
	private_data as GtkUIManagerPrivate ptr
end type

type _GtkUIManagerClass
	parent_class as GObjectClass
	add_widget as sub cdecl(byval as GtkUIManager ptr, byval as GtkWidget ptr)
	actions_changed as sub cdecl(byval as GtkUIManager ptr)
	connect_proxy as sub cdecl(byval as GtkUIManager ptr, byval as GtkAction ptr, byval as GtkWidget ptr)
	disconnect_proxy as sub cdecl(byval as GtkUIManager ptr, byval as GtkAction ptr, byval as GtkWidget ptr)
	pre_activate as sub cdecl(byval as GtkUIManager ptr, byval as GtkAction ptr)
	post_activate as sub cdecl(byval as GtkUIManager ptr, byval as GtkAction ptr)
	get_widget as function cdecl(byval as GtkUIManager ptr, byval as string) as GtkWidget
	get_action as function cdecl(byval as GtkUIManager ptr, byval as string) as GtkAction
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
end type

enum GtkUIManagerItemType
	GTK_UI_MANAGER_AUTO = 0
	GTK_UI_MANAGER_MENUBAR = 1 shl 0
	GTK_UI_MANAGER_MENU = 1 shl 1
	GTK_UI_MANAGER_TOOLBAR = 1 shl 2
	GTK_UI_MANAGER_PLACEHOLDER = 1 shl 3
	GTK_UI_MANAGER_POPUP = 1 shl 4
	GTK_UI_MANAGER_MENUITEM = 1 shl 5
	GTK_UI_MANAGER_TOOLITEM = 1 shl 6
	GTK_UI_MANAGER_SEPARATOR = 1 shl 7
	GTK_UI_MANAGER_ACCELERATOR = 1 shl 8
end enum


declare function gtk_ui_manager_get_type cdecl alias "gtk_ui_manager_get_type" () as GType
declare function gtk_ui_manager_new cdecl alias "gtk_ui_manager_new" () as GtkUIManager ptr
declare sub gtk_ui_manager_set_add_tearoffs cdecl alias "gtk_ui_manager_set_add_tearoffs" (byval self as GtkUIManager ptr, byval add_tearoffs as gboolean)
declare function gtk_ui_manager_get_add_tearoffs cdecl alias "gtk_ui_manager_get_add_tearoffs" (byval self as GtkUIManager ptr) as gboolean
declare sub gtk_ui_manager_insert_action_group cdecl alias "gtk_ui_manager_insert_action_group" (byval self as GtkUIManager ptr, byval action_group as GtkActionGroup ptr, byval pos as gint)
declare sub gtk_ui_manager_remove_action_group cdecl alias "gtk_ui_manager_remove_action_group" (byval self as GtkUIManager ptr, byval action_group as GtkActionGroup ptr)
declare function gtk_ui_manager_get_action_groups cdecl alias "gtk_ui_manager_get_action_groups" (byval self as GtkUIManager ptr) as GList ptr
declare function gtk_ui_manager_get_accel_group cdecl alias "gtk_ui_manager_get_accel_group" (byval self as GtkUIManager ptr) as GtkAccelGroup ptr
declare function gtk_ui_manager_get_widget cdecl alias "gtk_ui_manager_get_widget" (byval self as GtkUIManager ptr, byval path as string) as GtkWidget ptr
declare function gtk_ui_manager_get_toplevels cdecl alias "gtk_ui_manager_get_toplevels" (byval self as GtkUIManager ptr, byval types as GtkUIManagerItemType) as GSList ptr
declare function gtk_ui_manager_get_action cdecl alias "gtk_ui_manager_get_action" (byval self as GtkUIManager ptr, byval path as string) as GtkAction ptr
declare function gtk_ui_manager_add_ui_from_string cdecl alias "gtk_ui_manager_add_ui_from_string" (byval self as GtkUIManager ptr, byval buffer as string, byval length as gssize, byval error as GError ptr ptr) as guint
declare function gtk_ui_manager_add_ui_from_file cdecl alias "gtk_ui_manager_add_ui_from_file" (byval self as GtkUIManager ptr, byval filename as string, byval error as GError ptr ptr) as guint
declare sub gtk_ui_manager_add_ui cdecl alias "gtk_ui_manager_add_ui" (byval self as GtkUIManager ptr, byval merge_id as guint, byval path as string, byval name as string, byval action as string, byval type as GtkUIManagerItemType, byval top as gboolean)
declare sub gtk_ui_manager_remove_ui cdecl alias "gtk_ui_manager_remove_ui" (byval self as GtkUIManager ptr, byval merge_id as guint)
declare function gtk_ui_manager_get_ui cdecl alias "gtk_ui_manager_get_ui" (byval self as GtkUIManager ptr) as zstring ptr
declare sub gtk_ui_manager_ensure_update cdecl alias "gtk_ui_manager_ensure_update" (byval self as GtkUIManager ptr)
declare function gtk_ui_manager_new_merge_id cdecl alias "gtk_ui_manager_new_merge_id" (byval self as GtkUIManager ptr) as guint

#endif
