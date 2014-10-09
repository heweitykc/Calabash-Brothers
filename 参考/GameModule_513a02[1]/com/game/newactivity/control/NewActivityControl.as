package com.game.newactivity.control
{
    import com.game.newactivity.protocol.*;
    import com.game.utils.*;

    public class NewActivityControl extends Object
    {
        private var _procotol:NewActivityProtocol;
        private static var _instance:NewActivityControl;

        public function NewActivityControl()
        {
            this._procotol = new NewActivityProtocol();
            return;
        }// end function

        public function getActivityInfo(param1:int) : void
        {
            this._procotol.getActivityInfo(param1);
            return;
        }// end function

        public function getActivityReward(param1:int, param2:int) : void
        {
            this._procotol.getActivityReward(param1, param2);
            return;
        }// end function

        public function getActivityRankInfo(param1:int) : void
        {
            this._procotol.getActivityRankInfo(param1);
            return;
        }// end function

        public function reqExchangeJewewlry(param1:long, param2:long, param3:int) : void
        {
            this._procotol.reqExchangeJewewlry(param1, param2, param3);
            return;
        }// end function

        public function reqOpenPainInfo() : void
        {
            this._procotol.reqOpenPainInfo();
            return;
        }// end function

        public static function getInstance() : NewActivityControl
        {
            var _loc_1:* = new NewActivityControl;
            _instance = new NewActivityControl;
            return _instance || _loc_1;
        }// end function

    }
}
