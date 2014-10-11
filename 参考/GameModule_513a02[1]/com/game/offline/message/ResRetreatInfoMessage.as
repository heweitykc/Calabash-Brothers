package com.game.offline.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRetreatInfoMessage extends Message
    {
        private var _notifyType:int;
        private var _curTime:int;
        private var _curExp:long;
        private var _curZhenqi:int;

        public function ResRetreatInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._notifyType);
            writeInt(this._curTime);
            writeLong(this._curExp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._notifyType = readInt();
            this._curTime = readInt();
            this._curExp = readLong();
            this._curZhenqi = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 150203;
        }// end function

        public function get notifyType() : int
        {
            return this._notifyType;
        }// end function

        public function set notifyType(param1:int) : void
        {
            this._notifyType = param1;
            return;
        }// end function

        public function get curTime() : int
        {
            return this._curTime;
        }// end function

        public function set curTime(param1:int) : void
        {
            this._curTime = param1;
            return;
        }// end function

        public function get curExp() : long
        {
            return this._curExp;
        }// end function

        public function set curExp(param1:long) : void
        {
            this._curExp = param1;
            return;
        }// end function

        public function get curZhenqi() : int
        {
            return this._curZhenqi;
        }// end function

        public function set curZhenqi(param1:int) : void
        {
            this._curZhenqi = param1;
            return;
        }// end function

    }
}
