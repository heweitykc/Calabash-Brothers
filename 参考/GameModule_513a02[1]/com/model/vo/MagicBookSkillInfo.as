package com.model.vo
{
    import com.cfg.vo.*;
    import com.staticdata.*;
    import interfaces.role.*;

    public class MagicBookSkillInfo extends QMagicbookSkill
    {
        public var roundeffectURL:String;
        public var flyURL:String;
        public var iconUrl:String;
        public var actType:String = "act05";
        private var _targetRole:IRole;
        public var q_trajectory_speed:int = 2000;

        public function MagicBookSkillInfo()
        {
            return;
        }// end function

        override public function parse(param1:Object) : void
        {
            super.parse(param1);
            if (round_effect_id && round_effect_id != "0")
            {
                this.roundeffectURL = Params.SKILL_PATH + this.round_effect_id + ".png";
            }
            if (effect_id && effect_id != "0")
            {
                this.flyURL = Params.SKILL_PATH + effect_id + ".png";
            }
            if (icon_id && icon_id != "0")
            {
                this.iconUrl = Params.SKILL_ICON_PATH + icon_id + ".png";
            }
            return;
        }// end function

        public function get targetRole() : IRole
        {
            return this._targetRole;
        }// end function

        public function set targetRole(param1:IRole) : void
        {
            this._targetRole = param1;
            return;
        }// end function

    }
}
