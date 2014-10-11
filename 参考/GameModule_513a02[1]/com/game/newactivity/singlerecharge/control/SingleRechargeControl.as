package com.game.newactivity.singlerecharge.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.singlerecharge.view.*;
    import com.model.*;
    import com.staticdata.*;

    public class SingleRechargeControl extends Object
    {
        private var _panel:SingleRechargePanel;
        private static var _instance:SingleRechargeControl;

        public function SingleRechargeControl()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            var _loc_1:* = TopActivateCfgObj.getInstance().getButtonShowLevel(TopActivateName.TOP_ICON_SINGLE_RECHARGE);
            if (_loc_1 != 999 && _loc_1 > UserObj.getInstance().playerInfo.level)
            {
                Global.popManager.addedToSystem(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12112"), [_loc_1]));
                return;
            }
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_SINGLE_RECHARGE))
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10965"));
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
            this._panel = new SingleRechargePanel();
            Global.popManager.addPop(this._panel);
            return;
        }// end function

        public static function getInstance() : SingleRechargeControl
        {
            var _loc_1:* = new SingleRechargeControl;
            _instance = new SingleRechargeControl;
            return _instance || _loc_1;
        }// end function

    }
}
