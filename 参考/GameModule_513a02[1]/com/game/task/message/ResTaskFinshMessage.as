package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTaskFinshMessage extends Message
    {
        private var _type:int;
        private var _modelId:int;
        private var _conquerTadkId:long;
        private var _finshType:int;

        public function ResTaskFinshMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._modelId);
            writeLong(this._conquerTadkId);
            writeInt(this._finshType);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._modelId = readInt();
            this._conquerTadkId = readLong();
            this._finshType = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120102;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get conquerTadkId() : long
        {
            return this._conquerTadkId;
        }// end function

        public function set conquerTadkId(param1:long) : void
        {
            this._conquerTadkId = param1;
            return;
        }// end function

        public function get finshType() : int
        {
            return this._finshType;
        }// end function

        public function set finshType(param1:int) : void
        {
            this._finshType = param1;
            return;
        }// end function

    }
}
