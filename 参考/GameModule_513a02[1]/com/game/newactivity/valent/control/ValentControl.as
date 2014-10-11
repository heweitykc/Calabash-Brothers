package com.game.newactivity.valent.control
{
    import com.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.valent.view.*;

    public class ValentControl extends Object
    {
        private var _valentPanel:ValentPanel;
        private static var _instance:ValentControl;

        public function ValentControl()
        {
            return;
        }// end function

        public function openValentPanel() : void
        {
            if (!this._valentPanel)
            {
                this._valentPanel = new ValentPanel();
                Global.popManager.addPop(this._valentPanel);
            }
            if (!this._valentPanel.parent)
            {
                this.reqOpenPainInfo();
            }
            this._valentPanel.openOrClose();
            return;
        }// end function

        public function resOpenPainBack(param1:ResOpenPainMessage) : void
        {
            if (this._valentPanel)
            {
                this._valentPanel.setPainInfo(param1.count, param1.list);
            }
            return;
        }// end function

        public function reqOpenPainInfo() : void
        {
            NewActivityControl.getInstance().reqOpenPainInfo();
            return;
        }// end function

        public static function getInstance() : ValentControl
        {
            if (!_instance)
            {
                _instance = new ValentControl;
            }
            return _instance;
        }// end function

    }
}
