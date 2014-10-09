package com.cfg.vo
{

    public class QMagicbookSkill extends Object
    {
        public var skill_id:int;
        public var round_effect_id:String;
        public var skillname:String;
        public var tips:String;
        public var icon_id:String;
        public var skill_type:int;
        public var attack_id:String;
        public var effect_id:String;
        public var skill_cd:int;

        public function QMagicbookSkill()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.skill_id = param1.skill_id;
            this.round_effect_id = param1.round_effect_id;
            this.skillname = param1.skillname;
            this.tips = param1.tips;
            this.icon_id = param1.icon_id;
            this.skill_type = param1.skill_type;
            this.attack_id = param1.attack_id;
            this.effect_id = param1.effect_id;
            this.skill_cd = param1.skill_cd;
            return;
        }// end function

    }
}
