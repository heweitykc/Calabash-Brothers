package com.game.chat.message
{
    import __AS3__.vec.*;
    import com.game.chat.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ChatResponseWCMessage extends Message
    {
        private var _chattype:int;
        private var _chater:long;
        private var _chatername:String;
        private var _chaterlevel:int;
        private var _chaterkinglv:int;
        private var _country:int;
        private var _viptype:int;
        private var _receiver:long;
        private var _receiverlevel:int;
        private var _receivername:String;
        private var _receiverviptype:int;
        private var _condition:String;
        private var _other:Vector.<GoodsInfoRes>;
        private var _isgm:int;
        private var _webvip:int;
        private var _receiverwebvip:int;
        private var _vipLevel:int;

        public function ChatResponseWCMessage()
        {
            this._other = new Vector.<GoodsInfoRes>;
            return;
        }// end function

        public function get vipLevel() : int
        {
            return this._vipLevel;
        }// end function

        public function set vipLevel(param1:int) : void
        {
            this._vipLevel = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._chattype);
            writeLong(this._chater);
            writeString(this._chatername);
            writeInt(this._chaterlevel);
            writeInt(this._chaterkinglv);
            writeInt(this._country);
            writeShort(this._viptype);
            writeLong(this._receiver);
            writeInt(this._receiverlevel);
            writeString(this._receivername);
            writeShort(this._receiverviptype);
            writeString(this._condition);
            writeShort(this._other.length);
            _loc_1 = 0;
            while (_loc_1 < this._other.length)
            {
                
                writeBean(this._other[_loc_1]);
                _loc_1++;
            }
            writeByte(this._isgm);
            writeInt(this._webvip);
            writeInt(this._receiverwebvip);
            writeShort(this._vipLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._chattype = readInt();
            this._chater = readLong();
            this._chatername = readString();
            this._chaterlevel = readInt();
            this._chaterkinglv = readInt();
            this._country = readInt();
            this._viptype = readShort();
            this._receiver = readLong();
            this._receiverlevel = readInt();
            this._receivername = readString();
            this._receiverviptype = readShort();
            this._condition = readString();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._other[_loc_1] = readBean(GoodsInfoRes) as GoodsInfoRes;
                _loc_1++;
            }
            this._isgm = readByte();
            this._webvip = readInt();
            this._receiverwebvip = readInt();
            this._vipLevel = readShort();
            return true;
        }// end function

        override public function getId() : int
        {
            return 111103;
        }// end function

        public function get chattype() : int
        {
            return this._chattype;
        }// end function

        public function set chattype(param1:int) : void
        {
            this._chattype = param1;
            return;
        }// end function

        public function get chater() : long
        {
            return this._chater;
        }// end function

        public function set chater(param1:long) : void
        {
            this._chater = param1;
            return;
        }// end function

        public function get chatername() : String
        {
            return this._chatername;
        }// end function

        public function set chatername(param1:String) : void
        {
            this._chatername = param1;
            return;
        }// end function

        public function get chaterlevel() : int
        {
            return this._chaterlevel;
        }// end function

        public function set chaterlevel(param1:int) : void
        {
            this._chaterlevel = param1;
            return;
        }// end function

        public function get chaterkinglv() : int
        {
            return this._chaterkinglv;
        }// end function

        public function set chaterkinglv(param1:int) : void
        {
            this._chaterkinglv = param1;
            return;
        }// end function

        public function get country() : int
        {
            return this._country;
        }// end function

        public function set country(param1:int) : void
        {
            this._country = param1;
            return;
        }// end function

        public function get viptype() : int
        {
            return this._viptype;
        }// end function

        public function set viptype(param1:int) : void
        {
            this._viptype = param1;
            return;
        }// end function

        public function get receiver() : long
        {
            return this._receiver;
        }// end function

        public function set receiver(param1:long) : void
        {
            this._receiver = param1;
            return;
        }// end function

        public function get receiverlevel() : int
        {
            return this._receiverlevel;
        }// end function

        public function set receiverlevel(param1:int) : void
        {
            this._receiverlevel = param1;
            return;
        }// end function

        public function get receivername() : String
        {
            return this._receivername;
        }// end function

        public function set receivername(param1:String) : void
        {
            this._receivername = param1;
            return;
        }// end function

        public function get receiverviptype() : int
        {
            return this._receiverviptype;
        }// end function

        public function set receiverviptype(param1:int) : void
        {
            this._receiverviptype = param1;
            return;
        }// end function

        public function get condition() : String
        {
            return this._condition;
        }// end function

        public function set condition(param1:String) : void
        {
            this._condition = param1;
            return;
        }// end function

        public function get other() : Vector.<GoodsInfoRes>
        {
            return this._other;
        }// end function

        public function set other(param1:Vector.<GoodsInfoRes>) : void
        {
            this._other = param1;
            return;
        }// end function

        public function get isgm() : int
        {
            return this._isgm;
        }// end function

        public function set isgm(param1:int) : void
        {
            this._isgm = param1;
            return;
        }// end function

        public function get webvip() : int
        {
            return this._webvip;
        }// end function

        public function set webvip(param1:int) : void
        {
            this._webvip = param1;
            return;
        }// end function

        public function get receiverwebvip() : int
        {
            return this._receiverwebvip;
        }// end function

        public function set receiverwebvip(param1:int) : void
        {
            this._receiverwebvip = param1;
            return;
        }// end function

    }
}
