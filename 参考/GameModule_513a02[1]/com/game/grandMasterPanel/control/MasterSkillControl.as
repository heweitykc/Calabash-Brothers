package com.game.grandMasterPanel.control
{
    import com.*;
    import com.game.grandMasterPanel.protocol.*;
    import com.game.grandMasterPanel.view.*;
    import com.game.guide.control.*;
    import com.game.operationpanel.control.*;
    import com.greensock.*;
    import flash.display.*;

    public class MasterSkillControl extends Object
    {
        private var _protocol:MasterSkillProtocol;
        private var _skillPanel:GrandMasterPanel;
        private static var _instance:MasterSkillControl;

        public function MasterSkillControl()
        {
            this._protocol = new MasterSkillProtocol();
            return;
        }// end function

        public function get protocol() : MasterSkillProtocol
        {
            return this._protocol;
        }// end function

        public function openOrCloseSkillPanel() : void
        {
            if (this._skillPanel == null)
            {
                this._skillPanel = new GrandMasterPanel();
                Global.popManager.addPop(this._skillPanel);
            }
            this._skillPanel.openOrClose();
            return;
        }// end function

        public function showSkillUpdateEffect(param1:int) : void
        {
            var _loc_2:* = OperationPanelControl.getInstance().getSkillGridBySkillId(param1);
            if (_loc_2)
            {
                TweenLite.killTweensOf(_loc_2);
                ButtonFlickerControl.getInstance().addButtonFlicker(_loc_2);
                TweenLite.delayedCall(2, this.onResetFilterHandler, [_loc_2]);
            }
            return;
        }// end function

        private function onResetFilterHandler(param1:DisplayObject) : void
        {
            ButtonFlickerControl.getInstance().removeButtonFlicker(param1);
            return;
        }// end function

        public static function get instance() : MasterSkillControl
        {
            if (_instance == null)
            {
                _instance = new MasterSkillControl;
            }
            return _instance;
        }// end function

    }
}
