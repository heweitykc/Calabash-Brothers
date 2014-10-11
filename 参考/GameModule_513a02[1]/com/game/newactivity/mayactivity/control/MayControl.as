package com.game.newactivity.mayactivity.control
{
    import com.*;
    import com.f1.*;
    import com.game.newactivity.mayactivity.view.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;

    public class MayControl extends Object
    {
        private var _panel:MayPanel;
        private var _maySelectPanel:MaySelectPanel;
        private static var instance:MayControl;

        public function MayControl()
        {
            return;
        }// end function

        public function get maySelectPanel() : MaySelectPanel
        {
            return this._maySelectPanel;
        }// end function

        public function openOrClose(param1:int = 1) : void
        {
            if (NewActivityModel.getInstance().getActivityByGroup(NewActivityConfig.GROUP_MAY_ACTIVITY) == null)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12439"));
                return;
            }
            if (!this._panel)
            {
                this.initPanel();
            }
            this._panel.openOrClose();
            this._panel.curSelIndex = param1;
            return;
        }// end function

        public function close() : void
        {
            if (this._panel)
            {
                this._panel.close();
            }
            return;
        }// end function

        public function openSelectPanel() : void
        {
            if (!this._maySelectPanel)
            {
                this._maySelectPanel = new MaySelectPanel();
                Global.popManager.addPop(this._maySelectPanel);
            }
            this._maySelectPanel.openOrClose();
            return;
        }// end function

        private function initPanel() : void
        {
            this._panel = new MayPanel();
            Global.popManager.addPop(this._panel);
            return;
        }// end function

        public function resExchangeJewewlryHandler(param1:ResExchangeJewewlryMessage) : void
        {
            if (param1.result == 1)
            {
                if (this.maySelectPanel)
                {
                    this.maySelectPanel.close();
                }
            }
            return;
        }// end function

        public static function getInstance() : MayControl
        {
            if (instance == null)
            {
                instance = new MayControl;
            }
            return instance;
        }// end function

    }
}
