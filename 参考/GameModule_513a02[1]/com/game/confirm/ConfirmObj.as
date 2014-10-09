package com.game.confirm
{
    import flash.utils.*;

    public class ConfirmObj extends Object
    {
        private static var _dic:Dictionary;
        public static const SCARLET_ITEM:String = "scarlet_item";
        public static const CHAT_LABA:String = "chat_laba";

        public function ConfirmObj()
        {
            return;
        }// end function

        public static function isNeedConfirm(param1:String) : Boolean
        {
            if (_dic == null)
            {
                _dic = new Dictionary();
            }
            return _dic[param1];
        }// end function

        public static function setNeedConfirm(param1:String, param2:Boolean) : void
        {
            if (_dic == null)
            {
                _dic = new Dictionary();
            }
            _dic[param1] = param2;
            return;
        }// end function

    }
}
