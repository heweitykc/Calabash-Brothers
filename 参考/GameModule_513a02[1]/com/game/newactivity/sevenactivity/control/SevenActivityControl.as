package com.game.newactivity.sevenactivity.control
{
    import com.*;
    import com.f1.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.sevenactivity.view.*;
    import com.staticdata.*;

    public class SevenActivityControl extends Object
    {
        private var _panel:SevenActivityPanel;
        private static var _instance:SevenActivityControl;

        public function SevenActivityControl()
        {
            return;
        }// end function

        public function openOrClose(param1:int = 1) : void
        {
            if (NewActivityModel.getInstance().getActivityByGroup(NewActivityConfig.GROUP_SEVEN_ACTIVITY) == null)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10962"));
                return;
            }
            if (!this._panel)
            {
                this.initPanel();
            }
            this._panel.openOrClose();
            this._panel.curSelIndex = 1;
            return;
        }// end function

        private function initPanel() : void
        {
            this._panel = new SevenActivityPanel();
            Global.popManager.addPop(this._panel);
            return;
        }// end function

        public static function getInstance() : SevenActivityControl
        {
            var _loc_1:* = new SevenActivityControl;
            _instance = new SevenActivityControl;
            return _instance || _loc_1;
        }// end function

    }
}
