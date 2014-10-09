package com.game.primaryrole.control
{
    import com.game.horse.message.*;
    import com.game.primaryrole.view.*;

    public class OtherHorseControl extends Object
    {
        private var _otherHorseView:OtherHorseView;
        private static var _instance:OtherHorseControl;

        public function OtherHorseControl()
        {
            return;
        }// end function

        public function get otherHorseView() : OtherHorseView
        {
            if (!this._otherHorseView)
            {
                this._otherHorseView = new OtherHorseView();
            }
            return this._otherHorseView;
        }// end function

        public function otherPlayerHorseHandler(param1:ResOthersHorseInfoMessage) : void
        {
            var _loc_2:* = param1.info.curlayer;
            this.otherHorseView.updateHorseInfo(_loc_2);
            return;
        }// end function

        public static function getInstance() : OtherHorseControl
        {
            if (_instance == null)
            {
                _instance = new OtherHorseControl;
            }
            return _instance;
        }// end function

    }
}
