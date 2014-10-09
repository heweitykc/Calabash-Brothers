package com.game.vip.message
{
    import net.*;

    public class ReqOpenVIPMessage extends Message
    {
        private var _openType:int;
        private var _vipType:int;
        private var _friendName:String;

        public function ReqOpenVIPMessage()
        {
            return;
        }// end function

        public function set openType(param1:int) : void
        {
            this._openType = param1;
            return;
        }// end function

        public function get openType() : int
        {
            return this._openType;
        }// end function

        public function set vipType(param1:int) : void
        {
            this._vipType = param1;
            return;
        }// end function

        public function get vipType() : int
        {
            return this._vipType;
        }// end function

        public function set friendName(param1:String) : void
        {
            this._friendName = param1;
            return;
        }// end function

        public function get friendName() : String
        {
            return this._friendName;
        }// end function

        override public function getId() : int
        {
            return 147205;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._openType);
            writeByte(this._vipType);
            writeString(this._friendName);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._openType = readByte();
            this._vipType = readByte();
            this._friendName = readString();
            return true;
        }// end function

    }
}
