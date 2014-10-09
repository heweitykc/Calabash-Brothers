package com.game.shortcut.message
{
    import com.game.utils.*;
    import net.*;

    public class MoveShortCutMessage extends Message
    {
        private var _shortcutId:long;
        private var _shortcutGrid:int;

        public function MoveShortCutMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._shortcutId);
            writeInt(this._shortcutGrid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._shortcutId = readLong();
            this._shortcutGrid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 108203;
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

        public function get shortcutGrid() : int
        {
            return this._shortcutGrid;
        }// end function

        public function set shortcutGrid(param1:int) : void
        {
            this._shortcutGrid = param1;
            return;
        }// end function

    }
}
