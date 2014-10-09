package com.cfg.vo
{

    public class Monster extends Object
    {
        public var q_id:uint;
        public var q_name:String;
        public var q_monster_type:int;
        public var q_evasive_style:int;
        public var q_gethit_type:Boolean;
        public var q_sculpt_resid:String;
        public var q_sculpt_zoom:int;
        public var q_head_resid:String;
        public var q_tosay_timeinterval:int;
        public var q_say_condition:String;
        public var q_grade:uint;
        public var q_maxhp:uint;
        public var q_maxmp:uint;
        public var q_attack:uint;
        public var q_defense:uint;
        public var q_dodge:uint;
        public var q_attack_speed:uint;
        public var q_speed:uint;
        public var q_hit:uint;
        public var q_weight:uint;
        public var q_sound:String;
        public var q_die_sound:String;
        public var q_fixed_add:int;
        public var q_mouse:int;

        public function Monster()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_name = param1.q_name;
            this.q_monster_type = param1.q_monster_type;
            this.q_evasive_style = param1.q_evasive_style;
            this.q_gethit_type = param1.q_gethit_type && param1.q_gethit_type.replace(" ", "") == "1" ? (true) : (false);
            this.q_sculpt_resid = param1.q_sculpt_resid;
            this.q_sculpt_zoom = param1.q_sculpt_zoom;
            this.q_head_resid = param1.q_head_resid;
            this.q_tosay_timeinterval = param1.q_tosay_timeinterval;
            this.q_say_condition = param1.q_say_condition;
            this.q_grade = param1.q_grade;
            this.q_maxhp = param1.q_maxhp;
            this.q_maxmp = param1.q_maxmp;
            this.q_attack = param1.q_attack;
            this.q_defense = param1.q_defense;
            this.q_dodge = param1.q_dodge;
            this.q_attack_speed = param1.q_attack_speed;
            this.q_speed = param1.q_speed;
            this.q_hit = param1.q_hit;
            this.q_weight = param1.q_weight;
            this.q_sound = param1.q_sound;
            this.q_die_sound = param1.q_die_sound;
            this.q_fixed_add = param1.q_fixed_add;
            this.q_mouse = param1.q_mouse;
            return;
        }// end function

    }
}
