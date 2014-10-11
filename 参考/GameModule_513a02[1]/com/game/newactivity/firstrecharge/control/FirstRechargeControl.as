package com.game.newactivity.firstrecharge.control
{
    import com.*;
    import com.f1.*;
    import com.game.newactivity.firstrecharge.view.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;

    public class FirstRechargeControl extends Object
    {
        private var _panel:FirstRechargePanel;
        private static var _instance:FirstRechargeControl;

        public function FirstRechargeControl()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FIRST_RECHARGE))
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10961"));
                return;
            }
            if (!this._panel)
            {
                this.initPanel();
            }
            this._panel.openOrClose();
            return;
        }// end function

        private function initPanel() : void
        {
            this._panel = new FirstRechargePanel();
            Global.popManager.addPop(this._panel);
            return;
        }// end function

        public static function getInstance() : FirstRechargeControl
        {
            var _loc_1:* = new FirstRechargeControl;
            _instance = new FirstRechargeControl;
            return _instance || _loc_1;
        }// end function

    }
}
