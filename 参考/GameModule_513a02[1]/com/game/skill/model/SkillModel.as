package com.game.skill.model
{
    import __AS3__.vec.*;

    public class SkillModel extends Object
    {
        public var vecLostSkillInfo:Vector.<LostSkillInfo>;
        private static var _instance:SkillModel;

        public function SkillModel()
        {
            return;
        }// end function

        public static function getInstance() : SkillModel
        {
            if (!_instance)
            {
                _instance = new SkillModel;
            }
            return _instance;
        }// end function

    }
}
