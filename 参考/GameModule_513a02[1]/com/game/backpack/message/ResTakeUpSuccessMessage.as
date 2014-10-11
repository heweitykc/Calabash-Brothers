package com.game.backpack.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTakeUpSuccessMessage extends Message
    {
        private var _goodsId:long;
        private var _goodModelId:int;
        private var _effectType:int;
        private var _effectValue:int;
        private var _num:int;

        public function ResTakeUpSuccessMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._goodsId);
            writeInt(this._goodModelId);
            writeInt(this._effectType);
            writeInt(this._effectValue);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodsId = readLong();
            this._goodModelId = readInt();
            this._effectType = readInt();
            this._effectValue = readInt();
            this._num = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104212;
        }// end function

        public function get goodsId() : long
        {
            return this._goodsId;
        }// end function

        public function set goodsId(param1:long) : void
        {
            this._goodsId = param1;
            return;
        }// end function

        public function get goodModelId() : int
        {
            return this._goodModelId;
        }// end function

        public function set goodModelId(param1:int) : void
        {
            this._goodModelId = param1;
            return;
        }// end function

        public function get effectType() : int
        {
            return this._effectType;
        }// end function

        public function set effectType(param1:int) : void
        {
            this._effectType = param1;
            return;
        }// end function

        public function get effectValue() : int
        {
            return this._effectValue;
        }// end function

        public function set effectValue(param1:int) : void
        {
            this._effectValue = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
