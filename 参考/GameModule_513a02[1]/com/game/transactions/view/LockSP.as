package com.game.transactions.view
{
    import com.f1.ui.*;
    import flash.text.*;

    public class LockSP extends Component
    {
        private var _statusTxt:TextField;
        private var _tipsTxt:TextField;

        public function LockSP(param1 = "locksp", param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._statusTxt = getDisplayChildByName("txt_status");
            this._tipsTxt = getDisplayChildByName("txt_tips");
            return;
        }// end function

        public function set status(param1:String) : void
        {
            this._statusTxt.text = param1;
            return;
        }// end function

        public function set tips(param1:String) : void
        {
            this._tipsTxt.text = param1;
            return;
        }// end function

    }
}
