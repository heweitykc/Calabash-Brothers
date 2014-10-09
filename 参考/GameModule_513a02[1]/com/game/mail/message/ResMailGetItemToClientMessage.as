package com.game.mail.message
{
    import __AS3__.vec.*;
    import com.game.mail.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResMailGetItemToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _itemid:long;
        private var _mailDetail:MailDetailInfo;
        private var _itemModelIds:Vector.<int>;

        public function ResMailGetItemToClientMessage()
        {
            this._itemModelIds = new Vector.<int>;
            return;
        }// end function

        public function get itemModelIds() : Vector.<int>
        {
            return this._itemModelIds;
        }// end function

        public function set itemModelIds(param1:Vector.<int>) : void
        {
            this._itemModelIds = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeLong(this._itemid);
            writeBean(this._mailDetail);
            writeShort(this._itemModelIds.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._itemModelIds.length)
            {
                
                writeInt(this.itemModelIds[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._itemid = readLong();
            this._mailDetail = readBean(MailDetailInfo) as MailDetailInfo;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemModelIds[_loc_2] = readInt();
                _loc_2++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 124103;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

        public function get itemid() : long
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:long) : void
        {
            this._itemid = param1;
            return;
        }// end function

        public function get mailDetail() : MailDetailInfo
        {
            return this._mailDetail;
        }// end function

        public function set mailDetail(param1:MailDetailInfo) : void
        {
            this._mailDetail = param1;
            return;
        }// end function

    }
}
