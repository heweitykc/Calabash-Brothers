package com.game.grandMasterPanel.protocol
{
    import com.*;
    import com.game.masterskill.message.*;

    public class MasterSkillProtocol extends BaseProtocol
    {

        public function MasterSkillProtocol()
        {
            return;
        }// end function

        public function reqStudyMasterSkill(param1:int) : void
        {
            var _loc_2:* = new ReqStudyMasterSkillMessage();
            _loc_2.modelid = param1;
            send(_loc_2);
            return;
        }// end function

        public function resetAllSkill() : void
        {
            var _loc_1:* = new ReqMasterSkillResetMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
