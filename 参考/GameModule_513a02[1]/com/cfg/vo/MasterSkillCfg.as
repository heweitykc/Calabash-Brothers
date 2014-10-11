package com.cfg.vo
{
    import com.model.vo.*;
    import flash.utils.*;

    public class MasterSkillCfg extends Object
    {
        public var q_id_level:String;
        public var q_id:int;
        public var q_level:int;
        public var q_desc:String;
        public var q_icon:String;
        public var q_job:Number;
        public var q_name:String;
        public var q_cost_point:int;
        public var q_need_point:int;
        public var q_type:int;
        public var q_max_level:int;
        public var q_x:int;
        public var q_y:int;
        public var q_judge_value:int;
        public var q_effect_type:int;
        public var q_effect_value:int;
        public var q_effect_percent:int;
        public var q_effect_prob:int;
        public var q_depense:Array;
        public var q_judge_type:Array;
        public var q_effect_buff:Array;
        public var q_use_word:String;
        public var q_hit_word:String;
        public var q_skill_replace:int;
        public var q_icon_replace:String;
        public var q_desc_replace:String;
        public var q_effect_replace:Dictionary;
        public var skillInfo:SkillInfo;

        public function MasterSkillCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this.q_id_level = param1.q_id_level;
            this.q_id = param1.q_id;
            this.q_level = param1.q_level;
            this.q_desc = param1.q_desc;
            this.q_icon = param1.q_icon;
            this.q_job = param1.q_job;
            this.q_name = param1.q_name;
            this.q_cost_point = param1.q_cost_point;
            this.q_need_point = param1.q_need_point;
            this.q_type = param1.q_type;
            this.q_max_level = param1.q_max_level;
            this.q_x = param1.q_x;
            this.q_y = param1.q_y;
            this.q_judge_value = param1.q_judge_value;
            this.q_effect_type = param1.q_effect_type;
            this.q_effect_value = param1.q_effect_value;
            this.q_effect_percent = param1.q_effect_percent;
            this.q_effect_prob = param1.q_effect_prob;
            this.q_depense = [];
            var _loc_2:* = param1.q_depense;
            var _loc_3:* = _loc_2 ? (_loc_2.split("|")) : (null);
            var _loc_4:* = _loc_3 ? (_loc_3.length) : (0);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = String(_loc_3[_loc_5]).split("_");
                this.q_depense.push([int(_loc_9[0]), int(_loc_9[1])]);
                _loc_5++;
            }
            this.q_judge_type = [];
            var _loc_6:* = param1.q_judge_type;
            _loc_3 = param1.q_judge_type ? (_loc_6.split("|")) : (null);
            _loc_4 = _loc_3 ? (_loc_3.length) : (0);
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = String(_loc_3[_loc_5]).split(",");
                this.q_judge_type.push([int(_loc_9[0]), int(_loc_9[1])]);
                _loc_5++;
            }
            var _loc_7:* = param1.q_effect_buff;
            this.q_effect_buff = _loc_7 ? (_loc_7.split(";")) : ([]);
            this.q_use_word = param1.q_use_word;
            this.q_hit_word = param1.q_hit_word;
            this.q_skill_replace = param1.q_skill_replace;
            this.q_icon_replace = param1.q_icon_replace;
            this.q_desc_replace = param1.q_desc_replace;
            var _loc_8:* = param1.q_effect_replace;
            if (param1.q_effect_replace)
            {
                this.q_effect_replace = new Dictionary();
                _loc_10 = _loc_8.split("|");
                _loc_4 = _loc_10.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_11 = _loc_10[_loc_5];
                    _loc_12 = _loc_11.split("=");
                    this.q_effect_replace[_loc_12[0]] = _loc_12[1];
                    _loc_5++;
                }
            }
            this.skillInfo = new SkillInfo();
            this.skillInfo.q_use_effect = param1.q_use_effect;
            this.skillInfo.q_ground_effect = param1.q_ground_effect;
            this.skillInfo.q_hit_effect = param1.q_hit_effect;
            this.skillInfo.q_hit_ground_effect = param1.q_hit_ground_effect;
            this.skillInfo.q_skill_time = param1.q_skill_time;
            this.skillInfo.testEffect();
            return;
        }// end function

    }
}
