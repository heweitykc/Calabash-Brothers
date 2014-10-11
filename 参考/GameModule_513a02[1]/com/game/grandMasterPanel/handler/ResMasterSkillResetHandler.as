package com.game.grandMasterPanel.handler
{
    import com.*;
    import com.f1.*;
    import com.game.masterskill.message.*;
    import com.game.operationpanel.control.*;
    import com.model.*;
    import net.*;

    public class ResMasterSkillResetHandler extends Handler
    {

        public function ResMasterSkillResetHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMasterSkillResetMessage(message);
            MasterSkillData.instance.resetAll();
            MasterSkillData.instance.masterSkillPoint = _loc_1.masterPoint;
            MasterSkillData.instance.fireChangeEvent();
            OperationPanelControl.getInstance().freshShortCutView();
            Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("ResMasterSkillResetHandler_1409648445", "lang_masterSkill"));
            return;
        }// end function

    }
}
