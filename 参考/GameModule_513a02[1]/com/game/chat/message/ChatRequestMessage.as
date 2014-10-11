package com.game.chat.message
{
    import __AS3__.vec.*;
    import com.game.chat.bean.*;
    import net.*;

    public class ChatRequestMessage extends Message
    {
        private var _chattype:int;
        private var _roleName:String;
        private var _condition:String;
        private var _other:Vector.<GoodsInfoReq>;

        public function ChatRequestMessage()
        {
            this._other = new Vector.<GoodsInfoReq>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._chattype);
            writeString(this._roleName);
            writeString(this._condition);
            writeShort(this._other.length);
            _loc_1 = 0;
            while (_loc_1 < this._other.length)
            {
                
                writeBean(this._other[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._chattype = readInt();
            this._roleName = readString();
            this._condition = readString();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._other[_loc_1] = readBean(GoodsInfoReq) as GoodsInfoReq;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 111201;
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

        public function get roleName() : String
        {
            return this._roleName;
        }// end function

        public function set roleName(param1:String) : void
        {
            this._roleName = param1;
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

        public function get other() : Vector.<GoodsInfoReq>
        {
            return this._other;
        }// end function

        public function set other(param1:Vector.<GoodsInfoReq>) : void
        {
            this._other = param1;
            return;
        }// end function

    }
}
