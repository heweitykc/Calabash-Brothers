package com.game.skill.protocol
{
    import com.*;
    import com.game.lostskills.message.*;
    import com.game.skill.message.*;
    import com.game.utils.*;

    public class SkillProtocal extends BaseProtocol
    {

        public function SkillProtocal()
        {
            return;
        }// end function

        public function levelUpSkill() : void
        {
            var _loc_1:* = new LevelUpSkillMessage();
            _loc_1.skillModelId = 100001;
            send(_loc_1);
            return;
        }// end function

        public function nowLearnSkillQuery() : void
        {
            var _loc_1:* = new NowLearnSkillQueryMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCompleteMoment() : void
        {
            var _loc_1:* = new ReqCompleteMomentMessage();
            send(_loc_1);
            return;
        }// end function

        public function setDefaultSkill(param1:int) : void
        {
            var _loc_2:* = new SetDefaultSkillMessage();
            _loc_2.defaultSkill = param1;
            send(_loc_2);
            return;
        }// end function

        public function studySkill() : void
        {
            var _loc_1:* = new StudySkillMessage();
            var _loc_2:* = new long();
            _loc_2.high = uint(21112);
            _loc_2.low = uint(3739953084);
            _loc_1.bookId = _loc_2;
            _loc_1.skillModelId = 10005;
            send(_loc_1);
            return;
        }// end function

        public function lostSkillInfos() : void
        {
            var _loc_1:* = new ReqLostSkillInfosMessage();
            send(_loc_1);
            return;
        }// end function

        public function activateLostSkill(param1:uint) : void
        {
            var _loc_2:* = new ReqActivateLostSkillMessage();
            _loc_2.skillType = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
