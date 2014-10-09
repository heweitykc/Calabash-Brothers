package com.game.shortcut.bean
{
    import com.game.utils.*;
    import net.*;

    public class ShortCutInfo extends Bean
    {
        private var _shortcutId:long;
        private var _shortcutType:int;
        private var _shortcutSource:long;
        private var _shortcutSourceModel:int;
        private var _shortcutGrid:int;

        public function ShortCutInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._shortcutId);
            writeInt(this._shortcutType);
            writeLong(this._shortcutSource);
            writeInt(this._shortcutSourceModel);
            writeInt(this._shortcutGrid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._shortcutId = readLong();
            this._shortcutType = readInt();
            this._shortcutSource = readLong();
            this._shortcutSourceModel = readInt();
            this._shortcutGrid = readInt();
            return true;
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

        public function get shortcutType() : int
        {
            return this._shortcutType;
        }// end function

        public function set shortcutType(param1:int) : void
        {
            this._shortcutType = param1;
            return;
        }// end function

        public function get shortcutSource() : long
        {
            return this._shortcutSource;
        }// end function

        public function set shortcutSource(param1:long) : void
        {
            this._shortcutSource = param1;
            return;
        }// end function

        public function get shortcutSourceModel() : int
        {
            return this._shortcutSourceModel;
        }// end function

        public function set shortcutSourceModel(param1:int) : void
        {
            this._shortcutSourceModel = param1;
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
