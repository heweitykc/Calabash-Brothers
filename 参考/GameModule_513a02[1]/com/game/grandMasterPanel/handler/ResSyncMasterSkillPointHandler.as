package com.game.grandMasterPanel.handler
{
    import com.game.masterskill.message.*;
    import com.model.*;
    import net.*;

    public class ResSyncMasterSkillPointHandler extends Handler
    {

        public function ResSyncMasterSkillPointHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSyncMasterSkillPointMessage(message);
            MasterSkillData.instance.masterSkillPoint = _loc_1.masterPoint;
            MasterSkillData.instance.fireChangeEvent();
            return;
        }// end function

    }
}
