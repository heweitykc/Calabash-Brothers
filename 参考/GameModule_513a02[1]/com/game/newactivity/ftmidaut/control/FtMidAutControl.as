package com.game.newactivity.ftmidaut.control
{
    import com.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.ftmidaut.view.*;
    import com.game.newactivity.message.*;

    public class FtMidAutControl extends Object
    {
        private var _panel:FtMidAutPanel;
        private static var _instance:FtMidAutControl;

        public function FtMidAutControl()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!this._panel)
            {
                this._panel = new FtMidAutPanel();
                Global.popManager.addPop(this._panel);
            }
            if (!this._panel.parent)
            {
                this.reqOpenPainInfo();
            }
            this._panel.openOrClose();
            return;
        }// end function

        public function resOpenPainBack(param1:ResOpenPainMessage) : void
        {
            if (this._panel)
            {
                this._panel.setPainInfo(param1.count, param1.list);
            }
            return;
        }// end function

        public function reqOpenPainInfo() : void
        {
            NewActivityControl.getInstance().reqOpenPainInfo();
            return;
        }// end function

        public static function getInstance() : FtMidAutControl
        {
            if (!_instance)
            {
                _instance = new FtMidAutControl;
            }
            return _instance;
        }// end function

    }
}
