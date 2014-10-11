package com.game.shortcut.message
{
    import com.game.utils.*;
    import net.*;

    public class RemoveShortCutMessage extends Message
    {
        private var _shortcutId:long;

        public function RemoveShortCutMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._shortcutId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._shortcutId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 108202;
        }// end function

        public function get shortcutId() : long
        {
            return this._shortcutId;
        }// end function

        public function set shortcutId(param1:long) : void
        {
            this._shortcutId = param1;
            return;
        }// end function

    }
}
