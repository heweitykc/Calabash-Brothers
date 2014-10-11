package com.cfg.vo
{

    public class Skill extends Object
    {
        public var q_skillID_q_grade:String;
        public var q_skillID:uint;
        private var _q_skillName:String;
        public var q_panel_type:uint;
        public var q_index:uint;
        public var q_show_needgrade:uint;
        public var q_desc:String;
        private var _q_tips:String;
        public var q_skill_origin:String;
        public var q_trigger_type:uint;
        public var q_range_limit:uint;
        public var q_target:uint;
        public var q_area_shape:uint;
        public var q_area_target:uint;
        public var q_sector_radius:uint;
        public var q_circular_radius:uint;
        public var q_target_max:uint;
        public var q_shortcut:int;
        private var _q_cd:uint;
        public var q_public_cd:uint;
        public var q_public_cd_level:uint;
        public var q_grade:uint;
        public var q_need_mp:uint;
        public var q_attack_id:String;
        public var q_attack_id_double:String;
        public var q_delay_time:uint;
        public var q_trajectory_speed:uint;
        private var _q_use_effect:String;
        private var _q_trajectory_effect:String;
        public var q_trajectory_effect_dir:String;
        public var q_trajectory_effect_time:uint;
        private var _q_hit_effect:String;
        private var _q_ground_effect:String;
        private var _q_hit_ground_effect:String;
        public var q_series_effect:String;
        public var q_fly_Penetrate:uint;
        public var q_small_ico:String;
        public var q_use_sound:String;
        public var q_hit_sound:String;
        public var q_skill_time:int;
        public var q_skill_type:uint;
        public var q_loopmagic:Boolean;
        public var q_skill_elementtype:uint;
        public var q_pointtype:uint;
        public var q_job:Number;
        public var q_job_client:Number;
        public var q_animal_id:uint;
        public var q_whirlwind_nor:uint;
        public var q_whirlwind_dead:uint;
        public var q_shake_iskill:Boolean;
        public var q_shake_isluck:Boolean;
        public var q_shake_isperfect:Boolean;
        public var q_shake_isignore:Boolean;
        public var q_shake_begin:Boolean;
        public var q_shake_duration:uint;
        public var q_shake_level:uint;
        public var q_blood_num:int;
        public var q_brief_skill_type:String;
        public var q_auto_brief_skill_type:String;
        public var q_range_length:int;
        public var q_rotation:int;

        public function Skill()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_skillID_q_grade = param1.q_skillID_q_grade;
            this.q_skillID = param1.q_skillID;
            this.q_skillName = param1.q_skillName;
            this.q_panel_type = param1.q_panel_type;
            this.q_index = param1.q_index;
            this.q_show_needgrade = param1.q_show_needgrade;
            this.q_desc = param1.q_desc;
            this.q_tips = param1.q_tips;
            this.q_skill_origin = param1.q_skill_origin;
            this.q_trigger_type = param1.q_trigger_type;
            this.q_range_limit = param1.q_range_limit;
            this.q_target = param1.q_target;
            this.q_area_shape = param1.q_area_shape;
            this.q_area_target = param1.q_area_target;
            this.q_sector_radius = param1.q_sector_radius;
            this.q_circular_radius = param1.q_circular_radius;
            this.q_target_max = param1.q_target_max;
            this.q_shortcut = param1.q_shortcut;
            this.q_cd = param1.q_cd;
            this.q_public_cd = param1.q_public_cd;
            this.q_public_cd_level = param1.q_public_cd_level;
            this.q_grade = param1.q_grade;
            this.q_need_mp = param1.q_need_mp;
            this.q_attack_id = param1.q_attack_id;
            this.q_attack_id_double = param1.q_attack_id_double;
            this.q_delay_time = param1.q_delay_time;
            this.q_trajectory_speed = param1.q_trajectory_speed;
            this.q_use_effect = param1.q_use_effect;
            this.q_trajectory_effect = param1.q_trajectory_effect;
            this.q_trajectory_effect_dir = param1.q_trajectory_effect_dir;
            this.q_trajectory_effect_time = param1.q_trajectory_effect_time;
            this.q_hit_effect = param1.q_hit_effect;
            this.q_ground_effect = param1.q_ground_effect;
            this.q_hit_ground_effect = param1.q_hit_ground_effect;
            this.q_series_effect = param1.q_series_effect;
            this.q_fly_Penetrate = param1.q_fly_Penetrate;
            this.q_small_ico = param1.q_small_ico;
            this.q_use_sound = param1.q_use_sound;
            this.q_hit_sound = param1.q_hit_sound;
            this.q_skill_time = param1.q_skill_time;
            this.q_skill_type = param1.q_skill_type;
            this.q_loopmagic = param1.q_loopmagic && param1.q_loopmagic.replace(" ", "") == "1" ? (true) : (false);
            this.q_skill_elementtype = param1.q_skill_elementtype;
            this.q_pointtype = param1.q_pointtype;
            this.q_job = param1.q_job;
            this.q_job_client = param1.q_job_client;
            this.q_animal_id = param1.q_animal_id;
            this.q_whirlwind_nor = param1.q_whirlwind_nor;
            this.q_whirlwind_dead = param1.q_whirlwind_dead;
            this.q_shake_iskill = param1.q_shake_iskill && param1.q_shake_iskill.replace(" ", "") == "1" ? (true) : (false);
            this.q_shake_isluck = param1.q_shake_isluck && param1.q_shake_isluck.replace(" ", "") == "1" ? (true) : (false);
            this.q_shake_isperfect = param1.q_shake_isperfect && param1.q_shake_isperfect.replace(" ", "") == "1" ? (true) : (false);
            this.q_shake_isignore = param1.q_shake_isignore && param1.q_shake_isignore.replace(" ", "") == "1" ? (true) : (false);
            this.q_shake_begin = param1.q_shake_begin && param1.q_shake_begin.replace(" ", "") == "1" ? (true) : (false);
            this.q_shake_duration = param1.q_shake_duration;
            this.q_shake_level = param1.q_shake_level;
            this.q_blood_num = param1.q_blood_num;
            this.q_brief_skill_type = param1.q_brief_skill_type;
            this.q_auto_brief_skill_type = param1.q_auto_brief_skill_type;
            this.q_range_length = param1.q_range_length;
            this.q_rotation = param1.q_rotation;
            return;
        }// end function

        public function get q_skillName() : String
        {
            return this._q_skillName;
        }// end function

        public function set q_skillName(param1:String) : void
        {
            this._q_skillName = param1;
            return;
        }// end function

        public function get q_tips() : String
        {
            return this._q_tips;
        }// end function

        public function set q_tips(param1:String) : void
        {
            this._q_tips = param1;
            return;
        }// end function

        public function get q_use_effect() : String
        {
            return this._q_use_effect;
        }// end function

        public function set q_use_effect(param1:String) : void
        {
            this._q_use_effect = param1;
            return;
        }// end function

        public function get q_trajectory_effect() : String
        {
            return this._q_trajectory_effect;
        }// end function

        public function set q_trajectory_effect(param1:String) : void
        {
            this._q_trajectory_effect = param1;
            return;
        }// end function

        public function get q_hit_effect() : String
        {
            return this._q_hit_effect;
        }// end function

        public function set q_hit_effect(param1:String) : void
        {
            this._q_hit_effect = param1;
            return;
        }// end function

        public function get q_hit_ground_effect() : String
        {
            return this._q_hit_ground_effect;
        }// end function

        public function set q_hit_ground_effect(param1:String) : void
        {
            this._q_hit_ground_effect = param1;
            return;
        }// end function

        public function get q_ground_effect() : String
        {
            return this._q_ground_effect;
        }// end function

        public function set q_ground_effect(param1:String) : void
        {
            this._q_ground_effect = param1;
            return;
        }// end function

        public function get q_cd() : uint
        {
            return this._q_cd;
        }// end function

        public function set q_cd(param1:uint) : void
        {
            this._q_cd = param1;
            return;
        }// end function

    }
}
