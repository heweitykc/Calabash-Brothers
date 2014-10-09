package com.game.shortcut.message
{
    import com.game.shortcut.bean.*;
    import net.*;

    public class ShortCutAddMessage extends Message
    {
        private var _shortcut:ShortCutInfo;

        public function ShortCutAddMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._shortcut);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._shortcut = readBean(ShortCutInfo) as ShortCutInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 108102;
        }// end function

        public function get shortcut() : ShortCutInfo
        {
            return this._shortcut;
        }// end function

        public function set shortcut(param1:ShortCutInfo) : void
        {
            this._shortcut = param1;
            return;
        }// end function

    }
}
