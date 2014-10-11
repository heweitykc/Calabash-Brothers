package com.events
{
    import flash.events.*;

    public class RoleEvent extends Event
    {
        public var obj:Object;
        public static const WEAPON_CHANGE:String = "RoleEvent_WEAPON_CHANGE";
        public static const ACT_RES_LOADED:String = "RoleEvent_ACT_RES_LOADED";
        public static const ROLE_VIEW_SHOWED:String = "ROLE_VIEW_SHOWED";
        public static const ADD_ROLE:String = "role_add_role";
        public static const LEAVE:String = "LEAVE";
        public static const UPDATE_DIRECT:String = "update_direct";
        public static const ARRIVE:String = "role_arrive";
        public static const PATHING_ARRIVE:String = "role_pathing_arrive";
        public static const PATHING_UPDATE:String = "pathing_update";
        public static const PATHING_POINT_UPDATE:String = "pathing_point_update";
        public static const ROLE_MOVE:String = "role_move";
        public static const ROLE_MOUSE_OVER:String = "role_mouse_over";
        public static const PASS:String = "role_pass";
        public static const ACTION_COMPLETE:String = "act_complete";
        public static const ACTION_EFECT:String = "RoleEvent_ACT_EFECT";
        public static const ATTACKED:String = "attacked";
        public static const DEAD:String = "role_dead";
        public static const UPDATE_HP:String = "role_update_hp";
        public static const UPDATE_MP:String = "role_update_ep";
        public static const UPDATE_SP:String = "role_update_cp";
        public static const UPDATE_HORSE_STATE:String = "role_update_horse_state";
        public static const UPDATE_HPMAX:String = "role_update_hpmax";
        public static const UPDATE_MPMAX:String = "role_update_epmax";
        public static const UPDATE_SPMAX:String = "role_update_cpmax";
        public static const UPDATE_LEVEL:String = "role_update_level";
        public static const UPDATE_BUFF:String = "role_update_buff";
        public static const UPDATE_HEAD_PIC:String = "role_update_head_pic";
        public static const UPDATE_EXP:String = "role_update_exp";
        public static const UPDATE_DU:String = "role_update_du";
        public static const UPDATE_GOLD:String = "role_update_gold";
        public static const UPDATE_SPIRIT:String = "role_update_spirit";
        public static const UPDATE_MONEY:String = "role_update_money";
        public static const UPDATE_DIAMOND:String = "role_update_diamond";
        public static const UPDATE_BINDGOLD:String = "role_update_bindgold";
        public static const UPDATE_COMPLETE:String = "role_update_complete";
        public static const UPDATE_FIGHT_NUMBER:String = "role_update_fight_number";
        public static const UPDATE_FIGHT_DOWN_NUMBER:String = "role_update_fight_down_number";
        public static const UPDATE_HIT:String = "role_update_hit";
        public static const UPDATE_Q_ADDMP_WHENKILL:String = "role_update_q_addmp_whenkill";
        public static const UPDATE_Q_IGNORE_ATTACKPERCENT:String = "role_update_q_ignore_attackpercent";
        public static const UPDATE_PHYSIC_ATTACKPERCENT:String = "role_update_physic_attackpercent";
        public static const UPDATE_MAGIC_ATTACKPERCENT:String = "role_update_magic_attackpercent";
        public static const UPDATE_Q_ADDHP_WHENKILL:String = "role_update_q_addhp_whenkill";
        public static const UPDATE_Q_ATTACKSPEED:String = "role_update_q_attackspeed";
        public static const UPDATE_Q_MAGICATTACK_PERCENT:String = "role_update_q_magicattack_percent";
        public static const UPDATE_Q_MAGICATTACK_BYLEVEL:String = "role_update_q_magicattack_bylevel";
        public static const UPDATE_Q_PHYSICATTACK_PERCENT:String = "role_update_q_physicattack_percent";
        public static const UPDSATE_PHYSICATTACK_BYLEVEL:String = "role_updsate_physicattack_bylevel";
        public static const UPDATE_Q_REMARKABLE_ATTACK:String = "role_update_q_remarkable_attack";
        public static const UPDATE_Q_ADD_MONEY:String = "role_update_q_add_money";
        public static const UPDATE_Q_DODGE:String = "role_update_q_dodge";
        public static const UPDATE_Q_REBOUND_DAMAGE:String = "role_update_q_rebound_damage";
        public static const UPDATE_Q_REDUCE_DAMAGE:String = "role_update_q_reduce_damage";
        public static const UPDATE_Q_ADD_HPLIMIT:String = "role_update_q_add_hplimit";
        public static const UPDATE_Q_ADD_MPLIMIT:String = "role_update_q_add_mplimit";
        public static const UPDATE_Q_HP_COVER:String = "role_update_q_hp_cover";
        public static const UPDATE_DEFENSE_PERCENT:String = "role_update_defense_perscent";
        public static const UPDATE_IGNORE_ATTACKPERCENT:String = "role_update_ignore_attackpercent";
        public static const UPDATE_MAGIC_ATTACKLOWER:String = "role_update_magic_attacklower";
        public static const UPDATE_MAGIC_ATTACKUPPER:String = "role_update_magic_attackupper";
        public static const UPDATE_PHYSIC_ATTACKLOWER:String = "role_update_physic_attacklower";
        public static const UPDATE_PHYSIC_ATTACKUPPER:String = "role_update_physic_attackupper";
        public static const UPDATE_KNOWING_ATTACKPERCENT:String = "role_update_knowing_attackpercent";
        public static const UPDATE_ATTACK_PERCENT:String = "role_update_attack_percent";
        public static const UPDATE_CRIT_PERCENT:String = "role_update_crit_percent";
        public static const UPDATE_DODGE_PERCENT:String = "role_update_dodge_percent";
        public static const UPDATE_HIT_PERCENT:String = "role_update_hit_percent";
        public static const UPDATE_POISON_DEF:String = "role_update_poison_def";
        public static const UPDATE_RAY_DEF:String = "role_update_ray_def";
        public static const UPDATE_ICE_DEF:String = "role_update_ice_def";
        public static const UPDATE_FATAL_BLOW:String = "role_fatal_blow";
        public static const UPDATE_POISON_ATTACK:String = "role_update_poison_attack";
        public static const UPDATE_RAY_ATTACK:String = "role_update_ray_attack";
        public static const UPDATE_AGILE:String = "role_update_agile";
        public static const UPDATE_UNALLOCALTEDTALENT:String = "role_update_unallocatedtalent";
        public static const UPDATE_VITALITY:String = "role_update_vitality";
        public static const UPDATE_STRENGTH:String = "role_update_strength";
        public static const UPDATE_INTELLIGENCE:String = "role_update_intelligence";
        public static const UPDATE_ICE_ATTACK:String = "role_update_ice_attack";
        public static const UPDATE_SPEED:String = "role_update_speed";
        public static const UPDATE_ATTACKSPEED:String = "role_update_attackspeed";
        public static const UPDATE_CRIT:String = "role_update_crit";
        public static const UPDATE_DODGE:String = "role_update_dodge";
        public static const UPDATE_DEFENSE:String = "role_update_defense";
        public static const UPDATE_ATTACK:String = "role_update_attack";
        public static const UPDATE_HIT_POINT:String = "role_update_hit_point";
        public static const UPDATE_PLAGUE_MARK:String = "role_update_plague_mark";
        public static const UPDATE_GUILD_ID:String = "roleUpdateGuildID";
        public static const UPDATE_GUILD_NAME:String = "roleUpdateGuildName";
        public static const UPDATE_PK_STATE:String = "roleUpdatePKState";
        public static const UPDATE_PK_VALUE:String = "roleUpdatePKValue";
        public static const UPDATE_MAX_EXP:String = "role_update_max_exp";
        public static const UPDATE_VIP_LEVEL:String = "role_update_vip_level";
        public static const FIGHT_NUMBER_UP:String = "fight_number_up";
        public static const UPDATE_JOB:String = "role_update_job";
        public static const UPDATE_BECOME:String = "role_become";
        public static var UPDATE_CSYS_KILLS:String = "role_csys_kills";
        public static var UPDATE_OFFLINE_EXP:String = "update_offline_exp";
        public static var SET_MY_INFO:String = "set_my_info";

        public function RoleEvent(param1:String, param2 = null)
        {
            super(param1);
            this.obj = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            return new RoleEvent(type, this.obj);
        }// end function

    }
}
