package com.cfg.vo
{

    public class Buff extends Object
    {
        public var q_buff_id:uint;
        public var q_buff_name:String;
        public var q_effect_prompt:String;
        public var q_target:uint;
        public var q_user_prompt:String;
        public var q_cast_type:uint;
        public var q_effect_type:uint;
        public var q_action_type:uint;
        public var q_effect_value:int;
        public var q_effect_ratio:uint;
        public var q_effect_time:uint;
        public var q_overlay:int;
        public var q_overlay_maxcount:int;
        public var q_replace_level:int;
        public var q_small_ico:String;
        public var q_ico:String;
        public var q_swf:String;
        public var q_tips:String;
        public var q_Bonus_skill:String;
        public var q_buffswf_location:uint;
        public var q_buff_warning:Boolean;
        public var q_category:int;
        public var q_shapechange_skill:int;

        public function Buff()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_buff_id = param1.q_buff_id;
            this.q_buff_name = param1.q_buff_name;
            this.q_effect_prompt = param1.q_effect_prompt;
            this.q_target = param1.q_target;
            this.q_user_prompt = param1.q_user_prompt;
            this.q_cast_type = param1.q_cast_type;
            this.q_effect_type = param1.q_effect_type;
            this.q_action_type = param1.q_action_type;
            this.q_effect_value = param1.q_effect_value;
            this.q_effect_ratio = param1.q_effect_ratio;
            this.q_effect_time = param1.q_effect_time;
            this.q_overlay = param1.q_overlay;
            this.q_overlay_maxcount = param1.q_overlay_maxcount;
            this.q_replace_level = param1.q_replace_level;
            this.q_small_ico = param1.q_small_ico;
            this.q_ico = param1.q_ico;
            this.q_swf = param1.q_swf;
            this.q_tips = param1.q_tips;
            this.q_Bonus_skill = param1.q_Bonus_skill;
            this.q_buffswf_location = param1.q_buffswf_location;
            this.q_buff_warning = param1.q_buff_warning && param1.q_buff_warning.replace(" ", "") == "1" ? (true) : (false);
            this.q_category = param1.q_category;
            this.q_shapechange_skill = param1.q_shapechange_skill;
            return;
        }// end function

    }
}
