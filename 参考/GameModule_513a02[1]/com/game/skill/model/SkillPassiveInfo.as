package com.game.skill.model
{

    public class SkillPassiveInfo extends Object
    {
        public var skillIsActive:Boolean = false;
        public var skillLevel:uint;
        public var skillType:uint;
        public var q_skill_id:uint;
        public var q_skill_type:uint;
        public var q_skill_name:String;
        public var q_info:String;
        public var q_skill_levelmax:uint;
        public var q_icon:String;
        public var q_skill_level:uint;
        public var q_need_level:uint;
        public var q_need_info:String;
        public var q_add_attr:String;

        public function SkillPassiveInfo()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            if (!param1)
            {
                return;
            }
            this.q_skill_id = param1.q_skill_id;
            this.q_skill_type = param1.q_skill_type;
            this.q_skill_name = param1.q_skill_name;
            this.q_info = param1.q_info;
            this.q_skill_levelmax = param1.q_skill_levelmax;
            this.q_icon = param1.q_icon;
            this.q_skill_level = param1.q_skill_level;
            this.q_need_level = param1.q_need_level;
            this.q_add_attr = param1.q_add_attr;
            this.q_need_info = param1.q_need_info;
            return;
        }// end function

    }
}
