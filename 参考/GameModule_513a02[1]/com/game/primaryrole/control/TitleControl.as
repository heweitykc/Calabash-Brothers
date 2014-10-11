package com.game.primaryrole.control
{
    import com.game.primaryrole.protocol.*;

    public class TitleControl extends Object
    {
        private var _protocol:TitleProtocol;
        private static var _instance:TitleControl;

        public function TitleControl()
        {
            this._protocol = new TitleProtocol();
            return;
        }// end function

        public function wearTitle(param1:int) : void
        {
            this._protocol.wearTitle(param1);
            return;
        }// end function

        public static function get instance() : TitleControl
        {
            if (_instance == null)
            {
                _instance = new TitleControl;
            }
            return _instance;
        }// end function

    }
}
