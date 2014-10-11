package com.events
{
    import flash.events.*;

    public class GameEvent extends Event
    {
        public var obj:Object;
        public static const CHANGE_SELECT_ROLE:String = "CHANGE_SELECT_ROLE";
        public static const CD_CHANGE:String = "CD_CHANGE";
        public static const SKILL_PUBLIC_CD_CHANGE:String = "SKILL_PUBLIC_CD_CHANGE";
        public static const SHOW_OR_HIDE_PLAYERS:String = "SHOW_OR_HIDE_PLAYERS";
        public static const HIDE_OTHER_PLAYERS:String = "hide_other_player";
        public static const LOGIN_SUCCESS:String = "LOGIN_SUCCESS";
        public static const LOGIN_FAIL:String = "LOGIN_FAIL";
        public static const REGISTER_PANEL_LOADED:String = "REGISTER_PANEL_LOADED";
        public static const SHOW_OR_HIDE_MONSTER:String = "show_or_hide_monster";
        public static const OTHER_NORMAL_MODEL:String = "other_normal_model";
        public static const PLAYER_PRAY_INFO_UPDATE:String = "player_pray_info_upate";
        public static const TOP_ACTIVATE_BTN_ADD:String = "top_activate_btn_add";
        public static const TOP_ACTIVATE_BTN_REMOVE:String = "top_activate_btn_remove";
        public static const TOP_ACTIVATE_BTN_MOVE_EFFECT_COMPLETE:String = "top_activate_btn_move_effect_complete";
        public static const LINE_CHANGE:String = "line_change";
        public static const PLAYER_CUTE_PET_STATE_UPDATE:String = "player_cute_pet_state_update";
        public static const PLAYER_MAGIC_BOOK_STATE_UPDATE:String = "player_magicbook_state_update";
        public static const MONSTER_TYPE_LIST_ADD:String = "monster_type_list_add";
        public static const MONSTER_TYPE_LIST_REMOVE:String = "monster_type_list_remove";
        public static const MONSTER_TYPE_LIST_RESET:String = "monster_type_list_reset";
        public static const CHAT_CLICK_BLANK:String = "chat_click_blank";

        public function GameEvent(param1:String, param2 = null)
        {
            this.obj = param2;
            super(param1);
            return;
        }// end function

        override public function clone() : Event
        {
            return new GameEvent(type, this.obj);
        }// end function

    }
}
