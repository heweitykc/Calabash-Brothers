package com.game.magicbook.bean
{
    import net.*;

    public class MagicUseOnceInfo extends Bean
    {
        private var _itemId:int;
        private var _useOnceNum:int;
        private var _useOnceValue:int;
        private var _maxUseNum:int;

        public function MagicUseOnceInfo()
        {
            return;
        }// end function

        public function set itemId(param1:int) : void
        {
            this._itemId = param1;
            return;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function set useOnceNum(param1:int) : void
        {
            this._useOnceNum = param1;
            return;
        }// end function

        public function get useOnceNum() : int
        {
            return this._useOnceNum;
        }// end function

        public function set useOnceValue(param1:int) : void
        {
            this._useOnceValue = param1;
            return;
        }// end function

        public function get useOnceValue() : int
        {
            return this._useOnceValue;
        }// end function

        public function set maxUseNum(param1:int) : void
        {
            this._maxUseNum = param1;
            return;
        }// end function

        public function get maxUseNum() : int
        {
            return this._maxUseNum;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._itemId);
            writeInt(this._useOnceNum);
            writeInt(this._useOnceValue);
            writeInt(this._maxUseNum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readInt();
            this._useOnceNum = readInt();
            this._useOnceValue = readInt();
            this._maxUseNum = readInt();
            return true;
        }// end function

    }
}
