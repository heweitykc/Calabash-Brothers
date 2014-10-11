package com.game.mail.bean
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import net.*;

    public class MailDetailInfo extends Bean
    {
        private var _mailid:long;
        private var _senderid:long;
        private var _receiverid:long;
        private var _szSenderName:String;
        private var _szReceiverName:String;
        private var _szTitle:String;
        private var _szNotice:String;
        private var _btRead:int;
        private var _btGoldType:int;
        private var _nGold:int;
        private var _btAccessory:int;
        private var _nSendTime:int;
        private var _btSystem:int;
        private var _btReturn:int;
        private var _itemlist:Vector.<ItemInfo>;

        public function MailDetailInfo()
        {
            this._itemlist = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._mailid);
            writeLong(this._senderid);
            writeLong(this._receiverid);
            writeString(this._szSenderName);
            writeString(this._szReceiverName);
            writeString(this._szTitle);
            writeString(this._szNotice);
            writeByte(this._btRead);
            writeByte(this._btGoldType);
            writeInt(this._nGold);
            writeByte(this._btAccessory);
            writeInt(this._nSendTime);
            writeByte(this._btSystem);
            writeByte(this._btReturn);
            writeShort(this._itemlist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._itemlist.length)
            {
                
                writeBean(this._itemlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mailid = readLong();
            this._senderid = readLong();
            this._receiverid = readLong();
            this._szSenderName = readString();
            this._szReceiverName = readString();
            this._szTitle = readString();
            this._szNotice = readString();
            this._btRead = readByte();
            this._btGoldType = readByte();
            this._nGold = readInt();
            this._btAccessory = readByte();
            this._nSendTime = readInt();
            this._btSystem = readByte();
            this._btReturn = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemlist[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get mailid() : long
        {
            return this._mailid;
        }// end function

        public function set mailid(param1:long) : void
        {
            this._mailid = param1;
            return;
        }// end function

        public function get senderid() : long
        {
            return this._senderid;
        }// end function

        public function set senderid(param1:long) : void
        {
            this._senderid = param1;
            return;
        }// end function

        public function get receiverid() : long
        {
            return this._receiverid;
        }// end function

        public function set receiverid(param1:long) : void
        {
            this._receiverid = param1;
            return;
        }// end function

        public function get szSenderName() : String
        {
            return this._szSenderName;
        }// end function

        public function set szSenderName(param1:String) : void
        {
            this._szSenderName = param1;
            return;
        }// end function

        public function get szReceiverName() : String
        {
            return this._szReceiverName;
        }// end function

        public function set szReceiverName(param1:String) : void
        {
            this._szReceiverName = param1;
            return;
        }// end function

        public function get szTitle() : String
        {
            return this._szTitle;
        }// end function

        public function set szTitle(param1:String) : void
        {
            this._szTitle = param1;
            return;
        }// end function

        public function get szNotice() : String
        {
            return this._szNotice;
        }// end function

        public function set szNotice(param1:String) : void
        {
            this._szNotice = param1;
            return;
        }// end function

        public function get btRead() : int
        {
            return this._btRead;
        }// end function

        public function set btRead(param1:int) : void
        {
            this._btRead = param1;
            return;
        }// end function

        public function get btGoldType() : int
        {
            return this._btGoldType;
        }// end function

        public function set btGoldType(param1:int) : void
        {
            this._btGoldType = param1;
            return;
        }// end function

        public function get nGold() : int
        {
            return this._nGold;
        }// end function

        public function set nGold(param1:int) : void
        {
            this._nGold = param1;
            return;
        }// end function

        public function get btAccessory() : int
        {
            return this._btAccessory;
        }// end function

        public function set btAccessory(param1:int) : void
        {
            this._btAccessory = param1;
            return;
        }// end function

        public function get nSendTime() : int
        {
            return this._nSendTime;
        }// end function

        public function set nSendTime(param1:int) : void
        {
            this._nSendTime = param1;
            return;
        }// end function

        public function get btSystem() : int
        {
            return this._btSystem;
        }// end function

        public function set btSystem(param1:int) : void
        {
            this._btSystem = param1;
            return;
        }// end function

        public function get btReturn() : int
        {
            return this._btReturn;
        }// end function

        public function set btReturn(param1:int) : void
        {
            this._btReturn = param1;
            return;
        }// end function

        public function get itemlist() : Vector.<ItemInfo>
        {
            return this._itemlist;
        }// end function

        public function set itemlist(param1:Vector.<ItemInfo>) : void
        {
            this._itemlist = param1;
            return;
        }// end function

    }
}
