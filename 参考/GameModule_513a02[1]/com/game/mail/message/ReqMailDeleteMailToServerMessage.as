package com.game.mail.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ReqMailDeleteMailToServerMessage extends Message
    {
        private var _btdeleteall:int;
        private var _deleteMailIdList:Vector.<long>;

        public function ReqMailDeleteMailToServerMessage()
        {
            this._deleteMailIdList = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._btdeleteall);
            writeShort(this._deleteMailIdList.length);
            _loc_1 = 0;
            while (_loc_1 < this._deleteMailIdList.length)
            {
                
                writeLong(this._deleteMailIdList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._btdeleteall = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._deleteMailIdList[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 124155;
        }// end function

        public function get btdeleteall() : int
        {
            return this._btdeleteall;
        }// end function

        public function set btdeleteall(param1:int) : void
        {
            this._btdeleteall = param1;
            return;
        }// end function

        public function get deleteMailIdList() : Vector.<long>
        {
            return this._deleteMailIdList;
        }// end function

        public function set deleteMailIdList(param1:Vector.<long>) : void
        {
            this._deleteMailIdList = param1;
            return;
        }// end function

    }
}
