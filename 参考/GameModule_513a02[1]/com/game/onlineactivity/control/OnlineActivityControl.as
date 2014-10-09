package com.game.onlineactivity.control
{
    import com.*;
    import com.game.onlineactivity.protocol.*;
    import com.game.onlineactivity.view.*;

    public class OnlineActivityControl extends Object
    {
        private var _onlineActivityBox:OnlineActivityBox;
        private var _protocol:OnlineActivityProtocol;
        private static var _instance:OnlineActivityControl;

        public function OnlineActivityControl()
        {
            this._protocol = new OnlineActivityProtocol();
            return;
        }// end function

        public function get onlineActivityBox() : OnlineActivityBox
        {
            return this._onlineActivityBox;
        }// end function

        public function openOnlineActivityBox() : void
        {
            if (!this._onlineActivityBox)
            {
                this._onlineActivityBox = new OnlineActivityBox();
                Global.popManager.addPop(this._onlineActivityBox);
            }
            this._onlineActivityBox.openOrClose();
            return;
        }// end function

        public function reqGetNewActivityInfo(param1:int) : void
        {
            this._protocol.reqGetNewActivityInfo(param1);
            return;
        }// end function

        public static function getInstance() : OnlineActivityControl
        {
            if (_instance == null)
            {
                _instance = new OnlineActivityControl;
            }
            return _instance;
        }// end function

    }
}
