package com.game.shortcut.message
{
    import net.*;

    public class ShortCutRemoveMessage extends Message
    {
        private var _shortcutGrid:int;

        public function ShortCutRemoveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._shortcutGrid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._shortcutGrid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 108103;
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
